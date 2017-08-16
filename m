From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 26/29] sssa: protect against unreachable loops
Date: Wed, 16 Aug 2017 17:34:52 +0200
Message-ID: <20170816153455.97693-27-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37194 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbdHPPfy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:54 -0400
Received: by mail-wr0-f194.google.com with SMTP id z91so651928wrc.4
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:53 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

If unreachable loops are somehow presetn at the moment
we're doing a lookup things can turn into infinite loops.
Protect us agaisnt this by using the classic 'generation'
counter to detech any cycle and take the appropriate actions.

Note: reachable loops don't need this protection since
      at least one node will have more than 1 parent.
Note: how libfirm handle this? By adding keep-alive edge
      (to keep endless loops to be observable)?

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ssa.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/ssa.c b/ssa.c
index 7950ffeaf..9d532dbf6 100644
--- a/ssa.c
+++ b/ssa.c
@@ -13,7 +13,7 @@
 #include <assert.h>
 
 
-static pseudo_t load_var_(struct basic_block*, struct symbol*);
+static pseudo_t load_var_(struct basic_block*, struct symbol*, unsigned long);
 
 
 // FIXME: -> common file
@@ -25,13 +25,13 @@ static void append_instruction(struct basic_block *bb, struct instruction *insn)
 	add_instruction(&bb->insns, br);
 }
 
-static pseudo_t add_phi_operand(struct symbol *var, pseudo_t phi)
+static pseudo_t add_phi_operand(struct symbol *var, pseudo_t phi, unsigned long generation)
 {
 	struct instruction *node = phi->def;
 	struct basic_block *parent;
 
 	FOR_EACH_PTR(node->bb->parents, parent) {
-		pseudo_t val = load_var_(parent, var);
+		pseudo_t val = load_var_(parent, var, generation);
 		struct instruction *phisrc = alloc_phisrc(val, var);
 		pseudo_t src = phisrc->target;
 		append_instruction(parent, phisrc);
@@ -41,9 +41,10 @@ static pseudo_t add_phi_operand(struct symbol *var, pseudo_t phi)
 	return phi;
 }
 
-static pseudo_t load_var_(struct basic_block *bb, struct symbol *var)
+static pseudo_t load_var_(struct basic_block *bb, struct symbol *var, unsigned long generation)
 {
 	pseudo_t val = phi_map_lookup(var->phi_map, bb);
+	unsigned long bbgen = bb->generation;
 
 	if (val) {
 		while (val->type == PSEUDO_INDIR)
@@ -62,14 +63,19 @@ static pseudo_t load_var_(struct basic_block *bb, struct symbol *var)
 	case 0:	// never defined
 		val = undef_pseudo();
 		break;
-	case 1: // no phi needed
-		val = load_var_(first_basic_block(bb->parents), var);
+	case 1:
+		if (bbgen == generation)
+			goto cycle;
+		bb->generation = generation;
+		// no phi needed
+		val = load_var_(first_basic_block(bb->parents), var, generation);
 		break;
 	default:
+	cycle:
 		val = insert_phi_node(bb, var);
 		val->ident = var->ident;
 		store_var(bb, var, val);
-		val = add_phi_operand(var, val);
+		val = add_phi_operand(var, val, generation);
 	}
 
 out:
@@ -80,7 +86,7 @@ out:
 
 pseudo_t load_var(struct basic_block *bb, struct symbol *var)
 {
-	return load_var_(bb, var);
+	return load_var_(bb, var, ++bb_generation);
 }
 
 void store_var(struct basic_block *bb, struct symbol *var, pseudo_t val)
@@ -102,7 +108,7 @@ void seal_bb(struct basic_block *bb)
 		var = insn->var;
 		assert(var);
 		insn->var = NULL;
-		add_phi_operand(var, insn->target);
+		add_phi_operand(var, insn->target, ++bb_generation);
 	} END_FOR_EACH_PTR(insn);
 	bb->sealed = 1;
 }
-- 
2.14.0

