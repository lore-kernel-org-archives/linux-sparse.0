From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] do not use expr->left for conditionals
Date: Fri, 10 Apr 2020 20:56:40 +0200
Message-ID: <20200410185640.65301-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55252 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDJS4r (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 10 Apr 2020 14:56:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id h2so3367390wmb.4
        for <linux-sparse@vger.kernel.org>; Fri, 10 Apr 2020 11:56:47 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

expr->left & expr->conditional are unioned but 'left'
should only be used for binary operators.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expression.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/expression.c b/expression.c
index ffb6cb9dc415..5b9bddfe456e 100644
--- a/expression.c
+++ b/expression.c
@@ -873,7 +873,7 @@ struct token *conditional_expression(struct token *token, struct expression **tr
 	if (*tree && match_op(token, '?')) {
 		struct expression *expr = alloc_expression(token->pos, EXPR_CONDITIONAL);
 		expr->op = token->special;
-		expr->left = *tree;
+		expr->conditional = *tree;
 		*tree = expr;
 		token = parse_expression(token->next, &expr->cond_true);
 		token = expect(token, ':', "in conditional expression");
-- 
2.26.0
