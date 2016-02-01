From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 18/21] evaluate: relax some constant expression rules for pointer expressions
Date: Mon, 01 Feb 2016 03:44:38 +0100
Message-ID: <87fuxdgne1.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33184 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbcBACol (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:44:41 -0500
Received: by mail-wm0-f66.google.com with SMTP id r129so7050805wmr.0
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:44:40 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

The official constraints on constant expressions [6.6] are insanely
strict in that they do not allow some constructs commonly used in the
wild.

Relax them by treating
- address constants cast to different pointer type as address constants
  again,
- address constants cast to arithmetic type as arithmetic constant
  expressions
- conditional expressions whose true and false branches both yield
  address constants as address constants,
- and conditional expressions whose condition is an address constant
  as an constant expression to the extent their true and false branches
  allow.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 0101e61..ff51d84 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1129,14 +1129,23 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 	}
 
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
-	expr->constexpr_flags = (expr->conditional->constexpr_flags &
-				(*true)->constexpr_flags &
-				expr->cond_false->constexpr_flags &
-				~CONSTEXPR_FLAG_DECAY_CONSTS_MASK &
-				~CONSTEXPR_FLAG_ADDR_CONST);
+	if (expr->conditional->constexpr_flags &
+		(CONSTEXPR_FLAG_ARITH_CONST_EXPR | CONSTEXPR_FLAG_ADDR_CONST))
+		expr->constexpr_flags = (*true)->constexpr_flags &
+			expr->cond_false->constexpr_flags &
+			~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
 
 	lclass = classify_type(ltype, &ltype);
 	rclass = classify_type(rtype, &rtype);
@@ -2786,9 +2795,18 @@ static struct symbol *evaluate_cast(struct expression *expr)
 		/*
 		 * Casts of integer literals to pointer type yield
 		 * address constants [6.6(9)].
+		 *
+		 * As an extension, treat address constants cast to a
+		 * different pointer type as address constants again.
+		 *
+		 * As another extension, treat integer constant
+		 * expressions (in contrast to literals) cast to
+		 * pointer type as address constants.
 		 */
 		if (class1 & TYPE_PTR &&
-			(target->constexpr_flags & CONSTEXPR_FLAG_INT_CONST))
+			(target->constexpr_flags &
+				(CONSTEXPR_FLAG_INT_CONST_EXPR |
+					CONSTEXPR_FLAG_ADDR_CONST)))
 			expr->constexpr_flags = CONSTEXPR_FLAG_ADDR_CONST;
 	} else {
 		/*
@@ -2798,6 +2816,14 @@ static struct symbol *evaluate_cast(struct expression *expr)
 		expr->constexpr_flags = target->constexpr_flags &
 			~CONSTEXPR_FLAG_DECAY_CONSTS_MASK &
 			~CONSTEXPR_FLAG_ADDR_CONST;
+
+		/*
+		 * As an extension, treat address constants cast to
+		 * integer type as an arithmetic constant.
+		 */
+		if (target->constexpr_flags & CONSTEXPR_FLAG_ADDR_CONST)
+			expr->constexpr_flags = CONSTEXPR_FLAG_ARITH_CONST_EXPR;
+
 		/*
 		 * Cast to float type -> not an integer constant
 		 * expression [6.6(6)].
-- 
2.7.0

