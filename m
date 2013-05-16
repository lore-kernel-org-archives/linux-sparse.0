From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/3] symbol.c: Set correct size of array from parenthesized
 string initializer
Date: Thu, 16 May 2013 20:44:11 +0100
Message-ID: <5195370B.9080702@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:51499 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753110Ab3EPTyN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 May 2013 15:54:13 -0400
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 1652B400A65
	for <linux-sparse@vger.kernel.org>; Thu, 16 May 2013 20:47:38 +0100 (BST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 symbol.c                      | 10 ++++++++++
 validation/init-char-array1.c | 25 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 validation/init-char-array1.c

diff --git a/symbol.c b/symbol.c
index 80a2f23..051a909 100644
--- a/symbol.c
+++ b/symbol.c
@@ -284,6 +284,15 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
 	if (t->ctype.base_type == &int_type && t->ctype.modifiers & MOD_CHAR)
 		is_char = 1;
 
+	/* check for a parenthesized string: char x[] = ("string"); */
+	if (is_char && expr->type == EXPR_PREOP && expr->op == '(') {
+		struct expression *e = expr;
+		while (e && e->type == EXPR_PREOP && e->op == '(')
+			e = e->unop;
+		if (e && e->type == EXPR_STRING)
+			expr = e;
+	}
+
 	switch (expr->type) {
 	case EXPR_INITIALIZER: {
 		struct expression *entry;
@@ -310,6 +319,7 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
 	case EXPR_STRING:
 		if (is_char)
 			nr = expr->string->length;
+		break;
 	default:
 		break;
 	}
diff --git a/validation/init-char-array1.c b/validation/init-char-array1.c
new file mode 100644
index 0000000..7427702
--- /dev/null
+++ b/validation/init-char-array1.c
@@ -0,0 +1,25 @@
+/*
+ * for array of char, ("...") as the initializer is an gcc language
+ * extension. check that a parenthesized string initializer is handled
+ * correctly and that -Wparen-string warns about it's use.
+ */
+static const char u[] = ("hello");
+static const char v[] = {"hello"};
+static const char w[] = "hello";
+static const char x[5] = "hello";
+
+static void f(void)
+{
+	char a[1/(sizeof(u) == 6)];
+	char b[1/(sizeof(v) == 6)];
+	char c[1/(sizeof(w) == 6)];
+	char d[1/(sizeof(x) == 5)];
+}
+/*
+ * check-name: parenthesized string initializer
+ * check-command: sparse -Wparen-string $file
+ *
+ * check-error-start
+init-char-array1.c:6:26: warning: array initialized from parenthesized string constant
+ * check-error-end
+ */
-- 
1.8.2

