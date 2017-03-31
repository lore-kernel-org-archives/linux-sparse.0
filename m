From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 05/25] constexpr: examine constness of preops at evaluation only
Date: Fri, 31 Mar 2017 03:44:39 +0200
Message-ID: <20170331014459.9351-6-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35127 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934847AbdCaBqe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:34 -0400
Received: by mail-wr0-f196.google.com with SMTP id p52so16621170wrc.2
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:33 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

Move the whole calculation of prefix expressions' constness flags to
the evaluation phase such that expressions like

  -__builtin_choose_expr(0, 0, 0)
  ~__builtin_choose_expr(0, 0, 0)
  !__builtin_choose_expr(0, 0, 0)

can now be recognized as qualifying as integer constant expressions.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                   |  8 ++++----
 expression.c                 |  3 ---
 validation/constexpr-preop.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 7 deletions(-)
 create mode 100644 validation/constexpr-preop.c

diff --git a/evaluate.c b/evaluate.c
index 48530f28c..07788eacc 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1805,8 +1805,8 @@ static struct symbol *evaluate_sign(struct expression *expr)
 {
 	struct symbol *ctype = expr->unop->ctype;
 	int class = classify_type(ctype, &ctype);
-	if (expr->flags && !(expr->unop->flags & CEF_ICE))
-		expr->flags = CEF_NONE;
+	unsigned char flags = expr->unop->flags & ~CEF_CONST_MASK;
+
 	/* should be an arithmetic type */
 	if (!(class & TYPE_NUM))
 		return bad_expr_type(expr);
@@ -1823,6 +1823,7 @@ Normal:
 	}
 	if (expr->op == '+')
 		*expr = *expr->unop;
+	expr->flags = flags;
 	expr->ctype = ctype;
 	return ctype;
 Restr:
@@ -1860,8 +1861,7 @@ static struct symbol *evaluate_preop(struct expression *expr)
 		return evaluate_postop(expr);
 
 	case '!':
-		if (expr->flags && !(expr->unop->flags & CEF_ICE))
-			expr->flags = CEF_NONE;
+		expr->flags = expr->unop->flags & ~CEF_CONST_MASK;
 		if (is_safe_type(ctype))
 			warning(expr->pos, "testing a 'safe expression'");
 		if (is_float_type(ctype)) {
diff --git a/expression.c b/expression.c
index b59af8886..0332c4406 100644
--- a/expression.c
+++ b/expression.c
@@ -450,8 +450,6 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 			expr = alloc_expression(token->pos, EXPR_PREOP);
 			expr->op = '(';
 			token = parens_expression(token, &expr->unop, "in expression");
-			if (expr->unop)
-				expr->flags = expr->unop->flags;
 			break;
 		}
 		if (token->special == '[' && lookup_type(token->next)) {
@@ -663,7 +661,6 @@ static struct token *unary_expression(struct token *token, struct expression **t
 			unary = alloc_expression(token->pos, EXPR_PREOP);
 			unary->op = token->special;
 			unary->unop = unop;
-			unary->flags = unop->flags & ~CEF_CONST_MASK;
 			*tree = unary;
 			return next;
 		}
diff --git a/validation/constexpr-preop.c b/validation/constexpr-preop.c
new file mode 100644
index 000000000..5d869da4f
--- /dev/null
+++ b/validation/constexpr-preop.c
@@ -0,0 +1,29 @@
+static int a[] = {
+  [+0] = 0,					// OK
+  [+__builtin_choose_expr(0, 0, 0)] = 0,	// OK
+  [+0.] = 0,					// KO
+  [+__builtin_choose_expr(0, 0, 0.)] = 0,	// KO
+  [-0] = 0,					// OK
+  [-__builtin_choose_expr(0, 0, 0)] = 0,	// OK
+  [-0.] = 0,					// KO
+  [-__builtin_choose_expr(0, 0, 0.)] = 0,	// KO
+  [~0] = 0,					// OK
+  [~__builtin_choose_expr(0, 0, 0)] = 0,	// OK
+  [!0] = 0,					// OK
+  [!__builtin_choose_expr(0, 0, 0)] = 0,	// OK
+  [!0.] = 0,					// KO
+  [!__builtin_choose_expr(0, 0, 0.)] = 0,	// KO
+};
+
+/*
+ * check-name: Expression constness propagation in preops
+ *
+ * check-error-start
+constexpr-preop.c:4:5: error: bad constant expression
+constexpr-preop.c:5:33: error: bad constant expression
+constexpr-preop.c:8:4: error: bad constant expression
+constexpr-preop.c:9:4: error: bad constant expression
+constexpr-preop.c:14:4: error: bad integer constant expression
+constexpr-preop.c:15:4: error: bad integer constant expression
+ * check-error-end
+ */
-- 
2.12.0

