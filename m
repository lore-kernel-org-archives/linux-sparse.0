From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 01/25] constexpr: introduce additional expression constness tracking flags
Date: Fri, 31 Mar 2017 03:44:35 +0200
Message-ID: <20170331014459.9351-2-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33226 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934699AbdCaBqb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:31 -0400
Received: by mail-wr0-f195.google.com with SMTP id u18so16610774wrc.0
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:29 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

Even if sparse attempted to verify that initializers for static storage
duration objects are constant expressions [6.7.8(4)] (which it
currently does not), it could not tell reliably.
Example:

  enum { b = 0 };
  static void *c = { (void*)b }; /* disallowed by C99 */

References to enum members are not allowed in address constants [6.6(9)]
and thus, the initializer is not a constant expression at all.

Prepare for a more fine-grained tracking of expression constness in the
sense of C99 [6.4.4, 6.6].

Introduce a broader set of constness tracking flags, resembling the
four types of primary expression constants [6.4.4] (integer, floating,
enumeration, character). Define helper macros to consistently set and
clear these flags as they are not completely independent.

In particular, introduce the following flags for tagging expression constness
at the level of primary expressions:
- CEF_INT: integer constant, i.e. literal
- CEF_FLOAT: floating point constant (former Float_literal flag)
- CEF_ENUM: enumeration constant
- CEF_CHAR: character constant

Introduce the CEF_ICE flag meant for tagging integer constant
expressions. It is equivalent to the former Int_const_expr flag.
Note that CEF_INT, CEF_ENUM and CEF_CHAR flags imply CEF_ICE being set.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c   | 52 +++++++++++++++++++++++++-------------------------
 expand.c     |  2 +-
 expression.c | 62 +++++++++++++++++++++++++++++++++++++-----------------------
 expression.h | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 118 insertions(+), 55 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 47eeaef2e..18f1da8b3 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -404,7 +404,7 @@ static struct symbol *bad_expr_type(struct expression *expr)
 		break;
 	}
 
-	expr->flags = 0;
+	expr->flags = CEF_NONE;
 	return expr->ctype = &bad_ctype;
 }
 
@@ -889,8 +889,8 @@ static struct symbol *evaluate_logical(struct expression *expr)
 	/* the result is int [6.5.13(3), 6.5.14(3)] */
 	expr->ctype = &int_ctype;
 	if (expr->flags) {
-		if (!(expr->left->flags & expr->right->flags & Int_const_expr))
-			expr->flags = 0;
+		if (!(expr->left->flags & expr->right->flags & CEF_ICE))
+			expr->flags = CEF_NONE;
 	}
 	return &int_ctype;
 }
@@ -903,8 +903,8 @@ static struct symbol *evaluate_binop(struct expression *expr)
 	int op = expr->op;
 
 	if (expr->flags) {
-		if (!(expr->left->flags & expr->right->flags & Int_const_expr))
-			expr->flags = 0;
+		if (!(expr->left->flags & expr->right->flags & CEF_ICE))
+			expr->flags = CEF_NONE;
 	}
 
 	/* number op number */
@@ -995,7 +995,7 @@ static inline int is_null_pointer_constant(struct expression *e)
 {
 	if (e->ctype == &null_ctype)
 		return 1;
-	if (!(e->flags & Int_const_expr))
+	if (!(e->flags & CEF_ICE))
 		return 0;
 	return is_zero_constant(e) ? 2 : 0;
 }
@@ -1010,8 +1010,8 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	const char *typediff;
 
 	if (expr->flags) {
-		if (!(expr->left->flags & expr->right->flags & Int_const_expr))
-			expr->flags = 0;
+		if (!(expr->left->flags & expr->right->flags & CEF_ICE))
+			expr->flags = CEF_NONE;
 	}
 
 	/* Type types? */
@@ -1129,10 +1129,10 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 	}
 
 	if (expr->flags) {
-		int flags = expr->conditional->flags & Int_const_expr;
+		int flags = expr->conditional->flags & CEF_ICE;
 		flags &= (*true)->flags & expr->cond_false->flags;
 		if (!flags)
-			expr->flags = 0;
+			expr->flags = CEF_NONE;
 	}
 
 	lclass = classify_type(ltype, &ltype);
@@ -1693,7 +1693,7 @@ static struct symbol *evaluate_addressof(struct expression *expr)
 	}
 	ctype = op->ctype;
 	*expr = *op->unop;
-	expr->flags = 0;
+	expr->flags = CEF_NONE;
 
 	if (expr->type == EXPR_SYMBOL) {
 		struct symbol *sym = expr->symbol;
@@ -1721,7 +1721,7 @@ static struct symbol *evaluate_dereference(struct expression *expr)
 	/* Simplify: *&(expr) => (expr) */
 	if (op->type == EXPR_PREOP && op->op == '&') {
 		*expr = *op->unop;
-		expr->flags = 0;
+		expr->flags = CEF_NONE;
 		return expr->ctype;
 	}
 
@@ -1811,8 +1811,8 @@ static struct symbol *evaluate_sign(struct expression *expr)
 {
 	struct symbol *ctype = expr->unop->ctype;
 	int class = classify_type(ctype, &ctype);
-	if (expr->flags && !(expr->unop->flags & Int_const_expr))
-		expr->flags = 0;
+	if (expr->flags && !(expr->unop->flags & CEF_ICE))
+		expr->flags = CEF_NONE;
 	/* should be an arithmetic type */
 	if (!(class & TYPE_NUM))
 		return bad_expr_type(expr);
@@ -1866,8 +1866,8 @@ static struct symbol *evaluate_preop(struct expression *expr)
 		return evaluate_postop(expr);
 
 	case '!':
-		if (expr->flags && !(expr->unop->flags & Int_const_expr))
-			expr->flags = 0;
+		if (expr->flags && !(expr->unop->flags & CEF_ICE))
+			expr->flags = CEF_NONE;
 		if (is_safe_type(ctype))
 			warning(expr->pos, "testing a 'safe expression'");
 		if (is_float_type(ctype)) {
@@ -2770,12 +2770,12 @@ static struct symbol *evaluate_cast(struct expression *expr)
 
 	/* cast to non-integer type -> not an integer constant expression */
 	if (!is_int(class1))
-		expr->flags = 0;
+		expr->flags = CEF_NONE;
 	/* if argument turns out to be not an integer constant expression *and*
 	   it was not a floating literal to start with -> too bad */
-	else if (expr->flags == Int_const_expr &&
-		!(target->flags & Int_const_expr))
-		expr->flags = 0;
+	else if (expr->flags & CEF_ICE && !(target->flags & CEF_ICE))
+		expr->flags = CEF_NONE;
+
 	/*
 	 * You can always throw a value away by casting to
 	 * "void" - that's an implicit "force". Note that
@@ -2837,7 +2837,7 @@ static struct symbol *evaluate_cast(struct expression *expr)
 			"cast adds address space to expression (<asn:%d>)", as1);
 
 	if (!(t1->ctype.modifiers & MOD_PTRINHERIT) && class1 == TYPE_PTR &&
-	    !as1 && (target->flags & Int_const_expr)) {
+	    !as1 && (target->flags & CEF_ICE)) {
 		if (t1->ctype.base_type == &void_ctype) {
 			if (is_zero_constant(target)) {
 				/* NULL */
@@ -2971,7 +2971,7 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 		}
 		ctype = field;
 		expr->type = EXPR_VALUE;
-		expr->flags = Int_const_expr;
+		expr->flags = CEF_SET_ICE;
 		expr->value = offset;
 		expr->taint = 0;
 		expr->ctype = size_t_ctype;
@@ -2989,7 +2989,7 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 		ctype = ctype->ctype.base_type;
 		if (!expr->index) {
 			expr->type = EXPR_VALUE;
-			expr->flags = Int_const_expr;
+			expr->flags = CEF_SET_ICE;
 			expr->value = 0;
 			expr->taint = 0;
 			expr->ctype = size_t_ctype;
@@ -3006,13 +3006,13 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 			m = alloc_const_expression(expr->pos,
 						   bits_to_bytes(ctype->bit_size));
 			m->ctype = size_t_ctype;
-			m->flags = Int_const_expr;
+			m->flags |= CEF_SET_ICE;
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
@@ -3023,7 +3023,7 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 		if (!evaluate_expression(e))
 			return NULL;
 		expr->type = EXPR_BINOP;
-		expr->flags = e->flags & copy->flags & Int_const_expr;
+		expr->flags = e->flags & copy->flags & ~CEF_CONST_MASK;
 		expr->op = '+';
 		expr->ctype = size_t_ctype;
 		expr->left = copy;
diff --git a/expand.c b/expand.c
index 5f908c971..3a6684226 100644
--- a/expand.c
+++ b/expand.c
@@ -1223,7 +1223,7 @@ static int expand_statement(struct statement *stmt)
 
 static inline int bad_integer_constant_expression(struct expression *expr)
 {
-	if (!(expr->flags & Int_const_expr))
+	if (!(expr->flags & CEF_ICE))
 		return 1;
 	if (expr->taint & Taint_comma)
 		return 1;
diff --git a/expression.c b/expression.c
index 638639df8..4189e5f3a 100644
--- a/expression.c
+++ b/expression.c
@@ -131,7 +131,7 @@ static struct token *parse_type(struct token *token, struct expression **tree)
 {
 	struct symbol *sym;
 	*tree = alloc_expression(token->pos, EXPR_TYPE);
-	(*tree)->flags = Int_const_expr; /* sic */
+	(*tree)->flags = CEF_SET_ICE; /* sic */
 	token = typename(token, &sym, NULL);
 	if (sym->ident)
 		sparse_error(token->pos,
@@ -146,7 +146,7 @@ static struct token *builtin_types_compatible_p_expr(struct token *token,
 {
 	struct expression *expr = alloc_expression(
 		token->pos, EXPR_COMPARE);
-	expr->flags = Int_const_expr;
+	expr->flags = CEF_SET_ICE;
 	expr->op = SPECIAL_EQUAL;
 	token = token->next;
 	if (!match_op(token, '('))
@@ -200,7 +200,7 @@ static struct token *builtin_offsetof_expr(struct token *token,
 			return expect(token, ')', "at end of __builtin_offset");
 		case SPECIAL_DEREFERENCE:
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->flags = Int_const_expr;
+			e->flags = CEF_SET_ICE;
 			e->op = '[';
 			*p = e;
 			p = &e->down;
@@ -208,7 +208,7 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		case '.':
 			token = token->next;
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->flags = Int_const_expr;
+			e->flags = CEF_SET_ICE;
 			e->op = '.';
 			if (token_type(token) != TOKEN_IDENT) {
 				sparse_error(token->pos, "Expected member name");
@@ -220,7 +220,7 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		case '[':
 			token = token->next;
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->flags = Int_const_expr;
+			e->flags = CEF_SET_ICE;
 			e->op = '[';
 			token = parse_expression(token, &e->index);
 			token = expect(token, ']',
@@ -336,7 +336,7 @@ got_it:
 			"likely to produce unsigned long (and a warning) here",
 			show_token(token));
         expr->type = EXPR_VALUE;
-	expr->flags = Int_const_expr;
+	expr->flags = CEF_SET_INT;
         expr->ctype = ctype_integer(size, want_unsigned);
         expr->value = value;
 	return;
@@ -361,7 +361,7 @@ Float:
 	else
 		goto Enoint;
 
-	expr->flags = Float_literal;
+	expr->flags = CEF_SET_FLOAT;
 	expr->type = EXPR_FVALUE;
 	return;
 
@@ -375,8 +375,8 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 
 	switch (token_type(token)) {
 	case TOKEN_CHAR ... TOKEN_WIDE_CHAR_EMBEDDED_3:
-		expr = alloc_expression(token->pos, EXPR_VALUE);   
-		expr->flags = Int_const_expr;
+		expr = alloc_expression(token->pos, EXPR_VALUE);
+		expr->flags = CEF_SET_CHAR;
 		expr->ctype = token_type(token) < TOKEN_WIDE_CHAR ? &int_ctype : &long_ctype;
 		get_char_constant(token, &expr->value);
 		token = token->next;
@@ -390,7 +390,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 
 	case TOKEN_ZERO_IDENT: {
 		expr = alloc_expression(token->pos, EXPR_SYMBOL);
-		expr->flags = Int_const_expr;
+		expr->flags = CEF_SET_INT;
 		expr->ctype = &int_ctype;
 		expr->symbol = &zero_int;
 		expr->symbol_name = token->ident;
@@ -417,7 +417,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 			*expr = *sym->initializer;
 			/* we want the right position reported, thus the copy */
 			expr->pos = token->pos;
-			expr->flags = Int_const_expr;
+			expr->flags = CEF_SET_ENUM;
 			token = next;
 			break;
 		}
@@ -457,7 +457,8 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 		}
 		if (token->special == '[' && lookup_type(token->next)) {
 			expr = alloc_expression(token->pos, EXPR_TYPE);
-			expr->flags = Int_const_expr; /* sic */
+			/* sic */
+			expr->flags = CEF_SET_ICE;
 			token = typename(token->next, &expr->symbol, NULL);
 			token = expect(token, ']', "in type expression");
 			break;
@@ -573,7 +574,7 @@ static struct token *type_info_expression(struct token *token,
 	struct token *p;
 
 	*tree = expr;
-	expr->flags = Int_const_expr; /* XXX: VLA support will need that changed */
+	expr->flags = CEF_SET_ICE; /* XXX: VLA support will need that changed */
 	token = token->next;
 	if (!match_op(token, '(') || !lookup_type(token->next))
 		return unary_expression(token, &expr->cast_expression);
@@ -663,7 +664,7 @@ static struct token *unary_expression(struct token *token, struct expression **t
 			unary = alloc_expression(token->pos, EXPR_PREOP);
 			unary->op = token->special;
 			unary->unop = unop;
-			unary->flags = unop->flags & Int_const_expr;
+			unary->flags = unop->flags & ~CEF_CONST_MASK;
 			*tree = unary;
 			return next;
 		}
@@ -721,10 +722,25 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 			if (!v)
 				return token;
 			cast->cast_expression = v;
-			if (v->flags & Int_const_expr)
-				cast->flags = Int_const_expr;
-			else if (v->flags & Float_literal) /* and _not_ int */
-				cast->flags = Int_const_expr | Float_literal;
+
+			cast->flags = v->flags & ~CEF_CONST_MASK;
+			/*
+			 * Up to now, we missed the (int).0 case here
+			 * which should really get a
+			 * CEF_ICE marker. Also,
+			 * conversion to non-numeric types is not
+			 * properly reflected up to this point.
+			 * However, we do not know until evaluation.
+			 * For the moment, in order to preserve
+			 * semantics, speculatively set
+			 * CEF_ICE if
+			 * CEF_FLOAT is
+			 * set. evaluate_cast() will unset
+			 * inappropriate flags again after examining
+			 * type information.
+			 */
+			if (v->flags & CEF_FLOAT)
+				cast->flags |= CEF_SET_ICE;
 			return token;
 		}
 	}
@@ -762,7 +778,7 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 				break;					\
 			}						\
 			top->flags = left->flags & right->flags		\
-						& Int_const_expr;	\
+						& ~CEF_CONST_MASK;	\
 			top->op = op;					\
 			top->left = left;				\
 			top->right = right;				\
@@ -866,12 +882,10 @@ struct token *conditional_expression(struct token *token, struct expression **tr
 		token = expect(token, ':', "in conditional expression");
 		token = conditional_expression(token, &expr->cond_false);
 		if (expr->left && expr->cond_false) {
-			int is_const = expr->left->flags &
-					expr->cond_false->flags &
-					Int_const_expr;
+			expr->flags = expr->left->flags & expr->cond_false->flags;
 			if (expr->cond_true)
-				is_const &= expr->cond_true->flags;
-			expr->flags = is_const;
+				expr->flags &= expr->cond_true->flags;
+			expr->flags &= ~CEF_CONST_MASK;
 		}
 	}
 	return token;
diff --git a/expression.h b/expression.h
index 80b3be5f5..e02cb8584 100644
--- a/expression.h
+++ b/expression.h
@@ -66,10 +66,59 @@ enum expression_type {
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
+ * - CEF_INT, CEF_ENUM and
+ *   CEF_CHAR imply CEF_ICE.
+ *
+ * Use the CEF_*_SET_MASK and CEF_*_CLEAR_MASK
+ * helper macros defined below to set or clear one of these flags.
+ */
+enum constexpr_flag {
+	CEF_NONE = 0,
+	/*
+	 * A constant in the sense of [6.4.4]:
+	 * - Integer constant [6.4.4.1]
+	 * - Floating point constant [6.4.4.2]
+	 * - Enumeration constant [6.4.4.3]
+	 * - Character constant [6.4.4.4]
+	 */
+	CEF_INT = (1 << 0),
+	CEF_FLOAT = (1 << 1),
+	CEF_ENUM = (1 << 2),
+	CEF_CHAR = (1 << 3),
+
+	/*
+	 * A constant expression in the sense of [6.6]:
+	 * - integer constant expression [6.6(6)]
+	 */
+	CEF_ICE = (1 << 4),
+
+
+	CEF_SET_ICE = (CEF_ICE),
+
+	/* integer constant => integer constant expression */
+	CEF_SET_INT = (CEF_INT | CEF_SET_ICE),
+
+	CEF_SET_FLOAT = (CEF_FLOAT),
+
+	/* enumeration constant => integer constant expression */
+	CEF_SET_ENUM = (CEF_ENUM | CEF_SET_ICE),
+
+	/* character constant => integer constant expression */
+	CEF_SET_CHAR = (CEF_CHAR | CEF_SET_ICE),
+
+	/*
+	 * Remove any "Constant" [6.4.4] flag, but retain the "constant
+	 * expression" [6.6] flags.
+	 */
+	CEF_CONST_MASK = (CEF_INT | CEF_FLOAT | CEF_CHAR),
+};
 
 enum {
 	Taint_comma = 1,
-- 
2.12.0

