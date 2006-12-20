From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH][RFC] Adding instruction to pseudo user tracking.
Date: Tue, 19 Dec 2006 18:19:09 -0800
Message-ID: <20061220021909.GB8137@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc12.comcast.net ([204.127.225.92]:33894 "EHLO
	alnrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964794AbWLTCfc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Dec 2006 21:35:32 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>, Linus Torvalds <torvalds@osdl.org>

The current way of tracking pseudo register user is by
keeping a list of the address of the pseudo_t member.
This address can be in part of the instruction member, the
worse case is in the argument list of the call instruction.

As the comment for address_taken() said, using the container
to get instruction pointer is wrong. It use to work with instruction
that relate to symbol address. But that is not true any more. Even
worse, it is very hard to track the pseudo usage other than symbol
address. The only reason symbol address used to works for call instruction
is because call instruction did not directly use the symbol address.

I can't find other way to safely link instruction to pseudo usage.
I bit the bullet and just add the instruction pointer to pair with
the pseudo user pointer. So sparse can get the instruction from the
pseudo user chain. It is actually useful in doing other analyze.

Testing:

I compare the linearize result with/without the patch on a few
sparse source file itself. The linearize generate exactly
the same result except the symbol address changes, which is
predictable different because the pseudo user structure allocate
memory. So I know I did not break the simplify memory operation
too badly.


Index: sparse/flow.c
===================================================================
--- sparse.orig/flow.c	2006-12-18 13:58:01.000000000 -0800
+++ sparse/flow.c	2006-12-18 13:58:32.000000000 -0800
@@ -229,27 +229,27 @@ int simplify_flow(struct entrypoint *ep)
 	return simplify_branch_nodes(ep);
 }
 
-static inline void concat_user_list(struct pseudo_ptr_list *src, struct pseudo_ptr_list **dst)
+static inline void concat_user_list(struct pseudo_user_list *src, struct pseudo_user_list **dst)
 {
 	concat_ptr_list((struct ptr_list *)src, (struct ptr_list **)dst);
 }
 
 void convert_instruction_target(struct instruction *insn, pseudo_t src)
 {
-	pseudo_t target, *usep;
-
+	pseudo_t target;
+	struct pseudo_user *pu;
 	/*
 	 * Go through the "insn->users" list and replace them all..
 	 */
 	target = insn->target;
 	if (target == src)
 		return;
-	FOR_EACH_PTR(target->users, usep) {
-		if (*usep != VOID) {
-			assert(*usep == target);
-			*usep = src;
+	FOR_EACH_PTR(target->users, pu) {
+		if (*pu->userp != VOID) {
+			assert(*pu->userp == target);
+			*pu->userp = src;
 		}
-	} END_FOR_EACH_PTR(usep);
+	} END_FOR_EACH_PTR(pu);
 	concat_user_list(target->users, &src->users);
 	target->users = NULL;
 }
@@ -360,7 +360,7 @@ found_dominator:
 		phi = alloc_phi(parent, one->target, one->size);
 		phi->ident = phi->ident ? : pseudo->ident;
 		add_instruction(&parent->insns, br);
-		use_pseudo(phi, add_pseudo(dominators, phi));
+		use_pseudo(insn, phi, add_pseudo(dominators, phi));
 	} END_FOR_EACH_PTR(parent);
 	return 1;
 }		
@@ -592,7 +592,8 @@ void check_access(struct instruction *in
 
 static void simplify_one_symbol(struct entrypoint *ep, struct symbol *sym)
 {
-	pseudo_t pseudo, src, *pp;
+	pseudo_t pseudo, src;
+	struct pseudo_user *pu;
 	struct instruction *def;
 	unsigned long mod;
 	int all, stores, complex;
@@ -614,9 +615,9 @@ static void simplify_one_symbol(struct e
 	def = NULL;
 	stores = 0;
 	complex = 0;
-	FOR_EACH_PTR(pseudo->users, pp) {
+	FOR_EACH_PTR(pseudo->users, pu) {
 		/* We know that the symbol-pseudo use is the "src" in the instruction */
-		struct instruction *insn = container(pp, struct instruction, src);
+		struct instruction *insn = pu->insn;
 
 		switch (insn->opcode) {
 		case OP_STORE:
@@ -639,7 +640,7 @@ static void simplify_one_symbol(struct e
 			warning(sym->pos, "symbol '%s' pseudo used in unexpected way", show_ident(sym->ident));
 		}
 		complex |= insn->offset;
-	} END_FOR_EACH_PTR(pp);
+	} END_FOR_EACH_PTR(pu);
 
 	if (complex)
 		goto complex_def;
@@ -655,13 +656,13 @@ static void simplify_one_symbol(struct e
 	if (def)
 		src = def->target;
 
-	FOR_EACH_PTR(pseudo->users, pp) {
-		struct instruction *insn = container(pp, struct instruction, src);
+	FOR_EACH_PTR(pseudo->users, pu) {
+		struct instruction *insn = pu->insn;
 		if (insn->opcode == OP_LOAD) {
 			check_access(insn);
 			convert_load_instruction(insn, src);
 		}
-	} END_FOR_EACH_PTR(pp);
+	} END_FOR_EACH_PTR(pu);
 
 	/* Turn the store into a no-op */
 	kill_store(def);
@@ -671,29 +672,29 @@ multi_def:
 complex_def:
 external_visibility:
 	all = 1;
-	FOR_EACH_PTR_REVERSE(pseudo->users, pp) {
-		struct instruction *insn = container(pp, struct instruction, src);
+	FOR_EACH_PTR_REVERSE(pseudo->users, pu) {
+		struct instruction *insn = pu->insn;
 		if (insn->opcode == OP_LOAD)
 			all &= find_dominating_stores(pseudo, insn, ++bb_generation, !mod);
-	} END_FOR_EACH_PTR_REVERSE(pp);
+	} END_FOR_EACH_PTR_REVERSE(pu);
 
 	/* If we converted all the loads, remove the stores. They are dead */
 	if (all && !mod) {
-		FOR_EACH_PTR(pseudo->users, pp) {
-			struct instruction *insn = container(pp, struct instruction, src);
+		FOR_EACH_PTR(pseudo->users, pu) {
+			struct instruction *insn = pu->insn;
 			if (insn->opcode == OP_STORE)
 				kill_store(insn);
-		} END_FOR_EACH_PTR(pp);
+		} END_FOR_EACH_PTR(pu);
 	} else {
 		/*
 		 * If we couldn't take the shortcut, see if we can at least kill some
 		 * of them..
 		 */
-		FOR_EACH_PTR(pseudo->users, pp) {
-			struct instruction *insn = container(pp, struct instruction, src);
+		FOR_EACH_PTR(pseudo->users, pu) {
+			struct instruction *insn = pu->insn;
 			if (insn->opcode == OP_STORE)
 				kill_dominated_stores(pseudo, insn, ++bb_generation, insn->bb, !mod, 0);
-		} END_FOR_EACH_PTR(pp);
+		} END_FOR_EACH_PTR(pu);
 
 		if (!(mod & (MOD_NONLOCAL | MOD_STATIC))) {
 			struct basic_block *bb;
Index: sparse/simplify.c
===================================================================
--- sparse.orig/simplify.c	2006-12-18 13:58:01.000000000 -0800
+++ sparse/simplify.c	2006-12-18 13:58:32.000000000 -0800
@@ -146,10 +146,27 @@ static int clean_up_phi(struct instructi
 	return if_convert_phi(insn);
 }
 
+int delete_pseudo_user_list_entry(struct pseudo_user_list **list, pseudo_t *entry, int count)
+{
+	struct pseudo_user *pu;
+
+	FOR_EACH_PTR(*list, pu) {
+		if (pu->userp == entry) {
+			DELETE_CURRENT_PTR(pu);
+			if (!--count)
+				goto out;
+		}
+	} END_FOR_EACH_PTR(pu);
+	assert(count <= 0);
+out:
+	pack_ptr_list((struct ptr_list **)list);
+	return count;
+}
+
 static inline void remove_usage(pseudo_t p, pseudo_t *usep)
 {
 	if (has_use_list(p)) {
-		delete_ptr_list_entry((struct ptr_list **)&p->users, usep, 1);
+		delete_pseudo_user_list_entry(&p->users, usep, 1);
 		if (!p->users)
 			kill_instruction(p->def);
 	}
@@ -208,11 +225,11 @@ void kill_instruction(struct instruction
  */
 static int dead_insn(struct instruction *insn, pseudo_t *src1, pseudo_t *src2, pseudo_t *src3)
 {
-	pseudo_t *usep;
-	FOR_EACH_PTR(insn->target->users, usep) {
-		if (*usep != VOID)
+	struct pseudo_user *pu;
+	FOR_EACH_PTR(insn->target->users, pu) {
+		if (*pu->userp != VOID)
 			return 0;
-	} END_FOR_EACH_PTR(usep);
+	} END_FOR_EACH_PTR(pu);
 
 	insn->bb = NULL;
 	kill_use(src1);
@@ -419,12 +436,12 @@ static int simplify_binop(struct instruc
 	return 0;
 }
 
-static void switch_pseudo(pseudo_t *pp1, pseudo_t *pp2)
+static void switch_pseudo(struct instruction *insn1, pseudo_t *pp1, struct instruction *insn2, pseudo_t *pp2)
 {
 	pseudo_t p1 = *pp1, p2 = *pp2;
 
-	use_pseudo(p2, pp1);
-	use_pseudo(p1, pp2);
+	use_pseudo(insn1, p2, pp1);
+	use_pseudo(insn2, p1, pp2);
 	remove_usage(p1, pp1);
 	remove_usage(p2, pp2);
 }
@@ -444,7 +461,7 @@ static int canonical_order(pseudo_t p1, 
 static int simplify_commutative_binop(struct instruction *insn)
 {
 	if (!canonical_order(insn->src1, insn->src2)) {
-		switch_pseudo(&insn->src1, &insn->src2);
+		switch_pseudo(insn, &insn->src1, insn, &insn->src2);
 		return REPEAT_CSE;
 	}
 	return 0;
@@ -473,7 +490,7 @@ static int simplify_associative_binop(st
 		return 0;
 	if (ptr_list_size((struct ptr_list *)def->target->users) != 1)
 		return 0;
-	switch_pseudo(&def->src1, &insn->src2);
+	switch_pseudo(def, &def->src1, insn, &insn->src2);
 	return REPEAT_CSE;
 }
 
@@ -517,7 +534,7 @@ static int simplify_one_memop(struct ins
 		struct instruction *def = addr->def;
 		if (def->opcode == OP_SYMADDR && def->src) {
 			kill_use(&insn->src);
-			use_pseudo(def->src, &insn->src);
+			use_pseudo(insn, def->src, &insn->src);
 			return REPEAT_CSE | REPEAT_SYMBOL_CLEANUP;
 		}
 		if (def->opcode == OP_ADD) {
@@ -543,7 +560,7 @@ offset:
 		warning(insn->pos, "crazy programmer");
 	}
 	insn->offset += off->value;
-	use_pseudo(new, &insn->src);
+	use_pseudo(insn, new, &insn->src);
 	remove_usage(addr, &insn->src);
 	return REPEAT_CSE | REPEAT_SYMBOL_CLEANUP;
 }
@@ -699,7 +716,7 @@ static int simplify_range(struct instruc
  */
 static int simplify_cond_branch(struct instruction *br, pseudo_t cond, struct instruction *def, pseudo_t *pp)
 {
-	use_pseudo(*pp, &br->cond);
+	use_pseudo(br, *pp, &br->cond);
 	remove_usage(cond, &br->cond);
 	if (def->opcode == OP_SET_EQ) {
 		struct basic_block *true = br->bb_true;
@@ -763,7 +780,7 @@ static int simplify_branch(struct instru
 					insn->bb_false = true;
 					insn->bb_true = false;
 				}
-				use_pseudo(def->src1, &insn->cond);
+				use_pseudo(insn, def->src1, &insn->cond);
 				remove_usage(cond, &insn->cond);
 				return REPEAT_CSE;
 			}
@@ -771,7 +788,7 @@ static int simplify_branch(struct instru
 		if (def->opcode == OP_CAST || def->opcode == OP_SCAST) {
 			int orig_size = def->orig_type ? def->orig_type->bit_size : 0;
 			if (def->size > orig_size) {
-				use_pseudo(def->src, &insn->cond);
+				use_pseudo(insn, def->src, &insn->cond);
 				remove_usage(cond, &insn->cond);
 				return REPEAT_CSE;
 			}
Index: sparse/memops.c
===================================================================
--- sparse.orig/memops.c	2006-12-18 13:58:01.000000000 -0800
+++ sparse/memops.c	2006-12-18 13:58:32.000000000 -0800
@@ -59,31 +59,19 @@ found_dominator:
 		phi = alloc_phi(parent, one->target, one->size);
 		phi->ident = phi->ident ? : one->target->ident;
 		add_instruction(&parent->insns, br);
-		use_pseudo(phi, add_pseudo(dominators, phi));
+		use_pseudo(insn, phi, add_pseudo(dominators, phi));
 	} END_FOR_EACH_PTR(parent);
 	return 1;
 }		
 
-/*
- * FIXME! This is wrong. Since we now distribute out the OP_SYMADDR,
- * we can no longer really use "container()" to get from a user to
- * the instruction that uses it.
- *
- * This happens to work, simply because the likelihood of the
- * (possibly non-instruction) containing the right bitpattern
- * in the right place is pretty low. But this is still wrong.
- *
- * We should make symbol-pseudos count non-load/store usage,
- * or something.
- */
 static int address_taken(pseudo_t pseudo)
 {
-	pseudo_t *usep;
-	FOR_EACH_PTR(pseudo->users, usep) {
-		struct instruction *insn = container(usep, struct instruction, src);
+	struct pseudo_user *pu;
+	FOR_EACH_PTR(pseudo->users, pu) {
+		struct instruction *insn = pu->insn;
 		if (insn->bb && (insn->opcode != OP_LOAD || insn->opcode != OP_STORE))
 			return 1;
-	} END_FOR_EACH_PTR(usep);
+	} END_FOR_EACH_PTR(pu);
 	return 0;
 }
 
Index: sparse/linearize.h
===================================================================
--- sparse.orig/linearize.h	2006-12-18 13:58:01.000000000 -0800
+++ sparse/linearize.h	2006-12-19 16:12:49.000000000 -0800
@@ -9,6 +9,15 @@
 struct instruction;
 DECLARE_PTR_LIST(pseudo_ptr_list, pseudo_t);
 
+struct pseudo_user {
+	struct instruction *insn;
+	pseudo_t *userp;
+};
+
+DECLARE_ALLOCATOR(pseudo_user);
+DECLARE_PTR_LIST(pseudo_user_list, struct pseudo_user);
+
+
 enum pseudo_type {
 	PSEUDO_VOID,
 	PSEUDO_REG,
@@ -21,7 +30,7 @@ enum pseudo_type {
 struct pseudo {
 	int nr;
 	enum pseudo_type type;
-	struct pseudo_ptr_list *users;
+	struct pseudo_user_list *users;
 	struct ident *ident;
 	union {
 		struct symbol *sym;
@@ -268,16 +277,29 @@ static inline void add_pseudo_ptr(pseudo
 	add_ptr_list(list, ptr);
 }
 
+static inline void add_pseudo_user_ptr(struct pseudo_user *user, struct pseudo_user_list **list)
+{
+	add_ptr_list(list, user);
+}
+
 static inline int has_use_list(pseudo_t p)
 {
 	return (p && p->type != PSEUDO_VOID && p->type != PSEUDO_VAL);
 }
 
-static inline void use_pseudo(pseudo_t p, pseudo_t *pp)
+static inline struct pseudo_user* alloc_pseudo_user(struct instruction *insn, pseudo_t *pp)
+{
+	struct pseudo_user *user = __alloc_pseudo_user(0);
+	user->userp = pp;
+	user->insn = insn;
+	return user;
+}
+
+static inline void use_pseudo(struct instruction *insn, pseudo_t p, pseudo_t *pp)
 {
 	*pp = p;
 	if (has_use_list(p))
-		add_pseudo_ptr(pp, &p->users);
+		add_pseudo_user_ptr(alloc_pseudo_user(insn, pp), &p->users);
 }
 
 static inline void remove_bb_from_list(struct basic_block_list **list, struct basic_block *entry, int count)
Index: sparse/linearize.c
===================================================================
--- sparse.orig/linearize.c	2006-12-18 13:58:01.000000000 -0800
+++ sparse/linearize.c	2006-12-19 16:13:29.000000000 -0800
@@ -37,6 +37,8 @@ struct pseudo void_pseudo = {};
 
 static struct position current_pos;
 
+ALLOCATOR(pseudo_user, "pseudo_user");
+
 static struct instruction *alloc_instruction(int opcode, int size)
 {
 	struct instruction * insn = __alloc_instruction(0);
@@ -517,12 +519,12 @@ void show_bb(struct basic_block *bb)
 
 static void show_symbol_usage(pseudo_t pseudo)
 {
+	struct pseudo_user *pu;
+
 	if (pseudo) {
-		pseudo_t *pp;
-		FOR_EACH_PTR(pseudo->users, pp) {
-			struct instruction *insn = container(pp, struct instruction, src);
-			printf("\t%s\n", show_instruction(insn));
-		} END_FOR_EACH_PTR(pp);
+		FOR_EACH_PTR(pseudo->users, pu) {
+			printf("\t%s\n", show_instruction(pu->insn));
+		} END_FOR_EACH_PTR(pu);
 	}
 }
 
@@ -667,15 +669,15 @@ void insert_select(struct basic_block *b
 	select->bb = bb;
 
 	assert(br->cond);
-	use_pseudo(br->cond, &select->src1);
+	use_pseudo(select, br->cond, &select->src1);
 
 	target = phi_node->target;
 	assert(target->def == phi_node);
 	select->target = target;
 	target->def = select;
 
-	use_pseudo(true, &select->src2);
-	use_pseudo(false, &select->src3);
+	use_pseudo(select, true, &select->src2);
+	use_pseudo(select, false, &select->src3);
 
 	add_instruction(&bb->insns, select);
 	add_instruction(&bb->insns, br);
@@ -711,7 +713,7 @@ static void add_branch(struct entrypoint
 
 	if (bb_reachable(bb)) {
        		br = alloc_instruction(OP_BR, 0);
-		use_pseudo(cond, &br->cond);
+		use_pseudo(br, cond, &br->cond);
 		br->bb_true = bb_true;
 		br->bb_false = bb_false;
 		add_bb(&bb_true->parents, bb);
@@ -809,7 +811,7 @@ pseudo_t alloc_phi(struct basic_block *s
 	phi->nr = ++nr;
 	phi->def = insn;
 
-	use_pseudo(pseudo, &insn->phi_src);
+	use_pseudo(insn, pseudo, &insn->phi_src);
 	insn->bb = source;
 	insn->target = phi;
 	add_instruction(&source->insns, insn);
@@ -905,7 +907,7 @@ static pseudo_t add_load(struct entrypoi
 
 	insn->target = new;
 	insn->offset = ad->offset;
-	use_pseudo(ad->address, &insn->src);
+	use_pseudo(insn, ad->address, &insn->src);
 	add_one_insn(ep, insn);
 	return new;
 }
@@ -917,8 +919,8 @@ static void add_store(struct entrypoint 
 	if (bb_reachable(bb)) {
 		struct instruction *store = alloc_typed_instruction(OP_STORE, ad->source_type);
 		store->offset = ad->offset;
-		use_pseudo(value, &store->target);
-		use_pseudo(ad->address, &store->src);
+		use_pseudo(store, value, &store->target);
+		use_pseudo(store, ad->address, &store->src);
 		add_one_insn(ep, store);
 	}
 }
@@ -950,8 +952,8 @@ static pseudo_t add_binary_op(struct ent
 	struct instruction *insn = alloc_typed_instruction(op, ctype);
 	pseudo_t target = alloc_pseudo(insn);
 	insn->target = target;
-	use_pseudo(left, &insn->src1);
-	use_pseudo(right, &insn->src2);
+	use_pseudo(insn, left, &insn->src1);
+	use_pseudo(insn, right, &insn->src2);
 	add_one_insn(ep, insn);
 	return target;
 }
@@ -972,7 +974,7 @@ static pseudo_t add_symbol_address(struc
 	pseudo_t target = alloc_pseudo(insn);
 
 	insn->target = target;
-	use_pseudo(symbol_pseudo(ep, sym), &insn->symbol);
+	use_pseudo(insn, symbol_pseudo(ep, sym), &insn->symbol);
 	add_one_insn(ep, insn);
 	return target;
 }
@@ -1026,7 +1028,7 @@ static pseudo_t add_uniop(struct entrypo
 	pseudo_t new = alloc_pseudo(insn);
 
 	insn->target = new;
-	use_pseudo(src, &insn->src1);
+	use_pseudo(insn, src, &insn->src1);
 	add_one_insn(ep, insn);
 	return new;
 }
@@ -1040,7 +1042,7 @@ static pseudo_t linearize_slice(struct e
 	insn->target = new;
 	insn->from = expr->r_bitpos;
 	insn->len = expr->r_nrbits;
-	use_pseudo(pre, &insn->base);
+	use_pseudo(insn, pre, &insn->base);
 	add_one_insn(ep, insn);
 	return new;
 }
@@ -1122,7 +1124,7 @@ static pseudo_t cast_pseudo(struct entry
 	result = alloc_pseudo(insn);
 	insn->target = result;
 	insn->orig_type = from;
-	use_pseudo(src, &insn->src);
+	use_pseudo(insn, src, &insn->src);
 	add_one_insn(ep, insn);
 	return result;
 }
@@ -1193,7 +1195,7 @@ static pseudo_t linearize_call_expressio
 
 	FOR_EACH_PTR(expr->args, arg) {
 		pseudo_t new = linearize_expression(ep, arg);
-		use_pseudo(new, add_pseudo(&insn->arguments, new));
+		use_pseudo(insn, new, add_pseudo(&insn->arguments, new));
 	} END_FOR_EACH_PTR(arg);
 
 	fn = expr->fn;
@@ -1213,7 +1215,7 @@ static pseudo_t linearize_call_expressio
 	} else {
 		call = linearize_expression(ep, fn);
 	}
-	use_pseudo(call, &insn->func);
+	use_pseudo(insn, call, &insn->func);
 	retval = VOID;
 	if (expr->ctype != &void_ctype)
 		retval = alloc_pseudo(insn);
@@ -1286,9 +1288,9 @@ static pseudo_t linearize_select(struct 
 	insn = alloc_typed_instruction(OP_SEL, expr->ctype);
 	if (!expr->cond_true)
 		true = cond;
-	use_pseudo(cond, &insn->src1);
-	use_pseudo(true, &insn->src2);
-	use_pseudo(false, &insn->src3);
+	use_pseudo(insn, cond, &insn->src1);
+	use_pseudo(insn, true, &insn->src2);
+	use_pseudo(insn, false, &insn->src3);
 
 	res = alloc_pseudo(insn);
 	insn->target = res;
@@ -1308,8 +1310,8 @@ static pseudo_t add_join_conditional(str
 		return phi1;
 
 	phi_node = alloc_typed_instruction(OP_PHI, expr->ctype);
-	use_pseudo(phi1, add_pseudo(&phi_node->phi_list, phi1));
-	use_pseudo(phi2, add_pseudo(&phi_node->phi_list, phi2));
+	use_pseudo(phi_node, phi1, add_pseudo(&phi_node->phi_list, phi1));
+	use_pseudo(phi_node, phi2, add_pseudo(&phi_node->phi_list, phi2));
 	phi_node->target = target = alloc_pseudo(phi_node);
 	add_one_insn(ep, phi_node);
 	return target;
@@ -1652,9 +1654,9 @@ static pseudo_t linearize_range(struct e
 {
 	struct instruction *insn = alloc_instruction(OP_RANGE, 0);
 
-	use_pseudo(linearize_expression(ep, stmt->range_expression), &insn->src1);
-	use_pseudo(linearize_expression(ep, stmt->range_low), &insn->src2);
-	use_pseudo(linearize_expression(ep, stmt->range_high), &insn->src3);
+	use_pseudo(insn, linearize_expression(ep, stmt->range_expression), &insn->src1);
+	use_pseudo(insn, linearize_expression(ep, stmt->range_low), &insn->src2);
+	use_pseudo(insn, linearize_expression(ep, stmt->range_high), &insn->src3);
 	add_one_insn(ep, insn);
 	return VOID;
 }
@@ -1670,7 +1672,7 @@ static void add_asm_input(struct entrypo
 
 	rule->ident = ident;
 	rule->constraint = constraint;
-	use_pseudo(pseudo, &rule->pseudo);
+	use_pseudo(insn, pseudo, &rule->pseudo);
 	add_ptr_list(&insn->asm_rules->inputs, rule);
 }
 
@@ -1688,7 +1690,7 @@ static void add_asm_output(struct entryp
 	rule = __alloc_asm_constraint(0);
 	rule->ident = ident;
 	rule->constraint = constraint;
-	use_pseudo(pseudo, &rule->pseudo);
+	use_pseudo(insn, pseudo, &rule->pseudo);
 	add_ptr_list(&insn->asm_rules->outputs, rule);
 }
 
@@ -1847,7 +1849,7 @@ pseudo_t linearize_statement(struct entr
 			}
 			phi = alloc_phi(active, src, type_size(expr->ctype));
 			phi->ident = &return_ident;
-			use_pseudo(phi, add_pseudo(&phi_node->phi_list, phi));
+			use_pseudo(phi_node, phi, add_pseudo(&phi_node->phi_list, phi));
 		}
 		add_goto(ep, bb_return);
 		return VOID;
@@ -1897,7 +1899,7 @@ pseudo_t linearize_statement(struct entr
 
 		pseudo = linearize_expression(ep, expr);
 		goto_ins = alloc_instruction(OP_COMPUTEDGOTO, 0);
-		use_pseudo(pseudo, &goto_ins->target);
+		use_pseudo(goto_ins, pseudo, &goto_ins->target);
 		add_one_insn(ep, goto_ins);
 
 		FOR_EACH_PTR(stmt->target_list, sym) {
@@ -1956,7 +1958,7 @@ pseudo_t linearize_statement(struct entr
 			break;
 
 		switch_ins = alloc_instruction(OP_SWITCH, 0);
-		use_pseudo(pseudo, &switch_ins->cond);
+		use_pseudo(switch_ins, pseudo, &switch_ins->cond);
 		add_one_insn(ep, switch_ins);
 		finish_block(ep);
 
@@ -2086,7 +2088,7 @@ static struct entrypoint *linearize_fn(s
 		struct instruction *insn = alloc_typed_instruction(OP_RET, ret_type);
 
 		if (type_size(ret_type) > 0)
-			use_pseudo(result, &insn->src);
+			use_pseudo(insn, result, &insn->src);
 		add_one_insn(ep, insn);
 	}
 
