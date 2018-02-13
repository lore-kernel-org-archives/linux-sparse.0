From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] let struct access_data use a single type
Date: Tue, 13 Feb 2018 02:42:23 +0100
Message-ID: <20180213014223.59817-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38652 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933189AbeBMBof (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Feb 2018 20:44:35 -0500
Received: by mail-wm0-f67.google.com with SMTP id 141so13196597wme.3
        for <linux-sparse@vger.kernel.org>; Mon, 12 Feb 2018 17:44:35 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

'struct access_data' has two members for the type of the access:
'result_type' & 'source_type', the second being the application
of base_type() on the first. But the distinction between these
two types only matters for bitfields.

Simplify things by using a single type, and use base_type() when
doing the linearization of bitfield accesses.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/linearize.c b/linearize.c
index 3b4b0d9b4..cce06a563 100644
--- a/linearize.c
+++ b/linearize.c
@@ -882,8 +882,7 @@ pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, struct symbol *t
  * information in one place.
  */
 struct access_data {
-	struct symbol *result_type;	// result ctype
-	struct symbol *source_type;	// source ctype
+	struct symbol *type;		// ctype
 	pseudo_t address;		// pseudo containing address ..
 	unsigned int offset;		// byte offset
 	struct position pos;
@@ -936,8 +935,7 @@ static int linearize_address_gen(struct entrypoint *ep,
 	if (!ctype)
 		return 0;
 	ad->pos = expr->pos;
-	ad->result_type = ctype;
-	ad->source_type = base_type(ctype);
+	ad->type = ctype;
 	if (expr->type == EXPR_PREOP && expr->op == '*')
 		return linearize_simple_address(ep, expr->unop, ad);
 
@@ -948,9 +946,10 @@ static int linearize_address_gen(struct entrypoint *ep,
 static pseudo_t add_load(struct entrypoint *ep, struct access_data *ad)
 {
 	struct instruction *insn;
+	struct symbol *btype = base_type(ad->type);
 	pseudo_t new;
 
-	insn = alloc_typed_instruction(OP_LOAD, ad->source_type);
+	insn = alloc_typed_instruction(OP_LOAD, btype);
 	new = alloc_pseudo(insn);
 
 	insn->target = new;
@@ -963,9 +962,11 @@ static pseudo_t add_load(struct entrypoint *ep, struct access_data *ad)
 static void add_store(struct entrypoint *ep, struct access_data *ad, pseudo_t value)
 {
 	struct basic_block *bb = ep->active;
+	struct symbol *ctype = ad->type;
 
-	if (bb_reachable(bb)) {
-		struct instruction *store = alloc_typed_instruction(OP_STORE, ad->source_type);
+	if (bb_reachable(bb) && ctype) {
+		struct symbol *btype = base_type(ctype);
+		struct instruction *store = alloc_typed_instruction(OP_STORE, btype);
 		store->offset = ad->offset;
 		use_pseudo(store, value, &store->target);
 		use_pseudo(store, ad->address, &store->src);
@@ -977,21 +978,22 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
 		pseudo_t value,
 		struct access_data *ad)
 {
+	struct symbol *ctype = ad->type;
+	struct symbol *btype = base_type(ctype);
 	pseudo_t store = value;
 
-	if (type_size(ad->source_type) != type_size(ad->result_type)) {
-		struct symbol *ctype = ad->result_type;
+	if (type_size(btype) != type_size(ctype)) {
 		unsigned int shift = ctype->bit_offset;
 		unsigned int size = ctype->bit_size;
 		pseudo_t orig = add_load(ep, ad);
 		unsigned long long mask = (1ULL << size) - 1;
 
 		if (shift) {
-			store = add_binary_op(ep, ad->source_type, OP_SHL, value, value_pseudo(shift));
+			store = add_binary_op(ep, btype, OP_SHL, value, value_pseudo(shift));
 			mask <<= shift;
 		}
-		orig = add_binary_op(ep, ad->source_type, OP_AND, orig, value_pseudo(~mask));
-		store = add_binary_op(ep, ad->source_type, OP_OR, orig, store);
+		orig = add_binary_op(ep, btype, OP_AND, orig, value_pseudo(~mask));
+		store = add_binary_op(ep, btype, OP_OR, orig, store);
 	}
 	add_store(ep, ad, store);
 	return value;
@@ -1041,16 +1043,17 @@ static pseudo_t add_symbol_address(struct entrypoint *ep, struct symbol *sym)
 
 static pseudo_t linearize_load_gen(struct entrypoint *ep, struct access_data *ad)
 {
-	struct symbol *ctype = ad->result_type;
+	struct symbol *ctype = ad->type;
+	struct symbol *btype = base_type(ctype);
 	pseudo_t new = add_load(ep, ad);
 
 	if (ctype->bit_offset) {
 		pseudo_t shift = value_pseudo(ctype->bit_offset);
-		pseudo_t newval = add_binary_op(ep, ad->source_type, OP_LSR, new, shift);
+		pseudo_t newval = add_binary_op(ep, btype, OP_LSR, new, shift);
 		new = newval;
 	}
-	if (ctype->bit_size != type_size(ad->source_type))
-		new = cast_pseudo(ep, new, ad->source_type, ad->result_type);
+	if (ctype->bit_size != type_size(btype))
+		new = cast_pseudo(ep, new, btype, ctype);
 	return new;
 }
 
@@ -1574,8 +1577,7 @@ static pseudo_t linearize_position(struct entrypoint *ep, struct expression *pos
 	struct expression *init_expr = pos->init_expr;
 
 	ad->offset = pos->init_offset;
-	ad->source_type = base_type(init_expr->ctype);
-	ad->result_type = init_expr->ctype;
+	ad->type = init_expr->ctype;
 	return linearize_initializer(ep, init_expr, ad);
 }
 
@@ -1594,8 +1596,7 @@ static pseudo_t linearize_initializer(struct entrypoint *ep, struct expression *
 		break;
 	default: {
 		pseudo_t value = linearize_expression(ep, initializer);
-		ad->source_type = base_type(initializer->ctype);
-		ad->result_type = initializer->ctype;
+		ad->type = initializer->ctype;
 		linearize_store_gen(ep, value, ad);
 		return value;
 	}
@@ -1608,8 +1609,7 @@ static void linearize_argument(struct entrypoint *ep, struct symbol *arg, int nr
 {
 	struct access_data ad = { NULL, };
 
-	ad.source_type = arg;
-	ad.result_type = arg;
+	ad.type = arg;
 	ad.address = symbol_pseudo(ep, arg);
 	linearize_store_gen(ep, argument_pseudo(ep, nr), &ad);
 	finish_address_gen(ep, &ad);
@@ -1718,8 +1718,7 @@ static pseudo_t linearize_one_symbol(struct entrypoint *ep, struct symbol *sym)
 		// all fields arelater  explicitely initialized.
 		struct expression *expr = sym->initializer;
 		ad.pos = expr->pos;
-		ad.result_type = sym;
-		ad.source_type = base_type(sym);
+		ad.type = sym;
 		ad.address = symbol_pseudo(ep, sym);
 		linearize_store_gen(ep, value_pseudo(0), &ad);
 	}
-- 
2.16.0

