From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix expansion cost of pure functions
Date: Thu, 16 Feb 2017 16:45:32 +0100
Message-ID: <20170216154532.9261-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36805 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932364AbdBPPpn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Feb 2017 10:45:43 -0500
Received: by mail-wr0-f195.google.com with SMTP id z61so1740869wrc.3
        for <linux-sparse@vger.kernel.org>; Thu, 16 Feb 2017 07:45:42 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Expansion cost of an expression should be a monotonically
increasing function of its sub-expressions.

Here, for the costs of calling a pure function, the costs is
reset to zero (wich is used when the expression expand to
a constant/to test if the expression is a constant or not).

Fix this by setting the cost as the total expansion cost of
all the arguments plus one for the function itself.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/expand.c b/expand.c
index 7af12707e..738c79c51 100644
--- a/expand.c
+++ b/expand.c
@@ -796,7 +796,7 @@ static int expand_symbol_call(struct expression *expr, int cost)
 		return ctype->op->expand(expr, cost);
 
 	if (ctype->ctype.modifiers & MOD_PURE)
-		return 0;
+		return cost + 1;
 
 	return SIDE_EFFECTS;
 }
-- 
2.11.0

