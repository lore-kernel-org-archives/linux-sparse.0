From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH RFC 04/13] expression: examine constness of preops at evaluation only
Date: Thu, 23 Jul 2015 01:15:40 +0200
Message-ID: <87egjzkcmb.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35145 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbbGVXPo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2015 19:15:44 -0400
Received: by wibxm9 with SMTP id xm9so184201962wib.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2015 16:15:43 -0700 (PDT)
Received: from localhost.localdomain (x55b1cac6.dyn.telefonica.de. [85.177.202.198])
        by smtp.gmail.com with ESMTPSA id e2sm4605873wjw.12.2015.07.22.16.15.41
        for <linux-sparse@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 16:15:42 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Currently, the propagation of expressions' constness flags through
prefix expressions is done in two steps:
- Several flags are speculatively set at expression parsing time
- and possibly cleared again at evaluation time.

Set aside this unfortunate split of code, the early propagation of
constness flags is not able to recognize constant expressions such as
  -__builtin_choose_expr(0, 0, 0)
  ~__builtin_choose_expr(0, 0, 0)
  !__builtin_choose_expr(0, 0, 0)
since the final expression to be thrown into the prefix expression is
known only after evaluation.

Move the whole calculation of prefix expressions' constness flags to
the evaluation phase.

Introduce support for tracking arithmetic constness propagation through
prefix expressions.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c                   | 15 ++++++++++-----
 expression.c                 |  3 ---
 validation/constexpr-preop.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 8 deletions(-)
 create mode 100644 validation/constexpr-preop.c

diff --git a/evaluate.c b/evaluate.c
index 637824c..e1d2f3d 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1794,8 +1794,9 @@ static struct symbol *evaluate_sign(struct expression *expr)
 {
 	struct symbol *ctype = expr->unop->ctype;
 	int class = classify_type(ctype, &ctype);
-	if (expr->flags && !(expr->unop->flags & EXPR_FLAG_INT_CONST_EXPR))
-		expr->flags = EXPR_FLAG_NONE;
+	enum expression_flags flags;
+
+	flags = expr->flags | expr_flags_decay_consts(expr->unop->flags);
 	/* should be an arithmetic type */
 	if (!(class & TYPE_NUM))
 		return bad_expr_type(expr);
@@ -1812,6 +1813,7 @@ Normal:
 	}
 	if (expr->op == '+')
 		*expr = *expr->unop;
+	expr->flags = flags;
 	expr->ctype = ctype;
 	return ctype;
 Restr:
@@ -1849,9 +1851,12 @@ static struct symbol *evaluate_preop(struct expression *expr)
 		return evaluate_postop(expr);
 
 	case '!':
-		if (expr->flags && !(expr->unop->flags &
-					EXPR_FLAG_INT_CONST_EXPR))
-			expr->flags = EXPR_FLAG_NONE;
+		expr->flags |= expr_flags_decay_consts(expr->unop->flags);
+		/*
+		 * A logical negation never yields an address constant
+		 * [6.6(9)].
+		 */
+		expr->flags &= ~expr_clear_flag_mask(EXPR_FLAG_ADDR_CONST_EXPR);
 		if (is_safe_type(ctype))
 			warning(expr->pos, "testing a 'safe expression'");
 		if (is_float_type(ctype)) {
diff --git a/expression.c b/expression.c
index b52ae15..7759bd0 100644
--- a/expression.c
+++ b/expression.c
@@ -451,8 +451,6 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 			expr = alloc_expression(token->pos, EXPR_PREOP);
 			expr->op = '(';
 			token = parens_expression(token, &expr->unop, "in expression");
-			if (expr->unop)
-				expr->flags = expr->unop->flags;
 			break;
 		}
 		if (token->special == '[' && lookup_type(token->next)) {
@@ -665,7 +663,6 @@ static struct token *unary_expression(struct token *token, struct expression **t
 			unary = alloc_expression(token->pos, EXPR_PREOP);
 			unary->op = token->special;
 			unary->unop = unop;
-			unary->flags = expr_flags_decay_consts(unop->flags);
 			*tree = unary;
 			return next;
 		}
diff --git a/validation/constexpr-preop.c b/validation/constexpr-preop.c
new file mode 100644
index 0000000..5d869da
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
2.4.5

