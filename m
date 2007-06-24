From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 2/16] take cast_to() out of usual_conversions(), do it in callers
Date: Sun, 24 Jun 2007 09:03:31 +0100
Message-ID: <E1I2N4F-0003bq-5a@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34682 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbXFXIDb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 04:03:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I2N4F-0003bq-5a
	for linux-sparse@vger.kernel.org; Sun, 24 Jun 2007 09:03:31 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


At the same time we get to pass expressions by value...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index bf923f7..be67fa8 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -491,15 +491,15 @@ static struct symbol *restricted_binop_type(int op,
 }
 
 static struct symbol *usual_conversions(int op,
-					struct expression **left,
-					struct expression **right,
+					struct expression *left,
+					struct expression *right,
 					int lclass, int rclass,
 					struct symbol *ltype,
 					struct symbol *rtype)
 {
 	struct symbol *ctype;
 
-	warn_for_different_enum_types((*right)->pos, (*left)->ctype, (*right)->ctype);
+	warn_for_different_enum_types(right->pos, left->ctype, right->ctype);
 
 	if ((lclass | rclass) & TYPE_RESTRICT)
 		goto Restr;
@@ -521,27 +521,25 @@ Normal:
 		ctype = ltype;
 
 Convert:
-	*left = cast_to(*left, ctype);
-	*right = cast_to(*right, ctype);
 	return ctype;
 
 Restr:
-	ctype = restricted_binop_type(op, *left, *right,
+	ctype = restricted_binop_type(op, left, right,
 				      lclass, rclass, ltype, rtype);
 	if (ctype)
 		goto Convert;
 
 	if (lclass & TYPE_RESTRICT) {
-		warning((*left)->pos, "restricted degrades to integer");
-		ltype = ltype->ctype.base_type;
-		if (is_restricted_type(ltype)) /* was fouled */
+		warning(left->pos, "restricted degrades to integer");
+		if (lclass & TYPE_FOULED)
 			ltype = ltype->ctype.base_type;
+		ltype = ltype->ctype.base_type;
 	}
 	if (rclass & TYPE_RESTRICT) {
-		warning((*right)->pos, "restricted degrades to integer");
-		rtype = rtype->ctype.base_type;
-		if (is_restricted_type(rtype)) /* was fouled */
+		warning(right->pos, "restricted degrades to integer");
+		if (rclass & TYPE_FOULED)
 			rtype = rtype->ctype.base_type;
+		rtype = rtype->ctype.base_type;
 	}
 	goto Normal;
 }
@@ -559,8 +557,10 @@ static struct symbol *evaluate_arith(struct expression *expr, int float_ok)
 	if (!float_ok && (lclass | rclass) & TYPE_FLOAT)
 		goto Bad;
 
-	ctype = usual_conversions(expr->op, &expr->left, &expr->right,
+	ctype = usual_conversions(expr->op, expr->left, expr->right,
 				  lclass, rclass, ltype, rtype);
+	expr->left = cast_to(expr->left, ctype);
+	expr->right = cast_to(expr->right, ctype);
 	expr->ctype = ctype;
 	return ctype;
 
@@ -1106,8 +1106,10 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 	lclass = classify_type(ltype, &ltype);
 	rclass = classify_type(rtype, &rtype);
 	if (lclass & rclass & TYPE_NUM) {
-		ctype = usual_conversions('?', true, &expr->cond_false,
+		ctype = usual_conversions('?', *true, expr->cond_false,
 					  lclass, rclass, ltype, rtype);
+		*true = cast_to(*true, ctype);
+		expr->cond_false = cast_to(expr->cond_false, ctype);
 		goto out;
 	}
 	ctype = compatible_ptr_type(*true, expr->cond_false);
-- 
1.5.0-rc2.GIT
