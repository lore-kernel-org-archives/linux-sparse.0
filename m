From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v2 01/13] expression: introduce additional expression constness tracking flags
Date: Mon, 25 Jan 2016 15:49:28 +0100
Message-ID: <87powpg1dz.fsf@gmail.com>
References: <87twm1g1go.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35819 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756158AbcAYOtc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 09:49:32 -0500
Received: by mail-wm0-f66.google.com with SMTP id 123so11741982wmz.2
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 06:49:31 -0800 (PST)
In-Reply-To: <87twm1g1go.fsf@gmail.com> (Nicolai Stange's message of "Mon, 25
	Jan 2016 15:47:51 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Nicolai Stange <nicstange@gmail.com>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Prepare for a more fine-grained tracking of expression constness in the
sense of C99 [6.4.4, 6.6].

User-visible behaviour remains unchanged.

The current implementation tags an expression with either combination
of the flags Int_const_expr and Float_literal, the latter being only
used to tell that
  (int).0
is indeed an integer constant expression.

Even if sparse attempted to verify that initializers for static storage
duration objects are constant expressions [6.7.8(4)] (which it
currently does not), it could not tell reliably.
Examples:
1.)
  static float a = { (float)0 }; /* allowed by C99 */
  '(float)0' is not an integer constant expression, but an arithmetic
  one.
2.)
  enum { b = 0 };
  static void *c = { (void*)b }; /* disallowed by C99 */
  References to enum members are not allowed in address constants
  [6.6(9)] and thus, the initializer is not a constant expression at
  all.

Introduce a broader set of constness tracking flags, resembling the
four types of constants [6.4.4] (integer, floating, enumeration,
character) and the three types of constant expressions [6.6] (integer,
arithmetic, address). Use helper functions to consistently set and
clear these flags as they are not completely independent.
Finally, make alloc_expression() and alloc_const_expression()
initialize the new expression's flags to zero.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c   |  72 ++++++++++++++++++++--------------
 expand.c     |   2 +-
 expression.c |  67 ++++++++++++++++++++------------
 expression.h | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 206 insertions(+), 58 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 035e448..0cf85ae 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -400,7 +400,7 @@ static struct symbol *bad_expr_type(struct expression *expr)
 		break;
 	}
 
-	expr->flags = 0;
+	expr->flags = EXPR_FLAG_NONE;
 	return expr->ctype = &bad_ctype;
 }
 
@@ -880,8 +880,9 @@ static struct symbol *evaluate_logical(struct expression *expr)
 	/* the result is int [6.5.13(3), 6.5.14(3)] */
 	expr->ctype = &int_ctype;
 	if (expr->flags) {
-		if (!(expr->left->flags & expr->right->flags & Int_const_expr))
-			expr->flags = 0;
+		if (!(expr->left->flags & expr->right->flags &
+				EXPR_FLAG_INT_CONST_EXPR))
+			expr->flags = EXPR_FLAG_NONE;
 	}
 	return &int_ctype;
 }
@@ -894,8 +895,9 @@ static struct symbol *evaluate_binop(struct expression *expr)
 	int op = expr->op;
 
 	if (expr->flags) {
-		if (!(expr->left->flags & expr->right->flags & Int_const_expr))
-			expr->flags = 0;
+		if (!(expr->left->flags & expr->right->flags &
+				EXPR_FLAG_INT_CONST_EXPR))
+			expr->flags = EXPR_FLAG_NONE;
 	}
 
 	/* number op number */
@@ -986,7 +988,7 @@ static inline int is_null_pointer_constant(struct expression *e)
 {
 	if (e->ctype == &null_ctype)
 		return 1;
-	if (!(e->flags & Int_const_expr))
+	if (!(e->flags & EXPR_FLAG_INT_CONST_EXPR))
 		return 0;
 	return is_zero_constant(e) ? 2 : 0;
 }
@@ -1001,8 +1003,9 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	const char *typediff;
 
 	if (expr->flags) {
-		if (!(expr->left->flags & expr->right->flags & Int_const_expr))
-			expr->flags = 0;
+		if (!(expr->left->flags & expr->right->flags &
+				EXPR_FLAG_INT_CONST_EXPR))
+			expr->flags = EXPR_FLAG_NONE;
 	}
 
 	/* Type types? */
@@ -1120,10 +1123,14 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 	}
 
 	if (expr->flags) {
-		int flags = expr->conditional->flags & Int_const_expr;
+		unsigned char flags_mask = 0;
+		unsigned char flags;
+
+		expr_set_flag(&flags_mask, EXPR_FLAG_INT_CONST_EXPR);
+		flags = (expr->conditional->flags & flags_mask);
 		flags &= (*true)->flags & expr->cond_false->flags;
 		if (!flags)
-			expr->flags = 0;
+			expr->flags = EXPR_FLAG_NONE;
 	}
 
 	lclass = classify_type(ltype, &ltype);
@@ -1681,7 +1688,7 @@ static struct symbol *evaluate_addressof(struct expression *expr)
 	}
 	ctype = op->ctype;
 	*expr = *op->unop;
-	expr->flags = 0;
+	expr->flags = EXPR_FLAG_NONE;
 
 	if (expr->type == EXPR_SYMBOL) {
 		struct symbol *sym = expr->symbol;
@@ -1709,7 +1716,7 @@ static struct symbol *evaluate_dereference(struct expression *expr)
 	/* Simplify: *&(expr) => (expr) */
 	if (op->type == EXPR_PREOP && op->op == '&') {
 		*expr = *op->unop;
-		expr->flags = 0;
+		expr->flags = EXPR_FLAG_NONE;
 		return expr->ctype;
 	}
 
@@ -1799,8 +1806,8 @@ static struct symbol *evaluate_sign(struct expression *expr)
 {
 	struct symbol *ctype = expr->unop->ctype;
 	int class = classify_type(ctype, &ctype);
-	if (expr->flags && !(expr->unop->flags & Int_const_expr))
-		expr->flags = 0;
+	if (expr->flags && !(expr->unop->flags & EXPR_FLAG_INT_CONST_EXPR))
+		expr->flags = EXPR_FLAG_NONE;
 	/* should be an arithmetic type */
 	if (!(class & TYPE_NUM))
 		return bad_expr_type(expr);
@@ -1854,8 +1861,9 @@ static struct symbol *evaluate_preop(struct expression *expr)
 		return evaluate_postop(expr);
 
 	case '!':
-		if (expr->flags && !(expr->unop->flags & Int_const_expr))
-			expr->flags = 0;
+		if (expr->flags && !(expr->unop->flags &
+					EXPR_FLAG_INT_CONST_EXPR))
+			expr->flags = EXPR_FLAG_NONE;
 		if (is_safe_type(ctype))
 			warning(expr->pos, "testing a 'safe expression'");
 		if (is_float_type(ctype)) {
@@ -2734,14 +2742,18 @@ static struct symbol *evaluate_cast(struct expression *expr)
 
 	class1 = classify_type(ctype, &t1);
 
-	/* cast to non-integer type -> not an integer constant expression */
-	if (!is_int(class1))
-		expr->flags = 0;
+	/* cast to non-numeric type -> not an arithmetic expression */
+	if (!(class1 & TYPE_NUM))
+		expr_clear_flag(&expr->flags, EXPR_FLAG_ARITH_CONST_EXPR);
+	/* cast to float type -> not an integer constant expression */
+	else if (class1 & TYPE_FLOAT)
+		expr_clear_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);
 	/* if argument turns out to be not an integer constant expression *and*
 	   it was not a floating literal to start with -> too bad */
-	else if (expr->flags == Int_const_expr &&
-		!(target->flags & Int_const_expr))
-		expr->flags = 0;
+	else if (!(target->flags &
+			(EXPR_FLAG_INT_CONST_EXPR | EXPR_FLAG_FP_CONST)))
+		expr_clear_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);
+
 	/*
 	 * You can always throw a value away by casting to
 	 * "void" - that's an implicit "force". Note that
@@ -2803,7 +2815,7 @@ static struct symbol *evaluate_cast(struct expression *expr)
 			"cast adds address space to expression (<asn:%d>)", as1);
 
 	if (!(t1->ctype.modifiers & MOD_PTRINHERIT) && class1 == TYPE_PTR &&
-	    !as1 && (target->flags & Int_const_expr)) {
+	    !as1 && (target->flags & EXPR_FLAG_INT_CONST_EXPR)) {
 		if (t1->ctype.base_type == &void_ctype) {
 			if (is_zero_constant(target)) {
 				/* NULL */
@@ -2933,7 +2945,8 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 		}
 		ctype = field;
 		expr->type = EXPR_VALUE;
-		expr->flags = Int_const_expr;
+		expr->flags = EXPR_FLAG_NONE;
+		expr_set_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);
 		expr->value = offset;
 		expr->taint = 0;
 		expr->ctype = size_t_ctype;
@@ -2951,7 +2964,8 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 		ctype = ctype->ctype.base_type;
 		if (!expr->index) {
 			expr->type = EXPR_VALUE;
-			expr->flags = Int_const_expr;
+			expr->flags = EXPR_FLAG_NONE;
+			expr_set_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);
 			expr->value = 0;
 			expr->taint = 0;
 			expr->ctype = size_t_ctype;
@@ -2968,24 +2982,26 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 			m = alloc_const_expression(expr->pos,
 						   bits_to_bytes(ctype->bit_size));
 			m->ctype = size_t_ctype;
-			m->flags = Int_const_expr;
+			expr_set_flag(&m->flags, EXPR_FLAG_INT_CONST_EXPR);
 			expr->type = EXPR_BINOP;
 			expr->left = idx;
 			expr->right = m;
 			expr->op = '*';
 			expr->ctype = size_t_ctype;
-			expr->flags = m->flags & idx->flags & Int_const_expr;
+			expr->flags = m->flags & idx->flags;
 		}
 	}
 	if (e) {
 		struct expression *copy = __alloc_expression(0);
+		unsigned char flags_mask = EXPR_FLAG_NONE;
 		*copy = *expr;
 		if (e->type == EXPR_OFFSETOF)
 			e->in = ctype;
 		if (!evaluate_expression(e))
 			return NULL;
 		expr->type = EXPR_BINOP;
-		expr->flags = e->flags & copy->flags & Int_const_expr;
+		expr_set_flag(&flags_mask, EXPR_FLAG_INT_CONST_EXPR);
+		expr->flags = e->flags & copy->flags & flags_mask;
 		expr->op = '+';
 		expr->ctype = size_t_ctype;
 		expr->left = copy;
diff --git a/expand.c b/expand.c
index 0f6720c..afca611 100644
--- a/expand.c
+++ b/expand.c
@@ -1212,7 +1212,7 @@ static int expand_statement(struct statement *stmt)
 
 static inline int bad_integer_constant_expression(struct expression *expr)
 {
-	if (!(expr->flags & Int_const_expr))
+	if (!(expr->flags & EXPR_FLAG_INT_CONST_EXPR))
 		return 1;
 	if (expr->taint & Taint_comma)
 		return 1;
diff --git a/expression.c b/expression.c
index 7293d47..eccdb5a 100644
--- a/expression.c
+++ b/expression.c
@@ -131,7 +131,7 @@ static struct token *parse_type(struct token *token, struct expression **tree)
 {
 	struct symbol *sym;
 	*tree = alloc_expression(token->pos, EXPR_TYPE);
-	(*tree)->flags = Int_const_expr; /* sic */
+	expr_set_flag(&(*tree)->flags, EXPR_FLAG_INT_CONST_EXPR); /* sic */
 	token = typename(token, &sym, NULL);
 	if (sym->ident)
 		sparse_error(token->pos,
@@ -146,7 +146,7 @@ static struct token *builtin_types_compatible_p_expr(struct token *token,
 {
 	struct expression *expr = alloc_expression(
 		token->pos, EXPR_COMPARE);
-	expr->flags = Int_const_expr;
+	expr_set_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);
 	expr->op = SPECIAL_EQUAL;
 	token = token->next;
 	if (!match_op(token, '('))
@@ -200,7 +200,7 @@ static struct token *builtin_offsetof_expr(struct token *token,
 			return expect(token, ')', "at end of __builtin_offset");
 		case SPECIAL_DEREFERENCE:
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->flags = Int_const_expr;
+			expr_set_flag(&e->flags, EXPR_FLAG_INT_CONST_EXPR);
 			e->op = '[';
 			*p = e;
 			p = &e->down;
@@ -208,7 +208,7 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		case '.':
 			token = token->next;
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->flags = Int_const_expr;
+			expr_set_flag(&e->flags, EXPR_FLAG_INT_CONST_EXPR);
 			e->op = '.';
 			if (token_type(token) != TOKEN_IDENT) {
 				sparse_error(token->pos, "Expected member name");
@@ -220,7 +220,7 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		case '[':
 			token = token->next;
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->flags = Int_const_expr;
+			expr_set_flag(&e->flags, EXPR_FLAG_INT_CONST_EXPR);
 			e->op = '[';
 			token = parse_expression(token, &e->index);
 			token = expect(token, ']',
@@ -336,7 +336,8 @@ got_it:
 			"likely to produce unsigned long (and a warning) here",
 			show_token(token));
         expr->type = EXPR_VALUE;
-	expr->flags = Int_const_expr;
+	expr->flags = EXPR_FLAG_NONE;
+	expr_set_flag(&expr->flags, EXPR_FLAG_INT_CONST);
         expr->ctype = ctype_integer(size, want_unsigned);
         expr->value = value;
 	return;
@@ -361,7 +362,8 @@ Float:
 	else
 		goto Enoint;
 
-	expr->flags = Float_literal;
+	expr->flags = EXPR_FLAG_NONE;
+	expr_set_flag(&expr->flags, EXPR_FLAG_FP_CONST);
 	expr->type = EXPR_FVALUE;
 	return;
 
@@ -376,7 +378,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 	switch (token_type(token)) {
 	case TOKEN_CHAR ... TOKEN_WIDE_CHAR_EMBEDDED_3:
 		expr = alloc_expression(token->pos, EXPR_VALUE);   
-		expr->flags = Int_const_expr;
+		expr_set_flag(&expr->flags, EXPR_FLAG_CHAR_CONST);
 		expr->ctype = token_type(token) < TOKEN_WIDE_CHAR ? &int_ctype : &long_ctype;
 		get_char_constant(token, &expr->value);
 		token = token->next;
@@ -390,7 +392,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 
 	case TOKEN_ZERO_IDENT: {
 		expr = alloc_expression(token->pos, EXPR_SYMBOL);
-		expr->flags = Int_const_expr;
+		expr_set_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);
 		expr->ctype = &int_ctype;
 		expr->symbol = &zero_int;
 		expr->symbol_name = token->ident;
@@ -417,7 +419,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 			*expr = *sym->initializer;
 			/* we want the right position reported, thus the copy */
 			expr->pos = token->pos;
-			expr->flags = Int_const_expr;
+			expr_set_flag(&expr->flags, EXPR_FLAG_ENUM_CONST);
 			token = next;
 			break;
 		}
@@ -457,7 +459,8 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 		}
 		if (token->special == '[' && lookup_type(token->next)) {
 			expr = alloc_expression(token->pos, EXPR_TYPE);
-			expr->flags = Int_const_expr; /* sic */
+			/* sic */
+			expr_set_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);
 			token = typename(token->next, &expr->symbol, NULL);
 			token = expect(token, ']', "in type expression");
 			break;
@@ -573,7 +576,8 @@ static struct token *type_info_expression(struct token *token,
 	struct token *p;
 
 	*tree = expr;
-	expr->flags = Int_const_expr; /* XXX: VLA support will need that changed */
+	/* XXX: VLA support will need that changed */
+	expr_set_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);
 	token = token->next;
 	if (!match_op(token, '(') || !lookup_type(token->next))
 		return unary_expression(token, &expr->cast_expression);
@@ -662,7 +666,8 @@ static struct token *unary_expression(struct token *token, struct expression **t
 			unary = alloc_expression(token->pos, EXPR_PREOP);
 			unary->op = token->special;
 			unary->unop = unop;
-			unary->flags = unop->flags & Int_const_expr;
+			unary->flags = unop->flags;
+			expr_flags_decay_consts(&unary->flags);
 			*tree = unary;
 			return next;
 		}
@@ -720,10 +725,25 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 			if (!v)
 				return token;
 			cast->cast_expression = v;
-			if (v->flags & Int_const_expr)
-				cast->flags = Int_const_expr;
-			else if (v->flags & Float_literal) /* and _not_ int */
-				cast->flags = Int_const_expr | Float_literal;
+
+			cast->flags = v->flags;
+			expr_flags_decay_consts(&cast->flags);
+			/*
+			 * Up to now, we missed the (int).0 case here
+			 * which should really get a
+			 * EXPR_FLAG_INT_CONST_EXPR marker. Also,
+			 * conversion to non-numeric types is not
+			 * properly reflected up to this point.
+			 * However, we do not know until evaluation.
+			 * For the moment, in order to preserve
+			 * semantics, speculatively set
+			 * EXPR_FLAG_INT_CONST_EXPR if
+			 * EXPR_FLAG_FP_CONST is set. evaluate_cast()
+			 * will unset inappropriate flags again after
+			 * examining type information.
+			 */
+			if (v->flags & EXPR_FLAG_FP_CONST)
+				cast->flags |= EXPR_FLAG_INT_CONST_EXPR;
 			return token;
 		}
 	}
@@ -760,8 +780,8 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 				sparse_error(next->pos, "No right hand side of '%s'-expression", show_special(op));	\
 				break;					\
 			}						\
-			top->flags = left->flags & right->flags		\
-						& Int_const_expr;	\
+			top->flags = left->flags & right->flags;	\
+			expr_flags_decay_consts(&top->flags);		\
 			top->op = op;					\
 			top->left = left;				\
 			top->right = right;				\
@@ -865,12 +885,11 @@ struct token *conditional_expression(struct token *token, struct expression **tr
 		token = expect(token, ':', "in conditional expression");
 		token = conditional_expression(token, &expr->cond_false);
 		if (expr->left && expr->cond_false) {
-			int is_const = expr->left->flags &
-					expr->cond_false->flags &
-					Int_const_expr;
+			expr->flags = expr->left->flags &
+				expr->cond_false->flags;
 			if (expr->cond_true)
-				is_const &= expr->cond_true->flags;
-			expr->flags = is_const;
+				expr->flags &= expr->cond_true->flags;
+			expr_flags_decay_consts(&expr->flags);
 		}
 	}
 	return token;
diff --git a/expression.h b/expression.h
index 80b3be5..b9f6f08 100644
--- a/expression.h
+++ b/expression.h
@@ -66,10 +66,121 @@ enum expression_type {
 	EXPR_OFFSETOF,
 };
 
-enum {
-	Int_const_expr = 1,
-	Float_literal = 2,
-}; /* for expr->flags */
+
+/*
+ * Flags for tracking the promotion of various attributes from
+ * subexpressions to their parents.
+ *
+ * Currently, they only cope with an expression's constness as defined
+ * by C99.
+ *
+ * The flags are not independent as one might imply another. Use
+ * expr_set_flag() and expr_clear_flag() for setting and clearing a
+ * particular flag.
+ */
+enum expression_flags {
+	EXPR_FLAG_NONE = 0,
+	/*
+	 * A constant in the sense of [6.4.4]:
+	 * - Integer constant [6.4.4.1]
+	 * - Floating point constant [6.4.4.2]
+	 * - Enumeration constant [6.4.4.3]
+	 * - Character constant [6.4.4.4]
+	 */
+	EXPR_FLAG_INT_CONST = (1 << 0),
+	EXPR_FLAG_FP_CONST = (1 << 1),
+	EXPR_FLAG_ENUM_CONST = (1 << 2),
+	EXPR_FLAG_CHAR_CONST = (1 << 3),
+
+	/*
+	 * A constant expression in the sense of [6.6]:
+	 * - integer constant expression [6.6(6)]
+	 * - arithmetic constant expression [6.6(8)]
+	 * - address constanr [6.6(9)]
+	 */
+	EXPR_FLAG_INT_CONST_EXPR = (1 << 4),
+	EXPR_FLAG_ARITH_CONST_EXPR = (1 << 5),
+	EXPR_FLAG_ADDR_CONST_EXPR = (1 << 6),
+};
+
+/*
+ * Set a particular flag among an expression's ones.
+ *
+ * The set of flags defined is not completely independent. Take care
+ * that implications keep obeyed.
+ *
+ * Only one single flag from enum expression_flags is allowed for
+ * the flag argument at a time.
+ */
+static inline void expr_set_flag(unsigned char * const flags,
+				enum expression_flags flag)
+{
+	/* obey the implications */
+	switch (flag) {
+	case EXPR_FLAG_INT_CONST:
+	case EXPR_FLAG_ENUM_CONST:
+	case EXPR_FLAG_CHAR_CONST:
+		flag |= EXPR_FLAG_INT_CONST_EXPR;
+	/* fallthrough */
+	case EXPR_FLAG_FP_CONST:
+	case EXPR_FLAG_INT_CONST_EXPR:
+		flag |= EXPR_FLAG_ARITH_CONST_EXPR;
+	/* fallthrough */
+	case EXPR_FLAG_ARITH_CONST_EXPR:
+	case EXPR_FLAG_ADDR_CONST_EXPR:
+	case EXPR_FLAG_NONE:
+		break;
+	}
+
+	*flags |= flag;
+}
+
+/*
+ * Clear a particular flag among an expression's ones.
+ *
+ * The set of flags defined is not completely independent. Take care
+ * that implications keep obeyed.
+ *
+ * Only one single flag from enum expression_flags is allowed for
+ * the flag argument at a time.
+ */
+static inline void expr_clear_flag(unsigned char * const flags,
+				enum expression_flags flag)
+{
+	/* obey the implications */
+	switch (flag) {
+	case EXPR_FLAG_ARITH_CONST_EXPR:
+		flag |= EXPR_FLAG_INT_CONST_EXPR;
+		flag |= EXPR_FLAG_FP_CONST;
+	/* fallthrough */
+	case EXPR_FLAG_INT_CONST_EXPR:
+		flag |= EXPR_FLAG_INT_CONST;
+		flag |= EXPR_FLAG_ENUM_CONST;
+		flag |= EXPR_FLAG_CHAR_CONST;
+	/* fallthrough */
+	case EXPR_FLAG_ADDR_CONST_EXPR:
+	case EXPR_FLAG_INT_CONST:
+	case EXPR_FLAG_FP_CONST:
+	case EXPR_FLAG_ENUM_CONST:
+	case EXPR_FLAG_CHAR_CONST:
+	case EXPR_FLAG_NONE:
+		break;
+	}
+
+	*flags &= ~flag;
+}
+
+/*
+ * Remove any "Constant" [6.4.4] flag, but retain the "constant
+ * expression" [6.6] flags.
+ * Used to merge the constantness flags of primary subexpressions
+ * into their parent expressions' ones.
+ */
+static inline void expr_flags_decay_consts(unsigned char * const flags)
+{
+	*flags &= ~(EXPR_FLAG_INT_CONST | EXPR_FLAG_FP_CONST |
+		EXPR_FLAG_ENUM_CONST | EXPR_FLAG_CHAR_CONST);
+}
 
 enum {
 	Taint_comma = 1,
@@ -77,7 +188,7 @@ enum {
 
 struct expression {
 	enum expression_type type:8;
-	unsigned flags:8;
+	unsigned char flags;
 	int op;
 	struct position pos;
 	struct symbol *ctype;
@@ -199,6 +310,7 @@ static inline struct expression *alloc_expression(struct position pos, int type)
 {
 	struct expression *expr = __alloc_expression(0);
 	expr->type = type;
+	expr->flags = EXPR_FLAG_NONE;
 	expr->pos = pos;
 	return expr;
 }
@@ -207,6 +319,7 @@ static inline struct expression *alloc_const_expression(struct position pos, int
 {
 	struct expression *expr = __alloc_expression(0);
 	expr->type = EXPR_VALUE;
+	expr->flags = EXPR_FLAG_NONE;
 	expr->pos = pos;
 	expr->value = value;
 	expr->ctype = &int_ctype;
-- 
2.7.0

