From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 8/8] deal correctly with qualifiers on arrays
Date: Fri, 13 Jul 2007 18:45:37 +0100
Message-ID: <E1I9PCz-0000FX-65@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49782 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522AbXGMRpi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 13:45:38 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I9PCz-0000FX-65
	for linux-sparse@vger.kernel.org; Fri, 13 Jul 2007 18:45:37 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


* new helper: examine_pointer_target().  Examine target, find address_space
et.al.  If the target is SYM_NODE - merge it, etc.
* new helper: target_qualifiers().  Pointers to any array are considered
as pointers to unqualified type as far as implicit conversions are
concerned; handle that right.
* SYM_TYPEOF can be handled sanely now: don't copy the node, just convert
SYM_TYPEOF to SYM_NODE and examine that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   71 +++++++++++++++++++++++++++++++----------------------------
 symbol.c   |   37 ++++++++++++++++---------------
 symbol.h   |    1 +
 3 files changed, 57 insertions(+), 52 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 213039b..db33442 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -703,12 +703,12 @@ const char *type_difference(struct ctype *c1, struct ctype *c2,
 			if ((mod1 ^ mod2) & ~MOD_IGNORE & ~MOD_SPECIFIER)
 				return "different modifiers";
 			/* we could be lazier here */
+			base1 = examine_pointer_target(t1);
+			base2 = examine_pointer_target(t2);
 			mod1 = t1->ctype.modifiers;
 			as1 = t1->ctype.as;
 			mod2 = t2->ctype.modifiers;
 			as2 = t2->ctype.as;
-			base1 = examine_symbol_type(base1);
-			base2 = examine_symbol_type(base2);
 			break;
 		case SYM_FN: {
 			struct symbol *arg1, *arg2;
@@ -801,10 +801,17 @@ static void bad_null(struct expression *expr)
 		warning(expr->pos, "Using plain integer as NULL pointer");
 }
 
+static unsigned long target_qualifiers(struct symbol *type)
+{
+	unsigned long mod = type->ctype.modifiers & MOD_IGN;
+	if (type->ctype.base_type && type->ctype.base_type->type == SYM_ARRAY)
+		mod = 0;
+	return mod;
+}
+
 static struct symbol *evaluate_ptr_sub(struct expression *expr)
 {
 	const char *typediff;
-	struct symbol *ctype;
 	struct symbol *ltype, *rtype;
 	struct expression *l = expr->left;
 	struct expression *r = expr->right;
@@ -813,28 +820,25 @@ static struct symbol *evaluate_ptr_sub(struct expression *expr)
 	classify_type(degenerate(l), &ltype);
 	classify_type(degenerate(r), &rtype);
 
-	lbase = get_base_type(ltype);
-	rbase = get_base_type(rtype);
+	lbase = examine_pointer_target(ltype);
+	rbase = examine_pointer_target(rtype);
 	typediff = type_difference(&ltype->ctype, &rtype->ctype,
-				   MOD_IGN, MOD_IGN);
+				   target_qualifiers(rtype),
+				   target_qualifiers(ltype));
 	if (typediff)
 		expression_error(expr, "subtraction of different types can't work (%s)", typediff);
 
-	ctype = lbase;
-	/* Figure out the base type we point to */
-	if (ctype->type == SYM_NODE)
-		ctype = ctype->ctype.base_type;
-	if (ctype->type == SYM_FN) {
+	if (lbase->type == SYM_FN) {
 		expression_error(expr, "subtraction of functions? Share your drugs");
 		return NULL;
 	}
 
 	expr->ctype = ssize_t_ctype;
-	if (ctype->bit_size > bits_in_char) {
+	if (lbase->bit_size > bits_in_char) {
 		struct expression *sub = alloc_expression(expr->pos, EXPR_BINOP);
 		struct expression *div = expr;
 		struct expression *val = alloc_expression(expr->pos, EXPR_VALUE);
-		unsigned long value = ctype->bit_size >> 3;
+		unsigned long value = lbase->bit_size >> 3;
 
 		val->ctype = size_t_ctype;
 		val->value = value;
@@ -1050,8 +1054,8 @@ static struct symbol *evaluate_compare(struct expression *expr)
 		return bad_expr_type(expr);
 	expr->op = modify_for_unsigned(expr->op);
 
-	lbase = get_base_type(ltype);
-	rbase = get_base_type(rtype);
+	lbase = examine_pointer_target(ltype);
+	rbase = examine_pointer_target(rtype);
 
 	/* they also have special treatment for pointers to void */
 	if (expr->op == SPECIAL_EQUAL || expr->op == SPECIAL_NOTEQUAL) {
@@ -1068,7 +1072,8 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	}
 
 	typediff = type_difference(&ltype->ctype, &rtype->ctype,
-				   MOD_IGN, MOD_IGN);
+				   target_qualifiers(rtype),
+				   target_qualifiers(ltype));
 	if (!typediff)
 		goto OK;
 
@@ -1164,10 +1169,9 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 		}
 
 		/* need to be lazier here */
-		lbase = get_base_type(ltype);
-		rbase = get_base_type(rtype);
-		qual = ltype->ctype.modifiers | rtype->ctype.modifiers;
-		qual &= MOD_CONST | MOD_VOLATILE;
+		lbase = examine_pointer_target(ltype);
+		rbase = examine_pointer_target(rtype);
+		qual = target_qualifiers(ltype) | target_qualifiers(rtype);
 
 		if (lbase == &void_ctype) {
 			/* XXX: pointers to function should warn here */
@@ -1183,7 +1187,7 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 		/* XXX: that should be pointer to composite */
 		ctype = ltype;
 		typediff = type_difference(&ltype->ctype, &rtype->ctype,
-					   MOD_IGN, MOD_IGN);
+					   qual, qual);
 		if (!typediff)
 			goto Qual;
 		goto Err;
@@ -1314,11 +1318,10 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
 			typediff = "different base types";
 			goto Err;
 		}
-		/* we should be more lazy here */
-		mod1 = t->ctype.modifiers;
-		mod2 = s->ctype.modifiers;
-		b1 = get_base_type(t);
-		b2 = get_base_type(s);
+		b1 = examine_pointer_target(t);
+		b2 = examine_pointer_target(s);
+		mod1 = target_qualifiers(t);
+		mod2 = target_qualifiers(s);
 		if (b1 == &void_ctype || b2 == &void_ctype) {
 			/*
 			 * assignments to/from void * are OK, provided that
@@ -1329,15 +1332,14 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
 				typediff = "different address spaces";
 				goto Err;
 			}
-			if (mod2 & ~mod1 & MOD_IGN) {
+			if (mod2 & ~mod1) {
 				typediff = "different modifiers";
 				goto Err;
 			}
 			goto Cast;
 		}
 		/* It's OK if the target is more volatile or const than the source */
-		typediff = type_difference(&t->ctype, &s->ctype,
-					   0, mod1 & MOD_IGN);
+		typediff = type_difference(&t->ctype, &s->ctype, 0, mod1);
 		if (typediff)
 			goto Err;
 		return 1;
@@ -2623,9 +2625,6 @@ static struct symbol *evaluate_cast(struct expression *expr)
 	if (class1 & TYPE_COMPOUND)
 		warning(expr->pos, "cast to non-scalar");
 
-	if (class1 == TYPE_PTR)
-		get_base_type(t1);
-
 	t2 = target->ctype;
 	if (!t2) {
 		expression_error(expr, "cast from unknown type");
@@ -2652,13 +2651,17 @@ static struct symbol *evaluate_cast(struct expression *expr)
 
 	if (t1 == &ulong_ctype)
 		as1 = -1;
-	else if (class1 == TYPE_PTR)
+	else if (class1 == TYPE_PTR) {
+		examine_pointer_target(t1);
 		as1 = t1->ctype.as;
+	}
 
 	if (t2 == &ulong_ctype)
 		as2 = -1;
-	else if (class2 == TYPE_PTR)
+	else if (class2 == TYPE_PTR) {
+		examine_pointer_target(t2);
 		as2 = t2->ctype.as;
+	}
 
 	if (!as1 && as2 > 0)
 		warning(expr->pos, "cast removes address space of expression");
diff --git a/symbol.c b/symbol.c
index 9dfeb41..a64815c 100644
--- a/symbol.c
+++ b/symbol.c
@@ -193,13 +193,16 @@ static struct symbol *examine_base_type(struct symbol *sym)
 	struct symbol *base_type;
 
 	/* Check the base type */
-	base_type = sym->ctype.base_type;
-	if (base_type) {
-		base_type = examine_symbol_type(base_type);
-
-		/* "typeof" can cause this */
-		if (base_type && base_type->type == SYM_NODE)
-			merge_type(sym, base_type);
+	base_type = examine_symbol_type(sym->ctype.base_type);
+	if (!base_type || base_type->type == SYM_PTR)
+		return base_type;
+	sym->ctype.as |= base_type->ctype.as;
+	sym->ctype.modifiers |= base_type->ctype.modifiers & MOD_PTRINHERIT;
+	concat_ptr_list((struct ptr_list *)base_type->ctype.contexts,
+			(struct ptr_list **)&sym->ctype.contexts);
+	if (base_type->type == SYM_NODE) {
+		base_type = base_type->ctype.base_type;
+		sym->ctype.base_type = base_type;
 	}
 	return base_type;
 }
@@ -410,17 +413,10 @@ struct symbol *examine_symbol_type(struct symbol * sym)
 				warning(base->pos, "typeof applied to bitfield type");
 			if (base->type == SYM_NODE)
 				base = base->ctype.base_type;
-			switch (base->type) {
-			case SYM_RESTRICT:
-			case SYM_UNION:
-			case SYM_STRUCT:
-				sym->type = SYM_NODE;
-				sym->ctype.modifiers = 0;
-				sym->ctype.base_type = base;
-				return examine_node_type(sym);
-			}
-			*sym = *base;
-			break;
+			sym->type = SYM_NODE;
+			sym->ctype.modifiers = 0;
+			sym->ctype.base_type = base;
+			return examine_node_type(sym);
 		}
 		break;
 	}
@@ -443,6 +439,11 @@ struct symbol *examine_symbol_type(struct symbol * sym)
 	return sym;
 }
 
+struct symbol *examine_pointer_target(struct symbol *sym)
+{
+	return examine_base_type(sym);
+}
+
 static struct symbol_list *restr, *fouled;
 
 void create_fouled(struct symbol *type)
diff --git a/symbol.h b/symbol.h
index bf5b675..9b24f40 100644
--- a/symbol.h
+++ b/symbol.h
@@ -263,6 +263,7 @@ extern void add_symbol(struct symbol_list **, struct symbol *);
 extern void bind_symbol(struct symbol *, struct ident *, enum namespace);
 
 extern struct symbol *examine_symbol_type(struct symbol *);
+extern struct symbol *examine_pointer_target(struct symbol *);
 extern void examine_simple_symbol_type(struct symbol *);
 extern const char *show_typename(struct symbol *sym);
 extern const char *builtin_typename(struct symbol *sym);
-- 
1.5.0-rc2.GIT
