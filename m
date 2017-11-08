From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/9] dump-ir: use -O0
Date: Wed,  8 Nov 2017 11:27:58 +0100
Message-ID: <20171108102802.43987-6-luc.vanoostenryck@gmail.com>
References: <20171108102802.43987-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56308 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbdKHK2R (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 05:28:17 -0500
Received: by mail-wm0-f67.google.com with SMTP id y83so9592572wmc.4
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 02:28:17 -0800 (PST)
In-Reply-To: <20171108102802.43987-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linearize.c b/linearize.c
index 31cc94806..65a4baf96 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2238,6 +2238,8 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 	if (fpasses & PASS_MEM2REG)
 		simplify_symbol_usage(ep);
 
+	if (optimize == 0)
+		return ep;
 repeat:
 	/*
 	 * Remove trivial instructions, and try to CSE
-- 
2.14.0

