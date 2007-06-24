From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 12/16] move degenerate() down into compatible_assignment_types()
Date: Sun, 24 Jun 2007 09:05:11 +0100
Message-ID: <E1I2N5r-0003eC-7U@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34707 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbXFXIFM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 04:05:12 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I2N5r-0003eC-7U
	for linux-sparse@vger.kernel.org; Sun, 24 Jun 2007 09:05:11 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


... and lose useless argument

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   30 +++++++++++++-----------------
 1 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 1d34cdf..60a11ff 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1142,11 +1142,11 @@ Cast:
 }
 
 static int compatible_assignment_types(struct expression *expr, struct symbol *target,
-	struct expression **rp, struct symbol *source, const char *where)
+	struct expression **rp, const char *where)
 {
 	const char *typediff;
+	struct symbol *source = degenerate(*rp);
 	struct symbol *t, *s;
-	int target_as;
 	int tclass = classify_type(target, &t);
 	int sclass = classify_type(source, &s);
 
@@ -1170,6 +1170,7 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
 	if (tclass & TYPE_PTR) {
 		struct expression *right = *rp;
 		int source_as;
+		int target_as;
 
 		// NULL pointer is always OK
 		if (is_null_ptr(right))
@@ -1239,9 +1240,9 @@ static void evaluate_assign_to(struct expression *left, struct symbol *type)
 
 static struct symbol *evaluate_assignment(struct expression *expr)
 {
-	struct expression *left = expr->left, *right = expr->right;
+	struct expression *left = expr->left;
 	struct expression *where = expr;
-	struct symbol *ltype, *rtype;
+	struct symbol *ltype;
 
 	if (!lvalue_expression(left)) {
 		expression_error(expr, "not an lvalue");
@@ -1254,8 +1255,7 @@ static struct symbol *evaluate_assignment(struct expression *expr)
 		if (!evaluate_assign_op(expr))
 			return NULL;
 	} else {
-		rtype = degenerate(right);
-		if (!compatible_assignment_types(where, ltype, &where->right, rtype, "assignment"))
+		if (!compatible_assignment_types(where, ltype, &expr->right, "assignment"))
 			return NULL;
 	}
 
@@ -1914,8 +1914,7 @@ static int evaluate_arguments(struct symbol *f, struct symbol *fn, struct expres
 			static char where[30];
 			examine_symbol_type(target);
 			sprintf(where, "argument %d", i);
-			ctype = degenerate(expr);
-			compatible_assignment_types(expr, target, p, ctype, where);
+			compatible_assignment_types(expr, target, p, where);
 		}
 
 		i++;
@@ -2300,11 +2299,9 @@ static int handle_simple_initializer(struct expression **ep, int nested,
 		if (!e)
 			return 0;
 		*ep = e;
-		type = evaluate_expression(e);
-		if (!e->ctype)
+		if (!evaluate_expression(e))
 			return 1;
-		compatible_assignment_types(e, ctype, ep, degenerate(e),
-					    "initializer");
+		compatible_assignment_types(e, ctype, ep, "initializer");
 		return 1;
 	}
 
@@ -2785,13 +2782,12 @@ void evaluate_symbol_list(struct symbol_list *list)
 static struct symbol *evaluate_return_expression(struct statement *stmt)
 {
 	struct expression *expr = stmt->expression;
-	struct symbol *ctype, *fntype;
+	struct symbol *fntype;
 
 	evaluate_expression(expr);
-	ctype = degenerate(expr);
 	fntype = current_fn->ctype.base_type;
 	if (!fntype || fntype == &void_ctype) {
-		if (expr && ctype != &void_ctype)
+		if (expr && expr->ctype != &void_ctype)
 			expression_error(expr, "return expression in %s function", fntype?"void":"typeless");
 		return NULL;
 	}
@@ -2800,9 +2796,9 @@ static struct symbol *evaluate_return_expression(struct statement *stmt)
 		sparse_error(stmt->pos, "return with no return value");
 		return NULL;
 	}
-	if (!ctype)
+	if (!expr->ctype)
 		return NULL;
-	compatible_assignment_types(expr, fntype, &stmt->expression, ctype, "return expression");
+	compatible_assignment_types(expr, fntype, &stmt->expression, "return expression");
 	return NULL;
 }
 
-- 
1.5.0-rc2.GIT
