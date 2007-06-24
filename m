From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 10/16] fix index conversions in evaluate_ptr_add()
Date: Sun, 24 Jun 2007 09:04:51 +0100
Message-ID: <E1I2N5X-0003dl-76@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34705 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbXFXIEw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 04:04:52 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I2N5X-0003dl-76
	for linux-sparse@vger.kernel.org; Sun, 24 Jun 2007 09:04:51 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


index may need to be expanded

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   92 ++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 79f1ac9..6cb29ff 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -559,27 +559,12 @@ static int ptr_object_size(struct symbol *ptr_type)
 	return ptr_type->bit_size;
 }
 
-static inline void want_int(struct expression **expr, struct symbol **ctype)
+static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *ctype, struct symbol *itype)
 {
-	int class = classify_type((*expr)->ctype, ctype);
-
-	if (!(class & TYPE_RESTRICT))
-		return;
-	warning((*expr)->pos, "restricted degrades to integer");
-	if (class & TYPE_FOULED)	/* unfoul it first */
-		(*ctype) = (*ctype)->ctype.base_type;
-	(*ctype) = (*ctype)->ctype.base_type;	/* get to arithmetic type */
-	*expr = cast_to(*expr, *ctype);
-}
-
-static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *ctype, struct expression **ip)
-{
-	struct expression *i = *ip;
-	struct symbol *itype;
+	struct expression *index = expr->right;
+	int multiply;
 	int bit_size;
 
-	want_int(&i, &itype);
-
 	examine_symbol_type(ctype);
 
 	if (!ctype->ctype.base_type) {
@@ -589,31 +574,48 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *c
 
 	/* Get the size of whatever the pointer points to */
 	bit_size = ptr_object_size(ctype);
+	multiply = bit_size >> 3;
+
+	expr->ctype = ctype;
+
+	if (multiply == 1 && itype->bit_size >= bits_in_pointer)
+		return ctype;
 
-	if (bit_size > bits_in_char) {
-		int multiply = bit_size >> 3;
+	if (index->type == EXPR_VALUE) {
 		struct expression *val = alloc_expression(expr->pos, EXPR_VALUE);
+		unsigned long long v = index->value, mask;
+		mask = 1ULL << (itype->bit_size - 1);
+		if (v & mask)
+			v |= -mask;
+		else
+			v &= mask - 1;
+		v *= multiply;
+		mask = 1ULL << (bits_in_pointer - 1);
+		v &= mask | (mask - 1);
+		val->value = v;
+		val->ctype = ssize_t_ctype;
+		expr->right = val;
+		return ctype;
+	}
 
-		if (i->type == EXPR_VALUE) {
-			val->value = i->value * multiply;
-			val->ctype = size_t_ctype;
-			*ip = val;
-		} else {
-			struct expression *mul = alloc_expression(expr->pos, EXPR_BINOP);
+	if (itype->bit_size < bits_in_pointer)
+		index = cast_to(index, ssize_t_ctype);
 
-			val->ctype = size_t_ctype;
-			val->value = bit_size >> 3;
+	if (multiply > 1) {
+		struct expression *val = alloc_expression(expr->pos, EXPR_VALUE);
+		struct expression *mul = alloc_expression(expr->pos, EXPR_BINOP);
 
-			mul->op = '*';
-			mul->ctype = size_t_ctype;
-			mul->left = i;
-			mul->right = val;
+		val->ctype = ssize_t_ctype;
+		val->value = multiply;
 
-			*ip = mul;
-		}
+		mul->op = '*';
+		mul->ctype = ssize_t_ctype;
+		mul->left = index;
+		mul->right = val;
+		index = mul;
 	}
 
-	expr->ctype = ctype;	
+	expr->right = index;
 	return ctype;
 }
 
@@ -919,14 +921,19 @@ static struct symbol *evaluate_binop(struct expression *expr)
 	}
 
 	/* pointer (+|-) integer */
-	if (lclass & TYPE_PTR && is_int(rclass) && (op == '+' || op == '-'))
-		return evaluate_ptr_add(expr, degenerate(expr->left),
-					&expr->right);
+	if (lclass & TYPE_PTR && is_int(rclass) && (op == '+' || op == '-')) {
+		unrestrict(expr->right, rclass, &rtype);
+		return evaluate_ptr_add(expr, degenerate(expr->left), rtype);
+	}
 
 	/* integer + pointer */
-	if (rclass & TYPE_PTR && is_int(lclass) && op == '+')
-		return evaluate_ptr_add(expr, degenerate(expr->right),
-					&expr->left);
+	if (rclass & TYPE_PTR && is_int(lclass) && op == '+') {
+		struct expression *index = expr->left;
+		unrestrict(index, lclass, &ltype);
+		expr->left = expr->right;
+		expr->right = index;
+		return evaluate_ptr_add(expr, degenerate(expr->left), ltype);
+	}
 
 	/* pointer - pointer */
 	if (lclass & rclass & TYPE_PTR && expr->op == '-')
@@ -1118,7 +1125,8 @@ static int evaluate_assign_op(struct expression *expr)
 	}
 	if (tclass & TYPE_PTR && is_int(sclass)) {
 		if (op == SPECIAL_ADD_ASSIGN || op == SPECIAL_SUB_ASSIGN) {
-			evaluate_ptr_add(expr, target, &expr->right);
+			unrestrict(expr->right, sclass, &s);
+			evaluate_ptr_add(expr, target, s);
 			return 1;
 		}
 		expression_error(expr, "invalid pointer assignment");
-- 
1.5.0-rc2.GIT
