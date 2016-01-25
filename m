From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v2 11/13] evaluate: relax some constant expression rules for pointer expressions
Date: Mon, 25 Jan 2016 16:03:26 +0100
Message-ID: <87io2hem69.fsf@gmail.com>
References: <87twm1g1go.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35755 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000AbcAYPD3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 10:03:29 -0500
Received: by mail-wm0-f67.google.com with SMTP id 123so11820042wmz.2
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 07:03:28 -0800 (PST)
In-Reply-To: <87twm1g1go.fsf@gmail.com> (Nicolai Stange's message of "Mon, 25
	Jan 2016 15:47:51 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Nicolai Stange <nicstange@gmail.com>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The official constraints on constant expressions [6.6] are insanely
strict in that they do not allow some constructs commonly used in the
wild.

Relax them by treating
- address constants cast to different pointer type as address constants
  again,
- address constants cast to integer type as integer constant
  expressions
- conditional expressions whose true and false branches both yield
  address constants as address constants,
- and conditional expressions whose condition is an address constant
  as an constant expression to the extent their true and false branches
  allow.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index d32f5a4..2b60294 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1125,14 +1125,23 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 		true = &expr->cond_true;
 	}
 
-	expr->flags = (expr->conditional->flags & (*true)->flags &
-		expr->cond_false->flags);
-	expr_flags_decay_consts(&expr->flags);
 	/*
+	 * A conditional operator yields a particular constant
+	 * expression type only if all of its three subexpressions are
+	 * of that type [6.6(6), 6.6(8)].
+	 * As an extension, relax this restriction by allowing any
+	 * constant expression type for the condition expression.
+	 *
 	 * A conditional operator never yields an address constant
 	 * [6.6(9)].
+	 * However, as an extension, if the condition is any constant
+	 * expression, and the true and false expressions are both
+	 * address constants, mark the result as an address constant.
 	 */
-	expr_clear_flag(&expr->flags, EXPR_FLAG_ADDR_CONST_EXPR);
+	if (expr->conditional->flags & (EXPR_FLAG_ARITH_CONST_EXPR |
+						EXPR_FLAG_ADDR_CONST_EXPR))
+		expr->flags = (*true)->flags &expr->cond_false->flags;
+	expr_flags_decay_consts(&expr->flags);
 
 	lclass = classify_type(ltype, &ltype);
 	rclass = classify_type(rtype, &rtype);
@@ -2783,14 +2792,30 @@ static struct symbol *evaluate_cast(struct expression *expr)
 		/*
 		 * Casts of integer literals to pointer type yield
 		 * address constants [6.6(9)].
+		 *
+		 * As an extension, treat address constants cast to a
+		 * different pointer type as adress constants again.
+		 *
+		 * As another extension, treat integer constant
+		 * expressions (in contrast to literals) cast to
+		 * pointer type as address constants.
 		 */
 		if (class1 & TYPE_PTR &&
-			(target->flags & EXPR_FLAG_INT_CONST)) {
+			((target->flags & EXPR_FLAG_INT_CONST_EXPR) ||
+				(target->flags & EXPR_FLAG_ADDR_CONST_EXPR))) {
 			expr_set_flag(&expr->flags, EXPR_FLAG_ADDR_CONST_EXPR);
+
 		}
 	} else {
 		expr->flags = target->flags;
 		expr_flags_decay_consts(&expr->flags);
+
+		/*
+		 * As an extension, treat address constants cast to
+		 * integer type as an arithmetic constant.
+		 */
+		if (expr->flags & EXPR_FLAG_ADDR_CONST_EXPR)
+			expr_set_flag(&expr->flags, EXPR_FLAG_ARITH_CONST_EXPR);
 		/*
 		 * Casts to numeric types never result in address
 		 * constants [6.6(9)].
-- 
2.7.0

