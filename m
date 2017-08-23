From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 33/48] mem2reg: rename the other kill_dominated_stores()
Date: Wed, 23 Aug 2017 22:15:39 +0200
Message-ID: <20170823201554.90551-34-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34610 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWURG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:06 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69so654443wmh.1
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:06 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 memops.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/memops.c b/memops.c
index 501973788..294c89cbd 100644
--- a/memops.c
+++ b/memops.c
@@ -85,10 +85,11 @@ static void kill_store(struct instruction *insn)
 	}
 }
 
-static void kill_dominated_stores(struct basic_block *bb)
+static void simplify_stores(struct basic_block *bb)
 {
 	struct instruction *insn;
 
+	/* kill the dominated stores */
 	FOR_EACH_PTR_REVERSE(bb->insns, insn) {
 		if (!insn->bb)
 			continue;
@@ -138,7 +139,7 @@ static void simplify_all_stores(struct entrypoint *ep)
 	if (!fsimplify_stores)
 		return;
 	FOR_EACH_PTR_REVERSE(ep->bbs, bb) {
-		kill_dominated_stores(bb);
+		simplify_stores(bb);
 	} END_FOR_EACH_PTR_REVERSE(bb);
 }
 
-- 
2.14.0

