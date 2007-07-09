From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH] fix handling of address_space in casts and assignments
Date: Mon, 9 Jul 2007 23:13:06 +0100
Message-ID: <20070709221306.GP21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58554 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbXGIWNH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Jul 2007 18:13:07 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I81Te-0005N5-6H
	for linux-sparse@vger.kernel.org; Mon, 09 Jul 2007 23:13:06 +0100
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Turn FORCE_MOD into storage class specifier (that's how it's
actually used and that makes for much simpler logics).

Introduce explicit EXPR_FORCE_CAST for forced casts; handle it
properly.

Kill the idiocy in get_as() (we end up picking the oddest things
for address space - e.g. if we have int __attribute__((address_space(1))) *p,
we'll get warnings about removal of address space when we do things like
(unsigned short)*p.  Fixed.  BTW, that had caught a bunch of very odd
bogosities in the kernel and eliminated several false positives in there.

As the result, get_as() is gone now and evaluate_cast() got simpler.

Kill the similar idiocy in handling pointer assignments; while we are at it,
fix the qualifiers check for assignments to/from void * (you can't assign
const int * to void * - qualifiers on the left side should be no less than
on the right one; for normal codepath we get that checked, but the special
case of void * skips these checks).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 compile-i386.c |    1 +
 dissect.c      |    2 +-
 evaluate.c     |   91 +++++++++++++++++++++++---------------------------------
 expand.c       |    1 +
 expression.c   |   18 ++++++++---
 expression.h   |    3 +-
 inline.c       |    1 +
 linearize.c    |    1 +
 parse.c        |    7 +++-
 show-parse.c   |    1 +
 symbol.h       |    4 +-
 11 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/compile-i386.c b/compile-i386.c
index 425a1bc..8526408 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -2351,6 +2351,7 @@ static struct storage *x86_expression(struct expression *expr)
 		warning(expr->pos, "invalid expression after evaluation");
 		return NULL;
 	case EXPR_CAST:
+	case EXPR_FORCE_CAST:
 	case EXPR_IMPLIED_CAST:
 		return emit_cast_expr(expr);
 	case EXPR_VALUE:
diff --git a/dissect.c b/dissect.c
index 9dc3df9..61240d7 100644
--- a/dissect.c
+++ b/dissect.c
@@ -317,7 +317,7 @@ again:
 		do_expression(U_VOID, expr->left);
 		ret = do_expression(mode, expr->right);
 
-	break; case EXPR_CAST: //case EXPR_IMPLIED_CAST:
+	break; case EXPR_CAST: case EXPR_FORCE_CAST: //case EXPR_IMPLIED_CAST:
 		ret = base_type(expr->cast_type);
 		do_initializer(ret, expr->cast_expression);
 
diff --git a/evaluate.c b/evaluate.c
index b97a4d7..d505007 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1276,6 +1276,22 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
 				bad_null(*rp);
 			goto Cast;
 		}
+		if (sclass & TYPE_PTR && t->ctype.as == s->ctype.as) {
+			/* we should be more lazy here */
+			int mod1 = t->ctype.modifiers;
+			int mod2 = s->ctype.modifiers;
+			s = get_base_type(s);
+			t = get_base_type(t);
+
+			/*
+			 * assignments to/from void * are OK, provided that
+			 * we do not remove qualifiers from pointed to [C]
+			 * or mix address spaces [sparse].
+			 */
+			if (!(mod2 & ~mod1 & (MOD_VOLATILE | MOD_CONST)))
+				if (s == &void_ctype || t == &void_ctype)
+					goto Cast;
+		}
 	}
 
 	/* It's OK if the target is more volatile or const than the source */
@@ -1283,22 +1299,6 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
 	if (!typediff)
 		return 1;
 
-	/* Pointer destination? */
-	if (tclass & TYPE_PTR) {
-		int source_as;
-		int target_as;
-
-		/* "void *" matches anything as long as the address space is OK */
-		target_as = t->ctype.as | target->ctype.as;
-		source_as = s->ctype.as | source->ctype.as;
-		if (source_as == target_as && (s->type == SYM_PTR || s->type == SYM_ARRAY)) {
-			s = get_base_type(s);
-			t = get_base_type(t);
-			if (s == &void_ctype || t == &void_ctype)
-				goto Cast;
-		}
-	}
-
 	warning(expr->pos, "incorrect type in %s (%s)", where, typediff);
 	info(expr->pos, "   expected %s", show_typename(target));
 	info(expr->pos, "   got %s", show_typename(source));
@@ -1330,6 +1330,7 @@ static void mark_assigned(struct expression *expr)
 		mark_assigned(expr->right);
 		return;
 	case EXPR_CAST:
+	case EXPR_FORCE_CAST:
 		mark_assigned(expr->cast_expression);
 		return;
 	case EXPR_SLICE:
@@ -2496,46 +2497,13 @@ static void evaluate_initializer(struct symbol *ctype, struct expression **ep)
 		expression_error(*ep, "invalid initializer");
 }
 
-static int get_as(struct symbol *sym)
-{
-	int as;
-	unsigned long mod;
-
-	if (!sym)
-		return 0;
-	as = sym->ctype.as;
-	mod = sym->ctype.modifiers;
-	if (sym->type == SYM_NODE) {
-		sym = sym->ctype.base_type;
-		as |= sym->ctype.as;
-		mod |= sym->ctype.modifiers;
-	}
-
-	/*
-	 * At least for now, allow casting to a "unsigned long".
-	 * That's how we do things like pointer arithmetic and
-	 * store pointers to registers.
-	 */
-	if (sym == &ulong_ctype)
-		return -1;
-
-	if (sym && sym->type == SYM_PTR) {
-		sym = get_base_type(sym);
-		as |= sym->ctype.as;
-		mod |= sym->ctype.modifiers;
-	}
-	if (mod & MOD_FORCE)
-		return -1;
-	return as;
-}
-
 static struct symbol *evaluate_cast(struct expression *expr)
 {
 	struct expression *target = expr->cast_expression;
 	struct symbol *ctype;
 	struct symbol *t1, *t2;
 	int class1, class2;
-	int as1, as2;
+	int as1 = 0, as2 = 0;
 
 	if (!target)
 		return NULL;
@@ -2596,6 +2564,9 @@ static struct symbol *evaluate_cast(struct expression *expr)
 	if (class1 & TYPE_COMPOUND)
 		warning(expr->pos, "cast to non-scalar");
 
+	if (class1 == TYPE_PTR)
+		get_base_type(t1);
+
 	t2 = target->ctype;
 	if (!t2) {
 		expression_error(expr, "cast from unknown type");
@@ -2606,19 +2577,30 @@ static struct symbol *evaluate_cast(struct expression *expr)
 	if (class2 & TYPE_COMPOUND)
 		warning(expr->pos, "cast from non-scalar");
 
+	if (expr->type == EXPR_FORCE_CAST)
+		goto out;
+
 	/* allowed cast unfouls */
 	if (class2 & TYPE_FOULED)
 		t2 = t2->ctype.base_type;
 
-	if (!(ctype->ctype.modifiers & MOD_FORCE) && t1 != t2) {
+	if (t1 != t2) {
 		if (class1 & TYPE_RESTRICT)
 			warning(expr->pos, "cast to restricted type");
 		if (class2 & TYPE_RESTRICT)
 			warning(expr->pos, "cast from restricted type");
 	}
 
-	as1 = get_as(ctype);
-	as2 = get_as(target->ctype);
+	if (t1 == &ulong_ctype)
+		as1 = -1;
+	else if (class1 == TYPE_PTR)
+		as1 = t1->ctype.as;
+
+	if (t2 == &ulong_ctype)
+		as2 = -1;
+	else if (class2 == TYPE_PTR)
+		as2 = t2->ctype.as;
+
 	if (!as1 && as2 > 0)
 		warning(expr->pos, "cast removes address space of expression");
 	if (as1 > 0 && as2 > 0 && as1 != as2)
@@ -2628,7 +2610,7 @@ static struct symbol *evaluate_cast(struct expression *expr)
 		warning(expr->pos,
 			"cast adds address space to expression (<asn:%d>)", as1);
 
-	if (!(ctype->ctype.modifiers & MOD_PTRINHERIT) && class1 == TYPE_PTR &&
+	if (!(t1->ctype.modifiers & MOD_PTRINHERIT) && class1 == TYPE_PTR &&
 	    !as1 && (target->flags & Int_const_expr)) {
 		if (t1->ctype.base_type == &void_ctype) {
 			if (is_zero_constant(target)) {
@@ -2860,6 +2842,7 @@ struct symbol *evaluate_expression(struct expression *expr)
 			return NULL;
 		return evaluate_postop(expr);
 	case EXPR_CAST:
+	case EXPR_FORCE_CAST:
 	case EXPR_IMPLIED_CAST:
 		return evaluate_cast(expr);
 	case EXPR_SIZEOF:
diff --git a/expand.c b/expand.c
index b2eeef8..06b8127 100644
--- a/expand.c
+++ b/expand.c
@@ -955,6 +955,7 @@ static int expand_expression(struct expression *expr)
 		return expand_postop(expr);
 
 	case EXPR_CAST:
+	case EXPR_FORCE_CAST:
 	case EXPR_IMPLIED_CAST:
 		return expand_cast(expr);
 
diff --git a/expression.c b/expression.c
index 65f959e..77d665d 100644
--- a/expression.c
+++ b/expression.c
@@ -118,7 +118,7 @@ static struct token *parse_type(struct token *token, struct expression **tree)
 	struct symbol *sym;
 	*tree = alloc_expression(token->pos, EXPR_TYPE);
 	(*tree)->flags = Int_const_expr; /* sic */
-	token = typename(token, &sym);
+	token = typename(token, &sym, 0);
 	if (sym->ident)
 		sparse_error(token->pos,
 			     "type expression should not include identifier "
@@ -167,7 +167,7 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		return expect(token, '(', "after __builtin_offset");
 
 	token = token->next;
-	token = typename(token, &sym);
+	token = typename(token, &sym, 0);
 	if (sym->ident)
 		sparse_error(token->pos,
 			     "type expression should not include identifier "
@@ -482,7 +482,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 		if (token->special == '[' && lookup_type(token->next)) {
 			expr = alloc_expression(token->pos, EXPR_TYPE);
 			expr->flags = Int_const_expr; /* sic */
-			token = typename(token->next, &expr->symbol);
+			token = typename(token->next, &expr->symbol, 0);
 			token = expect(token, ']', "in type expression");
 			break;
 		}
@@ -600,7 +600,7 @@ static struct token *type_info_expression(struct token *token,
 	token = token->next;
 	if (!match_op(token, '(') || !lookup_type(token->next))
 		return unary_expression(token, &expr->cast_expression);
-	token = typename(token->next, &expr->cast_type);
+	token = typename(token->next, &expr->cast_type, 0);
 
 	if (!match_op(token, ')')) {
 		static const char * error[] = {
@@ -715,15 +715,23 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 			struct expression *cast = alloc_expression(next->pos, EXPR_CAST);
 			struct expression *v;
 			struct symbol *sym;
+			int is_force;
 
-			token = typename(next, &sym);
+			token = typename(next, &sym, MOD_FORCE);
 			cast->cast_type = sym;
+			is_force = sym->ctype.modifiers & MOD_FORCE;
+			sym->ctype.modifiers &= ~MOD_FORCE;
 			token = expect(token, ')', "at end of cast operator");
 			if (match_op(token, '{')) {
+				if (is_force)
+					warning(sym->pos,
+						"[force] in compound literal");
 				token = initializer(&cast->cast_expression, token);
 				return postfix_expression(token, tree, cast);
 			}
 			*tree = cast;
+			if (is_force)
+				cast->type = EXPR_FORCE_CAST;
 			token = cast_expression(token, &v);
 			if (!v)
 				return token;
diff --git a/expression.h b/expression.h
index 02eec02..fa5039a 100644
--- a/expression.h
+++ b/expression.h
@@ -27,6 +27,7 @@ enum expression_type {
 	EXPR_PREOP,
 	EXPR_POSTOP,
 	EXPR_CAST,
+	EXPR_FORCE_CAST,
 	EXPR_IMPLIED_CAST,
 	EXPR_SIZEOF,
 	EXPR_ALIGNOF,
@@ -190,7 +191,7 @@ static inline struct expression *alloc_const_expression(struct position pos, int
 }
 
 /* Type name parsing */
-struct token *typename(struct token *, struct symbol **);
+struct token *typename(struct token *, struct symbol **, int);
 
 static inline int lookup_type(struct token *token)
 {
diff --git a/inline.c b/inline.c
index 061261a..860c0ee 100644
--- a/inline.c
+++ b/inline.c
@@ -145,6 +145,7 @@ static struct expression * copy_expression(struct expression *expr)
 			*expr->cast_type = *sym;
 			break;
 		}
+	case EXPR_FORCE_CAST:
 	case EXPR_IMPLIED_CAST:
 	case EXPR_SIZEOF: 
 	case EXPR_PTRSIZEOF:
diff --git a/linearize.c b/linearize.c
index 3a07823..8a68f05 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1581,6 +1581,7 @@ pseudo_t linearize_expression(struct entrypoint *ep, struct expression *expr)
 		return linearize_postop(ep, expr);
 
 	case EXPR_CAST:
+	case EXPR_FORCE_CAST:
 	case EXPR_IMPLIED_CAST:
 		return linearize_cast(ep, expr);
 	
diff --git a/parse.c b/parse.c
index ab3a096..68f1dac 100644
--- a/parse.c
+++ b/parse.c
@@ -768,7 +768,7 @@ static struct token *typeof_specifier(struct token *token, struct ctype *ctype)
 		return token;
 	}
 	if (lookup_type(token->next)) {
-		token = typename(token->next, &sym);
+		token = typename(token->next, &sym, 0);
 		*ctype = sym->ctype;
 	} else {
 		struct symbol *typeof_sym = alloc_symbol(token->pos, SYM_TYPEOF);
@@ -1343,13 +1343,16 @@ static struct token *parameter_declaration(struct token *token, struct symbol **
 	return token;
 }
 
-struct token *typename(struct token *token, struct symbol **p)
+struct token *typename(struct token *token, struct symbol **p, int mod)
 {
 	struct symbol *sym = alloc_symbol(token->pos, SYM_NODE);
 	*p = sym;
 	token = declaration_specifiers(token, &sym->ctype, 0);
 	token = declarator(token, sym, NULL);
 	apply_modifiers(token->pos, &sym->ctype);
+	if (sym->ctype.modifiers & MOD_STORAGE & ~mod)
+		warning(sym->pos, "storage class in typename (%s)",
+			show_typename(sym));
 	return token;
 }
 
diff --git a/show-parse.c b/show-parse.c
index 07ee763..aae8b74 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -1053,6 +1053,7 @@ int show_expression(struct expression *expr)
 		warning(expr->pos, "invalid expression after evaluation");
 		return 0;
 	case EXPR_CAST:
+	case EXPR_FORCE_CAST:
 	case EXPR_IMPLIED_CAST:
 		return show_cast_expr(expr);
 	case EXPR_VALUE:
diff --git a/symbol.h b/symbol.h
index a59feee..4d8d328 100644
--- a/symbol.h
+++ b/symbol.h
@@ -204,12 +204,12 @@ struct symbol {
 #define MOD_BITWISE	0x80000000
 
 #define MOD_NONLOCAL	(MOD_EXTERN | MOD_TOPLEVEL)
-#define MOD_STORAGE	(MOD_AUTO | MOD_REGISTER | MOD_STATIC | MOD_EXTERN | MOD_INLINE | MOD_TOPLEVEL)
+#define MOD_STORAGE	(MOD_AUTO | MOD_REGISTER | MOD_STATIC | MOD_EXTERN | MOD_INLINE | MOD_TOPLEVEL | MOD_FORCE)
 #define MOD_SIGNEDNESS	(MOD_SIGNED | MOD_UNSIGNED | MOD_EXPLICITLY_SIGNED)
 #define MOD_SPECIFIER	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG | MOD_SIGNEDNESS)
 #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG)
 #define MOD_IGNORE (MOD_TOPLEVEL | MOD_STORAGE | MOD_ADDRESSABLE |	\
-	MOD_ASSIGNED | MOD_USERTYPE | MOD_FORCE | MOD_ACCESSED | MOD_EXPLICITLY_SIGNED)
+	MOD_ASSIGNED | MOD_USERTYPE | MOD_ACCESSED | MOD_EXPLICITLY_SIGNED)
 #define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STORAGE)
 
 
-- 
1.5.0-rc2.GIT
