From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 9/9] dump-ir: activate -fdump-ir=mem2reg
Date: Wed,  8 Nov 2017 11:28:02 +0100
Message-ID: <20171108102802.43987-10-luc.vanoostenryck@gmail.com>
References: <20171108102802.43987-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56895 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbdKHK2X (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 05:28:23 -0500
Received: by mail-wm0-f66.google.com with SMTP id z3so9649830wme.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 02:28:22 -0800 (PST)
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
index 212a5feaf..498c06da1 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2234,6 +2234,8 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 	 */
 	if (fpasses & PASS_MEM2REG)
 		simplify_symbol_usage(ep);
+	if (fdump_ir & PASS_MEM2REG)
+		show_entry(ep);
 
 	if (optimize == 0)
 		return ep;
-- 
2.14.0

