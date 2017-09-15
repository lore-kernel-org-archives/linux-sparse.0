From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/8] dump-ir: use -O0
Date: Fri, 15 Sep 2017 09:40:31 +0200
Message-ID: <20170915074034.7785-6-luc.vanoostenryck@gmail.com>
References: <20170915074034.7785-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33667 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdIOHkp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:40:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id 187so2024483wmn.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:40:44 -0700 (PDT)
In-Reply-To: <20170915074034.7785-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

