From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH RFC 06/13] expression, evaluate: add support for recognizing address constants
Date: Thu, 23 Jul 2015 01:18:08 +0200
Message-ID: <87615bkci7.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34505 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbbGVXSN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2015 19:18:13 -0400
Received: by wibud3 with SMTP id ud3so546889wib.1
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2015 16:18:12 -0700 (PDT)
Received: from localhost.localdomain (x55b1cac6.dyn.telefonica.de. [85.177.202.198])
        by smtp.gmail.com with ESMTPSA id qq1sm4630052wjc.0.2015.07.22.16.18.09
        for <linux-sparse@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 16:18:09 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

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
 evaluate.c   | 19 ++++++++++++++++++-
 expression.c |  9 +++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index edd0fe1..c38b893 100644
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
+	addr->flags |= expr_set_flag_mask(EXPR_FLAG_ADDR_CONST_EXPR);
 
 	expr->type = EXPR_PREOP;
 	expr->op = '*';
@@ -563,6 +566,15 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *i
 	classify_type(degenerate(expr->left), &ctype);
 	base = examine_pointer_target(ctype);
 
+	/*
+	 * An address constant +/- an integer constant expression
+	 * yields an address constant again [6.6(7)].
+	 */
+	if ((expr->left->flags & EXPR_FLAG_ADDR_CONST_EXPR) &&
+		(expr->right->flags & EXPR_FLAG_INT_CONST_EXPR))
+		expr->flags |=
+			expr_set_flag_mask(EXPR_FLAG_ADDR_CONST_EXPR);
+
 	if (!base) {
 		expression_error(expr, "missing type information");
 		return NULL;
@@ -1677,7 +1689,6 @@ static struct symbol *evaluate_addressof(struct expression *expr)
 	}
 	ctype = op->ctype;
 	*expr = *op->unop;
-	expr->flags = EXPR_FLAG_NONE;
 
 	if (expr->type == EXPR_SYMBOL) {
 		struct symbol *sym = expr->symbol;
@@ -1942,6 +1953,12 @@ static struct expression *evaluate_offset(struct expression *expr, unsigned long
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
index a18fcc6..4d5edc8 100644
--- a/expression.c
+++ b/expression.c
@@ -436,6 +436,15 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 		}
 		expr->symbol_name = token->ident;
 		expr->symbol = sym;
+
+		/*
+		 * A pointer to an lvalue designating a static storage
+		 * duration object is an address constant [6.6(9)].
+		 */
+		if (sym && (sym->ctype.modifiers & (MOD_TOPLEVEL | MOD_STATIC)))
+			expr->flags |=
+				expr_set_flag_mask(EXPR_FLAG_ADDR_CONST_EXPR);
+
 		token = next;
 		break;
 	}
-- 
2.4.5

