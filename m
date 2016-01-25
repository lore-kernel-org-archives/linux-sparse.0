From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v2 04/13] expression: examine constness of preops at evaluation only
Date: Mon, 25 Jan 2016 15:53:38 +0100
Message-ID: <87d1spg171.fsf@gmail.com>
References: <87twm1g1go.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36142 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756842AbcAYOxl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 09:53:41 -0500
Received: by mail-wm0-f68.google.com with SMTP id l65so11741907wmf.3
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 06:53:40 -0800 (PST)
In-Reply-To: <87twm1g1go.fsf@gmail.com> (Nicolai Stange's message of "Mon, 25
	Jan 2016 15:47:51 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Nicolai Stange <nicstange@gmail.com>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
 evaluate.c                   | 17 ++++++++++++-----
 expression.c                 |  4 ----
 validation/constexpr-preop.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 9 deletions(-)
 create mode 100644 validation/constexpr-preop.c

diff --git a/evaluate.c b/evaluate.c
index 5e3e2ca..5138d40 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1798,8 +1798,10 @@ static struct symbol *evaluate_sign(struct expression *expr)
 {
 	struct symbol *ctype = expr->unop->ctype;
 	int class = classify_type(ctype, &ctype);
-	if (expr->flags && !(expr->unop->flags & EXPR_FLAG_INT_CONST_EXPR))
-		expr->flags = EXPR_FLAG_NONE;
+	unsigned char flags;
+
+	flags = expr->flags | expr->unop->flags;
+	expr_flags_decay_consts(&flags);
 	/* should be an arithmetic type */
 	if (!(class & TYPE_NUM))
 		return bad_expr_type(expr);
@@ -1816,6 +1818,7 @@ Normal:
 	}
 	if (expr->op == '+')
 		*expr = *expr->unop;
+	expr->flags = flags;
 	expr->ctype = ctype;
 	return ctype;
 Restr:
@@ -1853,9 +1856,13 @@ static struct symbol *evaluate_preop(struct expression *expr)
 		return evaluate_postop(expr);
 
 	case '!':
-		if (expr->flags && !(expr->unop->flags &
-					EXPR_FLAG_INT_CONST_EXPR))
-			expr->flags = EXPR_FLAG_NONE;
+		expr->flags = expr->unop->flags;
+		expr_flags_decay_consts(&expr->flags);
+		/*
+		 * A logical negation never yields an address constant
+		 * [6.6(9)].
+		 */
+		expr_clear_flag(&expr->flags, EXPR_FLAG_ADDR_CONST_EXPR);
 		if (is_safe_type(ctype))
 			warning(expr->pos, "testing a 'safe expression'");
 		if (is_float_type(ctype)) {
diff --git a/expression.c b/expression.c
index e49a19d..377834e 100644
--- a/expression.c
+++ b/expression.c
@@ -452,8 +452,6 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 			expr = alloc_expression(token->pos, EXPR_PREOP);
 			expr->op = '(';
 			token = parens_expression(token, &expr->unop, "in expression");
-			if (expr->unop)
-				expr->flags = expr->unop->flags;
 			break;
 		}
 		if (token->special == '[' && lookup_type(token->next)) {
@@ -665,8 +663,6 @@ static struct token *unary_expression(struct token *token, struct expression **t
 			unary = alloc_expression(token->pos, EXPR_PREOP);
 			unary->op = token->special;
 			unary->unop = unop;
-			unary->flags = unop->flags;
-			expr_flags_decay_consts(&unary->flags);
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
2.7.0

