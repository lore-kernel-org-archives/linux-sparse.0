From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 2/7] introduce classify_type(), use it in obvious places
Date: Sun, 01 Oct 2006 14:57:21 +0100
Message-ID: <E1GU1on-0006ug-QV@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33196 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932202AbWJAN5T
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 09:57:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1GU1on-0006ug-QV
	for linux-sparse@vger.kernel.org; Sun, 01 Oct 2006 14:57:21 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |  107 +++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 58 insertions(+), 49 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index fd29edf..b3a79e7 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -337,6 +337,40 @@ static inline int is_byte_type(struct sy
 	return type->bit_size == bits_in_char && type->type != SYM_BITFIELD;
 }
 
+enum {
+	TYPE_NUM = 1,
+	TYPE_BITFIELD = 2,
+	TYPE_RESTRICT = 4,
+	TYPE_FLOAT = 8,
+	TYPE_PTR = 16,
+	TYPE_COMPOUND = 32,
+};
+
+static inline int classify_type(struct symbol *type, struct symbol **base)
+{
+	static int type_class[SYM_BAD + 1] = {
+		[SYM_PTR] = TYPE_PTR,
+		[SYM_FN] = TYPE_PTR,
+		[SYM_ARRAY] = TYPE_PTR | TYPE_COMPOUND,
+		[SYM_STRUCT] = TYPE_COMPOUND,
+		[SYM_UNION] = TYPE_COMPOUND,
+		[SYM_BITFIELD] = TYPE_NUM | TYPE_BITFIELD,
+		[SYM_RESTRICT] = TYPE_NUM | TYPE_RESTRICT,
+	};
+	if (type->type == SYM_NODE)
+		type = type->ctype.base_type;
+	if (type->type == SYM_ENUM)
+		type = type->ctype.base_type;
+	*base = type;
+	if (type->type == SYM_BASETYPE) {
+		if (type->ctype.base_type == &int_type)
+			return TYPE_NUM;
+		if (type->ctype.base_type == &fp_type)
+			return TYPE_NUM | TYPE_FLOAT;
+	}
+	return type_class[type->type];
+}
+
 static inline int is_string_type(struct symbol *type)
 {
 	if (type->type == SYM_NODE)
@@ -1083,31 +1117,26 @@ static int compatible_assignment_types(s
 	struct expression **rp, struct symbol *source, const char *where, int op)
 {
 	const char *typediff;
-	struct symbol *t;
+	struct symbol *t, *s;
 	int target_as;
+	int tclass = classify_type(target, &t);
+	int sclass = classify_type(source, &s);
 
-	if (is_int_type(target)) {
-		if (is_int_type(source))
-			goto Cast;
-		if (is_float_type(source))
-			goto Cast;
-	} else if (is_float_type(target)) {
-		if (!compatible_float_op(op)) {
+	if (tclass & sclass & TYPE_NUM) {
+		if (tclass & TYPE_FLOAT && !compatible_float_op(op)) {
 			sparse_error(expr->pos, "invalid assignment");
 			return 0;
 		}
-		if (is_int_type(source))
-			goto Cast;
-		if (is_float_type(source))
+		if (tclass & TYPE_RESTRICT) {
+			if (restricted_binop(op, target)) {
+				sparse_error(expr->pos, "bad restricted assignment");
+				return 0;
+			}
+			if (!restricted_value(*rp, target))
+				return 1;
+		} else if (!(sclass & TYPE_RESTRICT))
 			goto Cast;
-	} else if (is_restricted_type(target)) {
-		if (restricted_binop(op, target)) {
-			sparse_error(expr->pos, "bad restricted assignment");
-			return 0;
-		}
-		if (!restricted_value(*rp, target))
-			return 1;
-	} else if (is_ptr_type(target)) {
+	} else if (tclass & TYPE_PTR) {
 		if (op == SPECIAL_ADD_ASSIGN || op == SPECIAL_SUB_ASSIGN) {
 			evaluate_ptr_add(expr, target, rp);
 			return 1;
@@ -1127,15 +1156,8 @@ static int compatible_assignment_types(s
 		return 1;
 
 	/* Pointer destination? */
-	t = target;
-	target_as = t->ctype.as;
-	if (t->type == SYM_NODE) {
-		t = t->ctype.base_type;
-		target_as |= t->ctype.as;
-	}
-	if (t->type == SYM_PTR || t->type == SYM_FN || t->type == SYM_ARRAY) {
+	if (tclass & TYPE_PTR) {
 		struct expression *right = *rp;
-		struct symbol *s = source;
 		int source_as;
 
 		// NULL pointer is always ok
@@ -1143,11 +1165,8 @@ static int compatible_assignment_types(s
 			goto Cast;
 
 		/* "void *" matches anything as long as the address space is ok */
-		source_as = s->ctype.as;
-		if (s->type == SYM_NODE) {
-			s = s->ctype.base_type;
-			source_as |= s->ctype.as;
-		}
+		target_as = t->ctype.as | target->ctype.as;
+		source_as = s->ctype.as | source->ctype.as;
 		if (source_as == target_as && (s->type == SYM_PTR || s->type == SYM_ARRAY)) {
 			s = get_base_type(s);
 			t = get_base_type(t);
@@ -2153,7 +2172,7 @@ static struct symbol *evaluate_cast(stru
 	struct expression *target = expr->cast_expression;
 	struct symbol *ctype = examine_symbol_type(expr->cast_type);
 	struct symbol *t1, *t2;
-	enum type type1, type2;
+	int class1, class2;
 	int as1, as2;
 
 	if (!target)
@@ -2193,12 +2212,7 @@ static struct symbol *evaluate_cast(stru
 	evaluate_expression(target);
 	degenerate(target);
 
-	t1 = ctype;
-	if (t1->type == SYM_NODE)
-		t1 = t1->ctype.base_type;
-	if (t1->type == SYM_ENUM)
-		t1 = t1->ctype.base_type;
-
+	class1 = classify_type(ctype, &t1);
 	/*
 	 * You can always throw a value away by casting to
 	 * "void" - that's an implicit "force". Note that
@@ -2207,8 +2221,7 @@ static struct symbol *evaluate_cast(stru
 	if (t1 == &void_ctype)
 		goto out;
 
-	type1 = t1->type;
-	if (type1 == SYM_ARRAY || type1 == SYM_UNION || type1 == SYM_STRUCT)
+	if (class1 & TYPE_COMPOUND)
 		warning(expr->pos, "cast to non-scalar");
 
 	t2 = target->ctype;
@@ -2216,19 +2229,15 @@ static struct symbol *evaluate_cast(stru
 		sparse_error(expr->pos, "cast from unknown type");
 		goto out;
 	}
-	if (t2->type == SYM_NODE)
-		t2 = t2->ctype.base_type;
-	if (t2->type == SYM_ENUM)
-		t2 = t2->ctype.base_type;
+	class2 = classify_type(t2, &t2);
 
-	type2 = t2->type;
-	if (type2 == SYM_ARRAY || type2 == SYM_UNION || type2 == SYM_STRUCT)
+	if (class2 & TYPE_COMPOUND)
 		warning(expr->pos, "cast from non-scalar");
 
 	if (!(ctype->ctype.modifiers & MOD_FORCE) && t1 != t2) {
-		if (t1->type == SYM_RESTRICT)
+		if (class1 & TYPE_RESTRICT)
 			warning(expr->pos, "cast to restricted type");
-		if (t2->type == SYM_RESTRICT)
+		if (class2 & TYPE_RESTRICT)
 			warning(expr->pos, "cast from restricted type");
 	}
 
-- 
1.4.2.GIT
