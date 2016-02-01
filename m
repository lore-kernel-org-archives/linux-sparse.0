From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 16/21] expression: examine constness of __builtin_offsetof at evaluation only
Date: Mon, 01 Feb 2016 03:42:59 +0100
Message-ID: <87oac1gngs.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35199 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbcBACnB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:43:01 -0500
Received: by mail-wm0-f65.google.com with SMTP id l66so7038520wml.2
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:43:01 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

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
 evaluate.c                      | 10 +++++++---
 expression.c                    |  6 ------
 validation/constexpr-offsetof.c | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+), 9 deletions(-)
 create mode 100644 validation/constexpr-offsetof.c

diff --git a/evaluate.c b/evaluate.c
index 7a4af39..0101e61 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3031,25 +3031,29 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
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
+			old_idx_flags = idx->constexpr_flags;
 			idx = cast_to(idx, size_t_ctype);
+			idx->constexpr_flags = old_idx_flags;
 			m = alloc_const_expression(expr->pos,
 						   bits_to_bytes(ctype->bit_size));
 			m->ctype = size_t_ctype;
-			m->constexpr_flags |=
-				CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
+			m->constexpr_flags = CONSTEXPR_FLAG_INT_CONST_SET_MASK;
 			expr->type = EXPR_BINOP;
 			expr->left = idx;
 			expr->right = m;
 			expr->op = '*';
 			expr->ctype = size_t_ctype;
 			expr->constexpr_flags = m->constexpr_flags &
-				idx->constexpr_flags;
+				idx->constexpr_flags &
+				~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
 		}
 	}
 	if (e) {
diff --git a/expression.c b/expression.c
index ac6cf43..c3d54fe 100644
--- a/expression.c
+++ b/expression.c
@@ -200,8 +200,6 @@ static struct token *builtin_offsetof_expr(struct token *token,
 			return expect(token, ')', "at end of __builtin_offset");
 		case SPECIAL_DEREFERENCE:
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->constexpr_flags =
-				CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
 			e->op = '[';
 			*p = e;
 			p = &e->down;
@@ -209,8 +207,6 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		case '.':
 			token = token->next;
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->constexpr_flags =
-				CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
 			e->op = '.';
 			if (token_type(token) != TOKEN_IDENT) {
 				sparse_error(token->pos, "Expected member name");
@@ -222,8 +218,6 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		case '[':
 			token = token->next;
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->constexpr_flags =
-				CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
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

