From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 9/16] clean up usual_conversions(), kill evaluate_shift()
Date: Sun, 24 Jun 2007 09:04:41 +0100
Message-ID: <E1I2N5N-0003dX-6u@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34704 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbXFXIEm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 04:04:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I2N5N-0003dX-6u
	for linux-sparse@vger.kernel.org; Sun, 24 Jun 2007 09:04:41 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   78 ++++++++++++++++++++++++++---------------------------------
 1 files changed, 34 insertions(+), 44 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index abd3b3e..79f1ac9 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -492,6 +492,17 @@ static struct symbol *restricted_binop_type(int op,
 	return ctype;
 }
 
+static inline void unrestrict(struct expression *expr,
+			      int class, struct symbol **ctype)
+{
+	if (class & TYPE_RESTRICT) {
+		warning(expr->pos, "restricted degrades to integer");
+		if (class & TYPE_FOULED)	/* unfoul it first */
+			*ctype = (*ctype)->ctype.base_type;
+		*ctype = (*ctype)->ctype.base_type; /* get to arithmetic type */
+	}
+}
+
 static struct symbol *usual_conversions(int op,
 					struct expression *left,
 					struct expression *right,
@@ -509,40 +520,28 @@ static struct symbol *usual_conversions(int op,
 Normal:
 	if (!(lclass & TYPE_FLOAT)) {
 		if (!(rclass & TYPE_FLOAT))
-			ctype = bigger_int_type(ltype, rtype);
+			return bigger_int_type(ltype, rtype);
 		else
-			ctype = rtype;
+			return rtype;
 	} else if (rclass & TYPE_FLOAT) {
 		unsigned long lmod = ltype->ctype.modifiers;
 		unsigned long rmod = rtype->ctype.modifiers;
 		if (rmod & ~lmod & (MOD_LONG | MOD_LONGLONG))
-			ctype = rtype;
+			return rtype;
 		else
-			ctype = ltype;
+			return ltype;
 	} else
-		ctype = ltype;
-
-Convert:
-	return ctype;
+		return ltype;
 
 Restr:
 	ctype = restricted_binop_type(op, left, right,
 				      lclass, rclass, ltype, rtype);
 	if (ctype)
-		goto Convert;
+		return ctype;
+
+	unrestrict(left, lclass, &ltype);
+	unrestrict(right, rclass, &rtype);
 
-	if (lclass & TYPE_RESTRICT) {
-		warning(left->pos, "restricted degrades to integer");
-		if (lclass & TYPE_FOULED)
-			ltype = ltype->ctype.base_type;
-		ltype = ltype->ctype.base_type;
-	}
-	if (rclass & TYPE_RESTRICT) {
-		warning(right->pos, "restricted degrades to integer");
-		if (rclass & TYPE_FOULED)
-			rtype = rtype->ctype.base_type;
-		rtype = rtype->ctype.base_type;
-	}
 	goto Normal;
 }
 
@@ -882,21 +881,6 @@ static struct symbol *evaluate_logical(struct expression *expr)
 	return &bool_ctype;
 }
 
-static struct symbol *evaluate_shift(struct expression *expr)
-{
-	struct symbol *ltype, *rtype;
-	struct symbol *ctype;
-
-	want_int(&expr->left, &ltype);
-	want_int(&expr->right, &rtype);
-	ctype = integer_promotion(ltype);
-	expr->left = cast_to(expr->left, ctype);
-	expr->ctype = ctype;
-	ctype = integer_promotion(rtype);
-	expr->right = cast_to(expr->right, ctype);
-	return expr->ctype;
-}
-
 static struct symbol *evaluate_binop(struct expression *expr)
 {
 	struct symbol *ltype, *rtype, *ctype;
@@ -915,15 +899,21 @@ static struct symbol *evaluate_binop(struct expression *expr)
 			}
 		}
 
-		// shifts do integer promotions, but that's it.
-		if (op == SPECIAL_LEFTSHIFT || op == SPECIAL_RIGHTSHIFT)
-			return evaluate_shift(expr);
+		if (op == SPECIAL_LEFTSHIFT || op == SPECIAL_RIGHTSHIFT) {
+			// shifts do integer promotions, but that's it.
+			unrestrict(expr->left, lclass, &ltype);
+			unrestrict(expr->right, rclass, &rtype);
+			ctype = ltype = integer_promotion(ltype);
+			rtype = integer_promotion(rtype);
+		} else {
+			// The rest do usual conversions
+			ltype = usual_conversions(op, expr->left, expr->right,
+						  lclass, rclass, ltype, rtype);
+			ctype = rtype = ltype;
+		}
 
-		// The rest do usual conversions
-		ctype = usual_conversions(op, expr->left, expr->right,
-					  lclass, rclass, ltype, rtype);
-		expr->left = cast_to(expr->left, ctype);
-		expr->right = cast_to(expr->right, ctype);
+		expr->left = cast_to(expr->left, ltype);
+		expr->right = cast_to(expr->right, rtype);
 		expr->ctype = ctype;
 		return ctype;
 	}
-- 
1.5.0-rc2.GIT
