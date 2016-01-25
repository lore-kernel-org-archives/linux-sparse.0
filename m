From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v2 05/13] expression: examine constness of conditionals at evaluation only
Date: Mon, 25 Jan 2016 15:55:09 +0100
Message-ID: <878u3dg14i.fsf@gmail.com>
References: <87twm1g1go.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35989 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932395AbcAYOzM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 09:55:12 -0500
Received: by mail-wm0-f67.google.com with SMTP id l65so11750056wmf.3
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 06:55:11 -0800 (PST)
In-Reply-To: <87twm1g1go.fsf@gmail.com> (Nicolai Stange's message of "Mon, 25
	Jan 2016 15:47:51 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Nicolai Stange <nicstange@gmail.com>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
 evaluate.c                         | 18 ++++++++----------
 expression.c                       |  7 -------
 validation/constexpr-conditional.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 17 deletions(-)
 create mode 100644 validation/constexpr-conditional.c

diff --git a/evaluate.c b/evaluate.c
index 5138d40..97da51d 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1114,16 +1114,14 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 		true = &expr->cond_true;
 	}
 
-	if (expr->flags) {
-		unsigned char flags_mask = 0;
-		unsigned char flags;
-
-		expr_set_flag(&flags_mask, EXPR_FLAG_INT_CONST_EXPR);
-		flags = (expr->conditional->flags & flags_mask);
-		flags &= (*true)->flags & expr->cond_false->flags;
-		if (!flags)
-			expr->flags = EXPR_FLAG_NONE;
-	}
+	expr->flags = (expr->conditional->flags & (*true)->flags &
+		expr->cond_false->flags);
+	expr_flags_decay_consts(&expr->flags);
+	/*
+	 * A conditional operator never yields an address constant
+	 * [6.6(9)].
+	 */
+	expr_clear_flag(&expr->flags, EXPR_FLAG_ADDR_CONST_EXPR);
 
 	lclass = classify_type(ltype, &ltype);
 	rclass = classify_type(rtype, &rtype);
diff --git a/expression.c b/expression.c
index 377834e..792c2a5 100644
--- a/expression.c
+++ b/expression.c
@@ -858,13 +858,6 @@ struct token *conditional_expression(struct token *token, struct expression **tr
 		token = parse_expression(token->next, &expr->cond_true);
 		token = expect(token, ':', "in conditional expression");
 		token = conditional_expression(token, &expr->cond_false);
-		if (expr->left && expr->cond_false) {
-			expr->flags = expr->left->flags &
-				expr->cond_false->flags;
-			if (expr->cond_true)
-				expr->flags &= expr->cond_true->flags;
-			expr_flags_decay_consts(&expr->flags);
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
2.7.0

