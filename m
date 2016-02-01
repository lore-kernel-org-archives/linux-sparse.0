From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 05/21] expression: examine constness of preops at evaluation only
Date: Mon, 01 Feb 2016 03:33:38 +0100
Message-ID: <87zivli2gt.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36206 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933536AbcBACdl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:33:41 -0500
Received: by mail-wm0-f68.google.com with SMTP id 128so7013301wmz.3
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:33:40 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

Move the whole calculation of prefix expressions' constness flags to
the evaluation phase such that expressions like

  -__builtin_choose_expr(0, 0, 0)
  ~__builtin_choose_expr(0, 0, 0)
  !__builtin_choose_expr(0, 0, 0)

can now be recognized as qualifying as integer constant expressions.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c                   | 12 ++++++------
 expression.c                 |  5 -----
 validation/constexpr-preop.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 11 deletions(-)
 create mode 100644 validation/constexpr-preop.c

diff --git a/evaluate.c b/evaluate.c
index 32e5930..43a0432 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1797,9 +1797,9 @@ static struct symbol *evaluate_sign(struct expression *expr)
 {
 	struct symbol *ctype = expr->unop->ctype;
 	int class = classify_type(ctype, &ctype);
-	if (expr->constexpr_flags && !(expr->unop->constexpr_flags &
-					CONSTEXPR_FLAG_INT_CONST_EXPR))
-		expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
+	unsigned char flags = expr->unop->constexpr_flags &
+		~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
+
 	/* should be an arithmetic type */
 	if (!(class & TYPE_NUM))
 		return bad_expr_type(expr);
@@ -1816,6 +1816,7 @@ Normal:
 	}
 	if (expr->op == '+')
 		*expr = *expr->unop;
+	expr->constexpr_flags = flags;
 	expr->ctype = ctype;
 	return ctype;
 Restr:
@@ -1853,9 +1854,8 @@ static struct symbol *evaluate_preop(struct expression *expr)
 		return evaluate_postop(expr);
 
 	case '!':
-		if (expr->constexpr_flags && !(expr->unop->constexpr_flags &
-					CONSTEXPR_FLAG_INT_CONST_EXPR))
-			expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
+		expr->constexpr_flags = expr->unop->constexpr_flags &
+			~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
 		if (is_safe_type(ctype))
 			warning(expr->pos, "testing a 'safe expression'");
 		if (is_float_type(ctype)) {
diff --git a/expression.c b/expression.c
index 5970b1b..302ef8b 100644
--- a/expression.c
+++ b/expression.c
@@ -455,9 +455,6 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 			expr = alloc_expression(token->pos, EXPR_PREOP);
 			expr->op = '(';
 			token = parens_expression(token, &expr->unop, "in expression");
-			if (expr->unop)
-				expr->constexpr_flags =
-					expr->unop->constexpr_flags;
 			break;
 		}
 		if (token->special == '[' && lookup_type(token->next)) {
@@ -670,8 +667,6 @@ static struct token *unary_expression(struct token *token, struct expression **t
 			unary = alloc_expression(token->pos, EXPR_PREOP);
 			unary->op = token->special;
 			unary->unop = unop;
-			unary->constexpr_flags = unop->constexpr_flags &
-				~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
 			*tree = unary;
 			return next;
 		}
diff --git a/validation/constexpr-preop.c b/validation/constexpr-preop.c
new file mode 100644
index 0000000..5d869da
--- /dev/null
+++ b/validation/constexpr-preop.c
@@ -0,0 +1,29 @@
+static int a[] = {
+  [+0] = 0,					// OK
+  [+__builtin_choose_expr(0, 0, 0)] = 0,	// OK
+  [+0.] = 0,					// KO
+  [+__builtin_choose_expr(0, 0, 0.)] = 0,	// KO
+  [-0] = 0,					// OK
+  [-__builtin_choose_expr(0, 0, 0)] = 0,	// OK
+  [-0.] = 0,					// KO
+  [-__builtin_choose_expr(0, 0, 0.)] = 0,	// KO
+  [~0] = 0,					// OK
+  [~__builtin_choose_expr(0, 0, 0)] = 0,	// OK
+  [!0] = 0,					// OK
+  [!__builtin_choose_expr(0, 0, 0)] = 0,	// OK
+  [!0.] = 0,					// KO
+  [!__builtin_choose_expr(0, 0, 0.)] = 0,	// KO
+};
+
+/*
+ * check-name: Expression constness propagation in preops
+ *
+ * check-error-start
+constexpr-preop.c:4:5: error: bad constant expression
+constexpr-preop.c:5:33: error: bad constant expression
+constexpr-preop.c:8:4: error: bad constant expression
+constexpr-preop.c:9:4: error: bad constant expression
+constexpr-preop.c:14:4: error: bad integer constant expression
+constexpr-preop.c:15:4: error: bad integer constant expression
+ * check-error-end
+ */
-- 
2.7.0

