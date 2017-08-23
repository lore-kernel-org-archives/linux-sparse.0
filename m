From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 02/48] remove trivial phi-nodes during clean_up_phi()
Date: Wed, 23 Aug 2017 22:15:08 +0200
Message-ID: <20170823201554.90551-3-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36802 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932443AbdHWUQG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id f127so639315wmf.3
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:06 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In a set of related phi-nodes and phi-sources
if all phi-sources but one correspond to the target of one
of the phi-sources, then no phi-nodes is needed and all
%phis can be replaced by the unique source.
For example, if we have something like:
	foo:
		phisrc.32   %phi1 <- %arg1
		br          .L1
	.L1:
		phi.32      %r2 <- %phi1, %phi2
		phisrc.32   %phi2 <- %r2
		...
we can see that %phi2 is the target of the phi-node that use it
thus neither %phi2 nor %r2 are completly inter-dependent and the
only true soure is %arg1. In this case %r2 can be replaced by
%arg1 and the phi-node can be removed as well as its phi-sources.

There are also more complex cases with several inter-related
phi-nodes, the source of a phi-node being defined by another
phi-node. Like for the simple case, if there is only a single
independent source, all the related phi-nodes can be replaced by
this unique true source and the the phi-sources can be removed.

Removing these trivial phi-nodes will usually trigger other
simplifications, especially those concerning the CFG.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                      | 56 ++++++++++++++++++++++++++++-------------
 validation/optim/trivial-phis.c | 15 +++++++++++
 2 files changed, 54 insertions(+), 17 deletions(-)
 create mode 100644 validation/optim/trivial-phis.c

diff --git a/simplify.c b/simplify.c
index 2bc86f53e..766ac451d 100644
--- a/simplify.c
+++ b/simplify.c
@@ -133,37 +133,59 @@ static int if_convert_phi(struct instruction *insn)
 	return REPEAT_CSE;
 }
 
-static int clean_up_phi(struct instruction *insn)
+static int trivial_phi(pseudo_t *same, struct instruction *insn, struct pseudo_list **list)
 {
+	pseudo_t target = insn->target;
 	pseudo_t phi;
-	struct instruction *last;
-	int same;
 
-	last = NULL;
-	same = 1;
+	assert(insn->opcode == OP_PHI);
+
+	if (pseudo_in_list(*list, target))
+		return 1;
+	add_pseudo(list, target);
+
 	FOR_EACH_PTR(insn->phi_list, phi) {
 		struct instruction *def;
+		pseudo_t src;
+
 		if (phi == VOID)
 			continue;
 		def = phi->def;
-		if (def->src1 == VOID || !def->bb)
+		assert(def->bb);
+		if (!def->bb)
 			continue;
-		if (last) {
-			if (last->src1 != def->src1)
-				same = 0;
+
+		src = def->src;	// bypass OP_PHISRC & get the real source
+
+		if (src == VOID || src == target || src == *same)
+			continue;
+		if (!*same) {
+			*same = src;
 			continue;
 		}
-		last = def;
+		if (src->type == PSEUDO_REG && src->def->opcode == OP_PHI) {
+			if (trivial_phi(same, src->def, list))
+				continue;
+		}
+		return 0;
 	} END_FOR_EACH_PTR(phi);
 
-	if (same) {
-		pseudo_t pseudo = last ? last->src1 : VOID;
-		convert_instruction_target(insn, pseudo);
-		kill_instruction(insn);
-		return REPEAT_CSE;
-	}
+	return 1;
+}
+
+static int clean_up_phi(struct instruction *insn)
+{
+	struct pseudo_list *list = NULL;
+	pseudo_t same = NULL;
+
+	if (!trivial_phi(&same, insn, &list))
+		return if_convert_phi(insn);
 
-	return if_convert_phi(insn);
+	if (!same)
+		same = VOID;
+	convert_instruction_target(insn, same);
+	kill_instruction(insn);
+	return REPEAT_CSE;
 }
 
 static int delete_pseudo_user_list_entry(struct pseudo_user_list **list, pseudo_t *entry, int count)
diff --git a/validation/optim/trivial-phis.c b/validation/optim/trivial-phis.c
new file mode 100644
index 000000000..9cb9a2c78
--- /dev/null
+++ b/validation/optim/trivial-phis.c
@@ -0,0 +1,15 @@
+void foo(int *p)
+{
+	int a = *p;
+	while (1)
+		a ^= 0;
+}
+
+/*
+ * check-name: trivial phis
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ * check-output-excludes: phi\\.
+ * check-output-excludes: phisrc\\.
+ * check-output-end
+ */
-- 
2.14.0

