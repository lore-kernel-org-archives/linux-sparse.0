From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/9] dump-ir: activate/deactive pass 'mem2reg'
Date: Wed,  8 Nov 2017 11:27:56 +0100
Message-ID: <20171108102802.43987-4-luc.vanoostenryck@gmail.com>
References: <20171108102802.43987-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:45144 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdKHK2Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 05:28:16 -0500
Received: by mail-wm0-f66.google.com with SMTP id y80so9326660wmd.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 02:28:15 -0800 (PST)
In-Reply-To: <20171108102802.43987-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index ba76397ea..31cc94806 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2235,7 +2235,8 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 	/*
 	 * Turn symbols into pseudos
 	 */
-	simplify_symbol_usage(ep);
+	if (fpasses & PASS_MEM2REG)
+		simplify_symbol_usage(ep);
 
 repeat:
 	/*
-- 
2.14.0

