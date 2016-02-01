From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 21/21] evaluation: treat comparsions between types as integer constexpr
Date: Mon, 01 Feb 2016 03:47:16 +0100
Message-ID: <8737tdgn9n.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33225 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933645AbcBACrT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:47:19 -0500
Received: by mail-wm0-f67.google.com with SMTP id r129so7056421wmr.0
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:47:18 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

The expression parsing code builds an EXPR_COMPARE expression around two
EXPR_TYPE expressions for __builtin_types_compatible_p().

The EXPR_TYPE expressions are tagged as being integer constant expressions
in order to trick the generic comparison evaluation code into flagging the
result as an integer constant expression again.

Avoid this trickery by making evaluate_compare() unconditionally tag a
comparsion between types as an integer constant expression.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c                                | 16 +++++++++++-----
 expression.c                              |  5 -----
 validation/constexpr-types-compatible-p.c |  9 +++++++++
 3 files changed, 20 insertions(+), 10 deletions(-)
 create mode 100644 validation/constexpr-types-compatible-p.c

diff --git a/evaluate.c b/evaluate.c
index 06c360f..31ac4e1 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1010,17 +1010,23 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	struct symbol *ctype;
 	const char *typediff;
 
-	expr->constexpr_flags = left->constexpr_flags &
-		right->constexpr_flags & ~CONSTEXPR_FLAG_DECAY_CONSTS_MASK &
-		~CONSTEXPR_FLAG_ADDR_CONST;
-
 	/* Type types? */
-	if (is_type_type(ltype) && is_type_type(rtype))
+	if (is_type_type(ltype) && is_type_type(rtype)) {
+		/*
+		 * __builtin_types_compatible_p() yields an integer
+		 * constant expression
+		 */
+		expr->constexpr_flags = CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
 		goto OK;
+	}
 
 	if (is_safe_type(left->ctype) || is_safe_type(right->ctype))
 		warning(expr->pos, "testing a 'safe expression'");
 
+	expr->constexpr_flags = left->constexpr_flags &
+		right->constexpr_flags & ~CONSTEXPR_FLAG_DECAY_CONSTS_MASK &
+		~CONSTEXPR_FLAG_ADDR_CONST;
+
 	/* number on number */
 	if (lclass & rclass & TYPE_NUM) {
 		ctype = usual_conversions(expr->op, expr->left, expr->right,
diff --git a/expression.c b/expression.c
index f49c8f6..4285cc8 100644
--- a/expression.c
+++ b/expression.c
@@ -131,8 +131,6 @@ static struct token *parse_type(struct token *token, struct expression **tree)
 {
 	struct symbol *sym;
 	*tree = alloc_expression(token->pos, EXPR_TYPE);
-	(*tree)->constexpr_flags =
-		CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK; /* sic */
 	token = typename(token, &sym, NULL);
 	if (sym->ident)
 		sparse_error(token->pos,
@@ -461,9 +459,6 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 		}
 		if (token->special == '[' && lookup_type(token->next)) {
 			expr = alloc_expression(token->pos, EXPR_TYPE);
-			/* sic */
-			expr->constexpr_flags =
-				CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
 			token = typename(token->next, &expr->symbol, NULL);
 			token = expect(token, ']', "in type expression");
 			break;
diff --git a/validation/constexpr-types-compatible-p.c b/validation/constexpr-types-compatible-p.c
new file mode 100644
index 0000000..78c37b4
--- /dev/null
+++ b/validation/constexpr-types-compatible-p.c
@@ -0,0 +1,9 @@
+static int a[] = {[__builtin_types_compatible_p(int, int)] = 0};
+
+/*
+ * check-name: __builtin_types_compatible_p() constness verification.
+ *
+ * check-error-start
+ * check-error-end
+ */
+
-- 
2.7.0

