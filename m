From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 8/8] always evaluate both operands
Date: Fri,  2 Feb 2018 13:17:35 +0100
Message-ID: <20180202121735.39621-9-luc.vanoostenryck@gmail.com>
References: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35720 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeBBMTz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Feb 2018 07:19:55 -0500
Received: by mail-wm0-f65.google.com with SMTP id r78so12006633wme.0
        for <linux-sparse@vger.kernel.org>; Fri, 02 Feb 2018 04:19:54 -0800 (PST)
In-Reply-To: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When evaluating a binary expression, the evaluation
already stop if the left operand is found erroneous.
The right one is thus not evaluated but it may contain
another error which will only be diagnosticated after the
first one is corrected and the file rechecked.
This is especially annoying when there are several independent
errors in some complex expression since it will need several
cycles of check-edit-recheck to get all errrors out.

Fix this by always evaluating both left & right operands
(and returning NULL if one of them is erroneous).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index f63c0344d..bd10c6d9b 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3205,9 +3205,9 @@ struct symbol *evaluate_expression(struct expression *expr)
 	case EXPR_SYMBOL:
 		return evaluate_symbol_expression(expr);
 	case EXPR_BINOP:
-		if (!evaluate_expression(expr->left))
-			return NULL;
-		if (!evaluate_expression(expr->right))
+		evaluate_expression(expr->left);
+		evaluate_expression(expr->right);
+		if (!valid_subexpr_type(expr))
 			return NULL;
 		return evaluate_binop(expr);
 	case EXPR_LOGICAL:
@@ -3218,15 +3218,15 @@ struct symbol *evaluate_expression(struct expression *expr)
 			return NULL;
 		return evaluate_comma(expr);
 	case EXPR_COMPARE:
-		if (!evaluate_expression(expr->left))
-			return NULL;
-		if (!evaluate_expression(expr->right))
+		evaluate_expression(expr->left);
+		evaluate_expression(expr->right);
+		if (!valid_subexpr_type(expr))
 			return NULL;
 		return evaluate_compare(expr);
 	case EXPR_ASSIGNMENT:
-		if (!evaluate_expression(expr->left))
-			return NULL;
-		if (!evaluate_expression(expr->right))
+		evaluate_expression(expr->left);
+		evaluate_expression(expr->right);
+		if (!valid_subexpr_type(expr))
 			return NULL;
 		return evaluate_assignment(expr);
 	case EXPR_PREOP:
-- 
2.16.0

