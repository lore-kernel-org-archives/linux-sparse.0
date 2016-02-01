From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 06/21] expression: examine constness of conditionals at evaluation only
Date: Mon, 01 Feb 2016 03:34:34 +0100
Message-ID: <87vb69i2f9.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35681 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933536AbcBACeh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:34:37 -0500
Received: by mail-wm0-f65.google.com with SMTP id l66so7019548wml.2
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:34:36 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

Move the whole calculation of conditional expressions' constness flags
to the evaluation phase such that expressions like

  0 ? __builtin_choose_expr(0, 0, 0) : 0
  0 ? 0 : __builtin_choose_expr(0, 0, 0)

can now be recognized as qualifying as integer constant expressions.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c                         | 12 ++++--------
 expression.c                       |  9 ---------
 validation/constexpr-conditional.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 17 deletions(-)
 create mode 100644 validation/constexpr-conditional.c

diff --git a/evaluate.c b/evaluate.c
index 43a0432..03db2c3 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1115,14 +1115,10 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 		true = &expr->cond_true;
 	}
 
-	if (expr->constexpr_flags) {
-		int flags = (expr->conditional->constexpr_flags &
-			CONSTEXPR_FLAG_INT_CONST_EXPR);
-		flags &= (*true)->constexpr_flags &
-			expr->cond_false->constexpr_flags;
-		if (!flags)
-			expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
-	}
+	expr->constexpr_flags = (expr->conditional->constexpr_flags &
+				(*true)->constexpr_flags &
+				expr->cond_false->constexpr_flags &
+				~CONSTEXPR_FLAG_DECAY_CONSTS_MASK);
 
 	lclass = classify_type(ltype, &ltype);
 	rclass = classify_type(rtype, &rtype);
diff --git a/expression.c b/expression.c
index 302ef8b..b2d5eb4 100644
--- a/expression.c
+++ b/expression.c
@@ -862,15 +862,6 @@ struct token *conditional_expression(struct token *token, struct expression **tr
 		token = parse_expression(token->next, &expr->cond_true);
 		token = expect(token, ':', "in conditional expression");
 		token = conditional_expression(token, &expr->cond_false);
-		if (expr->left && expr->cond_false) {
-			expr->constexpr_flags = expr->left->constexpr_flags &
-				expr->cond_false->constexpr_flags;
-			if (expr->cond_true)
-				expr->constexpr_flags &=
-					expr->cond_true->constexpr_flags;
-			expr->constexpr_flags &=
-				~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
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

