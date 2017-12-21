From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] simplify linearize_call_expression()
Date: Thu, 21 Dec 2017 01:06:41 +0100
Message-ID: <20171221000642.56954-3-luc.vanoostenryck@gmail.com>
References: <20171221000642.56954-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37682 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755811AbdLUAIu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Dec 2017 19:08:50 -0500
Received: by mail-wm0-f66.google.com with SMTP id f140so12785680wmd.2
        for <linux-sparse@vger.kernel.org>; Wed, 20 Dec 2017 16:08:49 -0800 (PST)
In-Reply-To: <20171221000642.56954-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Use the fact that fn->ctype can't be NULL if expr->ctype
is not NULL.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/linearize.c b/linearize.c
index eff7d95f1..7ad348c00 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1279,15 +1279,10 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 	}
 
 	fn = expr->fn;
-
-	if (fn->ctype)
-		ctype = &fn->ctype->ctype;
