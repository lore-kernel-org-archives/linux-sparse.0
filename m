From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v2 06/13] expression, evaluate: add support for recognizing address constants
Date: Mon, 25 Jan 2016 15:56:23 +0100
Message-ID: <874me1g12g.fsf@gmail.com>
References: <87twm1g1go.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35838 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755678AbcAYO40 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 09:56:26 -0500
Received: by mail-wm0-f67.google.com with SMTP id 123so11781409wmz.2
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 06:56:25 -0800 (PST)
In-Reply-To: <87twm1g1go.fsf@gmail.com> (Nicolai Stange's message of "Mon, 25
	Jan 2016 15:47:51 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Nicolai Stange <nicstange@gmail.com>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Address constants [6.6(9)] constitute one of the types of constant
expressions allowed in initializers [6.6(7)] for static storage
duration objects [6.7.8(4)].

Introduce support for recognizing address constants created either
- explicitly by referencing a static storage duration object by means
  of the unary & operator
- or implicitly by the use of an expression of array or function type.

Treat string literals as address constants.

Initially tag an expression as being an address constant at the
primary expression level, i.e. upon encountering a symbol designating
an object of static storage duration in primary_expression().

Carry these flags over to the *-preop wrapped expression created by
evaluate_symbol_expression().

For the special case of string literals, tag them as address constants
in evaluate_string().

Take care in evaluate_ptr_add() and evaluate_offset()
to properly propagate the address constness flags from
subexpressions to their parent expressions, namely the array ([])
or structure member dereference (->, .) expressions.

Finally, do not strip away an *-preop wrapped expression's constness
flags in evaluate_addressof().

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c   | 18 +++++++++++++++++-
 expression.c |  8 ++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 97da51d..70f419f 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -70,9 +70,11 @@ static struct symbol *evaluate_symbol_expression(struct expression *expr)
 	addr->symbol = sym;
 	addr->symbol_name = expr->symbol_name;
 	addr->ctype = &lazy_ptr_ctype;	/* Lazy evaluation: we need to do a proper job if somebody does &sym */
+	addr->flags = expr->flags;
 	expr->type = EXPR_PREOP;
 	expr->op = '*';
 	expr->unop = addr;
+	expr->flags = EXPR_FLAG_NONE;
 
 	/* The type of a symbol is the symbol itself! */
 	expr->ctype = sym;
@@ -106,6 +108,7 @@ static struct symbol *evaluate_string(struct expression *expr)
 	
 	addr->symbol = sym;
 	addr->ctype = &lazy_ptr_ctype;
+	expr_set_flag(&addr->flags, EXPR_FLAG_ADDR_CONST_EXPR);
 
 	expr->type = EXPR_PREOP;
 	expr->op = '*';
@@ -563,6 +566,14 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *i
 	classify_type(degenerate(expr->left), &ctype);
 	base = examine_pointer_target(ctype);
 
+	/*
+	 * An address constant +/- an integer constant expression
+	 * yields an address constant again [6.6(7)].
+	 */
+	if((expr->left->flags & EXPR_FLAG_ADDR_CONST_EXPR) &&
+		(expr->right->flags & EXPR_FLAG_INT_CONST_EXPR))
+		expr_set_flag(&expr->flags, EXPR_FLAG_ADDR_CONST_EXPR);
+
 	if (!base) {
 		expression_error(expr, "missing type information");
 		return NULL;
@@ -1678,7 +1689,6 @@ static struct symbol *evaluate_addressof(struct expression *expr)
 	}
 	ctype = op->ctype;
 	*expr = *op->unop;
-	expr->flags = EXPR_FLAG_NONE;
 
 	if (expr->type == EXPR_SYMBOL) {
 		struct symbol *sym = expr->symbol;
@@ -1945,6 +1955,12 @@ static struct expression *evaluate_offset(struct expression *expr, unsigned long
 	 * we ever take the address of this member dereference..
 	 */
 	add->ctype = &lazy_ptr_ctype;
+	/*
+	 * An address constant +/- an integer constant expression
+	 * yields an address constant again [6.6(7)].
+	 */
+	add->flags |= expr->flags;
+
 	return add;
 }
 
diff --git a/expression.c b/expression.c
index 792c2a5..afc4f39 100644
--- a/expression.c
+++ b/expression.c
@@ -437,6 +437,14 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 		}
 		expr->symbol_name = token->ident;
 		expr->symbol = sym;
+
+		/*
+		 * A pointer to an lvalue designating a static storage
+		 * duration object is an address constant [6.6(9)].
+		 */
+		if(sym && (sym->ctype.modifiers & (MOD_TOPLEVEL | MOD_STATIC)))
+			expr_set_flag(&expr->flags, EXPR_FLAG_ADDR_CONST_EXPR);
+
 		token = next;
 		break;
 	}
-- 
2.7.0

