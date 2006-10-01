From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 4/7] beginning of SYM_RESTRICT rewrite: restricted_binop_type()
Date: Sun, 01 Oct 2006 14:57:41 +0100
Message-ID: <E1GU1p7-0006xd-SC@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33964 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932196AbWJAN5j
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 09:57:39 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1GU1p7-0006xd-SC
	for linux-sparse@vger.kernel.org; Sun, 01 Oct 2006 14:57:41 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


* new helper - restricted_binop_type(); gives resulting type of binary
operation when at least one of arguments is SYM_RESTRICT.  NULL is
returned in case of error.  Arguments will make sense when we get
to consolidation of compatible_binop_...() (next patch), switching
to better recovery from type errors for these guys (next after that)
and smarter handling of ~ on small restricted types.

* compatible_restricted_binop() and check_case_type() switched to
using that puppy
---
 evaluate.c |  104 ++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 1d33c58..9ff3983 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -490,41 +490,44 @@ static int restricted_unop(int op, struc
 	return 1;
 }
 
+static struct symbol *restricted_binop_type(int op,
+					struct expression *left,
+					struct expression *right,
+					int lclass, int rclass,
+					struct symbol *ltype,
+					struct symbol *rtype)
+{
+	struct symbol *ctype = NULL;
+	if (lclass & TYPE_RESTRICT) {
+		if (rclass & TYPE_RESTRICT) {
+			if (ltype == rtype)
+				ctype = ltype;
+		} else {
+			if (!restricted_value(right, ltype))
+				ctype = ltype;
+		}
+	} else if (!restricted_value(left, rtype))
+		ctype = rtype;
+
+	if (ctype && restricted_binop(op, ctype))
+		ctype = NULL;
+	return ctype;
+}
+
 static struct symbol *compatible_restricted_binop(int op, struct expression **lp, struct expression **rp)
 {
 	struct expression *left = *lp, *right = *rp;
-	struct symbol *ltype = left->ctype, *rtype = right->ctype;
-	struct symbol *type = NULL;
-
-	if (ltype->type == SYM_NODE)
-		ltype = ltype->ctype.base_type;
-	if (rtype->type == SYM_NODE)
-		rtype = rtype->ctype.base_type;
+	struct symbol *ltype, *rtype;
+	int lclass = classify_type(left->ctype, &ltype);
+	int rclass = classify_type(right->ctype, &rtype);
 
-	warn_for_different_enum_types(right->pos, ltype, rtype);
+	warn_for_different_enum_types(right->pos, left->ctype, right->ctype);
 
-	if (ltype->type == SYM_ENUM)
-		ltype = ltype->ctype.base_type;
-	if (rtype->type == SYM_ENUM)
-		rtype = rtype->ctype.base_type;
-
-	if (is_restricted_type(ltype)) {
-		if (is_restricted_type(rtype)) {
-			if (ltype == rtype)
-				type = ltype;
-		} else {
-			if (!restricted_value(right, ltype))
-				type = ltype;
-		}
-	} else if (is_restricted_type(rtype)) {
-		if (!restricted_value(left, rtype))
-			type = rtype;
-	}
-	if (!type)
+	if (!(lclass & rclass & TYPE_RESTRICT))
 		return NULL;
-	if (restricted_binop(op, type))
-		return NULL;
-	return type;
+
+	return restricted_binop_type(op, left, right,
+				     lclass, rclass, ltype, rtype);
 }
 
 static struct symbol *evaluate_arith(struct expression *expr, int float_ok)
@@ -2653,26 +2656,43 @@ static void check_case_type(struct expre
 			    struct expression **enumcase)
 {
 	struct symbol *switch_type, *case_type;
+	int sclass, cclass;
+
 	if (!case_expr)
 		return;
+
 	switch_type = switch_expr->ctype;
 	case_type = evaluate_expression(case_expr);
 
-	if (case_type && switch_type) {
-		if (enumcase) {
-			if (*enumcase)
-				warn_for_different_enum_types(case_expr->pos, case_type, (*enumcase)->ctype);
-			else if (is_enum_type(case_type))
-				*enumcase = case_expr;
-		}
-
-		/* Both integer types? */
-		if (compatible_restricted_binop(SPECIAL_EQUAL, &switch_expr, &case_expr))
-			return;
-		if (is_int_type(switch_type) && is_int_type(case_type)) 
-			return;
+	if (!switch_type || !case_type)
+		goto Bad;
+	if (enumcase) {
+		if (*enumcase)
+			warn_for_different_enum_types(case_expr->pos, case_type, (*enumcase)->ctype);
+		else if (is_enum_type(case_type))
+			*enumcase = case_expr;
 	}
 
+	sclass = classify_type(switch_type, &switch_type);
+	cclass = classify_type(case_type, &case_type);
+
+	/* both should be arithmetic */
+	if (!(sclass & cclass & TYPE_NUM))
+		goto Bad;
+
+	/* neither should be floating */
+	if ((sclass | cclass) & TYPE_FLOAT)
+		goto Bad;
+
+	/* if neither is restricted, we are OK */
+	if (!((sclass | cclass) & TYPE_RESTRICT))
+		return;
+
+	if (restricted_binop_type(SPECIAL_EQUAL, case_expr, switch_expr,
+				   cclass, sclass, case_type, switch_type))
+		return;
+
+Bad:
 	sparse_error(case_expr->pos, "incompatible types for 'case' statement");
 }
 
-- 
1.4.2.GIT
