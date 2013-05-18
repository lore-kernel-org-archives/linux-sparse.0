From: Chris Li <christ.li@gmail.com>
Subject: Re: [PATCH 3/3] symbol.c: Set correct size of array from parenthesized
 string initializer
Date: Sat, 18 May 2013 01:14:54 -0700
Message-ID: <5197387E.5030000@gmail.com>
References: <5195370B.9080702@ramsay1.demon.co.uk> <51972FDB.6060201@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060305040804000206000800"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:41713 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab3ERIPX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 May 2013 04:15:23 -0400
Received: by mail-pd0-f177.google.com with SMTP id g10so3946327pdj.8
        for <linux-sparse@vger.kernel.org>; Sat, 18 May 2013 01:15:22 -0700 (PDT)
In-Reply-To: <51972FDB.6060201@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

This is a multi-part message in MIME format.
--------------060305040804000206000800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 05/18/2013 12:38 AM, Christopher Li wrote:
> I guess the rules is that parenthesized string can appear in
> any place where string was allowed.


I create an incremental patch to address the issue. Please
check if that works for you.

Chris


--------------060305040804000206000800
Content-Type: text/x-patch;
 name="parenthesed-string-improve.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="parenthesed-string-improve.patch"

diff --git a/symbol.c b/symbol.c
index 051a909..a59a4ca 100644
--- a/symbol.c
+++ b/symbol.c
@@ -284,15 +284,6 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
 	if (t->ctype.base_type == &int_type && t->ctype.modifiers & MOD_CHAR)
 		is_char = 1;
 
-	/* check for a parenthesized string: char x[] = ("string"); */
-	if (is_char && expr->type == EXPR_PREOP && expr->op == '(') {
-		struct expression *e = expr;
-		while (e && e->type == EXPR_PREOP && e->op == '(')
-			e = e->unop;
-		if (e && e->type == EXPR_STRING)
-			expr = e;
-	}
-
 	switch (expr->type) {
 	case EXPR_INITIALIZER: {
 		struct expression *entry;
@@ -305,6 +296,15 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
 				if (entry->idx_to >= nr)
 					nr = entry->idx_to+1;
 				break;
+			case EXPR_PREOP: {
+				struct expression *e = entry;
+				while (e && e->type == EXPR_PREOP && e->op == '(')
+					e = e->unop;
+				if (!(e && e->type == EXPR_STRING))
+					break;
+				entry = e;
+				/* fall through to strings. */
+			}
 			case EXPR_STRING:
 				if (is_char)
 					str_len = entry->string->length;
@@ -316,6 +316,15 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
 			nr = str_len;
 		break;
 	}
+	case EXPR_PREOP: {
+		struct expression *e = expr;
+		while (e && e->type == EXPR_PREOP && e->op == '(')
+			e = e->unop;
+		if (!(e && e->type == EXPR_STRING))
+			break;
+		expr = e;
+		/* fall through to strings. */
+	}
 	case EXPR_STRING:
 		if (is_char)
 			nr = expr->string->length;
diff --git a/validation/init-char-array1.c b/validation/init-char-array1.c
index 7427702..24fd8d8 100644
--- a/validation/init-char-array1.c
+++ b/validation/init-char-array1.c
@@ -5,6 +5,7 @@
  */
 static const char u[] = ("hello");
 static const char v[] = {"hello"};
+static const char v1[] = {("hello")};
 static const char w[] = "hello";
 static const char x[5] = "hello";
 
@@ -21,5 +22,6 @@ static void f(void)
  *
  * check-error-start
 init-char-array1.c:6:26: warning: array initialized from parenthesized string constant
+init-char-array1.c:8:28: warning: array initialized from parenthesized string constant
  * check-error-end
  */

--------------060305040804000206000800--
