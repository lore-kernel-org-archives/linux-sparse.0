From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 40/48] mem2reg: delay the creation of phi-sources
Date: Wed, 23 Aug 2017 22:15:46 +0200
Message-ID: <20170823201554.90551-41-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34975 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWURV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id x79so650135wma.2
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:21 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 67 ++++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/mem2reg.c b/mem2reg.c
index ecda6675f..d0873b051 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -12,38 +12,63 @@
  * We should probably sort the phi list just to make it easier to compare
  * later for equality.
  */
-static void rewrite_load_instruction(struct symbol *sym, struct instruction *insn, struct pseudo_list *dominators)
+static void rewrite_load_instruction(struct symbol *sym, struct instruction *insn,
+	struct basic_block *bb, struct pseudo_list *dominators)
 {
-	pseudo_t new, phi;
+	struct basic_block *parent;
+	struct instruction *node;
+	pseudo_t new, val;
 
 	/*
 	 * Check for somewhat common case of duplicate
 	 * phi nodes.
 	 */
-	new = first_pseudo(dominators)->def->src1;
-	FOR_EACH_PTR(dominators, phi) {
-		if (new != phi->def->src1)
+	new = first_pseudo(dominators);
+	FOR_EACH_PTR(dominators, val) {
+		if (new != val)
 			goto complex_phi;
 		new->ident = new->ident ? : sym->ident;
-	} END_FOR_EACH_PTR(phi);
+	} END_FOR_EACH_PTR(val);
 
 	/*
-	 * All the same pseudo - mark the phi-nodes unused
-	 * and convert the load into a LNOP and replace the
-	 * pseudo.
+	 * All the same pseudo - replace the load by the unique val
 	 */
-	FOR_EACH_PTR(dominators, phi) {
-		kill_instruction(phi->def);
-	} END_FOR_EACH_PTR(phi);
-	convert_load_instruction(insn, new);
-	return;
+	goto convert;
 
 complex_phi:
+	/*
+	 * insert a new phi-node on top and
+	 * insert a phi-src at the end of each parents
+	 */
+	new = insert_phi_node(bb, sym);
+	node = new->def;
+
+	PREPARE_PTR_LIST(bb->parents, parent)
+	FOR_EACH_PTR(dominators, val) {
+		struct instruction *br;
+		pseudo_t src;
+
+		br = delete_last_instruction(&parent->insns);
+		/*
+		 * We could check if br is really a branch
+		 * We could check if the type of val & sym matches
+		 */
+		src = alloc_phi(parent, val, sym);
+		add_instruction(&parent->insns, br);
+		use_pseudo(node, src, add_pseudo(&node->phi_list, src));
+
+		NEXT_PTR_LIST(parent);
+	} END_FOR_EACH_PTR(val);
+	FINISH_PTR_LIST(parent);
+
+#if 0	// FIXME
 	/* We leave symbol pseudos with a bogus usage list here */
 	if (insn->src->type != PSEUDO_SYM)
 		kill_use(&insn->src);
-	insn->opcode = OP_PHI;
-	insn->phi_list = dominators;
+#endif
+
+convert:
+	convert_load_instruction(insn, new);
 }
 
 /*
@@ -68,8 +93,6 @@ static int find_dominating_parents(struct symbol *sym, struct instruction *insn,
 
 	FOR_EACH_PTR(bb->parents, parent) {
 		struct instruction *one;
-		struct instruction *br;
-		pseudo_t phi;
 
 		FOR_EACH_PTR_REVERSE(parent->insns, one) {
 			int dominance;
@@ -95,11 +118,7 @@ no_dominance:
 		continue;
 
 found_dominator:
-		br = delete_last_instruction(&parent->insns);
-		phi = alloc_phi(parent, one->target, one->type);
-		phi->ident = phi->ident ? : pseudo->ident;
-		add_instruction(&parent->insns, br);
-		use_pseudo(insn, phi, add_pseudo(dominators, phi));
+		add_pseudo(dominators, one->target);
 	} END_FOR_EACH_PTR(parent);
 	return 1;
 }
@@ -177,7 +196,7 @@ found:
 	 * have to turn the load into a phi-node of the
 	 * dominators.
 	 */
-	rewrite_load_instruction(sym, insn, dominators);
+	rewrite_load_instruction(sym, insn, bb, dominators);
 	return 1;
 }
 
-- 
2.14.0

