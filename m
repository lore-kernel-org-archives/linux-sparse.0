From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] fix OP_PHI usage in try_to_simplify_bb() only when non-bogus
Date: Fri, 16 Jun 2017 21:18:43 +0200
Message-ID: <20170616191844.86256-2-luc.vanoostenryck@gmail.com>
References: <20170616191844.86256-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33638 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdFPTS5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Jun 2017 15:18:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id f90so6629709wmh.0
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jun 2017 12:18:57 -0700 (PDT)
In-Reply-To: <20170616191844.86256-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, sparse method of conversion to SSA form, doesn't
place phi-nodes at the dominance frontier but often place them
'lower' where the corresponding 'value' is needed.
This, in itself create all sort of problems. One of these
problems is that it is then quite common for an OP_PHI
to contains less 'sources' than it has parents. This is wrong
has phi-nodes represent the 'join' a value can have from each
of the incoming paths/parents.

This situation can't be given a sensible semantic and any
attempt to try some optimization involving the phi-nodes and
their sources are bound to fail.

Temporary workaround this in try_to_simplify_bb() by simply
checking if the number of parents and the number of phi-sources
match and avoid to make this simplification if they don't.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/flow.c b/flow.c
index e0932edb4..8a9005aa6 100644
--- a/flow.c
+++ b/flow.c
@@ -79,34 +79,6 @@ static int bb_depends_on(struct basic_block *target, struct basic_block *src)
 	return 0;
 }
 
-/*
- * Return 1 if 'pseudo' is needed in some parent of 'bb'.
- * Need liveness info.
- */
-static int needed_phisrc(struct instruction *phi, struct basic_block *curr, unsigned long generation)
-{
-	pseudo_t target = phi->target;
-	struct basic_block *bb;
-
-	curr->generation = generation;
-	FOR_EACH_PTR(curr->children, bb) {
-		if (bb->generation == generation)
-			continue;
-		if (bb == phi->bb)
-			continue;
-		if (pseudo_in_list(bb->defines, target)) {
-			continue;
-		}
-		if (pseudo_in_list(bb->needs, target))
-			return 1;
-		if (needed_phisrc(phi, bb, generation))
-			return 1;
-
-	} END_FOR_EACH_PTR(bb);
-
-	return 0;
-}
-
 /*
  * When we reach here, we have:
  *  - a basic block that ends in a conditional branch and
@@ -122,6 +94,14 @@ static int try_to_simplify_bb(struct basic_block *bb, struct instruction *first,
 {
 	int changed = 0;
 	pseudo_t phi;
+	int bogus;
+
+	/*
+	 * This a due to improper dominance tracking during
+	 * simplify_symbol_usage()/conversion to SSA form.
+	 * No sane simplification can be done when we have this.
+	 */
+	bogus = bb_list_size(bb->parents) != pseudo_list_size(first->phi_list);
 
 	FOR_EACH_PTR(first->phi_list, phi) {
 		struct instruction *def = phi->def;
@@ -149,7 +129,7 @@ static int try_to_simplify_bb(struct basic_block *bb, struct instruction *first,
 			continue;
 		changed |= rewrite_branch(source, &br->bb_true, bb, target);
 		changed |= rewrite_branch(source, &br->bb_false, bb, target);
-		if (changed && !needed_phisrc(first, source, ++bb_generation))
+		if (changed && !bogus)
 			kill_use(THIS_ADDRESS(phi));
 	} END_FOR_EACH_PTR(phi);
 	return changed;
-- 
2.13.0

