From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v2 03/13] expression: examine constness of binops and alike at evaluation only
Date: Mon, 25 Jan 2016 15:52:14 +0100
Message-ID: <87h9i1g19d.fsf@gmail.com>
References: <87twm1g1go.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36468 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757132AbcAYOwT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 09:52:19 -0500
Received: by mail-wm0-f66.google.com with SMTP id l65so11734357wmf.3
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 06:52:18 -0800 (PST)
In-Reply-To: <87twm1g1go.fsf@gmail.com> (Nicolai Stange's message of "Mon, 25
	Jan 2016 15:47:51 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Nicolai Stange <nicstange@gmail.com>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, the propagation of expressions' constness flags through
binary operations, compare and logical expressions is done in two
steps:
- Several flags are speculatively set at expression parsing time
- and possibly cleared again at evaluation time.

Set aside this unfortunate split of code, the early propagation of
constness flags is not able to recognize constant expressions such as
  0 + __builtin_choose_expr(0, 0, 0)
  0 < __builtin_choose_expr(0, 0, 0)
  0 && __builtin_choose_expr(0, 0, 0)
since the final expression to be thrown into the binop-like expression
is known only after evaluation.

Move the whole calculation of binary operations', compare and logical
expressions' constness flags to the evaluation phase.

Introduce support for tracking arithmetic constness propagation through
binop-like expressions.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c                   | 25 +++++++++----------------
 expression.c                 |  3 ---
 validation/constexpr-binop.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 19 deletions(-)
 create mode 100644 validation/constexpr-binop.c

diff --git a/evaluate.c b/evaluate.c
index 11917ee..5e3e2ca 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -878,11 +878,9 @@ static struct symbol *evaluate_logical(struct expression *expr)
 
 	/* the result is int [6.5.13(3), 6.5.14(3)] */
 	expr->ctype = &int_ctype;
-	if (expr->flags) {
-		if (!(expr->left->flags & expr->right->flags &
-				EXPR_FLAG_INT_CONST_EXPR))
-			expr->flags = EXPR_FLAG_NONE;
-	}
+	expr->flags = expr->left->flags & expr->right->flags;
+	expr_flags_decay_consts(&expr->flags);
+	expr_clear_flag(&expr->flags, EXPR_FLAG_ADDR_CONST_EXPR);
 	return &int_ctype;
 }
 
@@ -893,14 +891,11 @@ static struct symbol *evaluate_binop(struct expression *expr)
 	int rclass = classify_type(expr->right->ctype, &rtype);
 	int op = expr->op;
 
-	if (expr->flags) {
-		if (!(expr->left->flags & expr->right->flags &
-				EXPR_FLAG_INT_CONST_EXPR))
-			expr->flags = EXPR_FLAG_NONE;
-	}
-
 	/* number op number */
 	if (lclass & rclass & TYPE_NUM) {
+		expr->flags = expr->left->flags & expr->right->flags;
+		expr_flags_decay_consts(&expr->flags);
+
 		if ((lclass | rclass) & TYPE_FLOAT) {
 			switch (op) {
 			case '+': case '-': case '*': case '/':
@@ -1001,11 +996,9 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	struct symbol *ctype;
 	const char *typediff;
 
-	if (expr->flags) {
-		if (!(expr->left->flags & expr->right->flags &
-				EXPR_FLAG_INT_CONST_EXPR))
-			expr->flags = EXPR_FLAG_NONE;
-	}
+	expr->flags = left->flags & right->flags;
+	expr_flags_decay_consts(&expr->flags);
+	expr_clear_flag(&expr->flags, EXPR_FLAG_ADDR_CONST_EXPR);
 
 	/* Type types? */
 	if (is_type_type(ltype) && is_type_type(rtype))
diff --git a/expression.c b/expression.c
index 33f4581..e49a19d 100644
--- a/expression.c
+++ b/expression.c
@@ -146,7 +146,6 @@ static struct token *builtin_types_compatible_p_expr(struct token *token,
 {
 	struct expression *expr = alloc_expression(
 		token->pos, EXPR_COMPARE);
-	expr_set_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);
 	expr->op = SPECIAL_EQUAL;
 	token = token->next;
 	if (!match_op(token, '('))
@@ -761,8 +760,6 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 				sparse_error(next->pos, "No right hand side of '%s'-expression", show_special(op));	\
 				break;					\
 			}						\
-			top->flags = left->flags & right->flags;	\
-			expr_flags_decay_consts(&top->flags);		\
 			top->op = op;					\
 			top->left = left;				\
 			top->right = right;				\
diff --git a/validation/constexpr-binop.c b/validation/constexpr-binop.c
new file mode 100644
index 0000000..85a88e3
--- /dev/null
+++ b/validation/constexpr-binop.c
@@ -0,0 +1,33 @@
+static int a[] = {
+	[0 + 0] = 0,						// OK
+	[0 + 0.] = 0,						// KO
+	[(void*)0 + 0] = 0,					// KO
+	[0 + __builtin_choose_expr(0, 0, 0)] = 0,		// OK
+	[0 + __builtin_choose_expr(0, 0., 0)] = 0,		// OK
+	[0 + __builtin_choose_expr(0, 0, 0.)] = 0,		// KO
+	[0 < 0] = 0,						// OK
+	[0 < 0.] = 0,						// KO
+	[0 < __builtin_choose_expr(0, 0, 0)] = 0,		// OK
+	[0 < __builtin_choose_expr(0, 0., 0)] = 0,		// OK
+	[0 < __builtin_choose_expr(0, 0, 0.)] = 0,		// KO
+	[0 && 0] = 0,						// OK
+	[0 && 0.] = 0,						// KO
+	[0 && __builtin_choose_expr(0, 0, 0)] = 0,		// OK
+	[0 && __builtin_choose_expr(0, 0., 0)] = 0,		// OK
+	[0 && __builtin_choose_expr(0, 0, 0.)] = 0,		// KO
+	[0 + __builtin_types_compatible_p(int, float)] = 0,	// OK
+};
+
+/*
+ * check-name: Expression constness propagation in binops and alike
+ *
+ * check-error-start
+constexpr-binop.c:3:12: error: bad constant expression
+constexpr-binop.c:4:19: error: bad integer constant expression
+constexpr-binop.c:7:12: error: bad constant expression
+constexpr-binop.c:9:12: error: bad integer constant expression
+constexpr-binop.c:12:12: error: bad integer constant expression
+constexpr-binop.c:14:12: error: bad integer constant expression
+constexpr-binop.c:17:12: error: bad integer constant expression
+ * check-error-end
+ */
-- 
2.7.0

