From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 04/25] constexpr: examine constness of binops and alike at evaluation only
Date: Fri, 31 Mar 2017 03:44:38 +0200
Message-ID: <20170331014459.9351-5-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35122 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934742AbdCaBqd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:33 -0400
Received: by mail-wr0-f194.google.com with SMTP id p52so16621133wrc.2
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:32 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

Move the whole calculation of binary operations', compare and logical
expressions' constness flags to the evaluation phase such that expressions
like

  0 + __builtin_choose_expr(0, 0, 0)
  0 < __builtin_choose_expr(0, 0, 0)
  0 && __builtin_choose_expr(0, 0, 0)

can now be recognized as qualifying as integer constant expressions.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                   | 19 ++++++-------------
 expression.c                 |  3 ---
 validation/constexpr-binop.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 16 deletions(-)
 create mode 100644 validation/constexpr-binop.c

diff --git a/evaluate.c b/evaluate.c
index 5725e898f..48530f28c 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -889,10 +889,8 @@ static struct symbol *evaluate_logical(struct expression *expr)
 
 	/* the result is int [6.5.13(3), 6.5.14(3)] */
 	expr->ctype = &int_ctype;
-	if (expr->flags) {
-		if (!(expr->left->flags & expr->right->flags & CEF_ICE))
-			expr->flags = CEF_NONE;
-	}
+	expr->flags = expr->left->flags & expr->right->flags;
+	expr->flags &= ~CEF_CONST_MASK;
 	return &int_ctype;
 }
 
@@ -903,13 +901,11 @@ static struct symbol *evaluate_binop(struct expression *expr)
 	int rclass = classify_type(expr->right->ctype, &rtype);
 	int op = expr->op;
 
-	if (expr->flags) {
-		if (!(expr->left->flags & expr->right->flags & CEF_ICE))
-			expr->flags = CEF_NONE;
-	}
-
 	/* number op number */
 	if (lclass & rclass & TYPE_NUM) {
+		expr->flags = expr->left->flags & expr->right->flags;
+		expr->flags &= ~CEF_CONST_MASK;
+
 		if ((lclass | rclass) & TYPE_FLOAT) {
 			switch (op) {
 			case '+': case '-': case '*': case '/':
@@ -1010,10 +1006,7 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	struct symbol *ctype;
 	const char *typediff;
 
-	if (expr->flags) {
-		if (!(expr->left->flags & expr->right->flags & CEF_ICE))
-			expr->flags = CEF_NONE;
-	}
+	expr->flags = left->flags & right->flags & ~CEF_CONST_MASK;
 
 	/* Type types? */
 	if (is_type_type(ltype) && is_type_type(rtype))
diff --git a/expression.c b/expression.c
index 3262cf22c..b59af8886 100644
--- a/expression.c
+++ b/expression.c
@@ -146,7 +146,6 @@ static struct token *builtin_types_compatible_p_expr(struct token *token,
 {
 	struct expression *expr = alloc_expression(
 		token->pos, EXPR_COMPARE);
-	expr->flags = CEF_SET_ICE;
 	expr->op = SPECIAL_EQUAL;
 	token = token->next;
 	if (!match_op(token, '('))
@@ -758,8 +757,6 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 				sparse_error(next->pos, "No right hand side of '%s'-expression", show_special(op));	\
 				break;					\
 			}						\
-			top->flags = left->flags & right->flags		\
-						& ~CEF_CONST_MASK;	\
 			top->op = op;					\
 			top->left = left;				\
 			top->right = right;				\
diff --git a/validation/constexpr-binop.c b/validation/constexpr-binop.c
new file mode 100644
index 000000000..85a88e3cd
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
2.12.0

