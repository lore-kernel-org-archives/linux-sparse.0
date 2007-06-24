From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 3/16] mechanically split compatible_assignment_types()
Date: Sun, 24 Jun 2007 09:03:41 +0100
Message-ID: <E1I2N4P-0003c7-5m@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34684 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbXFXIDm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 04:03:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I2N4P-0003c7-5m
	for linux-sparse@vger.kernel.org; Sun, 24 Jun 2007 09:03:41 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Pure assignment and <op>= cases are different enough to make it easier handling
them in separate functions.  For now just split compatible_assignment_types()
in two; the next patches will clean each up.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   63 ++++++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index be67fa8..febfad2 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1130,19 +1130,16 @@ out:
 /* FP assignments can not do modulo or bit operations */
 static int compatible_float_op(int op)
 {
-	return	op == '=' ||
-		op == SPECIAL_ADD_ASSIGN ||
+	return	op == SPECIAL_ADD_ASSIGN ||
 		op == SPECIAL_SUB_ASSIGN ||
 		op == SPECIAL_MUL_ASSIGN ||
 		op == SPECIAL_DIV_ASSIGN;
 }
 
-static int compatible_assignment_types(struct expression *expr, struct symbol *target,
-	struct expression **rp, struct symbol *source, const char *where, int op)
+static int evaluate_assign_op(struct expression *expr, struct symbol *target,
+	struct expression **rp, struct symbol *source, int op)
 {
-	const char *typediff;
 	struct symbol *t, *s;
-	int target_as;
 	int tclass = classify_type(target, &t);
 	int sclass = classify_type(source, &s);
 
@@ -1163,20 +1160,49 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
 				return 1;
 		} else if (!(sclass & TYPE_RESTRICT))
 			goto Cast;
+		/* source and target would better be identical restricted */
+		if (t == s)
+			return 1;
+		warning(expr->pos, "invalid restricted assignment");
+		*rp = cast_to(*rp, target);
+		return 0;
 	} else if (tclass & TYPE_PTR) {
 		if (op == SPECIAL_ADD_ASSIGN || op == SPECIAL_SUB_ASSIGN) {
 			evaluate_ptr_add(expr, target, rp);
 			return 1;
 		}
-		if (op != '=') {
-			expression_error(expr, "invalid pointer assignment");
-			return 0;
-		}
-	} else if (op != '=') {
+		expression_error(expr, "invalid pointer assignment");
+		return 0;
+	} else {
 		expression_error(expr, "invalid assignment");
 		return 0;
 	}
 
+Cast:
+	*rp = cast_to(*rp, target);
+	return 1;
+}
+
+static int compatible_assignment_types(struct expression *expr, struct symbol *target,
+	struct expression **rp, struct symbol *source, const char *where)
+{
+	const char *typediff;
+	struct symbol *t, *s;
+	int target_as;
+	int tclass = classify_type(target, &t);
+	int sclass = classify_type(source, &s);
+
+	if (tclass & sclass & TYPE_NUM) {
+		if (tclass & TYPE_RESTRICT) {
+			/* allowed assignments unfoul */
+			if (sclass & TYPE_FOULED && s->ctype.base_type == t)
+				goto Cast;
+			if (!restricted_value(*rp, target))
+				return 1;
+		} else if (!(sclass & TYPE_RESTRICT))
+			goto Cast;
+	}
+
 	/* It's OK if the target is more volatile or const than the source */
 	typediff = type_difference(target, source, MOD_VOLATILE | MOD_CONST, 0);
 	if (!typediff)
@@ -1268,8 +1294,13 @@ static struct symbol *evaluate_assignment(struct expression *expr)
 
 	rtype = degenerate(right);
 
-	if (!compatible_assignment_types(where, ltype, &where->right, rtype, "assignment", expr->op))
-		return NULL;
+	if (expr->op != '=') {
+		if (!evaluate_assign_op(where, ltype, &where->right, rtype, expr->op))
+			return NULL;
+	} else {
+		if (!compatible_assignment_types(where, ltype, &where->right, rtype, "assignment"))
+			return NULL;
+	}
 
 	evaluate_assign_to(left, ltype);
 
@@ -1918,7 +1949,7 @@ static int evaluate_arguments(struct symbol *f, struct symbol *fn, struct expres
 			static char where[30];
 			examine_symbol_type(target);
 			sprintf(where, "argument %d", i);
-			compatible_assignment_types(expr, target, p, ctype, where, '=');
+			compatible_assignment_types(expr, target, p, ctype, where);
 		}
 
 		i++;
@@ -2307,7 +2338,7 @@ static int handle_simple_initializer(struct expression **ep, int nested,
 		if (!e->ctype)
 			return 1;
 		compatible_assignment_types(e, ctype, ep, degenerate(e),
-					    "initializer", '=');
+					    "initializer");
 		return 1;
 	}
 
@@ -2805,7 +2836,7 @@ static struct symbol *evaluate_return_expression(struct statement *stmt)
 	}
 	if (!ctype)
 		return NULL;
-	compatible_assignment_types(expr, fntype, &stmt->expression, ctype, "return expression", '=');
+	compatible_assignment_types(expr, fntype, &stmt->expression, ctype, "return expression");
 	return NULL;
 }
 
-- 
1.5.0-rc2.GIT
