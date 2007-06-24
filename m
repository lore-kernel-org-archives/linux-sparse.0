From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 7/16] cleanup of evaluate_assign_op()
Date: Sun, 24 Jun 2007 09:04:21 +0100
Message-ID: <E1I2N53-0003d8-6U@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34691 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbXFXIEV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 04:04:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I2N53-0003d8-6U
	for linux-sparse@vger.kernel.org; Sun, 24 Jun 2007 09:04:21 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 2203e67..e299299 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1118,12 +1118,14 @@ static int compatible_float_op(int op)
 		op == SPECIAL_DIV_ASSIGN;
 }
 
-static int evaluate_assign_op(struct expression *expr, struct symbol *target,
-	struct expression **rp, struct symbol *source, int op)
+static int evaluate_assign_op(struct expression *expr)
 {
+	struct symbol *target = expr->left->ctype;
+	struct symbol *source = expr->right->ctype;
 	struct symbol *t, *s;
 	int tclass = classify_type(target, &t);
 	int sclass = classify_type(source, &s);
+	int op = expr->op;
 
 	if (tclass & sclass & TYPE_NUM) {
 		if (tclass & TYPE_FLOAT && !compatible_float_op(op)) {
@@ -1131,14 +1133,14 @@ static int evaluate_assign_op(struct expression *expr, struct symbol *target,
 			return 0;
 		}
 		if (tclass & TYPE_RESTRICT) {
-			if (!restricted_binop(op, target)) {
+			if (!restricted_binop(op, t)) {
 				expression_error(expr, "bad restricted assignment");
 				return 0;
 			}
 			/* allowed assignments unfoul */
 			if (sclass & TYPE_FOULED && s->ctype.base_type == t)
 				goto Cast;
-			if (!restricted_value(*rp, target))
+			if (!restricted_value(expr->right, t))
 				return 1;
 		} else if (!(sclass & TYPE_RESTRICT))
 			goto Cast;
@@ -1146,22 +1148,23 @@ static int evaluate_assign_op(struct expression *expr, struct symbol *target,
 		if (t == s)
 			return 1;
 		warning(expr->pos, "invalid restricted assignment");
-		*rp = cast_to(*rp, target);
+		expr->right = cast_to(expr->right, target);
 		return 0;
-	} else if (tclass & TYPE_PTR) {
+	}
+	if (tclass & TYPE_PTR) {
 		if (op == SPECIAL_ADD_ASSIGN || op == SPECIAL_SUB_ASSIGN) {
-			evaluate_ptr_add(expr, target, rp);
+			evaluate_ptr_add(expr, target, &expr->right);
 			return 1;
 		}
 		expression_error(expr, "invalid pointer assignment");
 		return 0;
-	} else {
-		expression_error(expr, "invalid assignment");
-		return 0;
 	}
 
+	expression_error(expr, "invalid assignment");
+	return 0;
+
 Cast:
-	*rp = cast_to(*rp, target);
+	expr->right = cast_to(expr->right, target);
 	return 1;
 }
 
@@ -1274,12 +1277,11 @@ static struct symbol *evaluate_assignment(struct expression *expr)
 
 	ltype = left->ctype;
 
-	rtype = degenerate(right);
-
 	if (expr->op != '=') {
-		if (!evaluate_assign_op(where, ltype, &where->right, rtype, expr->op))
+		if (!evaluate_assign_op(expr))
 			return NULL;
 	} else {
+		rtype = degenerate(right);
 		if (!compatible_assignment_types(where, ltype, &where->right, rtype, "assignment"))
 			return NULL;
 	}
-- 
1.5.0-rc2.GIT
