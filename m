From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix missing checks for deleted instructions
Date: Sun, 11 Feb 2018 10:21:04 +0100
Message-ID: <20180211092104.6703-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53718 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeBKJVM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 11 Feb 2018 04:21:12 -0500
Received: by mail-wm0-f68.google.com with SMTP id t74so4570744wme.3
        for <linux-sparse@vger.kernel.org>; Sun, 11 Feb 2018 01:21:12 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Instructions with a null ->bb are instructions which have
been killed. As such, they must thus always be ignored
but it's not always the case.

Fix this by adding a check for null ->bb where there is
some looping over all the instructions of a basic block.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                           | 20 ++++++++++++++++----
 validation/mem2reg/killed-insn.c | 15 +++++++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)
 create mode 100644 validation/mem2reg/killed-insn.c

diff --git a/flow.c b/flow.c
index e4c881d56..62658b920 100644
--- a/flow.c
+++ b/flow.c
@@ -164,6 +164,8 @@ static int bb_has_side_effects(struct basic_block *bb)
 {
 	struct instruction *insn;
 	FOR_EACH_PTR(bb->insns, insn) {
+		if (!insn->bb)
+			continue;
 		switch (insn->opcode) {
 		case OP_CALL:
 			/* FIXME! This should take "const" etc into account */
@@ -396,6 +398,8 @@ static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
 
 		FOR_EACH_PTR_REVERSE(parent->insns, one) {
 			int dominance;
+			if (!one->bb)
+				continue;
 			if (one == insn)
 				goto no_dominance;
 			dominance = dominates(pseudo, insn, one, local);
@@ -484,6 +488,8 @@ static int find_dominating_stores(pseudo_t pseudo, struct instruction *insn,
 	partial = 0;
 	FOR_EACH_PTR(bb->insns, one) {
 		int dominance;
+		if (!one->bb)
+			continue;
 		if (one == insn)
 			goto found;
 		dominance = dominates(pseudo, insn, one, local);
@@ -559,6 +565,8 @@ static void kill_dead_stores(pseudo_t pseudo, unsigned long generation, struct b
 	FOR_EACH_PTR_REVERSE(bb->insns, insn) {
 		int opcode = insn->opcode;
 
+		if (!insn->bb)
+			continue;
 		if (opcode != OP_LOAD && opcode != OP_STORE) {
 			if (local)
 				continue;
@@ -608,6 +616,8 @@ static void kill_dominated_stores(pseudo_t pseudo, struct instruction *insn,
 	bb->generation = generation;
 	FOR_EACH_PTR_REVERSE(bb->insns, one) {
 		int dominance;
+		if (!one->bb)
+			continue;
 		if (!found) {
 			if (one != insn)
 				continue;
@@ -777,6 +787,8 @@ void kill_bb(struct basic_block *bb)
 	struct basic_block *child, *parent;
 
 	FOR_EACH_PTR(bb->insns, insn) {
+		if (!insn->bb)
+			continue;
 		kill_instruction_force(insn);
 		kill_defs(insn);
 		/*
@@ -1022,10 +1034,10 @@ out:
 
 		kill_instruction(delete_last_instruction(&parent->insns));
 		FOR_EACH_PTR(bb->insns, insn) {
-			if (insn->bb) {
-				assert(insn->bb == bb);
-				insn->bb = parent;
-			}
+			if (!insn->bb)
+				continue;
+			assert(insn->bb == bb);
+			insn->bb = parent;
 			add_instruction(&parent->insns, insn);
 		} END_FOR_EACH_PTR(insn);
 		bb->insns = NULL;
diff --git a/validation/mem2reg/killed-insn.c b/validation/mem2reg/killed-insn.c
new file mode 100644
index 000000000..641525d3f
--- /dev/null
+++ b/validation/mem2reg/killed-insn.c
@@ -0,0 +1,15 @@
+static int g;
+static void foo(void)
+{
+	int a[2] = { };
+	a;
+	a[1] = g;
+}
+
+/*
+ * check-name: killed-insn
+ * check-command: test-linearize -fdump-ir=mem2reg $file
+ *
+ * check-output-ignore
+ * check-output-excludes: store\.
+ */
-- 
2.16.0

