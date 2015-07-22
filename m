From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH RFC 11/13] evaluate: relax some constant expression rules for pointer expressions
Date: Thu, 23 Jul 2015 01:23:02 +0200
Message-ID: <87k2trixpl.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36894 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbbGVXXG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2015 19:23:06 -0400
Received: by wibud3 with SMTP id ud3so194245177wib.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2015 16:23:04 -0700 (PDT)
Received: from localhost.localdomain (x55b1cac6.dyn.telefonica.de. [85.177.202.198])
        by smtp.gmail.com with ESMTPSA id 4sm4598259wjt.46.2015.07.22.16.23.03
        for <linux-sparse@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 16:23:04 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

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
 evaluate.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index c115e64..ee5f18f 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1125,14 +1125,25 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 		true = &expr->cond_true;
 	}
 
-	expr->flags |= expr_flags_decay_consts(expr->conditional->flags &
-					(*true)->flags &
-					expr->cond_false->flags);
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
-	expr->flags &= ~expr_clear_flag_mask(EXPR_FLAG_ADDR_CONST_EXPR);
+	if ((expr->conditional->flags &
+			(expr_set_flag_mask(EXPR_FLAG_ARITH_CONST_EXPR) |
+				expr_set_flag_mask(EXPR_FLAG_ADDR_CONST_EXPR))))
+		expr->flags |=
+			expr_flags_decay_consts((*true)->flags &
+						expr->cond_false->flags);
 
 	lclass = classify_type(ltype, &ltype);
 	rclass = classify_type(rtype, &rtype);
@@ -2780,15 +2791,31 @@ static struct symbol *evaluate_cast(struct expression *expr)
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
-			(target->flags & EXPR_FLAG_INT_CONST)) {
+			((target->flags & EXPR_FLAG_INT_CONST_EXPR) ||
+				(target->flags & EXPR_FLAG_ADDR_CONST_EXPR))) {
 			expr->flags |=
 				expr_set_flag_mask(EXPR_FLAG_ADDR_CONST_EXPR);
 
 		}
 	} else {
 		expr->flags |= expr_flags_decay_consts(target->flags);
+
+		/*
+		 * As an extension, treat address constants cast to
+		 * integer type as an arithmetic constant.
+		 */
+		if (expr->flags & EXPR_FLAG_ADDR_CONST_EXPR)
+			expr->flags |=
+				expr_set_flag_mask(EXPR_FLAG_ARITH_CONST_EXPR);
 		/*
 		 * Casts to numeric types never result in address
 		 * constants [6.6(9)].
-- 
2.4.5

