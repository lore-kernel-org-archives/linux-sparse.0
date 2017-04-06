From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] remove bit_size & bit_offset from struct access_data
Date: Fri,  7 Apr 2017 01:00:27 +0200
Message-ID: <20170406230029.11384-3-luc.vanoostenryck@gmail.com>
References: <20170406230029.11384-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34196 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbdDFXAi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Apr 2017 19:00:38 -0400
Received: by mail-wr0-f193.google.com with SMTP id u18so7293259wrc.1
        for <linux-sparse@vger.kernel.org>; Thu, 06 Apr 2017 16:00:38 -0700 (PDT)
In-Reply-To: <20170406230029.11384-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In struct access_data, the fields: 'bit_offset', 'bit_size' and
'alignment' are always the ones corresponding to the 'result_type'
and are thus completely redundant.

Change this by removing these fields and directly using
the info from the 'result_type' field.

Note: the motivation for this change is the realization that the
      initialization of bitfields are buggy because the 'bit_size'
      is never set for initializers. The bug could be solved by
      initializing 'bit_size' & 'bit_offset' but it was much
      simpler (and feel safer) to simply use the values from
      'result_type'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/linearize.c b/linearize.c
index 61c804333..e9610932b 100644
--- a/linearize.c
+++ b/linearize.c
@@ -844,8 +844,7 @@ struct access_data {
 	struct symbol *source_type;	// source ctype
 	pseudo_t address;		// pseudo containing address ..
 	pseudo_t origval;		// pseudo for original value ..
-	unsigned int offset, alignment;	// byte offset
-	unsigned int bit_size, bit_offset; // which bits
+	unsigned int offset;		// byte offset
 	struct position pos;
 };
 
@@ -898,9 +897,6 @@ static int linearize_address_gen(struct entrypoint *ep,
 	ad->pos = expr->pos;
 	ad->result_type = ctype;
 	ad->source_type = base_type(ctype);
-	ad->bit_size = ctype->bit_size;
-	ad->alignment = ctype->ctype.alignment;
-	ad->bit_offset = ctype->bit_offset;
 	if (expr->type == EXPR_PREOP && expr->op == '*')
 		return linearize_simple_address(ep, expr->unop, ad);
 
@@ -948,9 +944,11 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
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
@@ -997,14 +995,15 @@ static pseudo_t add_symbol_address(struct entrypoint *ep, struct symbol *sym)
 
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

