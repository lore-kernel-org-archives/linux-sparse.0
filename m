From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 3/3] symbol.c: Set correct size of array from parenthesized
 string initializer
Date: Sat, 01 Jun 2013 18:42:39 +0100
Message-ID: <51AA328F.3040603@ramsay1.demon.co.uk>
References: <5195370B.9080702@ramsay1.demon.co.uk> <51972FDB.6060201@chrisli.org> <5197387E.5030000@gmail.com> <519A6EAD.8070700@ramsay1.demon.co.uk> <519E3582.7060704@gmail.com> <51A1189A.1010404@ramsay1.demon.co.uk> <20130529100207.GA3005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:34946 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751289Ab3FARsT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 1 Jun 2013 13:48:19 -0400
In-Reply-To: <20130529100207.GA3005@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Chris Li wrote:
> On Sat, May 25, 2013 at 09:01:30PM +0100, Ramsay Jones wrote:
>> +static struct expression *paren_string(struct expression *expr)
> 
> Paren sounds very much like "parent". I would make the function name
> "parenthesized_string" or "extract_parenthesized_string".

OK, see below.

> 
>>  
>> +	/* check for a parenthesized string: char x[] = ("string"); */
>> +	if (is_char && (p = paren_string(expr)))
>> +		expr = p;
>> +
> 
> I want to move this test to inside the switch statement.
> The parenthesized string is a very rare case. Adding the test
> here make the common case pay a price.

OK

> 
>>  	switch (expr->type) {
>>  	case EXPR_INITIALIZER: {
>>  		struct expression *entry;
>> @@ -296,6 +313,10 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
>>  				if (entry->idx_to >= nr)
>>  					nr = entry->idx_to+1;
>>  				break;
>> +			case EXPR_PREOP:
>> +				/* check for char x[] = {("string")}; */
>> +				if (is_char && (p = paren_string(entry)))
>> +					entry = p;
>>  			case EXPR_STRING:
>>  				if (is_char)
>>  					str_len = entry->string->length;
> 
> OK, here is the subtle bug. Consider the case expr->type ==  EXPR_PREOP
> and is_char == 1 and paren_string(entry) return false.

Heh, indeed.

> 
> If you have better way to write it I am open to it.
> 

Well, I don't know that it's better; but the following patch (with or
without the diff applied) *reads* better to me. :-D

Note that the patch given below, after the scissors mark, keeps the
"fall through" into the string case, but I actually prefer not to do
so, and would add this (at least) on top:

  diff --git a/symbol.c b/symbol.c
  index 4e7b6e2..06e9596 100644
  --- a/symbol.c
  +++ b/symbol.c
  @@ -312,12 +312,12 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
   			case EXPR_PREOP:
   				/* check for: char x[] = {("string")}; */
   				p = parenthesized_string(entry);
  -				if (!(is_char && p)) {
  -					nr++;
  -					break;
  +				if (is_char && p) {
  +					entry = p;
  +					str_len = entry->string->length;
   				}
  -				entry = p;
  -				/* fall through to string */
  +				nr++;
  +				break;
   			case EXPR_STRING:
   				if (is_char)
   					str_len = entry->string->length;
  @@ -332,10 +332,11 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
   	case EXPR_PREOP:
   		/* check for parenthesized string: char x[] = ("string"); */
   		p = parenthesized_string(expr);
  -		if (!(is_char && p))
  -			break;
  -		expr = p;
  -		/* fall through to string */
  +		if (is_char && p) {
  +			expr = p;
  +			nr = expr->string->length;
  +		}
  +		break;
   	case EXPR_STRING:
   		if (is_char)
   			nr = expr->string->length;
  
Actually, I've just noticed that the last hunk above can be simplified
even further (there is no need to assign p to expr, just use p directly
in the assignment to nr).

[I would also consider making the string case self contained and not
falling through to the default case; i.e. add the "nr++;" and "break;"
statements.]

I have tested the patch below as-is, *and* with the above squashed in, on
Linux, cygwin and MinGW. Note, also, that the test has been fixed up.

Anyway, I will leave to choice of solution to you. ;-)

HTH

ATB,
Ramsay Jones


-- >8 --
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Date: Thu, 16 May 2013 20:44:11 +0100
Subject: [PATCH] symbol.c: Set correct size of array from parenthesized string initializer

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 symbol.c                      | 30 ++++++++++++++++++++++++++++++
 validation/init-char-array1.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 validation/init-char-array1.c

diff --git a/symbol.c b/symbol.c
index 80a2f23..4e7b6e2 100644
--- a/symbol.c
+++ b/symbol.c
@@ -269,8 +269,21 @@ void merge_type(struct symbol *sym, struct symbol *base_type)
 		merge_type(sym, sym->ctype.base_type);
 }
 
+static struct expression *parenthesized_string(struct expression *expr)
+{
+	if (expr && expr->type == EXPR_PREOP && expr->op == '(') {
+		struct expression *e = expr;
+		while (e && e->type == EXPR_PREOP && e->op == '(')
+			e = e->unop;
+		if (e && e->type == EXPR_STRING)
+			return e;
+	}
+	return NULL;
+}
+
 static int count_array_initializer(struct symbol *t, struct expression *expr)
 {
+	struct expression *p;
 	int nr = 0;
 	int is_char = 0;
 
@@ -296,6 +309,15 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
 				if (entry->idx_to >= nr)
 					nr = entry->idx_to+1;
 				break;
+			case EXPR_PREOP:
+				/* check for: char x[] = {("string")}; */
+				p = parenthesized_string(entry);
+				if (!(is_char && p)) {
+					nr++;
+					break;
+				}
+				entry = p;
+				/* fall through to string */
 			case EXPR_STRING:
 				if (is_char)
 					str_len = entry->string->length;
@@ -307,9 +329,17 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
 			nr = str_len;
 		break;
 	}
+	case EXPR_PREOP:
+		/* check for parenthesized string: char x[] = ("string"); */
+		p = parenthesized_string(expr);
+		if (!(is_char && p))
+			break;
+		expr = p;
+		/* fall through to string */
 	case EXPR_STRING:
 		if (is_char)
 			nr = expr->string->length;
+		break;
 	default:
 		break;
 	}
diff --git a/validation/init-char-array1.c b/validation/init-char-array1.c
new file mode 100644
index 0000000..923741f
--- /dev/null
+++ b/validation/init-char-array1.c
@@ -0,0 +1,28 @@
+/*
+ * for array of char, ("...") as the initializer is an gcc language
+ * extension. check that a parenthesized string initializer is handled
+ * correctly and that -Wparen-string warns about it's use.
+ */
+static const char u[] = ("hello");
+static const char v[] = {"hello"};
+static const char w[] = {("hello")};
+static const char x[] = "hello";
+static const char y[5] = "hello";
+
+static void f(void)
+{
+	char a[1/(sizeof(u) == 6)];
+	char b[1/(sizeof(v) == 6)];
+	char c[1/(sizeof(w) == 6)];
+	char d[1/(sizeof(x) == 6)];
+	char e[1/(sizeof(y) == 5)];
+}
+/*
+ * check-name: parenthesized string initializer
+ * check-command: sparse -Wparen-string $file
+ *
+ * check-error-start
+init-char-array1.c:6:26: warning: array initialized from parenthesized string constant
+init-char-array1.c:8:27: warning: array initialized from parenthesized string constant
+ * check-error-end
+ */
-- 
1.8.3



