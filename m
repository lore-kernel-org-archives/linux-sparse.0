From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH] first pass at null pointer constants
Date: Sun, 1 Jul 2007 08:49:22 +0100
Message-ID: <20070701074922.GB1101@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33474 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbXGAHtX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Jul 2007 03:49:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I4uBO-0000OP-1H
	for linux-sparse@vger.kernel.org; Sun, 01 Jul 2007 08:49:22 +0100
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

AFAICS, that should do null pointer constants right.  We assign
special instance of void * (&null_ctype) to (void *)<zero integer
constant expression> and replace it with normal void * when we
don't want null pointer constant.  is_zero_constant() checks if
we have an integer constant expression, does conservative expand
(i.e. instead of generating an error on 1/0, etc. leaves the
node unreplaced) and checks if we have reduced the sucker to
EXPR_VALUE[0] without comma taint.

Implemented all (AFAICS) special cases involving null pointer
constants; most changes in evaluate_compare() and evaluate_conditional().
Both are still incomplete; handling of qualifiers is still missing,
but that's a separate story.

Note that we get two new sets of warnings on the kernel build; one is
due to wrong size_t (handled in the next patch; didn't show up until
now since we didn't warn on comparison of pointers to incompatible
types) and another is a pile of warnings about integer 0 used as NULL
on
	if (p == 0)
where p is a pointer.  Additionally, there's an idiotic
	(p>0)
in one place (again, p is a pointer).  Bugger if I know how gcc doesn't
warn on that one, it's certainly a standard violation and bloody pointless
even as extension...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c   |  216 +++++++++++++++++++++++++++++++++++++++-------------------
 expand.c     |   38 +++++++---
 expression.h |    1 +
 symbol.c     |    4 +-
 symbol.h     |    3 +-
 5 files changed, 178 insertions(+), 84 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 3156e9d..b97a4d7 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -274,7 +274,7 @@ static struct expression * cast_to(struct expression *old, struct symbol *type)
 
 	warn_for_different_enum_types (old->pos, old->ctype, type);
 
-	if (is_same_type(old, type))
+	if (old->ctype != &null_ctype && is_same_type(old, type))
 		return old;
 
 	/*
@@ -567,6 +567,9 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *c
 	int multiply;
 	int bit_size;
 
+	if (ctype == &null_ctype)
+		ctype = &ptr_ctype;
+
 	examine_symbol_type(ctype);
 
 	if (!ctype->ctype.base_type) {
@@ -784,13 +787,10 @@ const char * type_difference(struct symbol *target, struct symbol *source,
 	return NULL;
 }
 
-static int is_null_ptr(struct expression *expr)
+static void bad_null(struct expression *expr)
 {
-	if (expr->type != EXPR_VALUE || expr->value)
-		return 0;
-	if (Wnon_pointer_null && !is_ptr_type(expr->ctype))
+	if (Wnon_pointer_null)
 		warning(expr->pos, "Using plain integer as NULL pointer");
-	return 1;
 }
 
 /*
@@ -973,12 +973,23 @@ static int modify_for_unsigned(int op)
 	return op;
 }
 
+static inline int is_null_pointer_constant(struct expression *e)
+{
+	if (e->ctype == &null_ctype)
+		return 1;
+	if (!(e->flags & Int_const_expr))
+		return 0;
+	return is_zero_constant(e) ? 2 : 0;
+}
+
 static struct symbol *evaluate_compare(struct expression *expr)
 {
 	struct expression *left = expr->left, *right = expr->right;
-	struct symbol *ltype = left->ctype, *rtype = right->ctype;
+	struct symbol *ltype, *rtype;
+	int lclass = classify_type(degenerate(left), &ltype);
+	int rclass = classify_type(degenerate(right), &rtype);
 	struct symbol *ctype;
-	int lclass, rclass;
+	const char *typediff;
 
 	if (expr->flags) {
 		if (!(expr->left->flags & expr->right->flags & Int_const_expr))
@@ -989,29 +1000,69 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	if (is_type_type(ltype) && is_type_type(rtype))
 		goto OK;
 
-	if (is_safe_type(ltype) || is_safe_type(rtype))
+	if (is_safe_type(left->ctype) || is_safe_type(right->ctype))
 		warning(expr->pos, "testing a 'safe expression'");
 
-	lclass = classify_type(ltype, &ltype);
-	rclass = classify_type(rtype, &rtype);
-
-	/* Pointer types? */
-	if ((lclass | rclass) & TYPE_PTR) {
-		// FIXME! Check the types for compatibility
-		expr->op = modify_for_unsigned(expr->op);
+	/* number on number */
+	if (lclass & rclass & TYPE_NUM) {
+		ctype = usual_conversions(expr->op, expr->left, expr->right,
+					  lclass, rclass, ltype, rtype);
+		expr->left = cast_to(expr->left, ctype);
+		expr->right = cast_to(expr->right, ctype);
+		if (ctype->ctype.modifiers & MOD_UNSIGNED)
+			expr->op = modify_for_unsigned(expr->op);
 		goto OK;
 	}
 
-	/* Both should be numbers */
-	if (!(lclass & rclass & TYPE_NUM))
+	/* at least one must be a pointer */
+	if (!((lclass | rclass) & TYPE_PTR))
+		return bad_expr_type(expr);
+
+	/* equality comparisons can be with null pointer constants */
+	if (expr->op == SPECIAL_EQUAL || expr->op == SPECIAL_NOTEQUAL) {
+		int is_null1 = is_null_pointer_constant(left);
+		int is_null2 = is_null_pointer_constant(right);
+		if (is_null1 == 2)
+			bad_null(left);
+		if (is_null2 == 2)
+			bad_null(right);
+		if (is_null1 && is_null2) {
+			int positive = expr->op == SPECIAL_EQUAL;
+			expr->type = EXPR_VALUE;
+			expr->value = positive;
+			goto OK;
+		}
+		if (is_null1) {
+			left = cast_to(left, rtype);
+			goto OK;
+		}
+		if (is_null2) {
+			right = cast_to(right, ltype);
+			goto OK;
+		}
+		/* they also have special treatment for pointers to void */
+		if (lclass & rclass & TYPE_PTR) {
+			if (get_base_type(ltype) == &void_ctype) {
+				right = cast_to(right, ltype);
+				goto OK;
+			}
+			if (get_base_type(rtype) == &void_ctype) {
+				left = cast_to(left, rtype);
+				goto OK;
+			}
+		}
+	}
+	/* both should be pointers */
+	if (!(lclass & rclass & TYPE_PTR))
 		return bad_expr_type(expr);
 
-	ctype = usual_conversions(expr->op, expr->left, expr->right,
-				  lclass, rclass, ltype, rtype);
-	expr->left = cast_to(expr->left, ctype);
-	expr->right = cast_to(expr->right, ctype);
-	if (ctype->ctype.modifiers & MOD_UNSIGNED)
-		expr->op = modify_for_unsigned(expr->op);
+	expr->op = modify_for_unsigned(expr->op);
+	typediff = type_difference(ltype, rtype, MOD_IGN, MOD_IGN);
+	if (!typediff)
+		goto OK;
+
+	expression_error(expr, "incompatible types in comparison expression (%s)", typediff);
+	return NULL;
 
 OK:
 	expr->ctype = &bool_ctype;
@@ -1032,12 +1083,12 @@ static struct symbol *compatible_ptr_type(struct expression *left, struct expres
 		rtype = rtype->ctype.base_type;
 
 	if (ltype->type == SYM_PTR) {
-		if (is_null_ptr(right) || rtype->ctype.base_type == &void_ctype)
+		if (rtype->ctype.base_type == &void_ctype)
 			return ltype;
 	}
 
 	if (rtype->type == SYM_PTR) {
-		if (is_null_ptr(left) || ltype->ctype.base_type == &void_ctype)
+		if (ltype->ctype.base_type == &void_ctype)
 			return rtype;
 	}
 	return NULL;
@@ -1090,13 +1141,45 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 		expr->cond_false = cast_to(expr->cond_false, ctype);
 		goto out;
 	}
-	ctype = compatible_ptr_type(*true, expr->cond_false);
-	if (ctype)
-		goto out;
+	if ((lclass | rclass) & TYPE_PTR) {
+		int is_null1 = is_null_pointer_constant(*true);
+		int is_null2 = is_null_pointer_constant(expr->cond_false);
+		if (is_null1 && is_null2) {
+			*true = cast_to(*true, &ptr_ctype);
+			expr->cond_false = cast_to(expr->cond_false, &ptr_ctype);
+			ctype = &ptr_ctype;
+			goto out;
+		}
+		if (is_null1 && (rclass & TYPE_PTR)) {
+			if (is_null1 == 2)
+				bad_null(*true);
+			*true = cast_to(*true, rtype);
+			ctype = rtype;
+			goto out;
+		}
+		if (is_null2 && (lclass & TYPE_PTR)) {
+			if (is_null2 == 2)
+				bad_null(expr->cond_false);
+			expr->cond_false = cast_to(expr->cond_false, ltype);
+			ctype = ltype;
+			goto out;
+		}
+		if (!(lclass & rclass & TYPE_PTR)) {
+			typediff = "different types";
+			goto Err;
+		}
+		/* OK, it's pointer on pointer */
+		/* XXX - we need to handle qualifiers */
+		ctype = compatible_ptr_type(*true, expr->cond_false);
+		if (ctype)
+			goto out;
+	}
 	ctype = ltype;
 	typediff = type_difference(ltype, rtype, MOD_IGN, MOD_IGN);
 	if (!typediff)
 		goto out;
+
+Err:
 	expression_error(expr, "incompatible types in conditional expression (%s)", typediff);
 	return NULL;
 
@@ -1185,6 +1268,16 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
 			goto Cast;
 	}
 
+	if (tclass & TYPE_PTR) {
+		// NULL pointer is always OK
+		int is_null = is_null_pointer_constant(*rp);
+		if (is_null) {
+			if (is_null == 2)
+				bad_null(*rp);
+			goto Cast;
+		}
+	}
+
 	/* It's OK if the target is more volatile or const than the source */
 	typediff = type_difference(target, source, MOD_VOLATILE | MOD_CONST, 0);
 	if (!typediff)
@@ -1192,14 +1285,9 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
 
 	/* Pointer destination? */
 	if (tclass & TYPE_PTR) {
-		struct expression *right = *rp;
 		int source_as;
 		int target_as;
 
-		// NULL pointer is always OK
-		if (is_null_ptr(right))
-			goto Cast;
-
 		/* "void *" matches anything as long as the address space is OK */
 		target_as = t->ctype.as | target->ctype.as;
 		source_as = s->ctype.as | source->ctype.as;
@@ -1941,7 +2029,10 @@ static int evaluate_arguments(struct symbol *f, struct symbol *fn, struct expres
 				if (!(mod & (MOD_LONG|MOD_LONGLONG)))
 					*p = cast_to(expr, &double_ctype);
 			} else if (class & TYPE_PTR) {
-				degenerate(expr);
+				if (expr->ctype == &null_ctype)
+					*p = cast_to(expr, &ptr_ctype);
+				else
+					degenerate(expr);
 			}
 		} else {
 			static char where[30];
@@ -2438,31 +2529,6 @@ static int get_as(struct symbol *sym)
 	return as;
 }
 
-static void cast_to_as(struct expression *e, int as)
-{
-	struct expression *v = e->cast_expression;
-	struct symbol *type = v->ctype;
-
-	if (!Wcast_to_address_space)
-		return;
-
-	if (v->type != EXPR_VALUE || v->value)
-		goto out;
-
-	/* cast from constant 0 to pointer is OK */
-	if (is_int_type(type))
-		return;
-
-	if (type->type == SYM_NODE)
-		type = type->ctype.base_type;
-
-	if (type->type == SYM_PTR && type->ctype.base_type == &void_ctype)
-		return;
-
-out:
-	warning(e->pos, "cast adds address space to expression (<asn:%d>)", as);
-}
-
 static struct symbol *evaluate_cast(struct expression *expr)
 {
 	struct expression *target = expr->cast_expression;
@@ -2557,17 +2623,23 @@ static struct symbol *evaluate_cast(struct expression *expr)
 		warning(expr->pos, "cast removes address space of expression");
 	if (as1 > 0 && as2 > 0 && as1 != as2)
 		warning(expr->pos, "cast between address spaces (<asn:%d>-><asn:%d>)", as2, as1);
-	if (as1 > 0 && !as2)
-		cast_to_as(expr, as1);
-
-	/*
-	 * Casts of constant values are special: they
-	 * can be NULL, and thus need to be simplified
-	 * early.
-	 */
-	if (target->type == EXPR_VALUE)
-		cast_value(expr, ctype, target, target->ctype);
-
+	if (as1 > 0 && !as2 &&
+	    !is_null_pointer_constant(target) && Wcast_to_address_space)
+		warning(expr->pos,
+			"cast adds address space to expression (<asn:%d>)", as1);
+
+	if (!(ctype->ctype.modifiers & MOD_PTRINHERIT) && class1 == TYPE_PTR &&
+	    !as1 && (target->flags & Int_const_expr)) {
+		if (t1->ctype.base_type == &void_ctype) {
+			if (is_zero_constant(target)) {
+				/* NULL */
+				expr->type = EXPR_VALUE;
+				expr->ctype = &null_ctype;
+				expr->value = 0;
+				return ctype;
+			}
+		}
+	}
 out:
 	return ctype;
 }
@@ -3153,6 +3225,8 @@ struct symbol *evaluate_statement(struct statement *stmt)
 	case STMT_EXPRESSION:
 		if (!evaluate_expression(stmt->expression))
 			return NULL;
+		if (stmt->expression->ctype == &null_ctype)
+			stmt->expression = cast_to(stmt->expression, &ptr_ctype);
 		return degenerate(stmt->expression);
 
 	case STMT_COMPOUND: {
diff --git a/expand.c b/expand.c
index 780b643..b2eeef8 100644
--- a/expand.c
+++ b/expand.c
@@ -34,6 +34,7 @@
 
 static int expand_expression(struct expression *);
 static int expand_statement(struct statement *);
+static int conservative;
 
 static int expand_symbol_expression(struct expression *expr)
 {
@@ -97,7 +98,7 @@ Int:
 	expr->value = value & mask;
 
 	// Stop here unless checking for truncation
-	if (!Wcast_truncate)
+	if (!Wcast_truncate || conservative)
 		return;
 	
 	// Check if we dropped any bits..
@@ -138,10 +139,8 @@ Float:
 
 static int check_shift_count(struct expression *expr, struct symbol *ctype, unsigned int count)
 {
-	if (count >= ctype->bit_size) {
-		warning(expr->pos, "shift too big (%u) for type %s", count, show_typename(ctype));
-		count &= ctype->bit_size-1;
-	}
+	warning(expr->pos, "shift too big (%u) for type %s", count, show_typename(ctype));
+	count &= ctype->bit_size-1;
 	return count;
 }
 
@@ -163,8 +162,12 @@ static int simplify_int_binop(struct expression *expr, struct symbol *ctype)
 		return 0;
 	r = right->value;
 	if (expr->op == SPECIAL_LEFTSHIFT || expr->op == SPECIAL_RIGHTSHIFT) {
-		r = check_shift_count(expr, ctype, r);
-		right->value = r;
+		if (r >= ctype->bit_size) {
+			if (conservative)
+				return 0;
+			r = check_shift_count(expr, ctype, r);
+			right->value = r;
+		}
 	}
 	if (left->type != EXPR_VALUE)
 		return 0;
@@ -257,10 +260,12 @@ static int simplify_int_binop(struct expression *expr, struct symbol *ctype)
 	expr->taint = left->taint | right->taint;
 	return 1;
 Div:
-	warning(expr->pos, "division by zero");
+	if (!conservative)
+		warning(expr->pos, "division by zero");
 	return 0;
 Overflow:
-	warning(expr->pos, "constant integer operation overflow");
+	if (!conservative)
+		warning(expr->pos, "constant integer operation overflow");
 	return 0;
 }
 
@@ -340,7 +345,8 @@ static int simplify_float_binop(struct expression *expr)
 	expr->fvalue = res;
 	return 1;
 Div:
-	warning(expr->pos, "division by zero");
+	if (!conservative)
+		warning(expr->pos, "division by zero");
 	return 0;
 }
 
@@ -660,7 +666,8 @@ static int simplify_preop(struct expression *expr)
 	return 1;
 
 Overflow:
-	warning(expr->pos, "constant integer operation overflow");
+	if (!conservative)
+		warning(expr->pos, "constant integer operation overflow");
 	return 0;
 }
 
@@ -1222,3 +1229,12 @@ long long const_expression_value(struct expression *expr)
 {
 	return __get_expression_value(expr, 1);
 }
+
+int is_zero_constant(struct expression *expr)
+{
+	int saved = conservative;
+	conservative = 1;
+	expand_expression(expr);
+	conservative = saved;
+	return expr->type == EXPR_VALUE && !expr->value;
+}
diff --git a/expression.h b/expression.h
index 23ca408..02eec02 100644
--- a/expression.h
+++ b/expression.h
@@ -154,6 +154,7 @@ struct expression {
 };
 
 /* Constant expression values */
+int is_zero_constant(struct expression *);
 long long get_expression_value(struct expression *);
 long long const_expression_value(struct expression *);
 
diff --git a/symbol.c b/symbol.c
index cec7e02..9dfeb41 100644
--- a/symbol.c
+++ b/symbol.c
@@ -753,7 +753,8 @@ struct symbol	bool_ctype, void_ctype, type_ctype,
 		llong_ctype, sllong_ctype, ullong_ctype,
 		float_ctype, double_ctype, ldouble_ctype,
 		string_ctype, ptr_ctype, lazy_ptr_ctype,
-		incomplete_ctype, label_ctype, bad_ctype;
+		incomplete_ctype, label_ctype, bad_ctype,
+		null_ctype;
 
 struct symbol	zero_int;
 
@@ -829,6 +830,7 @@ static const struct ctype_declare {
 
 	{ &string_ctype,    SYM_PTR,	  0,			    &bits_in_pointer,        &pointer_alignment, &char_ctype },
 	{ &ptr_ctype,	    SYM_PTR,	  0,			    &bits_in_pointer,        &pointer_alignment, &void_ctype },
+	{ &null_ctype,	    SYM_PTR,	  0,			    &bits_in_pointer,        &pointer_alignment, &void_ctype },
 	{ &label_ctype,	    SYM_PTR,	  0,			    &bits_in_pointer,        &pointer_alignment, &void_ctype },
 	{ &lazy_ptr_ctype,  SYM_PTR,	  0,			    &bits_in_pointer,        &pointer_alignment, &void_ctype },
 	{ NULL, }
diff --git a/symbol.h b/symbol.h
index 2bde84d..a59feee 100644
--- a/symbol.h
+++ b/symbol.h
@@ -229,7 +229,8 @@ extern struct symbol	bool_ctype, void_ctype, type_ctype,
 			llong_ctype, sllong_ctype, ullong_ctype,
 			float_ctype, double_ctype, ldouble_ctype,
 			string_ctype, ptr_ctype, lazy_ptr_ctype,
-			incomplete_ctype, label_ctype, bad_ctype;
+			incomplete_ctype, label_ctype, bad_ctype,
+			null_ctype;
 
 /* Special internal symbols */
 extern struct symbol	zero_int;
-- 
1.5.0-rc2.GIT
