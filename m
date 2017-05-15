From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix: kill old branch in insert_branch()
Date: Mon, 15 May 2017 16:31:13 +0200
Message-ID: <20170515143113.11782-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34629 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933222AbdEOOdT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 15 May 2017 10:33:19 -0400
Received: by mail-qk0-f195.google.com with SMTP id u75so17397586qka.1
        for <linux-sparse@vger.kernel.org>; Mon, 15 May 2017 07:33:19 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

insert_branch() is called after an optimization has detected
an opportunity to convert a switch or a conditional branch
into an unconditional branch (for example because the condition
is a constant). It does this by removing the BB's last instruction
and then allocate a new unconditional branch which is added at
the end of the BB. The old instruction is simply discarded.
Since the discarded instruction is one with a condition we must
insure that the associated usage is also removed (for example,
by calling kill_instruction()).

But currently kill_instruction() is called, just after the call
to insert_branch(), only at a single place. The 4 other places where
insert_branch() is called do nothing with the removed instruction
and it's condition's usage. As consequence, instructions that are
dead are not removed since it still wrongly has an user.

Fix this by adding a call to kill_instruction() in insert_branch()
itself (and make the function description more exact).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                          |  1 -
 linearize.c                     |  3 ++-
 validation/kill-insert-branch.c | 22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)
 create mode 100644 validation/kill-insert-branch.c

diff --git a/flow.c b/flow.c
index 09c9b8075..20031a9d5 100644
--- a/flow.c
+++ b/flow.c
@@ -226,7 +226,6 @@ try_to_rewrite_target:
 	if (bb_list_size(target->parents) != 1)
 		return retval;
 	insert_branch(target, insn, final);
-	kill_instruction(insn);
 	return 1;
 }
 
diff --git a/linearize.c b/linearize.c
index a36ab48c3..889483d28 100644
--- a/linearize.c
+++ b/linearize.c
@@ -646,7 +646,7 @@ static void remove_parent(struct basic_block *child, struct basic_block *parent)
 		repeat_phase |= REPEAT_CFG_CLEANUP;
 }
 
-/* Change a "switch" into a branch */
+/* Change a "switch" or a conditional branch into a branch */
 void insert_branch(struct basic_block *bb, struct instruction *jmp, struct basic_block *target)
 {
 	struct instruction *br, *old;
@@ -655,6 +655,7 @@ void insert_branch(struct basic_block *bb, struct instruction *jmp, struct basic
 	/* Remove the switch */
 	old = delete_last_instruction(&bb->insns);
 	assert(old == jmp);
+	kill_instruction(old);
 
 	br = alloc_instruction(OP_BR, 0);
 	br->bb = bb;
diff --git a/validation/kill-insert-branch.c b/validation/kill-insert-branch.c
new file mode 100644
index 000000000..e59b5bbcd
--- /dev/null
+++ b/validation/kill-insert-branch.c
@@ -0,0 +1,22 @@
+void foo(int a)
+{
+	int b = 1;
+	if (a)
+		b++;
+	if (b)
+		;
+}
+
+void bar(int a)
+{
+	if (a ? 1 : 2)
+		;
+}
+
+/*
+ * check-name: kill insert-branch
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: select\\.
+ */
-- 
2.12.2

