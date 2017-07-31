From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 1/7] fix ptrlist corruption while killing unreachable BBs
Date: Mon, 31 Jul 2017 22:36:18 +0200
Message-ID: <20170731203624.58971-2-luc.vanoostenryck@gmail.com>
References: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34717 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdGaUge (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 16:36:34 -0400
Received: by mail-wr0-f196.google.com with SMTP id o33so24996048wrb.1
        for <linux-sparse@vger.kernel.org>; Mon, 31 Jul 2017 13:36:34 -0700 (PDT)
In-Reply-To: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Michael Stefaniuc <mstefani@mykolab.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In commit (51cfbc90a5 "fix: kill unreachable BBs after killing a child")
kill_unreachable_bbs() was called during simplification in order
to avoid creating fake cycles between phis and issuing bogus
"crazy programmer" warnings.

However, simplification is done via cse.c:clean_up_insns()
which is looping over all BBs while kill_unreachable_bbs()
loops over all BBs *and* can delete some of them which may
corrupt the looping in clean_up_insns().

Fix this by:
1) refuse to emit the "crazy programmer" warning if there
   is a potential dead BB
2) move kill_unreachable_bbs() in the main cleanup loop
   which will avoid nested ep->bbs loop.

Note: this solution is preferable to some others because
      the "crazy programmer" condition happens very rarely.
      It this thus better to delay this check than to call
      kill_unreachable_bbs() preventively.

Note: the reproducer is one with very broken syntax but nothing
      forbid the same situation to happen with a valid program.

Fixes: 51cfbc90a5e1462fcd624a1598ecd985a508a5d6
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cse.c                       |  2 ++
 flow.c                      |  2 --
 linearize.c                 |  3 ---
 simplify.c                  |  9 +++++++++
 validation/crash-ptrlist.c  | 23 +++++++++++++++++++++++
 validation/crazy02-not-so.c | 18 ++++++++++++++++++
 6 files changed, 52 insertions(+), 5 deletions(-)
 create mode 100644 validation/crash-ptrlist.c

diff --git a/cse.c b/cse.c
index 0d3815c5a..17b3da01a 100644
--- a/cse.c
+++ b/cse.c
@@ -364,6 +364,8 @@ void cleanup_and_cse(struct entrypoint *ep)
 repeat:
 	repeat_phase = 0;
 	clean_up_insns(ep);
+	if (repeat_phase & REPEAT_CFG_CLEANUP)
+		kill_unreachable_bbs(ep);
 	for (i = 0; i < INSN_HASH_SIZE; i++) {
 		struct instruction_list **list = insn_hash_table + i;
 		if (*list) {
diff --git a/flow.c b/flow.c
index c7161d47e..fce8bde21 100644
--- a/flow.c
+++ b/flow.c
@@ -840,8 +840,6 @@ void kill_unreachable_bbs(struct entrypoint *ep)
 		DELETE_CURRENT_PTR(bb);
 	} END_FOR_EACH_PTR(bb);
 	PACK_PTR_LIST(&ep->bbs);
-
-	repeat_phase &= ~REPEAT_CFG_CLEANUP;
 }
 
 static int rewrite_parent_branch(struct basic_block *bb, struct basic_block *old, struct basic_block *new)
diff --git a/linearize.c b/linearize.c
index 7313e72d8..a36720779 100644
--- a/linearize.c
+++ b/linearize.c
@@ -671,9 +671,6 @@ void insert_branch(struct basic_block *bb, struct instruction *jmp, struct basic
 		remove_parent(child, bb);
 	} END_FOR_EACH_PTR(child);
 	PACK_PTR_LIST(&bb->children);
-
-	if (repeat_phase & REPEAT_CFG_CLEANUP)
-		kill_unreachable_bbs(bb->ep);
 }
 	
 
diff --git a/simplify.c b/simplify.c
index a141ddd43..03ff9c942 100644
--- a/simplify.c
+++ b/simplify.c
@@ -879,6 +879,15 @@ offset:
 	if (new == orig) {
 		if (new == VOID)
 			return 0;
+		/*
+		 * If some BB have been removed it is possible that this
+		 * memop is in fact part of a dead BB. In this case
+		 * we must not warn since nothing is wrong.
+		 * If not part of a dead BB this will be redone after
+		 * the BBs have been cleaned up.
+		 */
+		if (repeat_phase & REPEAT_CFG_CLEANUP)
+			return 0;
 		new = VOID;
 		warning(insn->pos, "crazy programmer");
 	}
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
diff --git a/validation/crazy02-not-so.c b/validation/crazy02-not-so.c
index fe7133587..19ee25299 100644
--- a/validation/crazy02-not-so.c
+++ b/validation/crazy02-not-so.c
@@ -16,6 +16,24 @@ int foo(int *ptr, int i)
 	return 1;
 }
 
+int bar(int *ptr, int i)
+{
+	int *p;
+
+	switch (i - i) {		// will be optimized to 0
+	case 0:
+		return 0;
+	case 1:				// will be optimized away
+					// p is uninitialized
+		do {			// will be an unreachable loop
+			*p++ = 123;
+		} while (--i);
+		break;
+	}
+
+	return 1;
+}
+
 /*
  * check-name: crazy02-not-so.c
  * check-command: sparse -Wno-decl $file
-- 
2.13.2

