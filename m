From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 06/25] constexpr: examine constness of conditionals at evaluation only
Date: Fri, 31 Mar 2017 03:44:40 +0200
Message-ID: <20170331014459.9351-7-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35985 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934785AbdCaBqf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:35 -0400
Received: by mail-wr0-f194.google.com with SMTP id k6so15309644wre.3
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:34 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

Move the whole calculation of conditional expressions' constness flags
to the evaluation phase such that expressions like

  0 ? __builtin_choose_expr(0, 0, 0) : 0
  0 ? 0 : __builtin_choose_expr(0, 0, 0)

can now be recognized as qualifying as integer constant expressions.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                         |  8 ++------
 expression.c                       |  6 ------
 validation/constexpr-conditional.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 12 deletions(-)
 create mode 100644 validation/constexpr-conditional.c

diff --git a/evaluate.c b/evaluate.c
index 07788eacc..6d6e462cd 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1122,12 +1122,8 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 		true = &expr->cond_true;
 	}
 
-	if (expr->flags) {
-		int flags = expr->conditional->flags & CEF_ICE;
-		flags &= (*true)->flags & expr->cond_false->flags;
-		if (!flags)
-			expr->flags = CEF_NONE;
-	}
+	expr->flags = (expr->conditional->flags & (*true)->flags &
+			expr->cond_false->flags & ~CEF_CONST_MASK);
 
 	lclass = classify_type(ltype, &ltype);
 	rclass = classify_type(rtype, &rtype);
diff --git a/expression.c b/expression.c
index 0332c4406..7f1eff306 100644
--- a/expression.c
+++ b/expression.c
@@ -856,12 +856,6 @@ struct token *conditional_expression(struct token *token, struct expression **tr
 		token = parse_expression(token->next, &expr->cond_true);
 		token = expect(token, ':', "in conditional expression");
 		token = conditional_expression(token, &expr->cond_false);
-		if (expr->left && expr->cond_false) {
-			expr->flags = expr->left->flags & expr->cond_false->flags;
-			if (expr->cond_true)
-				expr->flags &= expr->cond_true->flags;
-			expr->flags &= ~CEF_CONST_MASK;
-		}
 	}
 	return token;
 }
diff --git a/validation/constexpr-conditional.c b/validation/constexpr-conditional.c
new file mode 100644
index 000000000..a3331b3ef
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
2.12.0

