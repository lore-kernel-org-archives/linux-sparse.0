From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] always evaluate both operands
Date: Tue, 19 Sep 2017 04:13:35 +0200
Message-ID: <20170919021335.5881-6-luc.vanoostenryck@gmail.com>
References: <20170919021335.5881-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36150 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdISCNq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 22:13:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id r136so2482313wmf.3
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 19:13:45 -0700 (PDT)
In-Reply-To: <20170919021335.5881-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
index c16ee9624..9f8cf5be4 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3101,9 +3101,9 @@ struct symbol *evaluate_expression(struct expression *expr)
 	case EXPR_SYMBOL:
 		return evaluate_symbol_expression(expr);
 	case EXPR_BINOP:
-		if (!evaluate_expression(expr->left))
-			return NULL;
-		if (!evaluate_expression(expr->right))
+		evaluate_expression(expr->left);
+		evaluate_expression(expr->right);
+		if (!valid_expr_subtype(expr))
 			return NULL;
 		return evaluate_binop(expr);
 	case EXPR_LOGICAL:
@@ -3114,15 +3114,15 @@ struct symbol *evaluate_expression(struct expression *expr)
 			return NULL;
 		return evaluate_comma(expr);
 	case EXPR_COMPARE:
-		if (!evaluate_expression(expr->left))
-			return NULL;
-		if (!evaluate_expression(expr->right))
+		evaluate_expression(expr->left);
+		evaluate_expression(expr->right);
+		if (!valid_expr_subtype(expr))
 			return NULL;
 		return evaluate_compare(expr);
 	case EXPR_ASSIGNMENT:
-		if (!evaluate_expression(expr->left))
-			return NULL;
-		if (!evaluate_expression(expr->right))
+		evaluate_expression(expr->left);
+		evaluate_expression(expr->right);
+		if (!valid_expr_subtype(expr))
 			return NULL;
 		return evaluate_assignment(expr);
 	case EXPR_PREOP:
-- 
2.14.0

