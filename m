From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 09/48] small code reorg of add_store()
Date: Wed, 23 Aug 2017 22:15:15 +0200
Message-ID: <20170823201554.90551-10-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38720 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932443AbdHWUQS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id a70so622929wmd.5
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:17 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

No functional changes here. Just prepare for coming changes.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/linearize.c b/linearize.c
index 69e4f3e8f..3a1bc74ed 100644
--- a/linearize.c
+++ b/linearize.c
@@ -930,14 +930,16 @@ static pseudo_t add_load(struct entrypoint *ep, struct access_data *ad)
 static void add_store(struct entrypoint *ep, struct access_data *ad, pseudo_t value)
 {
 	struct basic_block *bb = ep->active;
+	struct instruction *store;
 
-	if (bb_reachable(bb)) {
-		struct instruction *store = alloc_typed_instruction(OP_STORE, ad->source_type);
-		store->offset = ad->offset;
-		use_pseudo(store, value, &store->target);
-		use_pseudo(store, ad->address, &store->src);
-		add_one_insn(ep, store);
-	}
+	if (!bb)
+		return;
+
+	store = alloc_typed_instruction(OP_STORE, ad->source_type);
+	store->offset = ad->offset;
+	use_pseudo(store, value, &store->target);
+	use_pseudo(store, ad->address, &store->src);
+	add_one_insn(ep, store);
 }
 
 static pseudo_t linearize_store_gen(struct entrypoint *ep,
-- 
2.14.0

