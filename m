From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 5/7] merged compatible_..._binop() into single function
Date: Sun, 01 Oct 2006 14:57:51 +0100
Message-ID: <E1GU1pH-0006yN-Sq@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34220 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932196AbWJAN5t
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 09:57:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1GU1pH-0006yN-Sq
	for linux-sparse@vger.kernel.org; Sun, 01 Oct 2006 14:57:51 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


All these guys are really pieces of usual arithmetic conversions;
doesn't make sense to handle them separately, especially if we
want to recover from mismatches in __bitwise__, etc. by letting
them degrade to corresponding integer types.
---
 evaluate.c |  140 ++++++++++++++++++++++++++----------------------------------
 1 files changed, 61 insertions(+), 79 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 9ff3983..7f4810d 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -398,61 +398,6 @@ static struct symbol *bad_expr_type(stru
 	return expr->ctype = &bad_ctype;
 }
 
-static struct symbol *compatible_float_binop(struct expression **lp, struct expression **rp)
-{
-	struct expression *left = *lp, *right = *rp;
-	struct symbol *ltype = left->ctype, *rtype = right->ctype;
-
-	if (ltype->type == SYM_NODE)
-		ltype = ltype->ctype.base_type;
-	if (rtype->type == SYM_NODE)
-		rtype = rtype->ctype.base_type;
-	if (is_float_type(ltype)) {
-		if (is_int_type(rtype))
-			goto Left;
-		if (is_float_type(rtype)) {
-			unsigned long lmod = ltype->ctype.modifiers;
-			unsigned long rmod = rtype->ctype.modifiers;
-			lmod &= MOD_LONG | MOD_LONGLONG;
-			rmod &= MOD_LONG | MOD_LONGLONG;
-			if (lmod == rmod)
-				return ltype;
-			if (lmod & ~rmod)
-				goto Left;
-			else
-				goto Right;
-		}
-		return NULL;
-	}
-	if (!is_float_type(rtype) || !is_int_type(ltype))
-		return NULL;
-Right:
-	*lp = cast_to(left, rtype);
-	return rtype;
-Left:
-	*rp = cast_to(right, ltype);
-	return ltype;
-}
-
-static struct symbol *compatible_integer_binop(struct expression **lp, struct expression **rp)
-{
-	struct expression *left = *lp, *right = *rp;
-	struct symbol *ltype = left->ctype, *rtype = right->ctype;
-
-	if (ltype->type == SYM_NODE)
-		ltype = ltype->ctype.base_type;
-	if (rtype->type == SYM_NODE)
-		rtype = rtype->ctype.base_type;
-	if (is_int_type(ltype) && is_int_type(rtype)) {
-		struct symbol *ctype = bigger_int_type(ltype, rtype);
-
-		*lp = cast_to(left, ctype);
-		*rp = cast_to(right, ctype);
-		return ctype;
-	}
-	return NULL;
-}
-
 static int restricted_value(struct expression *v, struct symbol *type)
 {
 	if (v->type != EXPR_VALUE)
@@ -514,33 +459,70 @@ static struct symbol *restricted_binop_t
 	return ctype;
 }
 
-static struct symbol *compatible_restricted_binop(int op, struct expression **lp, struct expression **rp)
+static struct symbol *usual_conversions(int op,
+					struct expression **left,
+					struct expression **right,
+					int lclass, int rclass,
+					struct symbol *ltype,
+					struct symbol *rtype)
 {
-	struct expression *left = *lp, *right = *rp;
-	struct symbol *ltype, *rtype;
-	int lclass = classify_type(left->ctype, &ltype);
-	int rclass = classify_type(right->ctype, &rtype);
+	struct symbol *ctype;
 
-	warn_for_different_enum_types(right->pos, left->ctype, right->ctype);
+	warn_for_different_enum_types((*right)->pos, (*left)->ctype, (*right)->ctype);
+
+	if ((lclass | rclass) & TYPE_RESTRICT)
+		goto Restr;
+
+	if (!(lclass & TYPE_FLOAT)) {
+		if (!(rclass & TYPE_FLOAT))
+			ctype = bigger_int_type(ltype, rtype);
+		else
+			ctype = rtype;
+	} else if (rclass & TYPE_FLOAT) {
+		unsigned long lmod = ltype->ctype.modifiers;
+		unsigned long rmod = rtype->ctype.modifiers;
+		if (rmod & ~lmod & (MOD_LONG | MOD_LONGLONG))
+			ctype = rtype;
+		else
+			ctype = ltype;
+	} else
+		ctype = ltype;
+
+Convert:
+	*left = cast_to(*left, ctype);
+	*right = cast_to(*right, ctype);
+	return ctype;
 
-	if (!(lclass & rclass & TYPE_RESTRICT))
-		return NULL;
+Restr:
+	ctype = restricted_binop_type(op, *left, *right,
+				      lclass, rclass, ltype, rtype);
+	if (ctype)
+		goto Convert;
 
-	return restricted_binop_type(op, left, right,
-				     lclass, rclass, ltype, rtype);
+	return NULL;
 }
 
 static struct symbol *evaluate_arith(struct expression *expr, int float_ok)
 {
-	struct symbol *ctype = compatible_integer_binop(&expr->left, &expr->right);
-	if (!ctype && float_ok)
-		ctype = compatible_float_binop(&expr->left, &expr->right);
-	if (!ctype)
-		ctype = compatible_restricted_binop(expr->op, &expr->left, &expr->right);
+	struct symbol *ltype, *rtype;
+	int lclass = classify_type(expr->left->ctype, &ltype);
+	int rclass = classify_type(expr->right->ctype, &rtype);
+	struct symbol *ctype;
+
+	if (!(lclass & rclass & TYPE_NUM))
+		goto Bad;
+
+	if (!float_ok && (lclass | rclass) & TYPE_FLOAT)
+		goto Bad;
+
+	ctype = usual_conversions(expr->op, &expr->left, &expr->right,
+				  lclass, rclass, ltype, rtype);
 	if (ctype) {
 		expr->ctype = ctype;
 		return ctype;
 	}
+
+Bad:
 	return bad_expr_type(expr);
 }
 
@@ -1048,6 +1030,7 @@ static struct symbol *evaluate_condition
 {
 	struct expression **true;
 	struct symbol *ctype, *ltype, *rtype;
+	int lclass, rclass;
 	const char * typediff;
 
 	if (!evaluate_conditional(expr->conditional, 0))
@@ -1067,18 +1050,17 @@ static struct symbol *evaluate_condition
 		true = &expr->cond_true;
 	}
 
-	ctype = compatible_integer_binop(true, &expr->cond_false);
-	if (ctype)
-		goto out;
+	lclass = classify_type(ltype, &ltype);
+	rclass = classify_type(rtype, &rtype);
+	if (lclass & rclass & TYPE_NUM) {
+		ctype = usual_conversions('?', true, &expr->cond_false,
+					  lclass, rclass, ltype, rtype);
+		if (ctype)
+			goto out;
+	}
 	ctype = compatible_ptr_type(*true, expr->cond_false);
 	if (ctype)
 		goto out;
-	ctype = compatible_float_binop(true, &expr->cond_false);
-	if (ctype)
-		goto out;
-	ctype = compatible_restricted_binop('?', true, &expr->cond_false);
-	if (ctype)
-		goto out;
 	ctype = ltype;
 	typediff = type_difference(ltype, rtype, MOD_IGN, MOD_IGN);
 	if (!typediff)
-- 
1.4.2.GIT
