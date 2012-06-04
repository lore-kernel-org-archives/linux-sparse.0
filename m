From: Xi Wang <xi.wang@gmail.com>
Subject: [RFC][PATCH 1/3] add ->ctype to struct pseudo
Date: Mon,  4 Jun 2012 02:54:35 -0400
Message-ID: <1338792878-25898-2-git-send-email-xi.wang@gmail.com>
References: <1338792878-25898-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:41199 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab2FDGzj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Jun 2012 02:55:39 -0400
Received: by qadb17 with SMTP id b17so1254231qad.19
        for <linux-sparse@vger.kernel.org>; Sun, 03 Jun 2012 23:55:39 -0700 (PDT)
In-Reply-To: <1338792878-25898-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Xi Wang <xi.wang@gmail.com>

This patch implements Chris's `counter RFC' by adding ->ctype to
struct pseduo so that we have easy access to type information.

Suggested-by: Christopher Li <sparse@chrisli.org>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 flow.c      |    2 +-
 linearize.c |   57 +++++++++++++++++++++++++++++++--------------------------
 linearize.h |    5 +++--
 memops.c    |    2 +-
 simplify.c  |   10 +++++-----
 unssa.c     |    2 +-
 6 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/flow.c b/flow.c
index 7db9548..45f1c8f 100644
--- a/flow.c
+++ b/flow.c
@@ -462,7 +462,7 @@ found:
 		if (!local)
 			return 0;
 		check_access(insn);
-		convert_load_instruction(insn, value_pseudo(0));
+		convert_load_instruction(insn, value_pseudo(insn->target->ctype, 0));
 		return 1;
 	}
 
diff --git a/linearize.c b/linearize.c
index 1d15cfd..a4bf309 100644
--- a/linearize.c
+++ b/linearize.c
@@ -734,12 +734,13 @@ static void add_branch(struct entrypoint *ep, struct expression *expr, pseudo_t
 }
 
 /* Dummy pseudo allocator */
-pseudo_t alloc_pseudo(struct instruction *def)
+pseudo_t alloc_pseudo(struct symbol *ctype, struct instruction *def)
 {
 	static int nr = 0;
 	struct pseudo * pseudo = __alloc_pseudo(0);
 	pseudo->type = PSEUDO_REG;
 	pseudo->nr = ++nr;
+	pseudo->ctype = ctype;
 	pseudo->def = def;
 	return pseudo;
 }
@@ -767,6 +768,7 @@ static pseudo_t symbol_pseudo(struct entrypoint *ep, struct symbol *sym)
 		pseudo->type = PSEUDO_SYM;
 		pseudo->sym = sym;
 		pseudo->ident = sym->ident;
+		pseudo->ctype = sym->ctype.base_type;
 		sym->pseudo = pseudo;
 		add_pseudo(&ep->accesses, pseudo);
 	}
@@ -774,21 +776,22 @@ static pseudo_t symbol_pseudo(struct entrypoint *ep, struct symbol *sym)
 	return pseudo;
 }
 
-pseudo_t value_pseudo(long long val)
+pseudo_t value_pseudo(struct symbol *ctype, long long val)
 {
 #define MAX_VAL_HASH 64
 	static struct pseudo_list *prev[MAX_VAL_HASH];
-	int hash = val & (MAX_VAL_HASH-1);
+	int hash = (val ^ type_size(ctype)) & (MAX_VAL_HASH-1);
 	struct pseudo_list **list = prev + hash;
 	pseudo_t pseudo;
 
 	FOR_EACH_PTR(*list, pseudo) {
-		if (pseudo->value == val)
+		if (pseudo->ctype == ctype && pseudo->value == val)
 			return pseudo;
 	} END_FOR_EACH_PTR(pseudo);
 
 	pseudo = __alloc_pseudo(0);
 	pseudo->type = PSEUDO_VAL;
+	pseudo->ctype = ctype;
 	pseudo->value = val;
 	add_pseudo(list, pseudo);
 
@@ -796,13 +799,14 @@ pseudo_t value_pseudo(long long val)
 	return pseudo;
 }
 
-static pseudo_t argument_pseudo(struct entrypoint *ep, int nr)
+static pseudo_t argument_pseudo(struct entrypoint *ep, struct symbol *ctype, int nr)
 {
 	pseudo_t pseudo = __alloc_pseudo(0);
 	struct instruction *entry = ep->entry;
 
 	pseudo->type = PSEUDO_ARG;
 	pseudo->nr = nr;
+	pseudo->ctype = ctype;
 	pseudo->def = entry;
 	add_pseudo(&entry->arg_list, pseudo);
 
@@ -818,6 +822,7 @@ pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, int size)
 
 	phi->type = PSEUDO_PHI;
 	phi->nr = ++nr;
+	phi->ctype = pseudo->ctype;
 	phi->def = insn;
 
 	use_pseudo(insn, pseudo, &insn->phi_src);
@@ -911,7 +916,7 @@ static pseudo_t add_load(struct entrypoint *ep, struct access_data *ad)
 		return new;
 
 	insn = alloc_typed_instruction(OP_LOAD, ad->source_type);
-	new = alloc_pseudo(insn);
+	new = alloc_pseudo(ad->source_type, insn);
 	ad->origval = new;
 
 	insn->target = new;
@@ -946,10 +951,10 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
 		unsigned long long mask = (1ULL << ad->bit_size)-1;
 
 		if (shift) {
-			store = add_binary_op(ep, ad->source_type, OP_SHL, value, value_pseudo(shift));
+			store = add_binary_op(ep, ad->source_type, OP_SHL, value, value_pseudo(value->ctype, shift));
 			mask <<= shift;
 		}
-		orig = add_binary_op(ep, ad->source_type, OP_AND, orig, value_pseudo(~mask));
+		orig = add_binary_op(ep, ad->source_type, OP_AND, orig, value_pseudo(orig->ctype, ~mask));
 		store = add_binary_op(ep, ad->source_type, OP_OR, orig, store);
 	}
 	add_store(ep, ad, store);
@@ -959,7 +964,7 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
 static pseudo_t add_binary_op(struct entrypoint *ep, struct symbol *ctype, int op, pseudo_t left, pseudo_t right)
 {
 	struct instruction *insn = alloc_typed_instruction(op, ctype);
-	pseudo_t target = alloc_pseudo(insn);
+	pseudo_t target = alloc_pseudo(ctype, insn);
 	insn->target = target;
 	use_pseudo(insn, left, &insn->src1);
 	use_pseudo(insn, right, &insn->src2);
@@ -970,17 +975,17 @@ static pseudo_t add_binary_op(struct entrypoint *ep, struct symbol *ctype, int o
 static pseudo_t add_setval(struct entrypoint *ep, struct symbol *ctype, struct expression *val)
 {
 	struct instruction *insn = alloc_typed_instruction(OP_SETVAL, ctype);
-	pseudo_t target = alloc_pseudo(insn);
+	pseudo_t target = alloc_pseudo(ctype, insn);
 	insn->target = target;
 	insn->val = val;
 	add_one_insn(ep, insn);
 	return target;
 }
 
-static pseudo_t add_symbol_address(struct entrypoint *ep, struct symbol *sym)
+static pseudo_t add_symbol_address(struct entrypoint *ep, struct symbol *ctype, struct symbol *sym)
 {
 	struct instruction *insn = alloc_instruction(OP_SYMADDR, bits_in_pointer);
-	pseudo_t target = alloc_pseudo(insn);
+	pseudo_t target = alloc_pseudo(ctype, insn);
 
 	insn->target = target;
 	use_pseudo(insn, symbol_pseudo(ep, sym), &insn->symbol);
@@ -993,7 +998,7 @@ static pseudo_t linearize_load_gen(struct entrypoint *ep, struct access_data *ad
 	pseudo_t new = add_load(ep, ad);
 
 	if (ad->bit_offset) {
-		pseudo_t shift = value_pseudo(ad->bit_offset);
+		pseudo_t shift = value_pseudo(new->ctype, ad->bit_offset);
 		pseudo_t newval = add_binary_op(ep, ad->source_type, OP_LSR, new, shift);
 		new = newval;
 	}
@@ -1024,7 +1029,7 @@ static pseudo_t linearize_inc_dec(struct entrypoint *ep, struct expression *expr
 		return VOID;
 
 	old = linearize_load_gen(ep, &ad);
-	one = value_pseudo(expr->op_value);
+	one = value_pseudo(expr->ctype, expr->op_value);
 	new = add_binary_op(ep, expr->ctype, op, old, one);
 	linearize_store_gen(ep, new, &ad);
 	finish_address_gen(ep, &ad);
@@ -1034,7 +1039,7 @@ static pseudo_t linearize_inc_dec(struct entrypoint *ep, struct expression *expr
 static pseudo_t add_uniop(struct entrypoint *ep, struct expression *expr, int op, pseudo_t src)
 {
 	struct instruction *insn = alloc_typed_instruction(op, expr->ctype);
-	pseudo_t new = alloc_pseudo(insn);
+	pseudo_t new = alloc_pseudo(expr->ctype, insn);
 
 	insn->target = new;
 	use_pseudo(insn, src, &insn->src1);
@@ -1046,7 +1051,7 @@ static pseudo_t linearize_slice(struct entrypoint *ep, struct expression *expr)
 {
 	pseudo_t pre = linearize_expression(ep, expr->base);
 	struct instruction *insn = alloc_typed_instruction(OP_SLICE, expr->ctype);
-	pseudo_t new = alloc_pseudo(insn);
+	pseudo_t new = alloc_pseudo(expr->ctype, insn);
 
 	insn->target = new;
 	insn->from = expr->r_bitpos;
@@ -1063,7 +1068,7 @@ static pseudo_t linearize_regular_preop(struct entrypoint *ep, struct expression
 	case '+':
 		return pre;
 	case '!': {
-		pseudo_t zero = value_pseudo(0);
+		pseudo_t zero = value_pseudo(pre->ctype, 0);
 		return add_binary_op(ep, expr->unop->ctype, OP_SET_EQ, pre, zero);
 	}
 	case '~':
@@ -1130,7 +1135,7 @@ static pseudo_t cast_pseudo(struct entrypoint *ep, pseudo_t src, struct symbol *
 	if (from->bit_size < 0 || to->bit_size < 0)
 		return VOID;
 	insn = alloc_cast_instruction(from, to);
-	result = alloc_pseudo(insn);
+	result = alloc_pseudo(to, insn);
 	insn->target = result;
 	insn->orig_type = from;
 	use_pseudo(insn, src, &insn->src);
@@ -1235,7 +1240,7 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 	use_pseudo(insn, call, &insn->func);
 	retval = VOID;
 	if (expr->ctype != &void_ctype)
-		retval = alloc_pseudo(insn);
+		retval = alloc_pseudo(expr->ctype, insn);
 	insn->target = retval;
 	add_one_insn(ep, insn);
 
@@ -1309,7 +1314,7 @@ static pseudo_t linearize_select(struct entrypoint *ep, struct expression *expr)
 	use_pseudo(insn, true, &insn->src2);
 	use_pseudo(insn, false, &insn->src3);
 
-	res = alloc_pseudo(insn);
+	res = alloc_pseudo(expr->ctype, insn);
 	insn->target = res;
 	add_one_insn(ep, insn);
 	return res;
@@ -1329,7 +1334,7 @@ static pseudo_t add_join_conditional(struct entrypoint *ep, struct expression *e
 	phi_node = alloc_typed_instruction(OP_PHI, expr->ctype);
 	use_pseudo(phi_node, phi1, add_pseudo(&phi_node->phi_list, phi1));
 	use_pseudo(phi_node, phi2, add_pseudo(&phi_node->phi_list, phi2));
-	phi_node->target = target = alloc_pseudo(phi_node);
+	phi_node->target = target = alloc_pseudo(expr->ctype, phi_node);
 	add_one_insn(ep, phi_node);
 	return target;
 }	
@@ -1533,7 +1538,7 @@ static void linearize_argument(struct entrypoint *ep, struct symbol *arg, int nr
 	ad.source_type = arg;
 	ad.result_type = arg;
 	ad.address = symbol_pseudo(ep, arg);
-	linearize_store_gen(ep, argument_pseudo(ep, nr), &ad);
+	linearize_store_gen(ep, argument_pseudo(ep, arg, nr), &ad);
 	finish_address_gen(ep, &ad);
 }
 
@@ -1546,10 +1551,10 @@ pseudo_t linearize_expression(struct entrypoint *ep, struct expression *expr)
 	switch (expr->type) {
 	case EXPR_SYMBOL:
 		linearize_one_symbol(ep, expr->symbol);
-		return add_symbol_address(ep, expr->symbol);
+		return add_symbol_address(ep, expr->ctype, expr->symbol);
 
 	case EXPR_VALUE:
-		return value_pseudo(expr->value);
+		return value_pseudo(expr->ctype, expr->value);
 
 	case EXPR_STRING: case EXPR_FVALUE: case EXPR_LABEL:
 		return add_setval(ep, expr->ctype, expr);
@@ -1730,7 +1735,7 @@ static void add_asm_output(struct entrypoint *ep, struct instruction *insn, stru
 	const char *constraint, const struct ident *ident)
 {
 	struct access_data ad = { NULL, };
-	pseudo_t pseudo = alloc_pseudo(insn);
+	pseudo_t pseudo = alloc_pseudo(expr->ctype, insn);
 	struct asm_constraint *rule;
 
 	if (!expr || !linearize_address_gen(ep, expr, &ad))
@@ -1863,7 +1868,7 @@ static pseudo_t linearize_return(struct entrypoint *ep, struct statement *stmt)
 		pseudo_t phi;
 		if (!phi_node) {
 			phi_node = alloc_typed_instruction(OP_PHI, expr->ctype);
-			phi_node->target = alloc_pseudo(phi_node);
+			phi_node->target = alloc_pseudo(expr->ctype, phi_node);
 			phi_node->bb = bb_return;
 			add_instruction(&bb_return->insns, phi_node);
 		}
diff --git a/linearize.h b/linearize.h
index 61fbd83..ebecf25 100644
--- a/linearize.h
+++ b/linearize.h
@@ -33,6 +33,7 @@ struct pseudo {
 	enum pseudo_type type;
 	struct pseudo_user_list *users;
 	struct ident *ident;
+	struct symbol *ctype;
 	union {
 		struct symbol *sym;
 		struct instruction *def;
@@ -335,8 +336,8 @@ extern void insert_select(struct basic_block *bb, struct instruction *br, struct
 extern void insert_branch(struct basic_block *bb, struct instruction *br, struct basic_block *target);
 
 pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, int size);
-pseudo_t alloc_pseudo(struct instruction *def);
-pseudo_t value_pseudo(long long val);
+pseudo_t alloc_pseudo(struct symbol *ctype, struct instruction *def);
+pseudo_t value_pseudo(struct symbol *ctype, long long val);
 
 struct entrypoint *linearize_symbol(struct symbol *sym);
 int unssa(struct entrypoint *ep);
diff --git a/memops.c b/memops.c
index 45bd340..d72d42c 100644
--- a/memops.c
+++ b/memops.c
@@ -126,7 +126,7 @@ static void simplify_loads(struct basic_block *bb)
 				if (!dominators) {
 					if (local) {
 						assert(pseudo->type != PSEUDO_ARG);
-						convert_load_instruction(insn, value_pseudo(0));
+						convert_load_instruction(insn, value_pseudo(insn->target->ctype, 0));
 					}
 					goto next_load;
 				}
diff --git a/simplify.c b/simplify.c
index bda4a5b..9f78e21 100644
--- a/simplify.c
+++ b/simplify.c
@@ -303,7 +303,7 @@ static int simplify_asr(struct instruction *insn, pseudo_t pseudo, long long val
 
 	if (value >= size) {
 		warning(insn->pos, "right shift by bigger than source value");
-		return replace_with_pseudo(insn, value_pseudo(0));
+		return replace_with_pseudo(insn, value_pseudo(pseudo->ctype, 0));
 	}
 	if (!value)
 		return replace_with_pseudo(insn, pseudo);
@@ -318,7 +318,7 @@ static int simplify_constant_rightside(struct instruction *insn)
 	case OP_SUB:
 		if (value) {
 			insn->opcode = OP_ADD;
-			insn->src2 = value_pseudo(-value);
+			insn->src2 = value_pseudo(insn->src2->ctype, -value);
 			return REPEAT_CSE;
 		}
 	/* Fall through */
@@ -480,7 +480,7 @@ static int simplify_constant_binop(struct instruction *insn)
 	}
 	res &= bits;
 
-	replace_with_pseudo(insn, value_pseudo(res));
+	replace_with_pseudo(insn, value_pseudo(insn->target->ctype, res));
 	return REPEAT_CSE;
 }
 
@@ -574,7 +574,7 @@ static int simplify_constant_unop(struct instruction *insn)
 	mask = 1ULL << (insn->size-1);
 	res &= mask | (mask-1);
 	
-	replace_with_pseudo(insn, value_pseudo(res));
+	replace_with_pseudo(insn, value_pseudo(insn->target->ctype, res));
 	return REPEAT_CSE;
 }
 
@@ -681,7 +681,7 @@ static int simplify_cast(struct instruction *insn)
 	if (constant(src)) {
 		int sign = orig_type->ctype.modifiers & MOD_SIGNED;
 		long long val = get_cast_value(src->value, orig_size, size, sign);
-		src = value_pseudo(val);
+		src = value_pseudo(src->ctype, val);
 		goto simplify;
 	}
 
diff --git a/unssa.c b/unssa.c
index 382095d..95d1877 100644
--- a/unssa.c
+++ b/unssa.c
@@ -44,7 +44,7 @@ static void replace_phi_node(struct instruction *phi)
 {
 	pseudo_t tmp;
 
-	tmp = alloc_pseudo(NULL);
+	tmp = alloc_pseudo(phi->target->ctype, NULL);
 	tmp->type = phi->target->type;
 	tmp->ident = phi->target->ident;
 	tmp->def = NULL;		// defined by all the phisrc
-- 
1.7.9.5

