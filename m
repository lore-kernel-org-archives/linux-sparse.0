From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 39/48] mem2reg: remove check phisrc_in_bb()
Date: Wed, 23 Aug 2017 22:15:45 +0200
Message-ID: <20170823201554.90551-40-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32865 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWURT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id b79so664164wmf.0
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:19 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/mem2reg.c b/mem2reg.c
index 4ba0f3408..ecda6675f 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -46,17 +46,6 @@ complex_phi:
 	insn->phi_list = dominators;
 }
 
-static int phisrc_in_bb(struct pseudo_list *list, struct basic_block *bb)
-{
-	pseudo_t p;
-	FOR_EACH_PTR(list, p) {
-		if (p->def->bb == bb)
-			return 1;
-	} END_FOR_EACH_PTR(p);
-
-	return 0;
-}
