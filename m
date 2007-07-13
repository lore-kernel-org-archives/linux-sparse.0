From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 7/8] rewrite type_difference()
Date: Fri, 13 Jul 2007 18:45:27 +0100
Message-ID: <E1I9PCp-0000FJ-5s@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49746 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329AbXGMRp2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 13:45:28 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I9PCp-0000FJ-5s
	for linux-sparse@vger.kernel.org; Fri, 13 Jul 2007 18:45:27 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


a) qualifiers should not be ignored beyond the top layer
b) qualifiers *should* be ignored in top layer of function arguments
c) change prototype - pass ctype * instead of symbol * and pass
"what to add to modifiers in that ctype" instead of "what to ignore".

We are still not quite done (there are incomplete types, there
are array size comparisons, there is lifting of signedness logics
into compatible_assignment_types()), but it's a much better approximation.

BTW, it's already good enough for kernel ARRAY_SIZE(), which
has become a major source of noise lately...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |  272 +++++++++++++++++++++++++++++++++--------------------------
 expand.c   |    6 +-
 symbol.h   |    2 +-
 3 files changed, 157 insertions(+), 123 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 8df2042..213039b 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -621,92 +621,145 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *c
 
 static void examine_fn_arguments(struct symbol *fn);
 
-const char * type_difference(struct symbol *target, struct symbol *source,
-	unsigned long target_mod_ignore, unsigned long source_mod_ignore)
+#define MOD_IGN (MOD_VOLATILE | MOD_CONST)
+
+const char *type_difference(struct ctype *c1, struct ctype *c2,
+	unsigned long mod1, unsigned long mod2)
 {
+	unsigned long as1 = c1->as, as2 = c2->as;
+	struct symbol *t1 = c1->base_type;
+	struct symbol *t2 = c2->base_type;
+	int move1 = 1, move2 = 1;
+	mod1 |= c1->modifiers;
+	mod2 |= c2->modifiers;
 	for (;;) {
-		unsigned long mod1, mod2, diff;
-		unsigned long as1, as2;
-		int type1, type2;
-		struct symbol *base1, *base2;
+		unsigned long diff;
+		int type;
+		struct symbol *base1 = t1->ctype.base_type;
+		struct symbol *base2 = t2->ctype.base_type;
 
-		if (target == source)
-			break;
-		if (!target || !source)
-			return "different types";
 		/*
-		 * Peel of per-node information.
-		 * FIXME! Check alignment and context too here!
+		 * FIXME! Collect alignment and context too here!
 		 */
-		mod1 = target->ctype.modifiers;
-		as1 = target->ctype.as;
-		mod2 = source->ctype.modifiers;
-		as2 = source->ctype.as; 
-		if (target->type == SYM_NODE) {
-			target = target->ctype.base_type;
-			if (!target)
-				return "bad types";
-			if (target->type == SYM_PTR) {
-				mod1 = 0;
-				as1 = 0;
-			}	
-			mod1 |= target->ctype.modifiers;
-			as1 |= target->ctype.as;
-		}
-		if (source->type == SYM_NODE) {
-			source = source->ctype.base_type;
-			if (!source)
-				return "bad types";
-			if (source->type == SYM_PTR) {
-				mod2 = 0;
-				as2 = 0;
+		if (move1) {
+			if (t1 && t1->type != SYM_PTR) {
+				mod1 |= t1->ctype.modifiers;
+				as1 |= t1->ctype.as;
 			}
-			mod2 |= source->ctype.modifiers;
-			as2 |= source->ctype.as; 
-		}
-		if (target->type == SYM_ENUM) {
-			target = target->ctype.base_type;
-			if (!target)
-				return "bad types";
+			move1 = 0;
 		}
-		if (source->type == SYM_ENUM) {
-			source = source->ctype.base_type;
-			if (!source)
-				return "bad types";
+
+		if (move2) {
+			if (t2 && t2->type != SYM_PTR) {
+				mod2 |= t2->ctype.modifiers;
+				as2 |= t2->ctype.as;
+			}
+			move2 = 0;
 		}
 
-		if (target == source)
+		if (t1 == t2)
 			break;
-		if (!target || !source)
+		if (!t1 || !t2)
 			return "different types";
 
-		type1 = target->type;
-		base1 = target->ctype.base_type;
-
-		type2 = source->type;
-		base2 = source->ctype.base_type;
+		if (t1->type == SYM_NODE || t1->type == SYM_ENUM) {
+			t1 = base1;
+			move1 = 1;
+			if (!t1)
+				return "bad types";
+			continue;
+		}
 
-		/*
-		 * Pointers to functions compare as the function itself
-		 */
-		if (type1 == SYM_PTR && base1)
-			base1 = examine_symbol_type(base1);
+		if (t2->type == SYM_NODE || t2->type == SYM_ENUM) {
+			t2 = base2;
+			move2 = 1;
+			if (!t2)
+				return "bad types";
+			continue;
+		}
 
-		if (type2 == SYM_PTR && base2)
-			base2 = examine_symbol_type(base2);
+		move1 = move2 = 1;
+		type = t1->type;
+		if (type != t2->type)
+			return "different base types";
 
-		if (type1 != type2 || type1 == SYM_RESTRICT ||
-		    type1 == SYM_UNION || type1 == SYM_STRUCT)
+		switch (type) {
+		default:
+			sparse_error(t1->pos,
+				     "internal error: bad type in derived(%d)",
+				     type);
+			return "bad types";
+		case SYM_RESTRICT:
+		case SYM_UNION:
+		case SYM_STRUCT:
 			return "different base types";
+		case SYM_ARRAY:
+			/* XXX: we ought to compare sizes */
+			break;
+		case SYM_PTR:
+			if (Waddress_space && as1 != as2)
+				return "different address spaces";
+			/* MOD_SPECIFIER is due to idiocy in parse.c */
+			if ((mod1 ^ mod2) & ~MOD_IGNORE & ~MOD_SPECIFIER)
+				return "different modifiers";
+			/* we could be lazier here */
+			mod1 = t1->ctype.modifiers;
+			as1 = t1->ctype.as;
+			mod2 = t2->ctype.modifiers;
+			as2 = t2->ctype.as;
+			base1 = examine_symbol_type(base1);
+			base2 = examine_symbol_type(base2);
+			break;
+		case SYM_FN: {
+			struct symbol *arg1, *arg2;
+			int i;
 
-		/* Must be same address space to be comparable */
-		if (Waddress_space && as1 != as2)
-			return "different address spaces";
+			if (Waddress_space && as1 != as2)
+				return "different address spaces";
+			if ((mod1 ^ mod2) & ~MOD_IGNORE & ~MOD_SIGNEDNESS)
+				return "different modifiers";
+			mod1 = t1->ctype.modifiers;
+			as1 = t1->ctype.as;
+			mod2 = t2->ctype.modifiers;
+			as2 = t2->ctype.as;
 
-		/* Ignore differences in storage types or addressability */
-		diff = (mod1 ^ mod2) & ~MOD_IGNORE;
-		diff &= (mod1 & ~target_mod_ignore) | (mod2 & ~source_mod_ignore);
-		if (diff) {
+			if (base1->variadic != base2->variadic)
+				return "incompatible variadic arguments";
+			examine_fn_arguments(t1);
+			examine_fn_arguments(t2);
+			PREPARE_PTR_LIST(t1->arguments, arg1);
+			PREPARE_PTR_LIST(t2->arguments, arg2);
+			i = 1;
+			for (;;) {
+				const char *diffstr;
+				if (!arg1 && !arg2)
+					break;
+				if (!arg1 || !arg2)
+					return "different argument counts";
+				diffstr = type_difference(&arg1->ctype,
+							  &arg2->ctype,
+							  MOD_IGN, MOD_IGN);
+				if (diffstr) {
+					static char argdiff[80];
+					sprintf(argdiff, "incompatible argument %d (%s)", i, diffstr);
+					return argdiff;
+				}
+				NEXT_PTR_LIST(arg1);
+				NEXT_PTR_LIST(arg2);
+				i++;
+			}
+			FINISH_PTR_LIST(arg2);
+			FINISH_PTR_LIST(arg1);
+			break;
+		}
+		case SYM_BASETYPE:
+			if (Waddress_space && as1 != as2)
+				return "different address spaces";
+			if (base1 != base2)
+				return "different base types";
+			diff = (mod1 ^ mod2) & ~MOD_IGNORE;
+			if (!diff)
+				return NULL;
 			if (diff & MOD_SIZE)
 				return "different type sizes";
 			if (diff & ~MOD_SIGNEDNESS)
@@ -730,39 +783,15 @@ const char * type_difference(struct symbol *target, struct symbol *source,
 				if (!(mod1 & MOD_CHAR))
 					return "different signedness";
 			}
+			return NULL;
 		}
-
-		if (type1 == SYM_FN) {
-			int i;
-			struct symbol *arg1, *arg2;
-			if (base1->variadic != base2->variadic)
-				return "incompatible variadic arguments";
-			examine_fn_arguments(target);
-			examine_fn_arguments(source);
-			PREPARE_PTR_LIST(target->arguments, arg1);
-			PREPARE_PTR_LIST(source->arguments, arg2);
-			i = 1;
-			for (;;) {
-				const char *diffstr;
-				diffstr = type_difference(arg1, arg2, 0, 0);
-				if (diffstr) {
-					static char argdiff[80];
-					sprintf(argdiff, "incompatible argument %d (%s)", i, diffstr);
-					return argdiff;
-				}
-				if (!arg1)
-					break;
-				NEXT_PTR_LIST(arg1);
-				NEXT_PTR_LIST(arg2);
-				i++;
-			}
-			FINISH_PTR_LIST(arg2);
-			FINISH_PTR_LIST(arg1);
-		}
-
-		target = base1;
-		source = base2;
+		t1 = base1;
+		t2 = base2;
 	}
+	if (Waddress_space && as1 != as2)
+		return "different address spaces";
+	if ((mod1 ^ mod2) & ~MOD_IGNORE & ~MOD_SIGNEDNESS)
+		return "different modifiers";
 	return NULL;
 }
 
@@ -772,12 +801,6 @@ static void bad_null(struct expression *expr)
 		warning(expr->pos, "Using plain integer as NULL pointer");
 }
 
-/*
- * Ignore differences in "volatile" and "const"ness when
- * subtracting pointers
- */
-#define MOD_IGN (MOD_VOLATILE | MOD_CONST)
-
 static struct symbol *evaluate_ptr_sub(struct expression *expr)
 {
 	const char *typediff;
@@ -792,7 +815,8 @@ static struct symbol *evaluate_ptr_sub(struct expression *expr)
 
 	lbase = get_base_type(ltype);
 	rbase = get_base_type(rtype);
-	typediff = type_difference(ltype, rtype, ~MOD_SIZE, ~MOD_SIZE);
+	typediff = type_difference(&ltype->ctype, &rtype->ctype,
+				   MOD_IGN, MOD_IGN);
 	if (typediff)
 		expression_error(expr, "subtraction of different types can't work (%s)", typediff);
 
@@ -965,7 +989,7 @@ static inline int is_null_pointer_constant(struct expression *e)
 static struct symbol *evaluate_compare(struct expression *expr)
 {
 	struct expression *left = expr->left, *right = expr->right;
-	struct symbol *ltype, *rtype;
+	struct symbol *ltype, *rtype, *lbase, *rbase;
 	int lclass = classify_type(degenerate(left), &ltype);
 	int rclass = classify_type(degenerate(right), &rtype);
 	struct symbol *ctype;
@@ -1020,24 +1044,31 @@ static struct symbol *evaluate_compare(struct expression *expr)
 			right = cast_to(right, ltype);
 			goto OK;
 		}
-		/* they also have special treatment for pointers to void */
-		if (lclass & rclass & TYPE_PTR) {
-			if (get_base_type(ltype) == &void_ctype) {
+	}
+	/* both should be pointers */
+	if (!(lclass & rclass & TYPE_PTR))
+		return bad_expr_type(expr);
+	expr->op = modify_for_unsigned(expr->op);
+
+	lbase = get_base_type(ltype);
+	rbase = get_base_type(rtype);
+
+	/* they also have special treatment for pointers to void */
+	if (expr->op == SPECIAL_EQUAL || expr->op == SPECIAL_NOTEQUAL) {
+		if (ltype->ctype.as == rtype->ctype.as) {
+			if (lbase == &void_ctype) {
 				right = cast_to(right, ltype);
 				goto OK;
 			}
-			if (get_base_type(rtype) == &void_ctype) {
+			if (rbase == &void_ctype) {
 				left = cast_to(left, rtype);
 				goto OK;
 			}
 		}
 	}
-	/* both should be pointers */
-	if (!(lclass & rclass & TYPE_PTR))
-		return bad_expr_type(expr);
 
-	expr->op = modify_for_unsigned(expr->op);
-	typediff = type_difference(ltype, rtype, MOD_IGN, MOD_IGN);
+	typediff = type_difference(&ltype->ctype, &rtype->ctype,
+				   MOD_IGN, MOD_IGN);
 	if (!typediff)
 		goto OK;
 
@@ -1151,7 +1182,8 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 		}
 		/* XXX: that should be pointer to composite */
 		ctype = ltype;
-		typediff = type_difference(lbase, rbase, MOD_IGN, MOD_IGN);
+		typediff = type_difference(&ltype->ctype, &rtype->ctype,
+					   MOD_IGN, MOD_IGN);
 		if (!typediff)
 			goto Qual;
 		goto Err;
@@ -1304,8 +1336,8 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
 			goto Cast;
 		}
 		/* It's OK if the target is more volatile or const than the source */
-		typediff = type_difference(target, source,
-					   MOD_VOLATILE | MOD_CONST, 0);
+		typediff = type_difference(&t->ctype, &s->ctype,
+					   0, mod1 & MOD_IGN);
 		if (typediff)
 			goto Err;
 		return 1;
@@ -2926,7 +2958,7 @@ static void check_duplicates(struct symbol *sym)
 		const char *typediff;
 		evaluate_symbol(next);
 		declared++;
-		typediff = type_difference(sym, next, 0, 0);
+		typediff = type_difference(&sym->ctype, &next->ctype, 0, 0);
 		if (typediff) {
 			sparse_error(sym->pos, "symbol '%s' redeclared with different type (originally declared at %s:%d) - %s",
 				show_ident(sym->ident),
diff --git a/expand.c b/expand.c
index 06b8127..72d9be6 100644
--- a/expand.c
+++ b/expand.c
@@ -460,11 +460,13 @@ static int expand_comma(struct expression *expr)
 
 static int compare_types(int op, struct symbol *left, struct symbol *right)
 {
+	struct ctype c1 = {.base_type = left};
+	struct ctype c2 = {.base_type = right};
 	switch (op) {
 	case SPECIAL_EQUAL:
-		return !type_difference(left, right, MOD_IGN, MOD_IGN);
+		return !type_difference(&c1, &c2, MOD_IGN, MOD_IGN);
 	case SPECIAL_NOTEQUAL:
-		return type_difference(left, right, MOD_IGN, MOD_IGN) != NULL;
+		return type_difference(&c1, &c2, MOD_IGN, MOD_IGN) != NULL;
 	case '<':
 		return left->bit_size < right->bit_size;
 	case '>':
diff --git a/symbol.h b/symbol.h
index 4d8d328..bf5b675 100644
--- a/symbol.h
+++ b/symbol.h
@@ -245,7 +245,7 @@ extern struct symbol_list *translation_unit_used_list;
 
 extern void access_symbol(struct symbol *);
 
-extern const char * type_difference(struct symbol *target, struct symbol *source,
+extern const char * type_difference(struct ctype *c1, struct ctype *c2,
 	unsigned long target_mod_ignore, unsigned long source_mod_ignore);
 
 extern struct symbol *lookup_symbol(struct ident *, enum namespace);
-- 
1.5.0-rc2.GIT
