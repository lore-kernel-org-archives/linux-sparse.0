From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] fix crash on bad expression in linearize_switch()
Date: Thu, 28 Dec 2017 18:25:19 +0100
Message-ID: <20171228172519.16550-3-luc.vanoostenryck@gmail.com>
References: <20171228172519.16550-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32830 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932102AbdL1RZj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 12:25:39 -0500
Received: by mail-wm0-f65.google.com with SMTP id g130so2633047wme.0
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 09:25:38 -0800 (PST)
In-Reply-To: <20171228172519.16550-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

If the expression for the condition is dereferenced
for its type even if it is NULL.

Fix this by returning early if the expression linearize to NULL.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c             | 2 ++
 validation/empty-expr.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index 2e146de7a..deed3ca2f 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1945,6 +1945,8 @@ static pseudo_t linearize_switch(struct entrypoint *ep, struct statement *stmt)
 	pseudo_t pseudo;
 
 	pseudo = linearize_expression(ep, expr);
+	if (pseudo == VOID)
+		return pseudo;
 
 	active = ep->active;
 	if (!bb_reachable(active))
diff --git a/validation/empty-expr.c b/validation/empty-expr.c
index 506cfba7e..61decf737 100644
--- a/validation/empty-expr.c
+++ b/validation/empty-expr.c
@@ -18,7 +18,6 @@ static int bar(void)
 
 /*
  * check-name: empty expression
- * check-known-to-fail
  *
  * check-error-start
 empty-expr.c:3:17: error: an expression is expected before ')'
-- 
2.15.0

