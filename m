From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH] fix the comma handling in integer constant expressions
Date: Sun, 1 Jul 2007 08:48:48 +0100
Message-ID: <20070701074848.GA1101@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33470 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbXGAHst (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Jul 2007 03:48:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I4uAq-0000NX-3I
	for linux-sparse@vger.kernel.org; Sun, 01 Jul 2007 08:48:48 +0100
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

[my apologies to the folks on Cc, original mails got the list address
buggered in To:, thus the resend of the entire series just to the list]

On Wed, Jun 27, 2007 at 04:54:25PM +0100, Al Viro wrote:
> ... or it could be done simpler, if we keep the current logics for
> Int_const_expr flag at parse time and add a 'const expression' one
> with rules as above.  Anyway, I'm going to get some sleep before
> dealing with that crap.

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sun, 1 Jul 2007 02:28:10 -0400
Subject: [PATCH] fix the comma handling in integer constant expressions

Treat it as normal binary operation, taint the value, check the taint.
We can do other kind of value tainting with the same infrastructure
as well...

Review and testing would be welcome; AFAICS, it works, but...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c   |    6 ++++++
 expand.c     |   41 ++++++++++++++++++++++++++++++++++++++---
 expression.c |   14 +++-----------
 expression.h |    9 ++++++++-
 symbol.c     |    1 +
 5 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index bcac1d2..3156e9d 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -956,6 +956,7 @@ static struct symbol *evaluate_binop(struct expression *expr)
 static struct symbol *evaluate_comma(struct expression *expr)
 {
 	expr->ctype = expr->right->ctype;
+	expr->flags &= expr->left->flags & expr->right->flags;
 	return expr->ctype;
 }
 
@@ -1859,6 +1860,7 @@ static struct symbol *evaluate_sizeof(struct expression *expr)
 		expression_error(expr, "cannot size expression");
 	expr->type = EXPR_VALUE;
 	expr->value = size >> 3;
+	expr->taint = 0;
 	expr->ctype = size_t_ctype;
 	return size_t_ctype;
 }
@@ -1892,6 +1894,7 @@ static struct symbol *evaluate_ptrsizeof(struct expression *expr)
 		size = 0;
 	expr->type = EXPR_VALUE;
 	expr->value = size >> 3;
+	expr->taint = 0;
 	expr->ctype = size_t_ctype;
 	return size_t_ctype;
 }
@@ -1906,6 +1909,7 @@ static struct symbol *evaluate_alignof(struct expression *expr)
 
 	expr->type = EXPR_VALUE;
 	expr->value = type->ctype.alignment;
+	expr->taint = 0;
 	expr->ctype = size_t_ctype;
 	return size_t_ctype;
 }
@@ -2675,6 +2679,7 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 		expr->type = EXPR_VALUE;
 		expr->flags = Int_const_expr;
 		expr->value = offset;
+		expr->taint = 0;
 		expr->ctype = size_t_ctype;
 	} else {
 		if (!ctype) {
@@ -2692,6 +2697,7 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 			expr->type = EXPR_VALUE;
 			expr->flags = Int_const_expr;
 			expr->value = 0;
+			expr->taint = 0;
 			expr->ctype = size_t_ctype;
 		} else {
 			struct expression *idx = expr->index, *m;
diff --git a/expand.c b/expand.c
index f945518..780b643 100644
--- a/expand.c
+++ b/expand.c
@@ -44,6 +44,7 @@ static int expand_symbol_expression(struct expression *expr)
 			warning(expr->pos, "undefined preprocessor identifier '%s'", show_ident(expr->symbol_name));
 		expr->type = EXPR_VALUE;
 		expr->value = 0;
+		expr->taint = 0;
 		return 0;
 	}
 	/* The cost of a symbol expression is lower for on-stack symbols */
@@ -80,6 +81,7 @@ void cast_value(struct expression *expr, struct symbol *newtype,
 
 	// For pointers and integers, we can just move the value around
 	expr->type = EXPR_VALUE;
+	expr->taint = old->taint;
 	if (old_size == new_size) {
 		expr->value = old->value;
 		return;
@@ -116,6 +118,7 @@ Float:
 	if (newtype->ctype.base_type != &fp_type) {
 		value = (long long)old->fvalue;
 		expr->type = EXPR_VALUE;
+		expr->taint = 0;
 		goto Int;
 	}
 
@@ -251,6 +254,7 @@ static int simplify_int_binop(struct expression *expr, struct symbol *ctype)
 	mask = mask | (mask-1);
 	expr->value = v & mask;
 	expr->type = EXPR_VALUE;
+	expr->taint = left->taint | right->taint;
 	return 1;
 Div:
 	warning(expr->pos, "division by zero");
@@ -288,6 +292,7 @@ static int simplify_cmp_binop(struct expression *expr, struct symbol *ctype)
 	case SPECIAL_UNSIGNED_GTE:expr->value = l >= r; break;
 	}
 	expr->type = EXPR_VALUE;
+	expr->taint = left->taint | right->taint;
 	return 1;
 }
 
@@ -358,6 +363,7 @@ static int simplify_float_cmp(struct expression *expr, struct symbol *ctype)
 	case SPECIAL_NOTEQUAL:	expr->value = l != r; break;
 	}
 	expr->type = EXPR_VALUE;
+	expr->taint = 0;
 	return 1;
 }
 
@@ -387,12 +393,14 @@ static int expand_logical(struct expression *expr)
 			if (!left->value) {
 				expr->type = EXPR_VALUE;
 				expr->value = 0;
+				expr->taint = left->taint;
 				return 0;
 			}
 		} else {
 			if (left->value) {
 				expr->type = EXPR_VALUE;
 				expr->value = 1;
+				expr->taint = left->taint;
 				return 0;
 			}
 		}
@@ -407,6 +415,7 @@ static int expand_logical(struct expression *expr)
 		 */
 		expr->type = EXPR_VALUE;
 		expr->value = right->value != 0;
+		expr->taint = left->taint | right->taint;
 		return 0;
 	}
 
@@ -429,8 +438,15 @@ static int expand_comma(struct expression *expr)
 
 	cost = expand_expression(expr->left);
 	cost += expand_expression(expr->right);
-	if (expr->left->type == EXPR_VALUE || expr->left->type == EXPR_FVALUE)
+	if (expr->left->type == EXPR_VALUE || expr->left->type == EXPR_FVALUE) {
+		unsigned flags = expr->flags;
+		unsigned taint;
+		taint = expr->left->type == EXPR_VALUE ? expr->left->taint : 0;
 		*expr = *expr->right;
+		expr->flags = flags;
+		if (expr->type == EXPR_VALUE)
+			expr->taint |= Taint_comma | taint;
+	}
 	return cost;
 }
 
@@ -469,6 +485,7 @@ static int expand_compare(struct expression *expr)
 			int op = expr->op;
 			expr->type = EXPR_VALUE;
 			expr->value = compare_types(op, left->symbol, right->symbol);
+			expr->taint = 0;
 			return 0;
 		}
 		if (simplify_cmp_binop(expr, left->ctype))
@@ -488,12 +505,17 @@ static int expand_conditional(struct expression *expr)
 
 	cond_cost = expand_expression(cond);
 	if (cond->type == EXPR_VALUE) {
+		unsigned flags = expr->flags;
 		if (!cond->value)
 			true = false;
 		if (!true)
 			true = cond;
+		cost = expand_expression(true);
 		*expr = *true;
-		return expand_expression(expr);
+		expr->flags = flags;
+		if (expr->type == EXPR_VALUE)
+			expr->taint |= cond->taint;
+		return cost;
 	}
 
 	cost = expand_expression(true);
@@ -594,6 +616,7 @@ static int expand_dereference(struct expression *expr)
 			if (value->type == EXPR_VALUE) {
 				expr->type = EXPR_VALUE;
 				expr->value = value->value;
+				expr->taint = 0;
 				return 0;
 			} else if (value->type == EXPR_FVALUE) {
 				expr->type = EXPR_FVALUE;
@@ -633,6 +656,7 @@ static int simplify_preop(struct expression *expr)
 	mask = mask | (mask-1);
 	expr->value = v & mask;
 	expr->type = EXPR_VALUE;
+	expr->taint = op->taint;
 	return 1;
 
 Overflow:
@@ -729,6 +753,7 @@ int expand_constant_p(struct expression *expr, int cost)
 {
 	expr->type = EXPR_VALUE;
 	expr->value = !cost;
+	expr->taint = 0;
 	return 0;
 }
 
@@ -737,6 +762,7 @@ int expand_safe_p(struct expression *expr, int cost)
 {
 	expr->type = EXPR_VALUE;
 	expr->value = (cost < SIDE_EFFECTS);
+	expr->taint = 0;
 	return 0;
 }
 
@@ -1144,6 +1170,15 @@ static int expand_statement(struct statement *stmt)
 	return SIDE_EFFECTS;
 }
 
+static inline int bad_integer_constant_expression(struct expression *expr)
+{
+	if (!(expr->flags & Int_const_expr))
+		return 1;
+	if (expr->taint & Taint_comma)
+		return 1;
+	return 0;
+}
+
 static long long __get_expression_value(struct expression *expr, int strict)
 {
 	long long value, mask;
@@ -1161,7 +1196,7 @@ static long long __get_expression_value(struct expression *expr, int strict)
 		expression_error(expr, "bad constant expression");
 		return 0;
 	}
-	if (strict && !(expr->flags & Int_const_expr)) {
+	if (strict && bad_integer_constant_expression(expr)) {
 		expression_error(expr, "bad integer constant expression");
 		return 0;
 	}
diff --git a/expression.c b/expression.c
index d36c3d2..65f959e 100644
--- a/expression.c
+++ b/expression.c
@@ -751,7 +751,7 @@ static struct token *cast_expression(struct token *token, struct expression **tr
  * than create a data structure for it.
  */
 
-#define __LR_BINOP_EXPRESSION(__token, tree, type, inner, compare, is_const)	\
+#define LR_BINOP_EXPRESSION(__token, tree, type, inner, compare)	\
 	struct expression *left = NULL;					\
 	struct token * next = inner(__token, &left);			\
 									\
@@ -768,8 +768,7 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 				sparse_error(next->pos, "No right hand side of '%s'-expression", show_special(op));	\
 				break;					\
 			}						\
-			if (is_const)					\
-				top->flags = left->flags & right->flags \
+			top->flags = left->flags & right->flags		\
 						& Int_const_expr;	\
 			top->op = op;					\
 			top->left = left;				\
@@ -781,13 +780,6 @@ out:									\
 	*tree = left;							\
 	return next;							\
 
-#define LR_BINOP_EXPRESSION(token, tree, type, inner, compare) \
-	__LR_BINOP_EXPRESSION((token), (tree), (type), (inner), (compare), 1)
-
-#define LR_BINOP_EXPRESSION_NONCONST(token, tree, type, inner, compare) \
-	__LR_BINOP_EXPRESSION((token), (tree), (type), (inner), (compare), 0)
-
-
 static struct token *multiplicative_expression(struct token *token, struct expression **tree)
 {
 	LR_BINOP_EXPRESSION(
@@ -918,7 +910,7 @@ struct token *assignment_expression(struct token *token, struct expression **tre
 
 static struct token *comma_expression(struct token *token, struct expression **tree)
 {
-	LR_BINOP_EXPRESSION_NONCONST(
+	LR_BINOP_EXPRESSION(
 		token, tree, EXPR_COMMA, assignment_expression,
 		(op == ',')
 	);
diff --git a/expression.h b/expression.h
index a913153..23ca408 100644
--- a/expression.h
+++ b/expression.h
@@ -52,6 +52,10 @@ enum {
 	Float_literal = 2,
 }; /* for expr->flags */
 
+enum {
+	Taint_comma = 1,
+};
+
 struct expression {
 	enum expression_type type:8;
 	unsigned flags:8;
@@ -60,7 +64,10 @@ struct expression {
 	struct symbol *ctype;
 	union {
 		// EXPR_VALUE
-		unsigned long long value;
+		struct {
+			unsigned long long value;
+			unsigned taint;
+		};
 
 		// EXPR_FVALUE
 		long double fvalue;
diff --git a/symbol.c b/symbol.c
index 329fed9..cec7e02 100644
--- a/symbol.c
+++ b/symbol.c
@@ -652,6 +652,7 @@ static int expand_warning(struct expression *expr, int cost)
 out:
 	expr->type = EXPR_VALUE;
 	expr->value = 1;
+	expr->taint = 0;
 	return 0;
 }
 
-- 
1.5.0-rc2.GIT
