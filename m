From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 3/3] symbol.c: Set correct size of array from parenthesized
 string initializer
Date: Sat, 25 May 2013 21:01:30 +0100
Message-ID: <51A1189A.1010404@ramsay1.demon.co.uk>
References: <5195370B.9080702@ramsay1.demon.co.uk> <51972FDB.6060201@chrisli.org> <5197387E.5030000@gmail.com> <519A6EAD.8070700@ramsay1.demon.co.uk> <519E3582.7060704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:39466 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757816Ab3EYUFJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 25 May 2013 16:05:09 -0400
In-Reply-To: <519E3582.7060704@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Li <christ.li@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Chris Li wrote:
> On 05/20/2013 11:42 AM, Ramsay Jones wrote:
> 
>> Unfortunately not. :(
> 
> Sorry about that.
> 
>>         const char *paths[] = { path, NULL };
> 
> I see where I make the mistake. I need to drop the parentheses
> only for char type. Can you please try this patch again? It is a
> replacement patch of your patch No3. Not a delta. It works for the
> the test case above.
> 
> Let's hope this one works.

Yes, this patch works.

However, it made me go cross-eyed trying to follow the flow of
control. So, I created a new patch, added after the scissor mark
below, which hopefully makes the flow of control easier to follow.

Note that I originally wrote the code like:

    p = paren_string(expr);
    if (is_char && p)
        expr = p;

since sparse source seemed not to use assignments embedded into
conditions, but I stumbled across a few examples:

  $ git grep -n -e 'if (.*([a-zA-Z_]* = [a-zA-Z_]*'
  c2xml.c:173:            if ((base = builtin_typename(sym->ctype.base_type)) == N
  dissect.c:381:                  if ((expr = peek_preop(unop, '*')))
  dissect.c:388:                  if ((expr = peek_preop(unop, '&')))
  ptrlist.c:129:  if (!list || (nr = (last = list->prev)->nr) >= LIST_NODE_NR) {
  show-parse.c:289:       if ((typename = builtin_typename(sym))) {
  $

Also, note that I changed the test to add a check for the length
of the v1 array. Having said that, I had intended to rename the
variables in the test to u->y and a->e (this is a new test, after
all), but I forgot! sorry about that.

ATB,
Ramsay Jones

-- >8 --
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Date: Fri, 8 Apr 2011 23:38:30 +0100
Subject: [PATCH] symbol.c: Set correct size of array from parenthesized string initializer


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 symbol.c                      | 22 ++++++++++++++++++++++
 validation/init-char-array1.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 validation/init-char-array1.c

diff --git a/symbol.c b/symbol.c
index 80a2f23..55e1b47 100644
--- a/symbol.c
+++ b/symbol.c
@@ -269,8 +269,21 @@ void merge_type(struct symbol *sym, struct symbol *base_type)
 		merge_type(sym, sym->ctype.base_type);
 }
 
+static struct expression *paren_string(struct expression *expr)
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
 
@@ -284,6 +297,10 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
 	if (t->ctype.base_type == &int_type && t->ctype.modifiers & MOD_CHAR)
 		is_char = 1;
 
+	/* check for a parenthesized string: char x[] = ("string"); */
+	if (is_char && (p = paren_string(expr)))
+		expr = p;
+
 	switch (expr->type) {
 	case EXPR_INITIALIZER: {
 		struct expression *entry;
@@ -296,6 +313,10 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
 				if (entry->idx_to >= nr)
 					nr = entry->idx_to+1;
 				break;
+			case EXPR_PREOP:
+				/* check for char x[] = {("string")}; */
+				if (is_char && (p = paren_string(entry)))
+					entry = p;
 			case EXPR_STRING:
 				if (is_char)
 					str_len = entry->string->length;
@@ -310,6 +331,7 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
 	case EXPR_STRING:
 		if (is_char)
 			nr = expr->string->length;
+		break;
 	default:
 		break;
 	}
diff --git a/validation/init-char-array1.c b/validation/init-char-array1.c
new file mode 100644
index 0000000..bd4ed68
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
+static const char v1[] = {("hello")};
+static const char w[] = "hello";
+static const char x[5] = "hello";
+
+static void f(void)
+{
+	char a[1/(sizeof(u) == 6)];
+	char b[1/(sizeof(v) == 6)];
+	char b1[1/(sizeof(v1) == 6)];
+	char c[1/(sizeof(w) == 6)];
+	char d[1/(sizeof(x) == 5)];
+}
+/*
+ * check-name: parenthesized string initializer
+ * check-command: sparse -Wparen-string $file
+ *
+ * check-error-start
+init-char-array1.c:6:26: warning: array initialized from parenthesized string constant
+init-char-array1.c:8:28: warning: array initialized from parenthesized string constant
+ * check-error-end
+ */
-- 
1.8.2


