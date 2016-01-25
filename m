From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v2 09/13] expression: examine constness of __builtin_offsetof at evaluation only
Date: Mon, 25 Jan 2016 16:00:48 +0100
Message-ID: <87r3h5eman.fsf@gmail.com>
References: <87twm1g1go.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36332 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbcAYPAv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 10:00:51 -0500
Received: by mail-wm0-f66.google.com with SMTP id l65so11783216wmf.3
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 07:00:50 -0800 (PST)
In-Reply-To: <87twm1g1go.fsf@gmail.com> (Nicolai Stange's message of "Mon, 25
	Jan 2016 15:47:51 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Nicolai Stange <nicstange@gmail.com>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, the determination of a __builtin_offsetof() expressions'
constness flags is done in two steps:
- Several flags are speculatively set at expression parsing time
- and possibly cleared again at evaluation if the member expression
  includes a non-const array index like in
    __builtin_offsetof(struct A, a.b[non_const_foo])

For consistency with other expression types' evaluation, defer the
determination of a __builtin_offsetof() expression's constness to
evaluation time, too.

Furthermore, carry an array index expression's constness flags
through the implicit cast to size_t type.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c                      | 13 ++++++++-----
 expression.c                    |  3 ---
 validation/constexpr-offsetof.c | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+), 8 deletions(-)
 create mode 100644 validation/constexpr-offsetof.c

diff --git a/evaluate.c b/evaluate.c
index e3b08e4..d32f5a4 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3001,7 +3001,6 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 		}
 		ctype = field;
 		expr->type = EXPR_VALUE;
-		expr->flags = EXPR_FLAG_NONE;
 		expr_set_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);
 		expr->value = offset;
 		expr->taint = 0;
@@ -3020,7 +3019,6 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 		ctype = ctype->ctype.base_type;
 		if (!expr->index) {
 			expr->type = EXPR_VALUE;
-			expr->flags = EXPR_FLAG_NONE;
 			expr_set_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);
 			expr->value = 0;
 			expr->taint = 0;
@@ -3028,13 +3026,18 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 		} else {
 			struct expression *idx = expr->index, *m;
 			struct symbol *i_type = evaluate_expression(idx);
+			unsigned old_idx_flags;
 			int i_class = classify_type(i_type, &i_type);
+
 			if (!is_int(i_class)) {
 				expression_error(expr, "non-integer index");
 				return NULL;
 			}
 			unrestrict(idx, i_class, &i_type);
+			old_idx_flags = idx->flags;
 			idx = cast_to(idx, size_t_ctype);
+			idx->flags |= old_idx_flags;
+			expr_flags_decay_consts(&idx->flags);
 			m = alloc_const_expression(expr->pos,
 						   bits_to_bytes(ctype->bit_size));
 			m->ctype = size_t_ctype;
@@ -3045,19 +3048,19 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 			expr->op = '*';
 			expr->ctype = size_t_ctype;
 			expr->flags = m->flags & idx->flags;
+			expr_flags_decay_consts(&expr->flags);
 		}
 	}
 	if (e) {
 		struct expression *copy = __alloc_expression(0);
-		unsigned char flags_mask = EXPR_FLAG_NONE;
 		*copy = *expr;
 		if (e->type == EXPR_OFFSETOF)
 			e->in = ctype;
 		if (!evaluate_expression(e))
 			return NULL;
 		expr->type = EXPR_BINOP;
-		expr_set_flag(&flags_mask, EXPR_FLAG_INT_CONST_EXPR);
-		expr->flags = e->flags & copy->flags & flags_mask;
+		expr->flags = e->flags & copy->flags;
+		expr_flags_decay_consts(&expr->flags);
 		expr->op = '+';
 		expr->ctype = size_t_ctype;
 		expr->left = copy;
diff --git a/expression.c b/expression.c
index b82a036..4ecc865 100644
--- a/expression.c
+++ b/expression.c
@@ -199,7 +199,6 @@ static struct token *builtin_offsetof_expr(struct token *token,
 			return expect(token, ')', "at end of __builtin_offset");
 		case SPECIAL_DEREFERENCE:
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			expr_set_flag(&e->flags, EXPR_FLAG_INT_CONST_EXPR);
 			e->op = '[';
 			*p = e;
 			p = &e->down;
@@ -207,7 +206,6 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		case '.':
 			token = token->next;
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			expr_set_flag(&e->flags, EXPR_FLAG_INT_CONST_EXPR);
 			e->op = '.';
 			if (token_type(token) != TOKEN_IDENT) {
 				sparse_error(token->pos, "Expected member name");
@@ -219,7 +217,6 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		case '[':
 			token = token->next;
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			expr_set_flag(&e->flags, EXPR_FLAG_INT_CONST_EXPR);
 			e->op = '[';
 			token = parse_expression(token, &e->index);
 			token = expect(token, ']',
diff --git a/validation/constexpr-offsetof.c b/validation/constexpr-offsetof.c
new file mode 100644
index 0000000..d1697b0
--- /dev/null
+++ b/validation/constexpr-offsetof.c
@@ -0,0 +1,21 @@
+struct A {
+	int a[1];
+	int b;
+};
+
+extern int c;
+
+static int o[] = {
+	[__builtin_offsetof(struct A, b)] = 0,		// OK
+	[__builtin_offsetof(struct A, a[0])] = 0,	// OK
+	[__builtin_offsetof(struct A, a[0*0])] = 0,	// OK
+	[__builtin_offsetof(struct A, a[c])] = 0	// KO
+};
+
+/*
+ * check-name: __builtin_offsetof() constness verification.
+ *
+ * check-error-start
+constexpr-offsetof.c:12:39: error: bad constant expression
+ * check-error-end
+ */
-- 
2.7.0

