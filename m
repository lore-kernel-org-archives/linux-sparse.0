From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 6/7] saner recovery from endianness errors, part 1.
Date: Sun, 01 Oct 2006 14:58:01 +0100
Message-ID: <E1GU1pR-0006zg-TT@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34476 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932223AbWJAN57
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 09:57:59 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1GU1pR-0006zg-TT
	for linux-sparse@vger.kernel.org; Sun, 01 Oct 2006 14:58:01 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


---
 evaluate.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 7f4810d..71c46d1 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -473,6 +473,7 @@ static struct symbol *usual_conversions(
 	if ((lclass | rclass) & TYPE_RESTRICT)
 		goto Restr;
 
+Normal:
 	if (!(lclass & TYPE_FLOAT)) {
 		if (!(rclass & TYPE_FLOAT))
 			ctype = bigger_int_type(ltype, rtype);
@@ -499,7 +500,15 @@ Restr:
 	if (ctype)
 		goto Convert;
 
-	return NULL;
+	if (lclass & TYPE_RESTRICT) {
+		warning((*left)->pos, "restricted degrades to integer");
+		ltype = ltype->ctype.base_type;
+	}
+	if (rclass & TYPE_RESTRICT) {
+		warning((*right)->pos, "restricted degrades to integer");
+		rtype = rtype->ctype.base_type;
+	}
+	goto Normal;
 }
 
 static struct symbol *evaluate_arith(struct expression *expr, int float_ok)
@@ -517,10 +526,8 @@ static struct symbol *evaluate_arith(str
 
 	ctype = usual_conversions(expr->op, &expr->left, &expr->right,
 				  lclass, rclass, ltype, rtype);
-	if (ctype) {
-		expr->ctype = ctype;
-		return ctype;
-	}
+	expr->ctype = ctype;
+	return ctype;
 
 Bad:
 	return bad_expr_type(expr);
@@ -1055,8 +1062,7 @@ static struct symbol *evaluate_condition
 	if (lclass & rclass & TYPE_NUM) {
 		ctype = usual_conversions('?', true, &expr->cond_false,
 					  lclass, rclass, ltype, rtype);
-		if (ctype)
-			goto out;
+		goto out;
 	}
 	ctype = compatible_ptr_type(*true, expr->cond_false);
 	if (ctype)
@@ -2670,9 +2676,11 @@ static void check_case_type(struct expre
 	if (!((sclass | cclass) & TYPE_RESTRICT))
 		return;
 
-	if (restricted_binop_type(SPECIAL_EQUAL, case_expr, switch_expr,
+	if (!restricted_binop_type(SPECIAL_EQUAL, case_expr, switch_expr,
 				   cclass, sclass, case_type, switch_type))
-		return;
+		warning(case_expr->pos, "restricted degrades to integer");
+
+	return;
 
 Bad:
 	sparse_error(case_expr->pos, "incompatible types for 'case' statement");
-- 
1.4.2.GIT
