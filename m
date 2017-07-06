From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Thu,  6 Jul 2017 21:19:46 +0200
Message-ID: <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32964 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752788AbdGFTUA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Jul 2017 15:20:00 -0400
Received: by mail-wr0-f195.google.com with SMTP id x23so2620408wrb.0
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 12:19:59 -0700 (PDT)
In-Reply-To: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In commit (51cfbc90a5 "fix: kill unreachable BBs after killing a child")
kill_unreachable_bbs() was called during simplification in order
to avoid creating fake cycles between phis and issuing bogus
"crazy programmer" warnings.

However, simplification is done via cse.c:clean_up_insns()
which is looping over all BBs while kill_unreachable_bbs()
loops over all BBs *and* can delete some of them which may
corrupt the looping in clean_up_insns().

Fix this, by adding a flag to kill_unreachable_bbs(), telling
if it is safe to delete the BBs or if we can just mark them
as unreachable (set bb->ep to NULL and unlink any parent and/or
chilren), in which case the deletion will be done later.

Note: the reproducer is one with very broken syntax but nothing
      seems to forbid the same situation to happen with a valid
      program.

Fixes: 51cfbc90a5e1462fcd624a1598ecd985a508a5d6
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                     |  5 +++--
 flow.h                     |  2 +-
 linearize.c                |  6 +++---
 validation/crash-ptrlist.c | 23 +++++++++++++++++++++++
 4 files changed, 30 insertions(+), 6 deletions(-)
 create mode 100644 validation/crash-ptrlist.c

diff --git a/flow.c b/flow.c
index c7161d47e..3974984de 100644
--- a/flow.c
+++ b/flow.c
@@ -825,7 +825,7 @@ void kill_bb(struct basic_block *bb)
 	bb->parents = NULL;
 }
 
-void kill_unreachable_bbs(struct entrypoint *ep)
+void kill_unreachable_bbs(struct entrypoint *ep, int del)
 {
 	struct basic_block *bb;
 	unsigned long generation = ++bb_generation;
@@ -837,7 +837,8 @@ void kill_unreachable_bbs(struct entrypoint *ep)
 		/* Mark it as being dead */
 		kill_bb(bb);
 		bb->ep = NULL;
-		DELETE_CURRENT_PTR(bb);
+		if (del)
+			DELETE_CURRENT_PTR(bb);
 	} END_FOR_EACH_PTR(bb);
 	PACK_PTR_LIST(&ep->bbs);
 
diff --git a/flow.h b/flow.h
index b592ad4d3..094368fcd 100644
--- a/flow.h
+++ b/flow.h
@@ -24,7 +24,7 @@ extern int simplify_instruction(struct instruction *);
 
 extern void kill_bb(struct basic_block *);
 extern void kill_use(pseudo_t *);
-extern void kill_unreachable_bbs(struct entrypoint *ep);
+extern void kill_unreachable_bbs(struct entrypoint *ep, int del);
 
 extern void kill_insn(struct instruction *, int force);
 static inline void kill_instruction(struct instruction *insn)
diff --git a/linearize.c b/linearize.c
index 7313e72d8..c1ad0c2a4 100644
--- a/linearize.c
+++ b/linearize.c
@@ -673,7 +673,7 @@ void insert_branch(struct basic_block *bb, struct instruction *jmp, struct basic
 	PACK_PTR_LIST(&bb->children);
 
 	if (repeat_phase & REPEAT_CFG_CLEANUP)
-		kill_unreachable_bbs(bb->ep);
+		kill_unreachable_bbs(bb->ep, 0);
 }
 	
 
@@ -2225,7 +2225,7 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 	 * Do trivial flow simplification - branches to
 	 * branches, kill dead basicblocks etc
 	 */
-	kill_unreachable_bbs(ep);
+	kill_unreachable_bbs(ep, 1);
 
 	/*
 	 * Turn symbols into pseudos
@@ -2242,7 +2242,7 @@ repeat:
 		pack_basic_blocks(ep);
 	} while (repeat_phase & REPEAT_CSE);
 
-	kill_unreachable_bbs(ep);
+	kill_unreachable_bbs(ep, 1);
 	vrfy_flow(ep);
 
 	/* Cleanup */
diff --git a/validation/crash-ptrlist.c b/validation/crash-ptrlist.c
new file mode 100644
index 000000000..8e9b5cb5f
--- /dev/null
+++ b/validation/crash-ptrlist.c
@@ -0,0 +1,23 @@
+a;
+char b;
+c() {
+  while () {
+    int *d;
+    while () {
+      char *e = &b;
+      if (a ?: (*d = f || *0) || g) {
+        if
+          ;
+      } else {
+        int h = 0;
+        if (j) {
+          char **i = &e;
+          if (0 ? 0 : 0 ?: (**i = 1 || 0 && 0))             h ?: (*e = i && &h
+
+/*
+ * check-name: crash ptrlist
+ * check-command: test-linearize $file
+ *
+ * check-error-ignore
+ * check-output-ignore
+ */
-- 
2.13.0

