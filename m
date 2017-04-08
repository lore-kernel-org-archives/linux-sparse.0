From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 2/6] remove bit_size & bit_offset from struct access_data
Date: Sat,  8 Apr 2017 23:18:57 +0200
Message-ID: <20170408211901.40507-3-luc.vanoostenryck@gmail.com>
References: <20170408211901.40507-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33550 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbdDHVTO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Apr 2017 17:19:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id o81so3595907wmb.0
        for <linux-sparse@vger.kernel.org>; Sat, 08 Apr 2017 14:19:14 -0700 (PDT)
In-Reply-To: <20170408211901.40507-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In struct access_data, the fields: 'bit_offset', 'bit_size'
are always the ones corresponding to the 'result_type' and
are thus completely redundant.

Change this by removing these fields and directly using
the info from the 'result_type' field.

Note: the motivation for this change is the realization that the
      initialization of bitfields are buggy because 'bit_size'
      is never set for initializers. The bug could be solved by
      initializing 'bit_size' & 'bit_offset' but it is much
      simpler (and feel safer) to simply use the values from
      'result_type'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/linearize.c b/linearize.c
index 61c804333..5c273a91d 100644
--- a/linearize.c
+++ b/linearize.c
@@ -845,7 +845,6 @@ struct access_data {
 	pseudo_t address;		// pseudo containing address ..
 	pseudo_t origval;		// pseudo for original value ..
 	unsigned int offset, alignment;	// byte offset
-	unsigned int bit_size, bit_offset; // which bits
 	struct position pos;
 };
 
@@ -898,9 +897,7 @@ static int linearize_address_gen(struct entrypoint *ep,
 	ad->pos = expr->pos;
 	ad->result_type = ctype;
 	ad->source_type = base_type(ctype);
-	ad->bit_size = ctype->bit_size;
 	ad->alignment = ctype->ctype.alignment;
-	ad->bit_offset = ctype->bit_offset;
 	if (expr->type == EXPR_PREOP && expr->op == '*')
 		return linearize_simple_address(ep, expr->unop, ad);
 
@@ -948,9 +945,11 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
 	pseudo_t store = value;
 
 	if (type_size(ad->source_type) != type_size(ad->result_type)) {
+		struct symbol *ctype = ad->result_type;
+		unsigned int shift = ctype->bit_offset;
+		unsigned int size = ctype->bit_size;
 		pseudo_t orig = add_load(ep, ad);
-		int shift = ad->bit_offset;
-		unsigned long long mask = (1ULL << ad->bit_size)-1;
+		unsigned long long mask = (1ULL << size) - 1;
 
 		if (shift) {
 			store = add_binary_op(ep, ad->source_type, OP_SHL, value, value_pseudo(shift));
@@ -997,14 +996,15 @@ static pseudo_t add_symbol_address(struct entrypoint *ep, struct symbol *sym)
 
 static pseudo_t linearize_load_gen(struct entrypoint *ep, struct access_data *ad)
 {
+	struct symbol *ctype = ad->result_type;
 	pseudo_t new = add_load(ep, ad);
 
-	if (ad->bit_offset) {
-		pseudo_t shift = value_pseudo(ad->bit_offset);
+	if (ctype->bit_offset) {
+		pseudo_t shift = value_pseudo(ctype->bit_offset);
 		pseudo_t newval = add_binary_op(ep, ad->source_type, OP_LSR, new, shift);
 		new = newval;
 	}
-	if (ad->bit_size != type_size(ad->source_type))
+	if (ctype->bit_size != type_size(ad->source_type))
 		new = cast_pseudo(ep, new, ad->source_type, ad->result_type);
 	return new;
 }
-- 
2.12.0

