From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 18/25] constexpr: examine constness of __builtin_offsetof at evaluation only
Date: Fri, 31 Mar 2017 03:44:52 +0200
Message-ID: <20170331014459.9351-19-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34267 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935038AbdCaBqr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:47 -0400
Received: by mail-wr0-f194.google.com with SMTP id w43so16583345wrb.1
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:45 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

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
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                      |  8 ++++++--
 expression.c                    |  3 ---
 validation/constexpr-offsetof.c | 21 +++++++++++++++++++++
 3 files changed, 27 insertions(+), 5 deletions(-)
 create mode 100644 validation/constexpr-offsetof.c

diff --git a/evaluate.c b/evaluate.c
index cdbc08ef2..be72b22b9 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3056,23 +3056,27 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
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
+			idx->flags = old_idx_flags;
 			m = alloc_const_expression(expr->pos,
 						   bits_to_bytes(ctype->bit_size));
 			m->ctype = size_t_ctype;
-			m->flags |= CEF_SET_ICE;
+			m->flags = CEF_SET_INT;
 			expr->type = EXPR_BINOP;
 			expr->left = idx;
 			expr->right = m;
 			expr->op = '*';
 			expr->ctype = size_t_ctype;
-			expr->flags = m->flags & idx->flags;
+			expr->flags = m->flags & idx->flags & ~CEF_CONST_MASK;
 		}
 	}
 	if (e) {
diff --git a/expression.c b/expression.c
index 241ab7bad..3f1ea2141 100644
--- a/expression.c
+++ b/expression.c
@@ -199,7 +199,6 @@ static struct token *builtin_offsetof_expr(struct token *token,
 			return expect(token, ')', "at end of __builtin_offset");
 		case SPECIAL_DEREFERENCE:
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->flags = CEF_SET_ICE;
 			e->op = '[';
 			*p = e;
 			p = &e->down;
@@ -207,7 +206,6 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		case '.':
 			token = token->next;
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->flags = CEF_SET_ICE;
 			e->op = '.';
 			if (token_type(token) != TOKEN_IDENT) {
 				sparse_error(token->pos, "Expected member name");
@@ -219,7 +217,6 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		case '[':
 			token = token->next;
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->flags = CEF_SET_ICE;
 			e->op = '[';
 			token = parse_expression(token, &e->index);
 			token = expect(token, ']',
diff --git a/validation/constexpr-offsetof.c b/validation/constexpr-offsetof.c
new file mode 100644
index 000000000..d1697b0c5
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
2.12.0

