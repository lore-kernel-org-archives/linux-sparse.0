From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 29/29] sssa: remove now unneeded simplify_one_symbol()
Date: Wed, 16 Aug 2017 17:34:55 +0200
Message-ID: <20170816153455.97693-30-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35847 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbdHPPgA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:36:00 -0400
Received: by mail-wr0-f194.google.com with SMTP id y67so3695935wrb.3
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:59 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Now that this function is not called anymore, we can
remove the associated code.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 324 -----------------------------------------------------------------
 flow.h |   1 -
 2 files changed, 325 deletions(-)

diff --git a/flow.c b/flow.c
index 78dd6b3a5..58ff24d23 100644
--- a/flow.c
+++ b/flow.c
@@ -362,66 +362,6 @@ int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom
 	return 1;
 }
 
-static int phisrc_in_bb(struct pseudo_list *list, struct basic_block *bb)
-{
-	pseudo_t p;
-	FOR_EACH_PTR(list, p) {
-		if (p->def->bb == bb)
-			return 1;
-	} END_FOR_EACH_PTR(p);
-
-	return 0;
-}
-
-static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
-	struct basic_block *bb, unsigned long generation, struct pseudo_list **dominators,
-	int local)
-{
-	struct basic_block *parent;
-
-	if (!bb->parents)
-		return !!local;
-
-	FOR_EACH_PTR(bb->parents, parent) {
-		struct instruction *one;
-		struct instruction *br;
-		pseudo_t phi;
-
-		FOR_EACH_PTR_REVERSE(parent->insns, one) {
-			int dominance;
-			if (one == insn)
-				goto no_dominance;
-			dominance = dominates(pseudo, insn, one, local);
-			if (dominance < 0) {
-				if (one->opcode == OP_LOAD)
-					continue;
-				return 0;
-			}
-			if (!dominance)
-				continue;
-			goto found_dominator;
-		} END_FOR_EACH_PTR_REVERSE(one);
-no_dominance:
-		if (parent->generation == generation)
-			continue;
-		parent->generation = generation;
-
-		if (!find_dominating_parents(pseudo, insn, parent, generation, dominators, local))
-			return 0;
-		continue;
-
-found_dominator:
-		if (dominators && phisrc_in_bb(*dominators, parent))
-			continue;
-		br = delete_last_instruction(&parent->insns);
-		phi = alloc_phi(parent, one->target, one->type);
-		phi->ident = phi->ident ? : pseudo->ident;
-		add_instruction(&parent->insns, br);
-		use_pseudo(insn, phi, add_pseudo(dominators, phi));
-	} END_FOR_EACH_PTR(parent);
-	return 1;
-}		
-
 /*
  * We should probably sort the phi list just to make it easier to compare
  * later for equality. 
@@ -460,178 +400,6 @@ complex_phi:
 	insn->phi_list = dominators;
 }
 
-static int find_dominating_stores(pseudo_t pseudo, struct instruction *insn,
-	unsigned long generation, int local)
-{
-	struct basic_block *bb = insn->bb;
-	struct instruction *one, *dom = NULL;
-	struct pseudo_list *dominators;
-	int partial;
-
-	/* Unreachable load? Undo it */
-	if (!bb) {
-		insn->opcode = OP_LNOP;
-		return 1;
-	}
-
-	partial = 0;
-	FOR_EACH_PTR(bb->insns, one) {
-		int dominance;
-		if (one == insn)
-			goto found;
-		dominance = dominates(pseudo, insn, one, local);
-		if (dominance < 0) {
-			/* Ignore partial load dominators */
-			if (one->opcode == OP_LOAD)
-				continue;
-			dom = NULL;
-			partial = 1;
-			continue;
-		}
-		if (!dominance)
-			continue;
-		dom = one;
-		partial = 0;
-	} END_FOR_EACH_PTR(one);
-	/* Whaa? */
-	warning(pseudo->sym->pos, "unable to find symbol read");
-	return 0;
-found:
-	if (partial)
-		return 0;
-
-	if (dom) {
-		convert_load_instruction(insn, dom->target);
-		return 1;
-	}
-
-	/* OK, go find the parents */
-	bb->generation = generation;
-
-	dominators = NULL;
-	if (!find_dominating_parents(pseudo, insn, bb, generation, &dominators, local))
-		return 0;
-
-	/* This happens with initial assignments to structures etc.. */
-	if (!dominators) {
-		if (!local)
-			return 0;
-		check_access(insn);
-		convert_load_instruction(insn, value_pseudo(0));
-		return 1;
-	}
-
-	/*
-	 * If we find just one dominating instruction, we
-	 * can turn it into a direct thing. Otherwise we'll
-	 * have to turn the load into a phi-node of the
-	 * dominators.
-	 */
-	rewrite_load_instruction(insn, dominators);
-	return 1;
-}
-
-static void kill_store(struct instruction *insn)
-{
-	if (insn) {
-		insn->bb = NULL;
-		insn->opcode = OP_SNOP;
-		kill_use(&insn->target);
-	}
-}
-
-/* Kill a pseudo that is dead on exit from the bb */
-static void kill_dead_stores(pseudo_t pseudo, unsigned long generation, struct basic_block *bb, int local)
-{
-	struct instruction *insn;
-	struct basic_block *parent;
-
-	if (bb->generation == generation)
-		return;
-	bb->generation = generation;
-	FOR_EACH_PTR_REVERSE(bb->insns, insn) {
-		int opcode = insn->opcode;
-
-		if (opcode != OP_LOAD && opcode != OP_STORE) {
-			if (local)
-				continue;
-			if (opcode == OP_CALL)
-				return;
-			continue;
-		}
-		if (insn->src == pseudo) {
-			if (opcode == OP_LOAD)
-				return;
-			kill_store(insn);
-			continue;
-		}
-		if (local)
-			continue;
-		if (insn->src->type != PSEUDO_SYM)
-			return;
-	} END_FOR_EACH_PTR_REVERSE(insn);
-
-	FOR_EACH_PTR(bb->parents, parent) {
-		struct basic_block *child;
-		FOR_EACH_PTR(parent->children, child) {
-			if (child && child != bb)
-				return;
-		} END_FOR_EACH_PTR(child);
-		kill_dead_stores(pseudo, generation, parent, local);
-	} END_FOR_EACH_PTR(parent);
-}
-
-/*
- * This should see if the "insn" trivially dominates some previous store, and kill the
- * store if unnecessary.
- */
-static void kill_dominated_stores(pseudo_t pseudo, struct instruction *insn, 
-	unsigned long generation, struct basic_block *bb, int local, int found)
-{
-	struct instruction *one;
-	struct basic_block *parent;
-
-	/* Unreachable store? Undo it */
-	if (!bb) {
-		kill_store(insn);
-		return;
-	}
-	if (bb->generation == generation)
-		return;
-	bb->generation = generation;
-	FOR_EACH_PTR_REVERSE(bb->insns, one) {
-		int dominance;
-		if (!found) {
-			if (one != insn)
-				continue;
-			found = 1;
-			continue;
-		}
-		dominance = dominates(pseudo, insn, one, local);
-		if (!dominance)
-			continue;
-		if (dominance < 0)
-			return;
-		if (one->opcode == OP_LOAD)
-			return;
-		kill_store(one);
-	} END_FOR_EACH_PTR_REVERSE(one);
-
-	if (!found) {
-		warning(bb->pos, "Unable to find instruction");
-		return;
-	}
-
-	FOR_EACH_PTR(bb->parents, parent) {
-		struct basic_block *child;
-		FOR_EACH_PTR(parent->children, child) {
-			if (child && child != bb)
-				return;
-		} END_FOR_EACH_PTR(child);
-		kill_dominated_stores(pseudo, insn, generation, parent, local, found);
-	} END_FOR_EACH_PTR(parent);
-}
-
 void check_access(struct instruction *insn)
 {
 	pseudo_t pseudo = insn->src;
@@ -648,98 +416,6 @@ void check_access(struct instruction *insn)
 	}
 }
 
-static void simplify_one_symbol(struct entrypoint *ep, struct symbol *sym)
-{
-	pseudo_t pseudo;
-	struct pseudo_user *pu;
-	unsigned long mod;
-	int all;
-
-	/* Never used as a symbol? */
-	pseudo = sym->pseudo;
-	if (!pseudo)
-		return;
-
-	/* We don't do coverage analysis of volatiles.. */
-	if (sym->ctype.modifiers & MOD_VOLATILE)
-		return;
-
-	/* ..and symbols with external visibility need more care */
-	mod = sym->ctype.modifiers & (MOD_NONLOCAL | MOD_STATIC | MOD_ADDRESSABLE);
-	if (mod)
-		goto external_visibility;
-
-	FOR_EACH_PTR(pseudo->users, pu) {
-		/* We know that the symbol-pseudo use is the "src" in the instruction */
-		struct instruction *insn = pu->insn;
-
-		switch (insn->opcode) {
-		case OP_STORE:
-			break;
-		case OP_LOAD:
-			break;
-		case OP_SYMADDR:
-			if (!insn->bb)
-				continue;
-			mod |= MOD_ADDRESSABLE;
-			goto external_visibility;
-		case OP_NOP:
-		case OP_SNOP:
-		case OP_LNOP:
-		case OP_PHI:
-			continue;
-		default:
-			warning(sym->pos, "symbol '%s' pseudo used in unexpected way", show_ident(sym->ident));
-		}
-	} END_FOR_EACH_PTR(pu);
-
-external_visibility:
-	all = 1;
-	FOR_EACH_PTR_REVERSE(pseudo->users, pu) {
-		struct instruction *insn = pu->insn;
-		if (insn->opcode == OP_LOAD)
-			all &= find_dominating_stores(pseudo, insn, ++bb_generation, !mod);
-	} END_FOR_EACH_PTR_REVERSE(pu);
-
-	/* If we converted all the loads, remove the stores. They are dead */
-	if (all && !mod) {
-		FOR_EACH_PTR(pseudo->users, pu) {
-			struct instruction *insn = pu->insn;
-			if (insn->opcode == OP_STORE)
-				kill_store(insn);
-		} END_FOR_EACH_PTR(pu);
-	} else {
-		/*
-		 * If we couldn't take the shortcut, see if we can at least kill some
-		 * of them..
-		 */
-		FOR_EACH_PTR(pseudo->users, pu) {
-			struct instruction *insn = pu->insn;
-			if (insn->opcode == OP_STORE)
-				kill_dominated_stores(pseudo, insn, ++bb_generation, insn->bb, !mod, 0);
-		} END_FOR_EACH_PTR(pu);
-
-		if (!(mod & (MOD_NONLOCAL | MOD_STATIC))) {
-			struct basic_block *bb;
-			FOR_EACH_PTR(ep->bbs, bb) {
-				if (!bb->children)
-					kill_dead_stores(pseudo, ++bb_generation, bb, !mod);
-			} END_FOR_EACH_PTR(bb);
-		}
-	}
-			
-	return;
-}
-
-void simplify_symbol_usage(struct entrypoint *ep)
-{
-	pseudo_t pseudo;
-
-	FOR_EACH_PTR(ep->accesses, pseudo) {
-		simplify_one_symbol(ep, pseudo->sym);
-	} END_FOR_EACH_PTR(pseudo);
-}
