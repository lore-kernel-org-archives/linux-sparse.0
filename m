From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 29/48] mem2reg: extract kill_pseudo_dead_stores()
Date: Wed, 23 Aug 2017 22:15:35 +0200
Message-ID: <20170823201554.90551-30-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34564 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWUQ5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69so654087wmh.1
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:56 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mem2reg.c b/mem2reg.c
index d13af1dd2..2a976e826 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -200,6 +200,15 @@ static void kill_dead_stores(pseudo_t pseudo, unsigned long generation, struct b
 	} END_FOR_EACH_PTR(parent);
 }
 
+static void kill_pseudo_dead_stores(struct entrypoint *ep, pseudo_t pseudo, int local)
+{
+	struct basic_block *bb;
+	FOR_EACH_PTR(ep->bbs, bb) {
+		if (!bb->children)
+			kill_dead_stores(pseudo, ++bb_generation, bb, local);
+	} END_FOR_EACH_PTR(bb);
+}
+
 /*
  * This should see if the "insn" trivially dominates some previous store, and kill the
  * store if unnecessary.
@@ -338,11 +347,7 @@ static void promote_symbol(struct entrypoint *ep, struct symbol *sym)
 		kill_pseudo_dominated_stores(pseudo, !mod);
 
 		if (!(mod & (MOD_NONLOCAL | MOD_STATIC))) {
-			struct basic_block *bb;
-			FOR_EACH_PTR(ep->bbs, bb) {
-				if (!bb->children)
-					kill_dead_stores(pseudo, ++bb_generation, bb, !mod);
-			} END_FOR_EACH_PTR(bb);
+			kill_pseudo_dead_stores(ep, pseudo, !mod);
 		}
 	}
 
-- 
2.14.0

