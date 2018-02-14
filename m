From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] rename base_type() to bitfield_base_type()
Date: Wed, 14 Feb 2018 02:51:42 +0100
Message-ID: <20180214015142.24725-3-luc.vanoostenryck@gmail.com>
References: <20180214015142.24725-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55157 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966425AbeBNBvw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 20:51:52 -0500
Received: by mail-wm0-f65.google.com with SMTP id i192so86471wme.4
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 17:51:51 -0800 (PST)
In-Reply-To: <20180214015142.24725-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In linearize.c, base_type() is not some kind of generic helper
like get_base_type() but is a more specialized thing used for
loads and stores and giving only the base type of bitfields.

Rename this helper to bitfield_base_type() to make this more
self-explained.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/linearize.c b/linearize.c
index 5aff861d4..a4ec79d81 100644
--- a/linearize.c
+++ b/linearize.c
@@ -913,7 +913,7 @@ static int linearize_simple_address(struct entrypoint *ep,
 	return 1;
 }
 
-static struct symbol *base_type(struct symbol *sym)
+static struct symbol *bitfield_base_type(struct symbol *sym)
 {
 	struct symbol *base = sym;
 
@@ -945,7 +945,7 @@ static int linearize_address_gen(struct entrypoint *ep,
 
 static pseudo_t add_load(struct entrypoint *ep, struct access_data *ad)
 {
-	struct symbol *btype = base_type(ad->type);
+	struct symbol *btype = bitfield_base_type(ad->type);
 	struct instruction *insn;
 	pseudo_t new;
 
@@ -964,7 +964,7 @@ static void add_store(struct entrypoint *ep, struct access_data *ad, pseudo_t va
 	struct basic_block *bb = ep->active;
 
 	if (bb_reachable(bb)) {
-		struct symbol *btype = base_type(ad->type);
+		struct symbol *btype = bitfield_base_type(ad->type);
 		struct instruction *store = alloc_typed_instruction(OP_STORE, btype);
 		store->offset = ad->offset;
 		use_pseudo(store, value, &store->target);
@@ -978,7 +978,7 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
 		struct access_data *ad)
 {
 	struct symbol *ctype = ad->type;
-	struct symbol *btype = base_type(ctype);
+	struct symbol *btype = bitfield_base_type(ctype);
 	pseudo_t store = value;
 
 	if (type_size(btype) != type_size(ctype)) {
@@ -1043,7 +1043,7 @@ static pseudo_t add_symbol_address(struct entrypoint *ep, struct symbol *sym)
 static pseudo_t linearize_load_gen(struct entrypoint *ep, struct access_data *ad)
 {
 	struct symbol *ctype = ad->type;
-	struct symbol *btype = base_type(ctype);
+	struct symbol *btype = bitfield_base_type(ctype);
 	pseudo_t new = add_load(ep, ad);
 
 	if (ctype->bit_offset) {
-- 
2.16.0

