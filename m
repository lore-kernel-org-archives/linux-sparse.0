From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH] fix floating point ! type
Date: Thu, 16 May 2013 16:56:13 -0400
Message-ID: <1368737773-6559-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ye0-f176.google.com ([209.85.213.176]:43499 "EHLO
	mail-ye0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab3EPU5j (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 May 2013 16:57:39 -0400
Received: by mail-ye0-f176.google.com with SMTP id m12so516267yen.7
        for <linux-sparse@vger.kernel.org>; Thu, 16 May 2013 13:57:38 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org, Xi Wang <xi.wang@gmail.com>

The expression type of zero testing should be EXPR_COMPARE, rather
than EXPR_BINOP.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 evaluate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index a090028..c345a50 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1807,7 +1807,7 @@ static struct symbol *evaluate_preop(struct expression *expr)
 			warning(expr->pos, "testing a 'safe expression'");
 		if (is_float_type(ctype)) {
 			struct expression *arg = expr->unop;
-			expr->type = EXPR_BINOP;
+			expr->type = EXPR_COMPARE;
 			expr->op = SPECIAL_EQUAL;
 			expr->left = arg;
 			expr->right = alloc_expression(expr->pos, EXPR_FVALUE);
-- 
1.8.1.2

