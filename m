From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 3/7] fix BB dependencies on phi-nodes
Date: Mon, 31 Jul 2017 22:36:20 +0200
Message-ID: <20170731203624.58971-4-luc.vanoostenryck@gmail.com>
References: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36314 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdGaUgh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 16:36:37 -0400
Received: by mail-wr0-f195.google.com with SMTP id y67so31687037wrb.3
        for <linux-sparse@vger.kernel.org>; Mon, 31 Jul 2017 13:36:36 -0700 (PDT)
In-Reply-To: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Michael Stefaniuc <mstefani@mykolab.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Simplification of BBs (via try_to_siplify_bb() or
simplify_branch_branch()) can only be done under
some conditions:
- the removed/bypassed BB is free of side-effects
- the removed/bypassed BB doesn't define some pseudos
  needed later.
This last check is efficiently done by bb_depends_on()
using liveness info. However, there is no liveness
done on OP_PHI thus the dependencies involving OP_PHI
are missing, resulting in illegal simplifications.

Fix this by explicitly adding the missing dependencies.

Supersedes: 852801f8b966407544326cd1c485f9bc7681a2e6
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/flow.c b/flow.c
index 536bf257f..23fa7c21b 100644
--- a/flow.c
+++ b/flow.c
@@ -81,26 +81,23 @@ static int bb_depends_on(struct basic_block *target, struct basic_block *src)
 }
 
 /*
- * This is only to be used by try_to_simplify_bb().
- * It really should be handled by bb_depends_on(), only
- * that there is no liveness done on OP_PHI/OP_PHISRC.
- * So we consider for now that if there is an OP_PHI
- * then some block in fact depends on this one.
- * The OP_PHI controling the conditional branch of this bb
- * is excluded since the branch will be removed.
+ * This really should be handled by bb_depends_on()
+ * which efficiently check the dependence using the
+ * defines - needs liveness info. Problem is that
+ * there is no liveness done on OP_PHI & OP_PHISRC.
+ *
+ * This function add the missing dependency checks.
  */
-static int bb_defines_phi(struct basic_block *bb, struct instruction *def)
+static int bb_depends_on_phi(struct basic_block *target, struct basic_block *src)
 {
 	struct instruction *insn;
-	FOR_EACH_PTR(bb->insns, insn) {
-		switch (insn->opcode) {
-		case OP_PHI:
-			if (def && insn != def)
-				return 1;
+	FOR_EACH_PTR(src->insns, insn) {
+		if (!insn->bb)
 			continue;
-		default:
+		if (insn->opcode != OP_PHI)
 			continue;
-		}
+		if (pseudo_in_list(target->needs, insn->target))
+			return 1;
 	} END_FOR_EACH_PTR(insn);
 	return 0;
 }
@@ -153,7 +150,7 @@ static int try_to_simplify_bb(struct basic_block *bb, struct instruction *first,
 		target = true ? second->bb_true : second->bb_false;
 		if (bb_depends_on(target, bb))
 			continue;
-		if (bb_defines_phi(bb, first))
+		if (bb_depends_on_phi(target, bb))
 			continue;
 		changed |= rewrite_branch(source, &br->bb_true, bb, target);
 		changed |= rewrite_branch(source, &br->bb_false, bb, target);
@@ -224,6 +221,8 @@ static int simplify_branch_branch(struct basic_block *bb, struct instruction *br
 		goto try_to_rewrite_target;
 	if (bb_depends_on(final, target))
 		goto try_to_rewrite_target;
+	if (bb_depends_on_phi(final, target))
+		return 0;
 	return rewrite_branch(bb, target_p, target, final);
 
 try_to_rewrite_target:
-- 
2.13.2

