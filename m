From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 8/16] clean up the typechecking in arithmetics
Date: Sun, 24 Jun 2007 09:04:31 +0100
Message-ID: <E1I2N5D-0003dJ-6i@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34692 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbXFXIEc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 04:04:32 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I2N5D-0003dJ-6i
	for linux-sparse@vger.kernel.org; Sun, 24 Jun 2007 09:04:31 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


* evaluate_binop() cleaned up
* evaluate_add(), evaluate_sub(), evaluate_arith() are gone

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |  171 +++++++++++++++++++++++++----------------------------------
 1 files changed, 73 insertions(+), 98 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index e299299..abd3b3e 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -377,6 +377,8 @@ static inline int classify_type(struct symbol *type, struct symbol **base)
 	return type_class[type->type];
 }
 
+#define is_int(class) ((class & (TYPE_NUM | TYPE_FLOAT)) == TYPE_NUM)
+
 static inline int is_string_type(struct symbol *type)
 {
 	if (type->type == SYM_NODE)
@@ -544,30 +546,6 @@ Restr:
 	goto Normal;
 }
 
-static struct symbol *evaluate_arith(struct expression *expr, int float_ok)
-{
-	struct symbol *ltype, *rtype;
-	int lclass = classify_type(expr->left->ctype, &ltype);
-	int rclass = classify_type(expr->right->ctype, &rtype);
-	struct symbol *ctype;
-
-	if (!(lclass & rclass & TYPE_NUM))
-		goto Bad;
-
-	if (!float_ok && (lclass | rclass) & TYPE_FLOAT)
-		goto Bad;
-
-	ctype = usual_conversions(expr->op, expr->left, expr->right,
-				  lclass, rclass, ltype, rtype);
-	expr->left = cast_to(expr->left, ctype);
-	expr->right = cast_to(expr->right, ctype);
-	expr->ctype = ctype;
-	return ctype;
-
-Bad:
-	return bad_expr_type(expr);
-}
-
 static inline int lvalue_expression(struct expression *expr)
 {
 	return expr->type == EXPR_PREOP && expr->op == '*';
@@ -582,20 +560,17 @@ static int ptr_object_size(struct symbol *ptr_type)
 	return ptr_type->bit_size;
 }
 
-static inline int want_int(struct expression **expr, struct symbol **ctype)
+static inline void want_int(struct expression **expr, struct symbol **ctype)
 {
 	int class = classify_type((*expr)->ctype, ctype);
 
-	if (!(class & TYPE_NUM))
-		return 0;
 	if (!(class & TYPE_RESTRICT))
-		return 1;
+		return;
 	warning((*expr)->pos, "restricted degrades to integer");
 	if (class & TYPE_FOULED)	/* unfoul it first */
 		(*ctype) = (*ctype)->ctype.base_type;
 	(*ctype) = (*ctype)->ctype.base_type;	/* get to arithmetic type */
 	*expr = cast_to(*expr, *ctype);
-	return 1;
 }
 
 static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *ctype, struct expression **ip)
@@ -604,8 +579,7 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *c
 	struct symbol *itype;
 	int bit_size;
 
-	if (!want_int(&i, &itype))
-		return bad_expr_type(expr);
+	want_int(&i, &itype);
 
 	examine_symbol_type(ctype);
 
@@ -644,20 +618,6 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *c
 	return ctype;
 }
 
-static struct symbol *evaluate_add(struct expression *expr)
-{
-	struct expression *left = expr->left, *right = expr->right;
-	struct symbol *ltype = left->ctype, *rtype = right->ctype;
-
-	if (is_ptr_type(ltype))
-		return evaluate_ptr_add(expr, degenerate(left), &expr->right);
-
-	if (is_ptr_type(rtype))
-		return evaluate_ptr_add(expr, degenerate(right), &expr->left);
-		
-	return evaluate_arith(expr, 1);
-}
-
 const char * type_difference(struct symbol *target, struct symbol *source,
 	unsigned long target_mod_ignore, unsigned long source_mod_ignore)
 {
@@ -836,23 +796,17 @@ static int is_null_ptr(struct expression *expr)
  */
 #define MOD_IGN (MOD_VOLATILE | MOD_CONST)
 
-static struct symbol *evaluate_ptr_sub(struct expression *expr, struct expression *l)
+static struct symbol *evaluate_ptr_sub(struct expression *expr)
 {
 	const char *typediff;
 	struct symbol *ctype;
 	struct symbol *ltype, *rtype;
+	struct expression *l = expr->left;
 	struct expression *r = expr->right;
 
 	ltype = degenerate(l);
 	rtype = degenerate(r);
 
-	/*
-	 * If it is an integer subtract: the ptr add case will do the
-	 * right thing.
-	 */
-	if (!is_ptr_type(rtype))
-		return evaluate_ptr_add(expr, degenerate(l), &expr->right);
-
 	ctype = ltype;
 	typediff = type_difference(ltype, rtype, ~MOD_SIZE, ~MOD_SIZE);
 	if (typediff)
@@ -896,17 +850,6 @@ static struct symbol *evaluate_ptr_sub(struct expression *expr, struct expressio
 	return ssize_t_ctype;
 }
 
-static struct symbol *evaluate_sub(struct expression *expr)
-{
-	struct expression *left = expr->left;
-	struct symbol *ltype = left->ctype;
-
-	if (is_ptr_type(ltype))
-		return evaluate_ptr_sub(expr, left);
-
-	return evaluate_arith(expr, 1);
-}
-
 #define is_safe_type(type) ((type)->ctype.modifiers & MOD_SAFE)
 
 static struct symbol *evaluate_conditional(struct expression *expr, int iterator)
@@ -942,42 +885,64 @@ static struct symbol *evaluate_logical(struct expression *expr)
 static struct symbol *evaluate_shift(struct expression *expr)
 {
 	struct symbol *ltype, *rtype;
+	struct symbol *ctype;
 
-	if (want_int(&expr->left, &ltype) && want_int(&expr->right, &rtype)) {
-		struct symbol *ctype = integer_promotion(ltype);
-		expr->left = cast_to(expr->left, ctype);
-		expr->ctype = ctype;
-		ctype = integer_promotion(rtype);
-		expr->right = cast_to(expr->right, ctype);
-		return expr->ctype;
-	}
-	return bad_expr_type(expr);
+	want_int(&expr->left, &ltype);
+	want_int(&expr->right, &rtype);
+	ctype = integer_promotion(ltype);
+	expr->left = cast_to(expr->left, ctype);
+	expr->ctype = ctype;
+	ctype = integer_promotion(rtype);
+	expr->right = cast_to(expr->right, ctype);
+	return expr->ctype;
 }
 
 static struct symbol *evaluate_binop(struct expression *expr)
 {
-	switch (expr->op) {
-	// addition can take ptr+int, fp and int
-	case '+':
-		return evaluate_add(expr);
-
-	// subtraction can take ptr-ptr, fp and int
-	case '-':
-		return evaluate_sub(expr);
+	struct symbol *ltype, *rtype, *ctype;
+	int lclass = classify_type(expr->left->ctype, &ltype);
+	int rclass = classify_type(expr->right->ctype, &rtype);
+	int op = expr->op;
 
-	// Arithmetic operations can take fp and int
-	case '*': case '/':
-		return evaluate_arith(expr, 1);
+	/* number op number */
+	if (lclass & rclass & TYPE_NUM) {
+		if ((lclass | rclass) & TYPE_FLOAT) {
+			switch (op) {
+			case '+': case '-': case '*': case '/':
+				break;
+			default:
+				return bad_expr_type(expr);
+			}
+		}
 
-	// shifts do integer promotions, but that's it.
-	case SPECIAL_LEFTSHIFT: case SPECIAL_RIGHTSHIFT:
-		return evaluate_shift(expr);
+		// shifts do integer promotions, but that's it.
+		if (op == SPECIAL_LEFTSHIFT || op == SPECIAL_RIGHTSHIFT)
+			return evaluate_shift(expr);
 
-	// The rest are integer operations
-	// '%', '&', '^', '|'
-	default:
-		return evaluate_arith(expr, 0);
+		// The rest do usual conversions
+		ctype = usual_conversions(op, expr->left, expr->right,
+					  lclass, rclass, ltype, rtype);
+		expr->left = cast_to(expr->left, ctype);
+		expr->right = cast_to(expr->right, ctype);
+		expr->ctype = ctype;
+		return ctype;
 	}
+
+	/* pointer (+|-) integer */
+	if (lclass & TYPE_PTR && is_int(rclass) && (op == '+' || op == '-'))
+		return evaluate_ptr_add(expr, degenerate(expr->left),
+					&expr->right);
+
+	/* integer + pointer */
+	if (rclass & TYPE_PTR && is_int(lclass) && op == '+')
+		return evaluate_ptr_add(expr, degenerate(expr->right),
+					&expr->left);
+
+	/* pointer - pointer */
+	if (lclass & rclass & TYPE_PTR && expr->op == '-')
+		return evaluate_ptr_sub(expr);
+
+	return bad_expr_type(expr);
 }
 
 static struct symbol *evaluate_comma(struct expression *expr)
@@ -1004,6 +969,7 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	struct expression *left = expr->left, *right = expr->right;
 	struct symbol *ltype = left->ctype, *rtype = right->ctype;
 	struct symbol *ctype;
+	int lclass, rclass;
 
 	/* Type types? */
 	if (is_type_type(ltype) && is_type_type(rtype))
@@ -1012,18 +978,27 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	if (is_safe_type(ltype) || is_safe_type(rtype))
 		warning(expr->pos, "testing a 'safe expression'");
 
+	lclass = classify_type(ltype, &ltype);
+	rclass = classify_type(rtype, &rtype);
+
 	/* Pointer types? */
-	if (is_ptr_type(ltype) || is_ptr_type(rtype)) {
+	if ((lclass | rclass) & TYPE_PTR) {
 		// FIXME! Check the types for compatibility
 		expr->op = modify_for_unsigned(expr->op);
 		goto OK;
 	}
 
-	ctype = evaluate_arith(expr, 1);
-	if (ctype) {
-		if (ctype->ctype.modifiers & MOD_UNSIGNED)
-			expr->op = modify_for_unsigned(expr->op);
-	}
+	/* Both should be numbers */
+	if (!(lclass & rclass & TYPE_NUM))
+		return bad_expr_type(expr);
+
+	ctype = usual_conversions(expr->op, expr->left, expr->right,
+				  lclass, rclass, ltype, rtype);
+	expr->left = cast_to(expr->left, ctype);
+	expr->right = cast_to(expr->right, ctype);
+	if (ctype->ctype.modifiers & MOD_UNSIGNED)
+		expr->op = modify_for_unsigned(expr->op);
+
 OK:
 	expr->ctype = &bool_ctype;
 	return &bool_ctype;
@@ -1151,7 +1126,7 @@ static int evaluate_assign_op(struct expression *expr)
 		expr->right = cast_to(expr->right, target);
 		return 0;
 	}
-	if (tclass & TYPE_PTR) {
+	if (tclass & TYPE_PTR && is_int(sclass)) {
 		if (op == SPECIAL_ADD_ASSIGN || op == SPECIAL_SUB_ASSIGN) {
 			evaluate_ptr_add(expr, target, &expr->right);
 			return 1;
-- 
1.5.0-rc2.GIT
