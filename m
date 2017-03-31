From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 22/25] constexpr: treat comparisons between types as integer constexpr
Date: Fri, 31 Mar 2017 03:44:56 +0200
Message-ID: <20170331014459.9351-23-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33376 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935019AbdCaBqv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:51 -0400
Received: by mail-wr0-f195.google.com with SMTP id u18so16611859wrc.0
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:49 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

The expression parsing code builds an EXPR_COMPARE expression around two
EXPR_TYPE expressions for __builtin_types_compatible_p().

The EXPR_TYPE expressions are tagged as being integer constant expressions
in order to trick the generic comparison evaluation code into flagging the
result as an integer constant expression again.

Avoid this trickery by making evaluate_compare() unconditionally tag a
comparison between types as an integer constant expression.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                                | 13 +++++++++----
 expression.c                              |  3 ---
 validation/constexpr-types-compatible-p.c |  8 ++++++++
 3 files changed, 17 insertions(+), 7 deletions(-)
 create mode 100644 validation/constexpr-types-compatible-p.c

diff --git a/evaluate.c b/evaluate.c
index 1ae370c7b..46ea10ed8 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1016,16 +1016,21 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	struct symbol *ctype;
 	const char *typediff;
 
-	expr->flags = left->flags & right->flags & ~CEF_CONST_MASK;
-	expr->flags &= ~CEF_ADDR;
-
 	/* Type types? */
-	if (is_type_type(ltype) && is_type_type(rtype))
+	if (is_type_type(ltype) && is_type_type(rtype)) {
+		/*
+		 * __builtin_types_compatible_p() yields an integer
+		 * constant expression
+		 */
+		expr->flags = CEF_SET_ICE;
 		goto OK;
+	}
 
 	if (is_safe_type(left->ctype) || is_safe_type(right->ctype))
 		warning(expr->pos, "testing a 'safe expression'");
 
+	expr->flags = left->flags & right->flags & ~CEF_CONST_MASK & ~CEF_ADDR;
+
 	/* number on number */
 	if (lclass & rclass & TYPE_NUM) {
 		ctype = usual_conversions(expr->op, expr->left, expr->right,
diff --git a/expression.c b/expression.c
index e4b770fc0..e5ebad65b 100644
--- a/expression.c
+++ b/expression.c
@@ -131,7 +131,6 @@ static struct token *parse_type(struct token *token, struct expression **tree)
 {
 	struct symbol *sym;
 	*tree = alloc_expression(token->pos, EXPR_TYPE);
-	(*tree)->flags = CEF_SET_ICE; /* sic */
 	token = typename(token, &sym, NULL);
 	if (sym->ident)
 		sparse_error(token->pos,
@@ -459,8 +458,6 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 		}
 		if (token->special == '[' && lookup_type(token->next)) {
 			expr = alloc_expression(token->pos, EXPR_TYPE);
-			/* sic */
-			expr->flags = CEF_SET_ICE;
 			token = typename(token->next, &expr->symbol, NULL);
 			token = expect(token, ']', "in type expression");
 			break;
diff --git a/validation/constexpr-types-compatible-p.c b/validation/constexpr-types-compatible-p.c
new file mode 100644
index 000000000..1969bf3bd
--- /dev/null
+++ b/validation/constexpr-types-compatible-p.c
@@ -0,0 +1,8 @@
+static int a[] = {[__builtin_types_compatible_p(int, int)] = 0};
+
+/*
+ * check-name: __builtin_types_compatible_p() constness verification.
+ *
+ * check-error-start
+ * check-error-end
+ */
-- 
2.12.0

