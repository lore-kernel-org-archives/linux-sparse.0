From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH RFC 03/13] expression: examine constness of binops and alike at evaluation only
Date: Thu, 23 Jul 2015 01:14:37 +0200
Message-ID: <87io9bkco2.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:32803 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbbGVXOk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2015 19:14:40 -0400
Received: by wicmv11 with SMTP id mv11so509443wic.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2015 16:14:39 -0700 (PDT)
Received: from localhost.localdomain (x55b1cac6.dyn.telefonica.de. [85.177.202.198])
        by smtp.gmail.com with ESMTPSA id d17sm4588565wjs.32.2015.07.22.16.14.38
        for <linux-sparse@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 16:14:38 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

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
 evaluate.c                   | 24 ++++++++----------------
 expression.c                 |  4 ----
 validation/constexpr-binop.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 20 deletions(-)
 create mode 100644 validation/constexpr-binop.c

diff --git a/evaluate.c b/evaluate.c
index 90d6da0..637824c 100644
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
+	expr->flags |= expr_flags_decay_consts(expr->left->flags &
+					expr->right->flags);
+	expr->flags &= ~expr_clear_flag_mask(EXPR_FLAG_ADDR_CONST_EXPR);
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
+		expr->flags |= expr_flags_decay_consts(expr->left->flags &
+						expr->right->flags);
+
 		if ((lclass | rclass) & TYPE_FLOAT) {
 			switch (op) {
 			case '+': case '-': case '*': case '/':
@@ -1001,11 +996,8 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	struct symbol *ctype;
 	const char *typediff;
 
-	if (expr->flags) {
-		if (!(expr->left->flags & expr->right->flags &
-				EXPR_FLAG_INT_CONST_EXPR))
-			expr->flags = EXPR_FLAG_NONE;
-	}
+	expr->flags |= expr_flags_decay_consts(left->flags & right->flags);
+	expr->flags &= ~expr_clear_flag_mask(EXPR_FLAG_ADDR_CONST_EXPR);
 
 	/* Type types? */
 	if (is_type_type(ltype) && is_type_type(rtype))
diff --git a/expression.c b/expression.c
index 9a0cd8c..b52ae15 100644
--- a/expression.c
+++ b/expression.c
@@ -147,7 +147,6 @@ static struct token *builtin_types_compatible_p_expr(struct token *token,
 {
 	struct expression *expr = alloc_expression(
 		token->pos, EXPR_COMPARE);
-	expr->flags = expr_set_flag_mask(EXPR_FLAG_INT_CONST_EXPR);
 	expr->op = SPECIAL_EQUAL;
 	token = token->next;
 	if (!match_op(token, '('))
@@ -760,9 +759,6 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 				sparse_error(next->pos, "No right hand side of '%s'-expression", show_special(op));	\
 				break;					\
 			}						\
-			top->flags					\
-				= expr_flags_decay_consts(left->flags	\
-							& right->flags); \
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
2.4.5

