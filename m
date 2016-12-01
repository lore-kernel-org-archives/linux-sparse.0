From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] unssa: simplify rewrite of OP_PHISOURCE
Date: Thu,  1 Dec 2016 16:07:02 +0100
Message-ID: <20161201150705.31590-3-luc.vanoostenryck@gmail.com>
References: <20161201150705.31590-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34705 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932836AbcLAPHW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Dec 2016 10:07:22 -0500
Received: by mail-wm0-f68.google.com with SMTP id g23so34725185wme.1
        for <linux-sparse@vger.kernel.org>; Thu, 01 Dec 2016 07:07:22 -0800 (PST)
In-Reply-To: <20161201150705.31590-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Using the fact that each OP_PHISOURCE is used by a single OP_PHI,
it's easier to rewrite OP_PHISOURCE at the same time as their
associated OP_PHI (because we have access to the new pseudo just created).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 unssa.c | 89 ++++++++++++++++-------------------------------------------------
 1 file changed, 21 insertions(+), 68 deletions(-)

diff --git a/unssa.c b/unssa.c
index 85b1388d..2660e94c 100644
--- a/unssa.c
+++ b/unssa.c
@@ -10,9 +10,9 @@
  *
  * This is similar to the "Sreedhar method I" except that the copies to the
  * temporaries are not placed at the end of the predecessor basic blocks, but
- * at the place where the phi-node operands are defined (the same place where the
- * phisrc were present).
- * Is this a problem? 
+ * at the place where the phi-node operands are defined.
+ * This is particulary easy since these copies are essentialy already present
+ * as the corresponding OP_PHISOURCE.
  *
  * While very simple this method create a lot more copies that really necessary.
  * Ideally, "Sreedhar method III" should be used:
@@ -30,31 +30,35 @@
 #include <assert.h>
 
 
-static void remove_phisrc_defines(struct instruction *phisrc)
-{
-	struct instruction *phi;
-	struct basic_block *bb = phisrc->bb;
-
-	FOR_EACH_PTR(phisrc->phi_users, phi) {
-		remove_pseudo(&bb->defines, phi->target);
-	} END_FOR_EACH_PTR(phi);
-}
-
 static void replace_phi_node(struct instruction *phi)
 {
 	pseudo_t tmp;
+	pseudo_t p;
 
 	tmp = alloc_pseudo(NULL);
 	tmp->type = phi->target->type;
 	tmp->ident = phi->target->ident;
 	tmp->def = NULL;		// defined by all the phisrc
-	
-	track_phi_uses(phi);
 
+	// rewrite all it's phi_src to copy to a new tmp
+	FOR_EACH_PTR(phi->phi_list, p) {
+		struct instruction *def = p->def;
+
+		if (p == VOID)
+			continue;
+
+		assert(def->opcode == OP_PHISOURCE);
+
+		def->opcode = OP_COPY;
+		def->target = tmp;
+	} END_FOR_EACH_PTR(p);
+
+	// rewrite the phi node:
+	//	phi	%rt, ...
+	// to:
+	//	copy	%rt, %tmp
 	phi->opcode = OP_COPY;
 	use_pseudo(phi, tmp, &phi->src);
-
-	// FIXME: free phi->phi_list;
 }
 
 static void rewrite_phi_bb(struct basic_block *bb)
@@ -73,53 +77,6 @@ static void rewrite_phi_bb(struct basic_block *bb)
 	} END_FOR_EACH_PTR(insn);
 }
 
-static void rewrite_phisrc_bb(struct basic_block *bb)
-{
-	struct instruction *insn;
-
-	// Replace all the phisrc by one or several copies to
-	// the temporaries associated to each phi-node it defines.
-	FOR_EACH_PTR_REVERSE(bb->insns, insn) {
-		struct instruction *phi;
-		int i;
-
-		if (!insn->bb)
-			continue;
-		if (insn->opcode != OP_PHISOURCE)
-			continue;
-
-		i = 0;
-		FOR_EACH_PTR(insn->phi_users, phi) {
-			pseudo_t tmp = phi->src;
-			pseudo_t src = insn->phi_src;
-
-			if (i == 0) {	// first phi: we overwrite the phisrc
-				insn->opcode = OP_COPY;
-				insn->target = tmp;
-				insn->src = src;
-			} else {
-				struct instruction *copy = __alloc_instruction(0);
-
-				copy->bb = bb;
-				copy->opcode = OP_COPY;
-				copy->size = insn->size;
-				copy->pos = insn->pos;
-				copy->target = tmp;
-				copy->src = src;
-
-				INSERT_CURRENT(copy, insn);
-			}
-			// update the liveness info
-			remove_phisrc_defines(insn);
-			// FIXME: should really something like add_pseudo_exclusive()
-			add_pseudo(&bb->defines, tmp);
-
-			i++;
-		} END_FOR_EACH_PTR(phi);
-
-	} END_FOR_EACH_PTR_REVERSE(insn);
-}
-
 int unssa(struct entrypoint *ep)
 {
 	struct basic_block *bb;
@@ -128,9 +85,5 @@ int unssa(struct entrypoint *ep)
 		rewrite_phi_bb(bb);
 	} END_FOR_EACH_PTR(bb);
 
-	FOR_EACH_PTR(ep->bbs, bb) {
-		rewrite_phisrc_bb(bb);
-	} END_FOR_EACH_PTR(bb);
