From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 6/8] div0: use -Wdiv-by-zero
Date: Sat,  3 Jun 2017 10:01:33 +0200
Message-ID: <20170603080135.46477-7-luc.vanoostenryck@gmail.com>
References: <20170603080135.46477-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33626 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdFCIBt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 3 Jun 2017 04:01:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id b84so22124891wmh.0
        for <linux-sparse@vger.kernel.org>; Sat, 03 Jun 2017 01:01:48 -0700 (PDT)
In-Reply-To: <20170603080135.46477-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/expand.c b/expand.c
index 5bbab17a9..71fbf209c 100644
--- a/expand.c
+++ b/expand.c
@@ -278,7 +278,7 @@ static int simplify_int_binop(struct expression *expr, struct symbol *ctype)
 	expr->taint = left->taint | right->taint;
 	return 1;
 Div:
-	if (!conservative)
+	if (!conservative && Wdiv_by_zero)
 		warning(expr->pos, "division by zero");
 	return 0;
 Overflow:
@@ -363,7 +363,7 @@ static int simplify_float_binop(struct expression *expr)
 	expr->fvalue = res;
 	return 1;
 Div:
-	if (!conservative)
+	if (!conservative && Wdiv_by_zero)
 		warning(expr->pos, "division by zero");
 	return 0;
 }
-- 
2.13.0

