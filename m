From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] warn on empty parenthesized expressions
Date: Thu, 28 Dec 2017 18:25:18 +0100
Message-ID: <20171228172519.16550-2-luc.vanoostenryck@gmail.com>
References: <20171228172519.16550-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45184 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbdL1RZi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 12:25:38 -0500
Received: by mail-wm0-f65.google.com with SMTP id 9so44933764wme.4
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 09:25:37 -0800 (PST)
In-Reply-To: <20171228172519.16550-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Empty sub-expressions are normally caught as syntax error
in most expressions but this is not the case for parenthesized
expressions.

Fix this by adding a check at the end of parens_expressions()
and warning if needed.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expression.c            |  6 ++++++
 validation/empty-expr.c | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 validation/empty-expr.c

diff --git a/expression.c b/expression.c
index e5ebad65b..6f4300b9a 100644
--- a/expression.c
+++ b/expression.c
@@ -62,7 +62,10 @@ static struct token *comma_expression(struct token *, struct expression **);
 
 struct token *parens_expression(struct token *token, struct expression **expr, const char *where)
 {
+	struct token *p;
+
 	token = expect(token, '(', where);
+	p = token;
 	if (match_op(token, '{')) {
 		struct expression *e = alloc_expression(token->pos, EXPR_STATEMENT);
 		struct statement *stmt = alloc_statement(token->pos, STMT_COMPOUND);
@@ -74,6 +77,9 @@ struct token *parens_expression(struct token *token, struct expression **expr, c
 		token = expect(token, '}', "at end of statement expression");
 	} else
 		token = parse_expression(token, expr);
+
+	if (token == p)
+		sparse_error(token->pos, "an expression is expected before ')'");
 	return expect(token, ')', where);
 }
 
diff --git a/validation/empty-expr.c b/validation/empty-expr.c
new file mode 100644
index 000000000..506cfba7e
--- /dev/null
+++ b/validation/empty-expr.c
@@ -0,0 +1,27 @@
+static int foo(void)
+{
+	switch () {
+	case 0:
+		return 0;
+	default:
+		return 1;
+	}
+}
+
+static int bar(void)
+{
+	if ()
+		return 0;
+	else
+		return 1;
+}
+
+/*
+ * check-name: empty expression
+ * check-known-to-fail
+ *
+ * check-error-start
+empty-expr.c:3:17: error: an expression is expected before ')'
+empty-expr.c:13:13: error: an expression is expected before ')'
+ * check-error-end
+ */
-- 
2.15.0

