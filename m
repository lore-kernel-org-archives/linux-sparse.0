From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 01/21] expression: introduce additional expression constness tracking flags
Date: Mon, 01 Feb 2016 03:29:40 +0100
Message-ID: <87h9htjh7v.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33989 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933594AbcBAC3o (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:29:44 -0500
Received: by mail-wm0-f67.google.com with SMTP id p63so7008607wmp.1
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:29:43 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

Even if sparse attempted to verify that initializers for static storage
duration objects are constant expressions [6.7.8(4)] (which it
currently does not), it could not tell reliably.
Example:

  enum { b = 0 };
  static void *c = { (void*)b }; /* disallowed by C99 */

References to enum members are not allowed in address constants [6.6(9)] and thus,
the initializer is not a constant expression at all.

Prepare for a more fine-grained tracking of expression constness in the
sense of C99 [6.4.4, 6.6].

Introduce a broader set of constness tracking flags, resembling the
four types of primary expression constants [6.4.4] (integer, floating, enumeration,
character). Define helper macros to consistently set and clear these flags as they
are not completely independent.

In particular, introduce the following flags for tagging expression constness at
the level of primary expressions:
- CONSTEXPR_FLAG_INT_CONST: integer constant, i.e. literal
- CONSTEXPR_FLAG_FP_CONST: floating point constant, equivalent to the former
                           Float_literal flag
- CONSTEXPR_FLAG_ENUM_CONST: enumeration constant
- CONSTEXPR_FLAG_CHAR_CONST: character constant

Introduce the CONSTEXPR_FLAG_INT_CONST_EXPR flag meant for tagging integer constant
expressions. It is equivalent to the former Int_const_expr flag.
Note that the new CONSTEXPR_FLAG_INT_CONST, CONSTEXPR_FLAG_ENUM_CONST and
CONSTEXPR_FLAG_CHAR_CONST flags imply CONSTEXPR_FLAG_INT_CONST_EXPR being set.

Finally, rename ->flags to ->constexpr_flags because they are solely used for the
purpose of tracking an expression's constness.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c   | 83 ++++++++++++++++++++++++++++++++++++------------------------
 expand.c     | 10 ++++----
 expression.c | 82 ++++++++++++++++++++++++++++++++++++++++-------------------
 expression.h | 65 +++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 171 insertions(+), 69 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 035e448..7bce4fb 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -323,7 +323,7 @@ static struct expression * cast_to(struct expression *old, struct symbol *type)
 	}
 
 	expr = alloc_expression(old->pos, EXPR_IMPLIED_CAST);
-	expr->flags = old->flags;
+	expr->constexpr_flags = old->constexpr_flags;
 	expr->ctype = type;
 	expr->cast_type = type;
 	expr->cast_expression = old;
@@ -400,7 +400,7 @@ static struct symbol *bad_expr_type(struct expression *expr)
 		break;
 	}
 
-	expr->flags = 0;
+	expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
 	return expr->ctype = &bad_ctype;
 }
 
@@ -879,9 +879,11 @@ static struct symbol *evaluate_logical(struct expression *expr)
 
 	/* the result is int [6.5.13(3), 6.5.14(3)] */
 	expr->ctype = &int_ctype;
-	if (expr->flags) {
-		if (!(expr->left->flags & expr->right->flags & Int_const_expr))
-			expr->flags = 0;
+	if (expr->constexpr_flags) {
+		if (!(expr->left->constexpr_flags &
+				expr->right->constexpr_flags &
+				CONSTEXPR_FLAG_INT_CONST_EXPR))
+			expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
 	}
 	return &int_ctype;
 }
@@ -893,9 +895,11 @@ static struct symbol *evaluate_binop(struct expression *expr)
 	int rclass = classify_type(expr->right->ctype, &rtype);
 	int op = expr->op;
 
-	if (expr->flags) {
-		if (!(expr->left->flags & expr->right->flags & Int_const_expr))
-			expr->flags = 0;
+	if (expr->constexpr_flags) {
+		if (!(expr->left->constexpr_flags &
+				expr->right->constexpr_flags &
+				CONSTEXPR_FLAG_INT_CONST_EXPR))
+			expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
 	}
 
 	/* number op number */
@@ -965,7 +969,8 @@ static struct symbol *evaluate_comma(struct expression *expr)
 	expr->ctype = degenerate(expr->right);
 	if (expr->ctype == &null_ctype)
 		expr->ctype = &ptr_ctype;
-	expr->flags &= expr->left->flags & expr->right->flags;
+	expr->constexpr_flags &= expr->left->constexpr_flags &
+		expr->right->constexpr_flags;
 	return expr->ctype;
 }
 
@@ -986,7 +991,7 @@ static inline int is_null_pointer_constant(struct expression *e)
 {
 	if (e->ctype == &null_ctype)
 		return 1;
-	if (!(e->flags & Int_const_expr))
+	if (!(e->constexpr_flags & CONSTEXPR_FLAG_INT_CONST_EXPR))
 		return 0;
 	return is_zero_constant(e) ? 2 : 0;
 }
@@ -1000,9 +1005,11 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	struct symbol *ctype;
 	const char *typediff;
 
-	if (expr->flags) {
-		if (!(expr->left->flags & expr->right->flags & Int_const_expr))
-			expr->flags = 0;
+	if (expr->constexpr_flags) {
+		if (!(expr->left->constexpr_flags &
+				expr->right->constexpr_flags &
+				CONSTEXPR_FLAG_INT_CONST_EXPR))
+			expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
 	}
 
 	/* Type types? */
@@ -1119,11 +1126,13 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 		true = &expr->cond_true;
 	}
 
-	if (expr->flags) {
-		int flags = expr->conditional->flags & Int_const_expr;
-		flags &= (*true)->flags & expr->cond_false->flags;
+	if (expr->constexpr_flags) {
+		int flags = (expr->conditional->constexpr_flags &
+			CONSTEXPR_FLAG_INT_CONST_EXPR);
+		flags &= (*true)->constexpr_flags &
+			expr->cond_false->constexpr_flags;
 		if (!flags)
-			expr->flags = 0;
+			expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
 	}
 
 	lclass = classify_type(ltype, &ltype);
@@ -1681,7 +1690,7 @@ static struct symbol *evaluate_addressof(struct expression *expr)
 	}
 	ctype = op->ctype;
 	*expr = *op->unop;
-	expr->flags = 0;
+	expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
 
 	if (expr->type == EXPR_SYMBOL) {
 		struct symbol *sym = expr->symbol;
@@ -1709,7 +1718,7 @@ static struct symbol *evaluate_dereference(struct expression *expr)
 	/* Simplify: *&(expr) => (expr) */
 	if (op->type == EXPR_PREOP && op->op == '&') {
 		*expr = *op->unop;
-		expr->flags = 0;
+		expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
 		return expr->ctype;
 	}
 
@@ -1799,8 +1808,9 @@ static struct symbol *evaluate_sign(struct expression *expr)
 {
 	struct symbol *ctype = expr->unop->ctype;
 	int class = classify_type(ctype, &ctype);
-	if (expr->flags && !(expr->unop->flags & Int_const_expr))
-		expr->flags = 0;
+	if (expr->constexpr_flags && !(expr->unop->constexpr_flags &
+					CONSTEXPR_FLAG_INT_CONST_EXPR))
+		expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
 	/* should be an arithmetic type */
 	if (!(class & TYPE_NUM))
 		return bad_expr_type(expr);
@@ -1854,8 +1864,9 @@ static struct symbol *evaluate_preop(struct expression *expr)
 		return evaluate_postop(expr);
 
 	case '!':
-		if (expr->flags && !(expr->unop->flags & Int_const_expr))
-			expr->flags = 0;
+		if (expr->constexpr_flags && !(expr->unop->constexpr_flags &
+					CONSTEXPR_FLAG_INT_CONST_EXPR))
+			expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
 		if (is_safe_type(ctype))
 			warning(expr->pos, "testing a 'safe expression'");
 		if (is_float_type(ctype)) {
@@ -2736,12 +2747,13 @@ static struct symbol *evaluate_cast(struct expression *expr)
 
 	/* cast to non-integer type -> not an integer constant expression */
 	if (!is_int(class1))
-		expr->flags = 0;
+		expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
 	/* if argument turns out to be not an integer constant expression *and*
 	   it was not a floating literal to start with -> too bad */
-	else if (expr->flags == Int_const_expr &&
-		!(target->flags & Int_const_expr))
-		expr->flags = 0;
+	else if (expr->constexpr_flags & CONSTEXPR_FLAG_INT_CONST_EXPR &&
+		!(target->constexpr_flags & CONSTEXPR_FLAG_INT_CONST_EXPR))
+		expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
+
 	/*
 	 * You can always throw a value away by casting to
 	 * "void" - that's an implicit "force". Note that
@@ -2803,7 +2815,7 @@ static struct symbol *evaluate_cast(struct expression *expr)
 			"cast adds address space to expression (<asn:%d>)", as1);
 
 	if (!(t1->ctype.modifiers & MOD_PTRINHERIT) && class1 == TYPE_PTR &&
-	    !as1 && (target->flags & Int_const_expr)) {
+	    !as1 && (target->constexpr_flags & CONSTEXPR_FLAG_INT_CONST_EXPR)) {
 		if (t1->ctype.base_type == &void_ctype) {
 			if (is_zero_constant(target)) {
 				/* NULL */
@@ -2933,7 +2945,7 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 		}
 		ctype = field;
 		expr->type = EXPR_VALUE;
-		expr->flags = Int_const_expr;
+		expr->constexpr_flags = CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
 		expr->value = offset;
 		expr->taint = 0;
 		expr->ctype = size_t_ctype;
@@ -2951,7 +2963,8 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 		ctype = ctype->ctype.base_type;
 		if (!expr->index) {
 			expr->type = EXPR_VALUE;
-			expr->flags = Int_const_expr;
+			expr->constexpr_flags =
+				CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
 			expr->value = 0;
 			expr->taint = 0;
 			expr->ctype = size_t_ctype;
@@ -2968,13 +2981,15 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 			m = alloc_const_expression(expr->pos,
 						   bits_to_bytes(ctype->bit_size));
 			m->ctype = size_t_ctype;
-			m->flags = Int_const_expr;
+			m->constexpr_flags |=
+				CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
 			expr->type = EXPR_BINOP;
 			expr->left = idx;
 			expr->right = m;
 			expr->op = '*';
 			expr->ctype = size_t_ctype;
-			expr->flags = m->flags & idx->flags & Int_const_expr;
+			expr->constexpr_flags = m->constexpr_flags &
+				idx->constexpr_flags;
 		}
 	}
 	if (e) {
@@ -2985,7 +3000,9 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 		if (!evaluate_expression(e))
 			return NULL;
 		expr->type = EXPR_BINOP;
-		expr->flags = e->flags & copy->flags & Int_const_expr;
+		expr->constexpr_flags = e->constexpr_flags &
+			copy->constexpr_flags &
+			~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
 		expr->op = '+';
 		expr->ctype = size_t_ctype;
 		expr->left = copy;
diff --git a/expand.c b/expand.c
index 0f6720c..4739d54 100644
--- a/expand.c
+++ b/expand.c
@@ -472,11 +472,11 @@ static int expand_comma(struct expression *expr)
 	cost = expand_expression(expr->left);
 	cost += expand_expression(expr->right);
 	if (expr->left->type == EXPR_VALUE || expr->left->type == EXPR_FVALUE) {
-		unsigned flags = expr->flags;
+		unsigned flags = expr->constexpr_flags;
 		unsigned taint;
 		taint = expr->left->type == EXPR_VALUE ? expr->left->taint : 0;
 		*expr = *expr->right;
-		expr->flags = flags;
+		expr->constexpr_flags = flags;
 		if (expr->type == EXPR_VALUE)
 			expr->taint |= Taint_comma | taint;
 	}
@@ -540,14 +540,14 @@ static int expand_conditional(struct expression *expr)
 
 	cond_cost = expand_expression(cond);
 	if (cond->type == EXPR_VALUE) {
-		unsigned flags = expr->flags;
+		unsigned flags = expr->constexpr_flags;
 		if (!cond->value)
 			true = false;
 		if (!true)
 			true = cond;
 		cost = expand_expression(true);
 		*expr = *true;
-		expr->flags = flags;
+		expr->constexpr_flags = flags;
 		if (expr->type == EXPR_VALUE)
 			expr->taint |= cond->taint;
 		return cost;
@@ -1212,7 +1212,7 @@ static int expand_statement(struct statement *stmt)
 
 static inline int bad_integer_constant_expression(struct expression *expr)
 {
-	if (!(expr->flags & Int_const_expr))
+	if (!(expr->constexpr_flags & CONSTEXPR_FLAG_INT_CONST_EXPR))
 		return 1;
 	if (expr->taint & Taint_comma)
 		return 1;
diff --git a/expression.c b/expression.c
index 7293d47..f9adab6 100644
--- a/expression.c
+++ b/expression.c
@@ -131,7 +131,8 @@ static struct token *parse_type(struct token *token, struct expression **tree)
 {
 	struct symbol *sym;
 	*tree = alloc_expression(token->pos, EXPR_TYPE);
-	(*tree)->flags = Int_const_expr; /* sic */
+	(*tree)->constexpr_flags =
+		CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK; /* sic */
 	token = typename(token, &sym, NULL);
 	if (sym->ident)
 		sparse_error(token->pos,
@@ -146,7 +147,7 @@ static struct token *builtin_types_compatible_p_expr(struct token *token,
 {
 	struct expression *expr = alloc_expression(
 		token->pos, EXPR_COMPARE);
-	expr->flags = Int_const_expr;
+	expr->constexpr_flags = CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
 	expr->op = SPECIAL_EQUAL;
 	token = token->next;
 	if (!match_op(token, '('))
@@ -200,7 +201,8 @@ static struct token *builtin_offsetof_expr(struct token *token,
 			return expect(token, ')', "at end of __builtin_offset");
 		case SPECIAL_DEREFERENCE:
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->flags = Int_const_expr;
+			e->constexpr_flags =
+				CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
 			e->op = '[';
 			*p = e;
 			p = &e->down;
@@ -208,7 +210,8 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		case '.':
 			token = token->next;
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->flags = Int_const_expr;
+			e->constexpr_flags =
+				CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
 			e->op = '.';
 			if (token_type(token) != TOKEN_IDENT) {
 				sparse_error(token->pos, "Expected member name");
@@ -220,7 +223,8 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		case '[':
 			token = token->next;
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->flags = Int_const_expr;
+			e->constexpr_flags =
+				CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
 			e->op = '[';
 			token = parse_expression(token, &e->index);
 			token = expect(token, ']',
@@ -336,7 +340,7 @@ got_it:
 			"likely to produce unsigned long (and a warning) here",
 			show_token(token));
         expr->type = EXPR_VALUE;
-	expr->flags = Int_const_expr;
+	expr->constexpr_flags = CONSTEXPR_FLAG_INT_CONST_SET_MASK;
         expr->ctype = ctype_integer(size, want_unsigned);
         expr->value = value;
 	return;
@@ -361,7 +365,7 @@ Float:
 	else
 		goto Enoint;
 
-	expr->flags = Float_literal;
+	expr->constexpr_flags = CONSTEXPR_FLAG_FP_CONST_SET_MASK;
 	expr->type = EXPR_FVALUE;
 	return;
 
@@ -375,8 +379,8 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 
 	switch (token_type(token)) {
 	case TOKEN_CHAR ... TOKEN_WIDE_CHAR_EMBEDDED_3:
-		expr = alloc_expression(token->pos, EXPR_VALUE);   
-		expr->flags = Int_const_expr;
+		expr = alloc_expression(token->pos, EXPR_VALUE);
+		expr->constexpr_flags = CONSTEXPR_FLAG_CHAR_CONST_SET_MASK;
 		expr->ctype = token_type(token) < TOKEN_WIDE_CHAR ? &int_ctype : &long_ctype;
 		get_char_constant(token, &expr->value);
 		token = token->next;
@@ -390,7 +394,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 
 	case TOKEN_ZERO_IDENT: {
 		expr = alloc_expression(token->pos, EXPR_SYMBOL);
-		expr->flags = Int_const_expr;
+		expr->constexpr_flags = CONSTEXPR_FLAG_INT_CONST_SET_MASK;
 		expr->ctype = &int_ctype;
 		expr->symbol = &zero_int;
 		expr->symbol_name = token->ident;
@@ -417,7 +421,8 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 			*expr = *sym->initializer;
 			/* we want the right position reported, thus the copy */
 			expr->pos = token->pos;
-			expr->flags = Int_const_expr;
+			expr->constexpr_flags =
+				CONSTEXPR_FLAG_ENUM_CONST_SET_MASK;
 			token = next;
 			break;
 		}
@@ -452,12 +457,15 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 			expr->op = '(';
 			token = parens_expression(token, &expr->unop, "in expression");
 			if (expr->unop)
-				expr->flags = expr->unop->flags;
+				expr->constexpr_flags =
+					expr->unop->constexpr_flags;
 			break;
 		}
 		if (token->special == '[' && lookup_type(token->next)) {
 			expr = alloc_expression(token->pos, EXPR_TYPE);
-			expr->flags = Int_const_expr; /* sic */
+			/* sic */
+			expr->constexpr_flags =
+				CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
 			token = typename(token->next, &expr->symbol, NULL);
 			token = expect(token, ']', "in type expression");
 			break;
@@ -573,7 +581,8 @@ static struct token *type_info_expression(struct token *token,
 	struct token *p;
 
 	*tree = expr;
-	expr->flags = Int_const_expr; /* XXX: VLA support will need that changed */
+	/* XXX: VLA support will need that changed */
+	expr->constexpr_flags = CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
 	token = token->next;
 	if (!match_op(token, '(') || !lookup_type(token->next))
 		return unary_expression(token, &expr->cast_expression);
@@ -662,7 +671,8 @@ static struct token *unary_expression(struct token *token, struct expression **t
 			unary = alloc_expression(token->pos, EXPR_PREOP);
 			unary->op = token->special;
 			unary->unop = unop;
-			unary->flags = unop->flags & Int_const_expr;
+			unary->constexpr_flags = unop->constexpr_flags &
+				~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
 			*tree = unary;
 			return next;
 		}
@@ -720,10 +730,27 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 			if (!v)
 				return token;
 			cast->cast_expression = v;
-			if (v->flags & Int_const_expr)
-				cast->flags = Int_const_expr;
-			else if (v->flags & Float_literal) /* and _not_ int */
-				cast->flags = Int_const_expr | Float_literal;
+
+			cast->constexpr_flags = v->constexpr_flags &
+				~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
+			/*
+			 * Up to now, we missed the (int).0 case here
+			 * which should really get a
+			 * CONSTEXPR_FLAG_INT_CONST_EXPR marker. Also,
+			 * conversion to non-numeric types is not
+			 * properly reflected up to this point.
+			 * However, we do not know until evaluation.
+			 * For the moment, in order to preserve
+			 * semantics, speculatively set
+			 * CONSTEXPR_FLAG_INT_CONST_EXPR if
+			 * CONSTEXPR_FLAG_FP_CONST is
+			 * set. evaluate_cast() will unset
+			 * inappropriate flags again after examining
+			 * type information.
+			 */
+			if (v->constexpr_flags & CONSTEXPR_FLAG_FP_CONST)
+				cast->constexpr_flags |=
+					CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
 			return token;
 		}
 	}
@@ -760,8 +787,10 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 				sparse_error(next->pos, "No right hand side of '%s'-expression", show_special(op));	\
 				break;					\
 			}						\
-			top->flags = left->flags & right->flags		\
-						& Int_const_expr;	\
+			top->constexpr_flags =				\
+				left->constexpr_flags &		\
+				right->constexpr_flags &		\
+				~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;	\
 			top->op = op;					\
 			top->left = left;				\
 			top->right = right;				\
@@ -865,12 +894,13 @@ struct token *conditional_expression(struct token *token, struct expression **tr
 		token = expect(token, ':', "in conditional expression");
 		token = conditional_expression(token, &expr->cond_false);
 		if (expr->left && expr->cond_false) {
-			int is_const = expr->left->flags &
-					expr->cond_false->flags &
-					Int_const_expr;
+			expr->constexpr_flags = expr->left->constexpr_flags &
+				expr->cond_false->constexpr_flags;
 			if (expr->cond_true)
-				is_const &= expr->cond_true->flags;
-			expr->flags = is_const;
+				expr->constexpr_flags &=
+					expr->cond_true->constexpr_flags;
+			expr->constexpr_flags &=
+				~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
 		}
 	}
 	return token;
diff --git a/expression.h b/expression.h
index 80b3be5..3725a73 100644
--- a/expression.h
+++ b/expression.h
@@ -66,10 +66,65 @@ enum expression_type {
 	EXPR_OFFSETOF,
 };
 
-enum {
-	Int_const_expr = 1,
-	Float_literal = 2,
-}; /* for expr->flags */
+
+/*
+ * Flags for tracking the promotion of constness related attributes
+ * from subexpressions to their parents.
+ *
+ * The flags are not independent as one might imply another.
+ * The implications are as follows:
+ * - CONSTEXPR_FLAG_INT_CONST, CONSTEXPR_FLAG_ENUM_CONST and
+ *   CONSTEXPR_FLAG_CHAR_CONST imply CONSTEXPR_FLAG_INT_CONST_EXPR.
+ *
+ * Use the CONSTEXPR_FLAG_*_SET_MASK and CONSTEXPR_FLAG_*_CLEAR_MASK
+ * helper macros defined below to set or clear one of these flags.
+ */
+enum constexpr_flag {
+	CONSTEXPR_FLAG_NONE = 0,
+	/*
+	 * A constant in the sense of [6.4.4]:
+	 * - Integer constant [6.4.4.1]
+	 * - Floating point constant [6.4.4.2]
+	 * - Enumeration constant [6.4.4.3]
+	 * - Character constant [6.4.4.4]
+	 */
+	CONSTEXPR_FLAG_INT_CONST = (1 << 0),
+	CONSTEXPR_FLAG_FP_CONST = (1 << 1),
+	CONSTEXPR_FLAG_ENUM_CONST = (1 << 2),
+	CONSTEXPR_FLAG_CHAR_CONST = (1 << 3),
+
+	/*
+	 * A constant expression in the sense of [6.6]:
+	 * - integer constant expression [6.6(6)]
+	 */
+	CONSTEXPR_FLAG_INT_CONST_EXPR = (1 << 4),
+};
+
+#define CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK	\
+	(CONSTEXPR_FLAG_INT_CONST_EXPR)
+
+/* integer constant => integer constant expression */
+#define CONSTEXPR_FLAG_INT_CONST_SET_MASK			\
+	(CONSTEXPR_FLAG_INT_CONST | CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK)
+
+#define CONSTEXPR_FLAG_FP_CONST_SET_MASK	\
+	(CONSTEXPR_FLAG_FP_CONST)
+
+/* enumeration constant => integer constant expression */
+#define CONSTEXPR_FLAG_ENUM_CONST_SET_MASK				\
+	(CONSTEXPR_FLAG_ENUM_CONST | CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK)
+
+/* character constant => integer constant expression */
+#define CONSTEXPR_FLAG_CHAR_CONST_SET_MASK			\
+	(CONSTEXPR_FLAG_CHAR_CONST | CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK)
+
+/*
+ * Remove any "Constant" [6.4.4] flag, but retain the "constant
+ * expression" [6.6] flags.
+ */
+#define CONSTEXPR_FLAG_DECAY_CONSTS_MASK				\
+	(CONSTEXPR_FLAG_INT_CONST | CONSTEXPR_FLAG_INT_CONST |		\
+		CONSTEXPR_FLAG_FP_CONST | CONSTEXPR_FLAG_CHAR_CONST)
 
 enum {
 	Taint_comma = 1,
@@ -77,7 +132,7 @@ enum {
 
 struct expression {
 	enum expression_type type:8;
-	unsigned flags:8;
+	unsigned constexpr_flags:8;
 	int op;
 	struct position pos;
 	struct symbol *ctype;
-- 
2.7.0

