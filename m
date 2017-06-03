From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 4/8] div0: also check for compound assignments
Date: Sat,  3 Jun 2017 10:01:31 +0200
Message-ID: <20170603080135.46477-5-luc.vanoostenryck@gmail.com>
References: <20170603080135.46477-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34799 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdFCIBr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 3 Jun 2017 04:01:47 -0400
Received: by mail-wm0-f68.google.com with SMTP id d127so22056512wmf.1
        for <linux-sparse@vger.kernel.org>; Sat, 03 Jun 2017 01:01:46 -0700 (PDT)
In-Reply-To: <20170603080135.46477-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 expand.c                 | 12 ++++++++++++
 validation/div-by-zero.c |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/expand.c b/expand.c
index 0b528ea5a..5bbab17a9 100644
--- a/expand.c
+++ b/expand.c
@@ -559,6 +559,18 @@ static int expand_assignment(struct expression *expr)
 {
 	expand_expression(expr->left);
 	expand_expression(expr->right);
+	if (!conservative) {
+		switch (expr->op) {
+		case SPECIAL_DIV_ASSIGN:
+		case SPECIAL_MOD_ASSIGN:
+			if (expr->right->type != EXPR_VALUE)
+				break;
+			if (expr->right->value)
+				break;
+			warning(expr->pos, "division by zero");
+			break;
+		}
+	}
 	return SIDE_EFFECTS;
 }
 
diff --git a/validation/div-by-zero.c b/validation/div-by-zero.c
index 500ceb8eb..bd8d0dfdf 100644
--- a/validation/div-by-zero.c
+++ b/validation/div-by-zero.c
@@ -59,8 +59,14 @@ div-by-zero.c:17:30: warning: division by zero
 div-by-zero.c:18:30: warning: division by zero
 div-by-zero.c:19:30: warning: division by zero
 div-by-zero.c:21:42: warning: division by zero
+div-by-zero.c:22:30: warning: division by zero
 div-by-zero.c:25:42: warning: division by zero
+div-by-zero.c:26:30: warning: division by zero
+div-by-zero.c:29:42: warning: division by zero
+div-by-zero.c:30:42: warning: division by zero
 div-by-zero.c:35:37: warning: division by zero
 div-by-zero.c:36:37: warning: division by zero
+div-by-zero.c:37:37: warning: division by zero
+div-by-zero.c:38:37: warning: division by zero
  * check-error-end
  */
-- 
2.13.0

