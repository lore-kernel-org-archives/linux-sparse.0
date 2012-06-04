From: Xi Wang <xi.wang@gmail.com>
Subject: [RFC][PATCH 2/3] remove ->type and ->size from struct instruction
Date: Mon,  4 Jun 2012 02:54:36 -0400
Message-ID: <1338792878-25898-3-git-send-email-xi.wang@gmail.com>
References: <1338792878-25898-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36445 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab2FDGzl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Jun 2012 02:55:41 -0400
Received: by mail-qc0-f174.google.com with SMTP id o28so1994107qcr.19
        for <linux-sparse@vger.kernel.org>; Sun, 03 Jun 2012 23:55:40 -0700 (PDT)
In-Reply-To: <1338792878-25898-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Xi Wang <xi.wang@gmail.com>

One can use insn->target->ctype and further ->bit_size to get ->type
and ->size of an instruction, respectively.

Suggested-by: Christopher Li <sparse@chrisli.org>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 cse.c       |    6 ++--
 example.c   |   12 +++----
 flow.c      |   10 +++---
 linearize.c |  110 +++++++++++++++++++++++------------------------------------
 linearize.h |   12 ++++---
 memops.c    |    2 +-
 simplify.c  |   14 ++++----
 sparse.c    |    2 +-
 unssa.c     |    1 -
 9 files changed, 74 insertions(+), 95 deletions(-)

diff --git a/cse.c b/cse.c
index e8fbe34..b23d3b4 100644
--- a/cse.c
+++ b/cse.c
@@ -43,7 +43,7 @@ static void clean_up_one_instruction(struct basic_block *bb, struct instruction
 		return;
 	assert(insn->bb == bb);
 	repeat_phase |= simplify_instruction(insn);
-	hash = (insn->opcode << 3) + (insn->size >> 3);
+	hash = (insn->opcode << 3) + (instruction_size(insn) >> 3);
 	switch (insn->opcode) {
 	case OP_SEL:
 		hash += hashval(insn->src3);
@@ -237,8 +237,8 @@ static int insn_compare(const void *_i1, const void *_i2)
 	default:
 		warning(i1->pos, "bad instruction on hash chain");
 	}
-	if (i1->size != i2->size)
-		return i1->size < i2->size ? -1 : 1;
+	if (instruction_size(i1) != instruction_size(i2))
+		return instruction_size(i1) < instruction_size(i2) ? -1 : 1;
 	return 0;
 }
 
diff --git a/example.c b/example.c
index 24444c6..1c6414c 100644
--- a/example.c
+++ b/example.c
@@ -896,7 +896,7 @@ static void do_binop(struct bb_state *state, struct instruction *insn, pseudo_t
 	struct hardreg *dst;
 
 	dst = target_copy_reg(state, src->reg, insn->target);
-	output_insn(state, "%s.%d %s,%s", op, insn->size, show_op(state, src2), dst->name);
+	output_insn(state, "%s.%d %s,%s", op, instruction_size(insn), show_op(state, src2), dst->name);
 	put_operand(state, src);
 	put_operand(state, src2);
 	add_pseudo_reg(state, insn->target, dst);
@@ -983,7 +983,7 @@ static void kill_dead_pseudos(struct bb_state *state)
 
 static void generate_store(struct instruction *insn, struct bb_state *state)
 {
-	output_insn(state, "mov.%d %s,%s", insn->size, reg_or_imm(state, insn->target), address(state, insn));
+	output_insn(state, "mov.%d %s,%s", instruction_size(insn), reg_or_imm(state, insn->target), address(state, insn));
 }
 
 static void generate_load(struct instruction *insn, struct bb_state *state)
@@ -993,7 +993,7 @@ static void generate_load(struct instruction *insn, struct bb_state *state)
 
 	kill_dead_pseudos(state);
 	dst = target_reg(state, insn->target, NULL);
-	output_insn(state, "mov.%d %s,%s", insn->size, input, dst->name);
+	output_insn(state, "mov.%d %s,%s", instruction_size(insn), input, dst->name);
 }
 
 static void kill_pseudo(struct bb_state *state, pseudo_t pseudo)
@@ -1031,7 +1031,7 @@ static void generate_cast(struct bb_state *state, struct instruction *insn)
 	struct hardreg *src = getreg(state, insn->src, insn->target);
 	struct hardreg *dst;
 	unsigned int old = insn->orig_type ? insn->orig_type->bit_size : 0;
-	unsigned int new = insn->size;
+	unsigned int new = instruction_size(insn);
 
 	/*
 	 * Cast to smaller type? Ignore the high bits, we
@@ -1050,7 +1050,7 @@ static void generate_cast(struct bb_state *state, struct instruction *insn)
 		unsigned long long mask;
 		mask = ~(~0ULL << old);
 		mask &= ~(~0ULL << new);
-		output_insn(state, "andl.%d $%#llx,%s", insn->size, mask, dst->name);
+		output_insn(state, "andl.%d $%#llx,%s", instruction_size(insn), mask, dst->name);
 	}
 	add_pseudo_reg(state, insn->target, dst);
 }
@@ -1358,7 +1358,7 @@ static void generate_compare(struct bb_state *state, struct instruction *insn)
 	src = getreg(state, insn->src1, insn->target);
 	src2 = generic(state, insn->src2);
 
-	output_insn(state, "cmp.%d %s,%s", insn->size, src2, src->name);
+	output_insn(state, "cmp.%d %s,%s", instruction_size(insn), src2, src->name);
 
 	add_cc_cache(state, opcode, insn->target);
 }
diff --git a/flow.c b/flow.c
index 45f1c8f..16a66db 100644
--- a/flow.c
+++ b/flow.c
@@ -268,8 +268,8 @@ static int overlapping_memop(struct instruction *a, struct instruction *b)
 {
 	unsigned int a_start = bytes_to_bits(a->offset);
 	unsigned int b_start = bytes_to_bits(b->offset);
-	unsigned int a_size = a->size;
-	unsigned int b_size = b->size;
+	unsigned int a_size = instruction_size(a);
+	unsigned int b_size = instruction_size(b);
 
 	if (a_size + a_start <= b_start)
 		return 0;
@@ -280,7 +280,7 @@ static int overlapping_memop(struct instruction *a, struct instruction *b)
 
 static inline int same_memop(struct instruction *a, struct instruction *b)
 {
-	return	a->offset == b->offset && a->size == b->size;
+	return a->offset == b->offset && instruction_size(a) == instruction_size(b);
 }
 
 /*
@@ -359,7 +359,7 @@ no_dominance:
 
 found_dominator:
 		br = delete_last_instruction(&parent->insns);
-		phi = alloc_phi(parent, one->target, one->size);
+		phi = alloc_phi(parent, one->target);
 		phi->ident = phi->ident ? : pseudo->ident;
 		add_instruction(&parent->insns, br);
 		use_pseudo(insn, phi, add_pseudo(dominators, phi));
@@ -582,7 +582,7 @@ void check_access(struct instruction *insn)
 	pseudo_t pseudo = insn->src;
 
 	if (insn->bb && pseudo->type == PSEUDO_SYM) {
-		int offset = insn->offset, bit = bytes_to_bits(offset) + insn->size;
+		int offset = insn->offset, bit = bytes_to_bits(offset) + instruction_size(insn);
 		struct symbol *sym = pseudo->sym;
 
 		if (sym->bit_size > 0 && (offset < 0 || bit > sym->bit_size))
diff --git a/linearize.c b/linearize.c
index a4bf309..82e8482 100644
--- a/linearize.c
+++ b/linearize.c
@@ -39,11 +39,10 @@ static struct position current_pos;
 
 ALLOCATOR(pseudo_user, "pseudo_user");
 
-static struct instruction *alloc_instruction(int opcode, int size)
+static struct instruction *alloc_instruction(int opcode)
 {
 	struct instruction * insn = __alloc_instruction(0);
 	insn->opcode = opcode;
-	insn->size = size;
 	insn->pos = current_pos;
 	return insn;
 }
@@ -53,13 +52,15 @@ static inline int type_size(struct symbol *type)
 	return type ? type->bit_size > 0 ? type->bit_size : 0 : 0;
 }
 
-static struct instruction *alloc_typed_instruction(int opcode, struct symbol *type)
+static struct instruction *alloc_typed_instruction(int opcode, struct symbol *ctype)
 {
-	struct instruction *insn = alloc_instruction(opcode, type_size(type));
-	insn->type = type;
+	struct instruction *insn = alloc_instruction(opcode);
+	struct pseudo *target = (ctype == &void_ctype) ? VOID : alloc_pseudo(ctype, insn);
+	insn->target = target;
 	return insn;
 }
 
+
 static struct entrypoint *alloc_entrypoint(void)
 {
 	return __alloc_entrypoint(0);
@@ -288,8 +289,8 @@ const char *show_instruction(struct instruction *insn)
 			buf += sprintf(buf, "opcode:%d", opcode);
 		else
 			buf += sprintf(buf, "%s", op);
-		if (insn->size)
-			buf += sprintf(buf, ".%d", insn->size);
+		if (instruction_size(insn))
+			buf += sprintf(buf, ".%d", instruction_size(insn));
 		memset(buf, ' ', 20);
 		buf++;
 	}
@@ -602,7 +603,7 @@ static void add_goto(struct entrypoint *ep, struct basic_block *dst)
 {
 	struct basic_block *src = ep->active;
 	if (bb_reachable(src)) {
-		struct instruction *br = alloc_instruction(OP_BR, 0);
+		struct instruction *br = alloc_instruction(OP_BR);
 		br->bb_true = dst;
 		add_bb(&dst->parents, src);
 		add_bb(&src->children, dst);
@@ -649,7 +650,7 @@ void insert_branch(struct basic_block *bb, struct instruction *jmp, struct basic
 	old = delete_last_instruction(&bb->insns);
 	assert(old == jmp);
 
-	br = alloc_instruction(OP_BR, 0);
+	br = alloc_instruction(OP_BR);
 	br->bb = bb;
 	br->bb_true = target;
 	add_instruction(&bb->insns, br);
@@ -674,7 +675,7 @@ void insert_select(struct basic_block *bb, struct instruction *br, struct instru
 	/* Remove the 'br' */
 	delete_last_instruction(&bb->insns);
 
-	select = alloc_instruction(OP_SEL, phi_node->size);
+	select = alloc_instruction(OP_SEL);
 	select->bb = bb;
 
 	assert(br->cond);
@@ -721,7 +722,7 @@ static void add_branch(struct entrypoint *ep, struct expression *expr, pseudo_t
 	struct instruction *br;
 
 	if (bb_reachable(bb)) {
-       		br = alloc_instruction(OP_BR, 0);
+		br = alloc_instruction(OP_BR);
 		use_pseudo(br, cond, &br->cond);
 		br->bb_true = bb_true;
 		br->bb_false = bb_false;
@@ -814,9 +815,9 @@ static pseudo_t argument_pseudo(struct entrypoint *ep, struct symbol *ctype, int
 	return pseudo;
 }
 
-pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, int size)
+pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo)
 {
-	struct instruction *insn = alloc_instruction(OP_PHISOURCE, size);
+	struct instruction *insn = alloc_instruction(OP_PHISOURCE);
 	pseudo_t phi = __alloc_pseudo(0);
 	static int nr = 0;
 
@@ -916,14 +917,12 @@ static pseudo_t add_load(struct entrypoint *ep, struct access_data *ad)
 		return new;
 
 	insn = alloc_typed_instruction(OP_LOAD, ad->source_type);
-	new = alloc_pseudo(ad->source_type, insn);
-	ad->origval = new;
+	ad->origval = insn->target;
 
-	insn->target = new;
 	insn->offset = ad->offset;
 	use_pseudo(insn, ad->address, &insn->src);
 	add_one_insn(ep, insn);
-	return new;
+	return insn->target;
 }
 
 static void add_store(struct entrypoint *ep, struct access_data *ad, pseudo_t value)
@@ -931,7 +930,7 @@ static void add_store(struct entrypoint *ep, struct access_data *ad, pseudo_t va
 	struct basic_block *bb = ep->active;
 
 	if (bb_reachable(bb)) {
-		struct instruction *store = alloc_typed_instruction(OP_STORE, ad->source_type);
+		struct instruction *store = alloc_instruction(OP_STORE);
 		store->offset = ad->offset;
 		use_pseudo(store, value, &store->target);
 		use_pseudo(store, ad->address, &store->src);
@@ -964,27 +963,23 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
 static pseudo_t add_binary_op(struct entrypoint *ep, struct symbol *ctype, int op, pseudo_t left, pseudo_t right)
 {
 	struct instruction *insn = alloc_typed_instruction(op, ctype);
-	pseudo_t target = alloc_pseudo(ctype, insn);
-	insn->target = target;
 	use_pseudo(insn, left, &insn->src1);
 	use_pseudo(insn, right, &insn->src2);
 	add_one_insn(ep, insn);
-	return target;
+	return insn->target;
 }
 
 static pseudo_t add_setval(struct entrypoint *ep, struct symbol *ctype, struct expression *val)
 {
 	struct instruction *insn = alloc_typed_instruction(OP_SETVAL, ctype);
-	pseudo_t target = alloc_pseudo(ctype, insn);
-	insn->target = target;
 	insn->val = val;
 	add_one_insn(ep, insn);
-	return target;
+	return insn->target;
 }
 
 static pseudo_t add_symbol_address(struct entrypoint *ep, struct symbol *ctype, struct symbol *sym)
 {
-	struct instruction *insn = alloc_instruction(OP_SYMADDR, bits_in_pointer);
+	struct instruction *insn = alloc_instruction(OP_SYMADDR);
 	pseudo_t target = alloc_pseudo(ctype, insn);
 
 	insn->target = target;
@@ -1022,7 +1017,7 @@ static pseudo_t linearize_access(struct entrypoint *ep, struct expression *expr)
 static pseudo_t linearize_inc_dec(struct entrypoint *ep, struct expression *expr, int postop)
 {
 	struct access_data ad = { NULL, };
-		pseudo_t old, new, one;
+	pseudo_t old, new, one;
 	int op = expr->op == SPECIAL_INCREMENT ? OP_ADD : OP_SUB;
 
 	if (!linearize_address_gen(ep, expr->unop, &ad))
@@ -1039,26 +1034,21 @@ static pseudo_t linearize_inc_dec(struct entrypoint *ep, struct expression *expr
 static pseudo_t add_uniop(struct entrypoint *ep, struct expression *expr, int op, pseudo_t src)
 {
 	struct instruction *insn = alloc_typed_instruction(op, expr->ctype);
-	pseudo_t new = alloc_pseudo(expr->ctype, insn);
-
-	insn->target = new;
 	use_pseudo(insn, src, &insn->src1);
 	add_one_insn(ep, insn);
-	return new;
+	return insn->target;
 }
 
 static pseudo_t linearize_slice(struct entrypoint *ep, struct expression *expr)
 {
 	pseudo_t pre = linearize_expression(ep, expr->base);
 	struct instruction *insn = alloc_typed_instruction(OP_SLICE, expr->ctype);
-	pseudo_t new = alloc_pseudo(expr->ctype, insn);
 
-	insn->target = new;
 	insn->from = expr->r_bitpos;
 	insn->len = expr->r_nrbits;
 	use_pseudo(insn, pre, &insn->base);
 	add_one_insn(ep, insn);
-	return new;
+	return insn->target;
 }
 
 static pseudo_t linearize_regular_preop(struct entrypoint *ep, struct expression *expr)
@@ -1125,7 +1115,6 @@ static struct instruction *alloc_cast_instruction(struct symbol *src, struct sym
 
 static pseudo_t cast_pseudo(struct entrypoint *ep, pseudo_t src, struct symbol *from, struct symbol *to)
 {
-	pseudo_t result;
 	struct instruction *insn;
 
 	if (src == VOID)
@@ -1135,12 +1124,10 @@ static pseudo_t cast_pseudo(struct entrypoint *ep, pseudo_t src, struct symbol *
 	if (from->bit_size < 0 || to->bit_size < 0)
 		return VOID;
 	insn = alloc_cast_instruction(from, to);
-	result = alloc_pseudo(to, insn);
-	insn->target = result;
 	insn->orig_type = from;
 	use_pseudo(insn, src, &insn->src);
 	add_one_insn(ep, insn);
-	return result;
+	return insn->target;
 }
 
 static int opcode_sign(int opcode, struct symbol *ctype)
@@ -1198,7 +1185,7 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 {
 	struct expression *arg, *fn;
 	struct instruction *insn = alloc_typed_instruction(OP_CALL, expr->ctype);
-	pseudo_t retval, call;
+	pseudo_t call;
 	struct ctype *ctype = NULL;
 	struct symbol *fntype;
 	struct context *context;
@@ -1238,10 +1225,6 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 		call = linearize_expression(ep, fn);
 	}
 	use_pseudo(insn, call, &insn->func);
-	retval = VOID;
-	if (expr->ctype != &void_ctype)
-		retval = alloc_pseudo(expr->ctype, insn);
-	insn->target = retval;
 	add_one_insn(ep, insn);
 
 	if (ctype) {
@@ -1260,7 +1243,7 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 			}
 			context_diff = out - in;
 			if (check || context_diff) {
-				insn = alloc_instruction(OP_CONTEXT, 0);
+				insn = alloc_instruction(OP_CONTEXT);
 				insn->increment = context_diff;
 				insn->check = check;
 				insn->context_expr = context->context;
@@ -1269,7 +1252,7 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 		} END_FOR_EACH_PTR(context);
 	}
 
-	return retval;
+	return insn->target;
 }
 
 static pseudo_t linearize_binop(struct entrypoint *ep, struct expression *expr)
@@ -1300,7 +1283,7 @@ pseudo_t linearize_cond_branch(struct entrypoint *ep, struct expression *expr, s
 
 static pseudo_t linearize_select(struct entrypoint *ep, struct expression *expr)
 {
-	pseudo_t cond, true, false, res;
+	pseudo_t cond, true, false;
 	struct instruction *insn;
 
 	true = linearize_expression(ep, expr->cond_true);
@@ -1314,16 +1297,13 @@ static pseudo_t linearize_select(struct entrypoint *ep, struct expression *expr)
 	use_pseudo(insn, true, &insn->src2);
 	use_pseudo(insn, false, &insn->src3);
 
-	res = alloc_pseudo(expr->ctype, insn);
-	insn->target = res;
 	add_one_insn(ep, insn);
-	return res;
+	return insn->target;
 }
 
 static pseudo_t add_join_conditional(struct entrypoint *ep, struct expression *expr,
 				     pseudo_t phi1, pseudo_t phi2)
 {
-	pseudo_t target;
 	struct instruction *phi_node;
 
 	if (phi1 == VOID)
@@ -1334,10 +1314,9 @@ static pseudo_t add_join_conditional(struct entrypoint *ep, struct expression *e
 	phi_node = alloc_typed_instruction(OP_PHI, expr->ctype);
 	use_pseudo(phi_node, phi1, add_pseudo(&phi_node->phi_list, phi1));
 	use_pseudo(phi_node, phi2, add_pseudo(&phi_node->phi_list, phi2));
-	phi_node->target = target = alloc_pseudo(expr->ctype, phi_node);
 	add_one_insn(ep, phi_node);
-	return target;
-}	
+	return phi_node->target;
+}
 
 static pseudo_t linearize_short_conditional(struct entrypoint *ep, struct expression *expr,
 					    struct expression *cond,
@@ -1347,19 +1326,18 @@ static pseudo_t linearize_short_conditional(struct entrypoint *ep, struct expres
 	struct basic_block *bb_false;
 	struct basic_block *merge = alloc_basic_block(ep, expr->pos);
 	pseudo_t phi1, phi2;
-	int size = type_size(expr->ctype);
 
 	if (!expr_false || !ep->active)
 		return VOID;
 
 	bb_false = alloc_basic_block(ep, expr_false->pos);
 	src1 = linearize_expression(ep, cond);
-	phi1 = alloc_phi(ep->active, src1, size);
+	phi1 = alloc_phi(ep->active, src1);
 	add_branch(ep, expr, src1, merge, bb_false);
 
 	set_activeblock(ep, bb_false);
 	src2 = linearize_expression(ep, expr_false);
-	phi2 = alloc_phi(ep->active, src2, size);
+	phi2 = alloc_phi(ep->active, src2);
 	set_activeblock(ep, merge);
 
 	return add_join_conditional(ep, expr, phi1, phi2);
@@ -1373,7 +1351,6 @@ static pseudo_t linearize_conditional(struct entrypoint *ep, struct expression *
 	pseudo_t src1, src2;
 	pseudo_t phi1, phi2;
 	struct basic_block *bb_true, *bb_false, *merge;
-	int size = type_size(expr->ctype);
 
 	if (!cond || !expr_true || !expr_false || !ep->active)
 		return VOID;
@@ -1385,12 +1362,12 @@ static pseudo_t linearize_conditional(struct entrypoint *ep, struct expression *
 
 	set_activeblock(ep, bb_true);
 	src1 = linearize_expression(ep, expr_true);
-	phi1 = alloc_phi(ep->active, src1, size);
+	phi1 = alloc_phi(ep->active, src1);
 	add_goto(ep, merge); 
 
 	set_activeblock(ep, bb_false);
 	src2 = linearize_expression(ep, expr_false);
-	phi2 = alloc_phi(ep->active, src2, size);
+	phi2 = alloc_phi(ep->active, src2);
 	set_activeblock(ep, merge);
 
 	return add_join_conditional(ep, expr, phi1, phi2);
@@ -1666,7 +1643,7 @@ static pseudo_t linearize_compound_statement(struct entrypoint *ep, struct state
 
 static pseudo_t linearize_inlined_call(struct entrypoint *ep, struct statement *stmt)
 {
-	struct instruction *insn = alloc_instruction(OP_INLINED_CALL, 0);
+	struct instruction *insn = alloc_instruction(OP_INLINED_CALL);
 	struct statement *args = stmt->args;
 	struct basic_block *bb;
 	pseudo_t pseudo;
@@ -1692,7 +1669,7 @@ static pseudo_t linearize_inlined_call(struct entrypoint *ep, struct statement *
 
 static pseudo_t linearize_context(struct entrypoint *ep, struct statement *stmt)
 {
-	struct instruction *insn = alloc_instruction(OP_CONTEXT, 0);
+	struct instruction *insn = alloc_instruction(OP_CONTEXT);
 	struct expression *expr = stmt->expression;
 	int value = 0;
 
@@ -1707,7 +1684,7 @@ static pseudo_t linearize_context(struct entrypoint *ep, struct statement *stmt)
 
 static pseudo_t linearize_range(struct entrypoint *ep, struct statement *stmt)
 {
-	struct instruction *insn = alloc_instruction(OP_RANGE, 0);
+	struct instruction *insn = alloc_instruction(OP_RANGE);
 
 	use_pseudo(insn, linearize_expression(ep, stmt->range_expression), &insn->src1);
 	use_pseudo(insn, linearize_expression(ep, stmt->range_low), &insn->src2);
@@ -1758,7 +1735,7 @@ static pseudo_t linearize_asm_statement(struct entrypoint *ep, struct statement
 	const char *constraint;
 	struct ident *ident;
 
-	insn = alloc_instruction(OP_ASM, 0);
+	insn = alloc_instruction(OP_ASM);
 	expr = stmt->asm_string;
 	if (!expr || expr->type != EXPR_STRING) {
 		warning(stmt->pos, "expected string in inline asm");
@@ -1868,11 +1845,10 @@ static pseudo_t linearize_return(struct entrypoint *ep, struct statement *stmt)
 		pseudo_t phi;
 		if (!phi_node) {
 			phi_node = alloc_typed_instruction(OP_PHI, expr->ctype);
-			phi_node->target = alloc_pseudo(expr->ctype, phi_node);
 			phi_node->bb = bb_return;
 			add_instruction(&bb_return->insns, phi_node);
 		}
-		phi = alloc_phi(active, src, type_size(expr->ctype));
+		phi = alloc_phi(active, src);
 		phi->ident = &return_ident;
 		use_pseudo(phi_node, phi, add_pseudo(&phi_node->phi_list, phi));
 	}
@@ -1895,7 +1871,7 @@ static pseudo_t linearize_switch(struct entrypoint *ep, struct statement *stmt)
 	if (!bb_reachable(active))
 		return VOID;
 
-	switch_ins = alloc_instruction(OP_SWITCH, 0);
+	switch_ins = alloc_instruction(OP_SWITCH);
 	use_pseudo(switch_ins, pseudo, &switch_ins->cond);
 	add_one_insn(ep, switch_ins);
 	finish_block(ep);
@@ -2063,7 +2039,7 @@ pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stmt)
 		}
 
 		pseudo = linearize_expression(ep, expr);
-		goto_ins = alloc_instruction(OP_COMPUTEDGOTO, 0);
+		goto_ins = alloc_instruction(OP_COMPUTEDGOTO);
 		use_pseudo(goto_ins, pseudo, &goto_ins->target);
 		add_one_insn(ep, goto_ins);
 
@@ -2141,7 +2117,7 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 	sym->ep = ep;
 	set_activeblock(ep, bb);
 
-	entry = alloc_instruction(OP_ENTRY, 0);
+	entry = alloc_instruction(OP_ENTRY);
 	add_one_insn(ep, entry);
 	ep->entry = entry;
 
diff --git a/linearize.h b/linearize.h
index ebecf25..8f24e67 100644
--- a/linearize.h
+++ b/linearize.h
@@ -69,11 +69,9 @@ struct asm_rules {
 DECLARE_ALLOCATOR(asm_rules);
 
 struct instruction {
-	unsigned opcode:8,
-		 size:24;
+	unsigned opcode;
 	struct basic_block *bb;
 	struct position pos;
-	struct symbol *type;
 	union {
 		pseudo_t target;
 		pseudo_t cond;		/* for branch and switch */
@@ -237,6 +235,12 @@ struct basic_block {
 	void *priv;
 };
 
+static inline int instruction_size(const struct instruction *insn)
+{
+	struct symbol *type = insn->target ? insn->target->ctype : NULL;
+	return type ? type->bit_size > 0 ? type->bit_size : 0 : 0;
+}
+
 static inline int is_branch_goto(struct instruction *br)
 {
 	return br && br->opcode==OP_BR && (!br->bb_true || !br->bb_false);
@@ -335,7 +339,7 @@ struct entrypoint {
 extern void insert_select(struct basic_block *bb, struct instruction *br, struct instruction *phi, pseudo_t if_true, pseudo_t if_false);
 extern void insert_branch(struct basic_block *bb, struct instruction *br, struct basic_block *target);
 
-pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, int size);
+pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo);
 pseudo_t alloc_pseudo(struct symbol *ctype, struct instruction *def);
 pseudo_t value_pseudo(struct symbol *ctype, long long val);
 
diff --git a/memops.c b/memops.c
index d72d42c..dcfeda9 100644
--- a/memops.c
+++ b/memops.c
@@ -56,7 +56,7 @@ no_dominance:
 
 found_dominator:
 		br = delete_last_instruction(&parent->insns);
-		phi = alloc_phi(parent, one->target, one->size);
+		phi = alloc_phi(parent, one->target);
 		phi->ident = phi->ident ? : one->target->ident;
 		add_instruction(&parent->insns, br);
 		use_pseudo(insn, phi, add_pseudo(dominators, phi));
diff --git a/simplify.c b/simplify.c
index 9f78e21..4c41436 100644
--- a/simplify.c
+++ b/simplify.c
@@ -279,7 +279,7 @@ static unsigned int value_size(long long value)
  */
 static unsigned int operand_size(struct instruction *insn, pseudo_t pseudo)
 {
-	unsigned int size = insn->size;
+	unsigned int size = instruction_size(insn);
 
 	if (pseudo->type == PSEUDO_REG) {
 		struct instruction *src = pseudo->def;
@@ -375,7 +375,7 @@ static int simplify_constant_binop(struct instruction *insn)
 	unsigned long long ul, ur;
 	long long res, mask, bits;
 
-	mask = 1ULL << (insn->size-1);
+	mask = 1ULL << (instruction_size(insn)-1);
 	bits = mask | (mask-1);
 
 	if (left & mask)
@@ -571,7 +571,7 @@ static int simplify_constant_unop(struct instruction *insn)
 	default:
 		return 0;
 	}
-	mask = 1ULL << (insn->size-1);
+	mask = 1ULL << (instruction_size(insn)-1);
 	res &= mask | (mask-1);
 	
 	replace_with_pseudo(insn, value_pseudo(insn->target->ctype, res));
@@ -670,11 +670,11 @@ static int simplify_cast(struct instruction *insn)
 		return 0;
 
 	/* Keep casts with pointer on either side (not only case of OP_PTRCAST) */
-	if (is_ptr_type(orig_type) || is_ptr_type(insn->type))
+	if (is_ptr_type(orig_type) || is_ptr_type(insn->target->ctype))
 		return 0;
 
 	orig_size = orig_type->bit_size;
-	size = insn->size;
+	size = instruction_size(insn);
 	src = insn->src;
 
 	/* A cast of a constant? */
@@ -688,7 +688,7 @@ static int simplify_cast(struct instruction *insn)
 	/* A cast of a "and" might be a no-op.. */
 	if (src->type == PSEUDO_REG) {
 		struct instruction *def = src->def;
-		if (def->opcode == OP_AND && def->size >= size) {
+		if (def->opcode == OP_AND && instruction_size(def) >= size) {
 			pseudo_t val = def->src2;
 			if (val->type == PSEUDO_VAL) {
 				unsigned long long value = val->value;
@@ -854,7 +854,7 @@ static int simplify_branch(struct instruction *insn)
 		}
 		if (def->opcode == OP_CAST || def->opcode == OP_SCAST) {
 			int orig_size = def->orig_type ? def->orig_type->bit_size : 0;
-			if (def->size > orig_size) {
+			if (instruction_size(def) > orig_size) {
 				use_pseudo(insn, def->src, &insn->cond);
 				remove_usage(cond, &insn->cond);
 				return REPEAT_CSE;
diff --git a/sparse.c b/sparse.c
index 67b7d9e..ba13f63 100644
--- a/sparse.c
+++ b/sparse.c
@@ -102,7 +102,7 @@ static void check_cast_instruction(struct instruction *insn)
 	struct symbol *orig_type = insn->orig_type;
 	if (orig_type) {
 		int old = orig_type->bit_size;
-		int new = insn->size;
+		int new = instruction_size(insn);
 		int oldsigned = (orig_type->ctype.modifiers & MOD_SIGNED) != 0;
 		int newsigned = insn->opcode == OP_SCAST;
 
diff --git a/unssa.c b/unssa.c
index 95d1877..169e819 100644
--- a/unssa.c
+++ b/unssa.c
@@ -105,7 +105,6 @@ static void rewrite_phisrc_bb(struct basic_block *bb)
 
 				copy->bb = bb;
 				copy->opcode = OP_COPY;
-				copy->size = insn->size;
 				copy->pos = insn->pos;
 				copy->target = tmp;
 				copy->src = src;
-- 
1.7.9.5

