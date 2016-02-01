From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 04/21] expression: examine constness of binops and alike at evaluation only
Date: Mon, 01 Feb 2016 03:32:32 +0100
Message-ID: <874mdtjh33.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34110 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933536AbcBACcf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:32:35 -0500
Received: by mail-wm0-f66.google.com with SMTP id p63so7015082wmp.1
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:32:34 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

Move the whole calculation of binary operations', compare and logical
expressions' constness flags to the evaluation phase such that expressions
like

  0 + __builtin_choose_expr(0, 0, 0)
  0 < __builtin_choose_expr(0, 0, 0)
  0 && __builtin_choose_expr(0, 0, 0)

can now be recognized as qualifying as integer constant expressions.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c                   | 28 +++++++++-------------------
 expression.c                 |  5 -----
 validation/constexpr-binop.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 24 deletions(-)
 create mode 100644 validation/constexpr-binop.c

diff --git a/evaluate.c b/evaluate.c
index 24a7f2f..32e5930 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -878,12 +878,9 @@ static struct symbol *evaluate_logical(struct expression *expr)
 
 	/* the result is int [6.5.13(3), 6.5.14(3)] */
 	expr->ctype = &int_ctype;
-	if (expr->constexpr_flags) {
-		if (!(expr->left->constexpr_flags &
-				expr->right->constexpr_flags &
-				CONSTEXPR_FLAG_INT_CONST_EXPR))
-			expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
-	}
+	expr->constexpr_flags = expr->left->constexpr_flags &
+		expr->right->constexpr_flags &
+		~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
 	return &int_ctype;
 }
 
@@ -894,15 +891,12 @@ static struct symbol *evaluate_binop(struct expression *expr)
 	int rclass = classify_type(expr->right->ctype, &rtype);
 	int op = expr->op;
 
-	if (expr->constexpr_flags) {
-		if (!(expr->left->constexpr_flags &
-				expr->right->constexpr_flags &
-				CONSTEXPR_FLAG_INT_CONST_EXPR))
-			expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
-	}
-
 	/* number op number */
 	if (lclass & rclass & TYPE_NUM) {
+		expr->constexpr_flags = expr->left->constexpr_flags &
+			expr->right->constexpr_flags &
+			~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
+
 		if ((lclass | rclass) & TYPE_FLOAT) {
 			switch (op) {
 			case '+': case '-': case '*': case '/':
@@ -1004,12 +998,8 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	struct symbol *ctype;
 	const char *typediff;
 
-	if (expr->constexpr_flags) {
-		if (!(expr->left->constexpr_flags &
-				expr->right->constexpr_flags &
-				CONSTEXPR_FLAG_INT_CONST_EXPR))
-			expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
-	}
+	expr->constexpr_flags = left->constexpr_flags &
+		right->constexpr_flags & ~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
 
 	/* Type types? */
 	if (is_type_type(ltype) && is_type_type(rtype))
diff --git a/expression.c b/expression.c
index 759bee8..5970b1b 100644
--- a/expression.c
+++ b/expression.c
@@ -147,7 +147,6 @@ static struct token *builtin_types_compatible_p_expr(struct token *token,
 {
 	struct expression *expr = alloc_expression(
 		token->pos, EXPR_COMPARE);
-	expr->constexpr_flags = CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
 	expr->op = SPECIAL_EQUAL;
 	token = token->next;
 	if (!match_op(token, '('))
@@ -766,10 +765,6 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 				sparse_error(next->pos, "No right hand side of '%s'-expression", show_special(op));	\
 				break;					\
 			}						\
-			top->constexpr_flags =				\
-				left->constexpr_flags &		\
-				right->constexpr_flags &		\
-				~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;	\
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

