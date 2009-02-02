From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH] Fix type_info_expression()
Date: Mon, 2 Feb 2009 07:31:51 +0000
Message-ID: <20090202073151.GC28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:46862 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbZBBHbw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Feb 2009 02:31:52 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LTtHb-0006ef-8O
	for linux-sparse@vger.kernel.org; Mon, 02 Feb 2009 07:31:51 +0000
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

sizeof (typename){initializers}.foo is nice and valid C99 - it's parsed
as sizeof primary.foo <- sizeof postfix.foo <- sizeof postfix <- sizeof unary
<- unary.  Current type_info_expression() stops too early.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 expression.c                         |   12 ++++++++++--
 validation/sizeof-compound-postfix.c |    8 ++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100644 validation/sizeof-compound-postfix.c

diff --git a/expression.c b/expression.c
index f634b07..124a8ec 100644
--- a/expression.c
+++ b/expression.c
@@ -594,12 +594,14 @@ static struct token *type_info_expression(struct token *token,
 	struct expression **tree, int type)
 {
 	struct expression *expr = alloc_expression(token->pos, type);
+	struct token *p;
 
 	*tree = expr;
 	expr->flags = Int_const_expr; /* XXX: VLA support will need that changed */
 	token = token->next;
 	if (!match_op(token, '(') || !lookup_type(token->next))
 		return unary_expression(token, &expr->cast_expression);
+	p = token;
 	token = typename(token->next, &expr->cast_type, 0);
 
 	if (!match_op(token, ')')) {
@@ -616,8 +618,14 @@ static struct token *type_info_expression(struct token *token,
 	 * C99 ambiguity: the typename might have been the beginning
 	 * of a typed initializer expression..
 	 */
-	if (match_op(token, '{'))
-		token = initializer(&expr->cast_expression, token);
+	if (match_op(token, '{')) {
+		struct expression *cast = alloc_expression(p->pos, EXPR_CAST);
+		cast->cast_type = expr->cast_type;
+		expr->cast_type = NULL;
+		expr->cast_expression = cast;
+		token = initializer(&cast->cast_expression, token);
+		token = postfix_expression(token, &expr->cast_expression, cast);
+	}
 	return token;
 }
 
diff --git a/validation/sizeof-compound-postfix.c b/validation/sizeof-compound-postfix.c
new file mode 100644
index 0000000..3b716fe
--- /dev/null
+++ b/validation/sizeof-compound-postfix.c
@@ -0,0 +1,8 @@
+struct foo {int x, y;};
+static int a(void)
+{
+	return sizeof (struct foo){0,1}.y;
+}
+/*
+ * check-name: Handling of sizeof compound-literal . member
+ */
-- 
1.5.6.6

