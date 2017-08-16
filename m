From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/29] small code reorg of add_store()
Date: Wed, 16 Aug 2017 17:34:34 +0200
Message-ID: <20170816153455.97693-9-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32770 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbdHPPfX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:23 -0400
Received: by mail-wr0-f196.google.com with SMTP id n88so3696856wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:22 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

