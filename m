From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] let struct access_data use a single type
Date: Wed, 14 Feb 2018 02:51:41 +0100
Message-ID: <20180214015142.24725-2-luc.vanoostenryck@gmail.com>
References: <20180214015142.24725-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35725 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966428AbeBNBvv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 20:51:51 -0500
Received: by mail-wm0-f66.google.com with SMTP id r78so19257171wme.0
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 17:51:50 -0800 (PST)
In-Reply-To: <20180214015142.24725-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

'struct access_data' has two members for the type of the access:
'result_type' & 'source_type', the second being the application
of base_type() on the first.

These two names are not very self-explained and are confusing
when trying to know which one must be used for loads vs stores.
Also, the distinction between these two types only exists for
bitfields.

Simplify things by using a single type, and use base_type() when
doing the linearization of bitfield accesses.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/linearize.c b/linearize.c
index 3b4b0d9b4..5aff861d4 100644
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
 
@@ -947,10 +945,11 @@ static int linearize_address_gen(struct entrypoint *ep,
 
 static pseudo_t add_load(struct entrypoint *ep, struct access_data *ad)
 {
+	struct symbol *btype = base_type(ad->type);
 	struct instruction *insn;
 	pseudo_t new;
 
-	insn = alloc_typed_instruction(OP_LOAD, ad->source_type);
+	insn = alloc_typed_instruction(OP_LOAD, btype);
 	new = alloc_pseudo(insn);
 
 	insn->target = new;
@@ -965,7 +964,8 @@ static void add_store(struct entrypoint *ep, struct access_data *ad, pseudo_t va
 	struct basic_block *bb = ep->active;
 
 	if (bb_reachable(bb)) {
-		struct instruction *store = alloc_typed_instruction(OP_STORE, ad->source_type);
+		struct symbol *btype = base_type(ad->type);
+		struct instruction *store = alloc_typed_instruction(OP_STORE, btype);
 		store->offset = ad->offset;
 		use_pseudo(store, value, &store->target);
 		use_pseudo(store, ad->address, &store->src);
@@ -977,21 +977,22 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
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
@@ -1041,16 +1042,17 @@ static pseudo_t add_symbol_address(struct entrypoint *ep, struct symbol *sym)
 
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
 
@@ -1574,8 +1576,7 @@ static pseudo_t linearize_position(struct entrypoint *ep, struct expression *pos
 	struct expression *init_expr = pos->init_expr;
 
 	ad->offset = pos->init_offset;
-	ad->source_type = base_type(init_expr->ctype);
-	ad->result_type = init_expr->ctype;
+	ad->type = init_expr->ctype;
 	return linearize_initializer(ep, init_expr, ad);
 }
 
@@ -1594,8 +1595,7 @@ static pseudo_t linearize_initializer(struct entrypoint *ep, struct expression *
 		break;
 	default: {
 		pseudo_t value = linearize_expression(ep, initializer);
-		ad->source_type = base_type(initializer->ctype);
-		ad->result_type = initializer->ctype;
+		ad->type = initializer->ctype;
 		linearize_store_gen(ep, value, ad);
 		return value;
 	}
@@ -1608,8 +1608,7 @@ static void linearize_argument(struct entrypoint *ep, struct symbol *arg, int nr
 {
 	struct access_data ad = { NULL, };
 
-	ad.source_type = arg;
-	ad.result_type = arg;
+	ad.type = arg;
 	ad.address = symbol_pseudo(ep, arg);
 	linearize_store_gen(ep, argument_pseudo(ep, nr), &ad);
 	finish_address_gen(ep, &ad);
@@ -1718,8 +1717,7 @@ static pseudo_t linearize_one_symbol(struct entrypoint *ep, struct symbol *sym)
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

