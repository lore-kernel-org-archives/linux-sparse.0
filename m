From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH RFC 05/13] expression: examine constness of conditionals at evaluation only
Date: Thu, 23 Jul 2015 01:16:47 +0200
Message-ID: <87a8unkckg.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34967 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbbGVXQv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2015 19:16:51 -0400
Received: by wibxm9 with SMTP id xm9so184227226wib.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2015 16:16:50 -0700 (PDT)
Received: from localhost.localdomain (x55b1cac6.dyn.telefonica.de. [85.177.202.198])
        by smtp.gmail.com with ESMTPSA id ft5sm24262149wib.4.2015.07.22.16.16.48
        for <linux-sparse@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 16:16:49 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Currently, the propagation of expressions' constness flags through
conditional expressions is done in two steps:
- Several flags are speculatively set at expression parsing time
- and possibly cleared again at evaluation time.

Set aside this unfortunate split of code, the early propagation of
constness flags is not able to recognize constant expressions such as
  0 ? __builtin_choose_expr(0, 0, 0) : 0
  0 ? 0 : __builtin_choose_expr(0, 0, 0)
since the final expression to be thrown into the conditional
expression is known only after evaluation.

Move the whole calculation of conditional expressions' constness flags
to the evaluation phase.

Introduce support for tracking arithmetic constness propagation through
conditional expressions.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c                         | 15 ++++++++-------
 expression.c                       |  7 -------
 validation/constexpr-conditional.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 14 deletions(-)
 create mode 100644 validation/constexpr-conditional.c

diff --git a/evaluate.c b/evaluate.c
index e1d2f3d..edd0fe1 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1113,13 +1113,14 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 		true = &expr->cond_true;
 	}
 
-	if (expr->flags) {
-		int flags = (expr->conditional->flags &
-			expr_set_flag_mask(EXPR_FLAG_INT_CONST_EXPR));
-		flags &= (*true)->flags & expr->cond_false->flags;
-		if (!flags)
-			expr->flags = EXPR_FLAG_NONE;
-	}
+	expr->flags |= expr_flags_decay_consts(expr->conditional->flags &
+					(*true)->flags &
+					expr->cond_false->flags);
+	/*
+	 * A conditional operator never yields an address constant
+	 * [6.6(9)].
+	 */
+	expr->flags &= ~expr_clear_flag_mask(EXPR_FLAG_ADDR_CONST_EXPR);
 
 	lclass = classify_type(ltype, &ltype);
 	rclass = classify_type(rtype, &rtype);
diff --git a/expression.c b/expression.c
index 7759bd0..a18fcc6 100644
--- a/expression.c
+++ b/expression.c
@@ -858,13 +858,6 @@ struct token *conditional_expression(struct token *token, struct expression **tr
 		token = parse_expression(token->next, &expr->cond_true);
 		token = expect(token, ':', "in conditional expression");
 		token = conditional_expression(token, &expr->cond_false);
-		if (expr->left && expr->cond_false) {
-			enum expression_flags flags = expr->left->flags &
-				expr->cond_false->flags;
-			if (expr->cond_true)
-				flags &= expr->cond_true->flags;
-			expr->flags = expr_flags_decay_consts(flags);
-		}
 	}
 	return token;
 }
diff --git a/validation/constexpr-conditional.c b/validation/constexpr-conditional.c
new file mode 100644
index 0000000..a3331b3
--- /dev/null
+++ b/validation/constexpr-conditional.c
@@ -0,0 +1,34 @@
+static int a[] = {
+	[0 ? : 0] = 0,						// OK
+	[1 ? : 0] = 0,						// OK
+	[0 ? 0 : 0] = 0,					// OK
+	[1 ? 0 : 0] = 0,					// OK
+	[0 ? 0 : __builtin_choose_expr(0, 0, 0)] = 0,		// OK
+	[1 ? __builtin_choose_expr(0, 0, 0) : 0] = 0,		// OK
+	[0 ? __builtin_choose_expr(0, 0, 0) : 0] = 0,		// OK
+	[1 ? 1 : __builtin_choose_expr(0, 0, 0)] = 0,		// OK
+	[__builtin_choose_expr(0, 0, 0) ? : 0] = 0,		// OK
+	[__builtin_choose_expr(0, 0, 1) ? : 0] = 0,		// OK
+	[0. ? : 0] = 0,					// KO
+	[0 ? 0. : 0] = 0,					// KO
+	[1 ? : 0.] = 0,					// KO
+	[__builtin_choose_expr(0, 0., 0) ? : 0] = 0,		// OK
+	[__builtin_choose_expr(0, 0, 0.) ? : 0] = 0,		// KO
+	[0 ? __builtin_choose_expr(0, 0., 0) : 0] = 0,		// OK
+	[0 ? __builtin_choose_expr(0, 0, 0.) : 0] = 0,		// KO
+	[1 ? 0 : __builtin_choose_expr(0, 0., 0)] = 0,		// OK
+	[1 ? 0 : __builtin_choose_expr(0, 0, 0.)] = 0,		// KO
+};
+
+/*
+ * check-name: Expression constness propagation in conditional expressions
+ *
+ * check-error-start
+constexpr-conditional.c:12:13: error: bad constant expression
+constexpr-conditional.c:13:19: error: bad constant expression
+constexpr-conditional.c:14:12: error: bad constant expression
+constexpr-conditional.c:16:42: error: bad constant expression
+constexpr-conditional.c:18:48: error: bad constant expression
+constexpr-conditional.c:20:14: error: bad constant expression
+ * check-error-end
+ */
-- 
2.4.5

