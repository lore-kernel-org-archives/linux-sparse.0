From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/8] dump-ir: activate/deactive pass 'mem2reg'
Date: Fri, 15 Sep 2017 09:40:29 +0200
Message-ID: <20170915074034.7785-4-luc.vanoostenryck@gmail.com>
References: <20170915074034.7785-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34246 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbdIOHkn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:40:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id i131so2023240wma.1
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:40:42 -0700 (PDT)
In-Reply-To: <20170915074034.7785-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

