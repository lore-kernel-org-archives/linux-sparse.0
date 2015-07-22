From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH RFC 09/13] expression: examine constness of __builtin_offsetof at evaluation only
Date: Thu, 23 Jul 2015 01:21:07 +0200
Message-ID: <87si8fixss.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36554 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbbGVXVL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2015 19:21:11 -0400
Received: by wicgb10 with SMTP id gb10so119077491wic.1
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2015 16:21:09 -0700 (PDT)
Received: from localhost.localdomain (x55b1cac6.dyn.telefonica.de. [85.177.202.198])
        by smtp.gmail.com with ESMTPSA id c11sm24278890wib.1.2015.07.22.16.21.08
        for <linux-sparse@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 16:21:09 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

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
 evaluate.c                      | 15 +++++++++------
 expression.c                    |  3 ---
 validation/constexpr-offsetof.c | 21 +++++++++++++++++++++
 3 files changed, 30 insertions(+), 9 deletions(-)
 create mode 100644 validation/constexpr-offsetof.c

diff --git a/evaluate.c b/evaluate.c
index a65cc0c..c115e64 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3002,7 +3002,7 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 		}
 		ctype = field;
 		expr->type = EXPR_VALUE;
-		expr->flags = expr_set_flag_mask(EXPR_FLAG_INT_CONST_EXPR);
+		expr->flags |= expr_set_flag_mask(EXPR_FLAG_INT_CONST_EXPR);
 		expr->value = offset;
 		expr->taint = 0;
 		expr->ctype = size_t_ctype;
@@ -3021,20 +3021,24 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 		if (!expr->index) {
 			expr->type = EXPR_VALUE;
 			expr->flags
-				= expr_set_flag_mask(EXPR_FLAG_INT_CONST_EXPR);
+				|= expr_set_flag_mask(EXPR_FLAG_INT_CONST_EXPR);
 			expr->value = 0;
 			expr->taint = 0;
 			expr->ctype = size_t_ctype;
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
+			idx->flags |= expr_flags_decay_consts(old_idx_flags);
 			m = alloc_const_expression(expr->pos,
 						   bits_to_bytes(ctype->bit_size));
 			m->ctype = size_t_ctype;
@@ -3044,8 +3048,8 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 			expr->right = m;
 			expr->op = '*';
 			expr->ctype = size_t_ctype;
-			expr->flags = m->flags & idx->flags &
-				expr_set_flag_mask(EXPR_FLAG_INT_CONST_EXPR);
+			expr->flags |=
+				expr_flags_decay_consts(m->flags & idx->flags);
 		}
 	}
 	if (e) {
@@ -3056,8 +3060,7 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 		if (!evaluate_expression(e))
 			return NULL;
 		expr->type = EXPR_BINOP;
-		expr->flags = e->flags & copy->flags &
-			expr_set_flag_mask(EXPR_FLAG_INT_CONST_EXPR);
+		expr->flags = expr_flags_decay_consts(e->flags & copy->flags);
 		expr->op = '+';
 		expr->ctype = size_t_ctype;
 		expr->left = copy;
diff --git a/expression.c b/expression.c
index 19786e8..a4b6fa2 100644
--- a/expression.c
+++ b/expression.c
@@ -200,7 +200,6 @@ static struct token *builtin_offsetof_expr(struct token *token,
 			return expect(token, ')', "at end of __builtin_offset");
 		case SPECIAL_DEREFERENCE:
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->flags = expr_set_flag_mask(EXPR_FLAG_INT_CONST_EXPR);
 			e->op = '[';
 			*p = e;
 			p = &e->down;
@@ -208,7 +207,6 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		case '.':
 			token = token->next;
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->flags = expr_set_flag_mask(EXPR_FLAG_INT_CONST_EXPR);
 			e->op = '.';
 			if (token_type(token) != TOKEN_IDENT) {
 				sparse_error(token->pos, "Expected member name");
@@ -220,7 +218,6 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		case '[':
 			token = token->next;
 			e = alloc_expression(token->pos, EXPR_OFFSETOF);
-			e->flags = expr_set_flag_mask(EXPR_FLAG_INT_CONST_EXPR);
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
+ * check-name: __builtin_offsetof() constness verification
+ *
+ * check-error-start
+constexpr-offsetof.c:12:39: error: bad constant expression
+ * check-error-end
+ */
-- 
2.4.5

