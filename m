From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2] fix OP_PHI usage in try_to_simplify_bb(), correctly
Date: Sat,  1 Apr 2017 12:16:55 +0200
Message-ID: <20170401101655.28237-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33195 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbdDAKRC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Apr 2017 06:17:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id o81so3158214wmb.0
        for <linux-sparse@vger.kernel.org>; Sat, 01 Apr 2017 03:17:02 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Patch 11b1a83b1 solved an issue with dangling PSEUDO_PHI
by killing it's use after a branch rewrite.

However, the change didn't took in account the fact that,
even after the branch rewrite, some other paths may exist
where this pseudo was needed.

Fix this by cheking that no such path exist before killing
the (usage of the) pseudo.

Fixes: 11b1a83b1 "fix OP_PHI usage in try_to_simplify_bb()"
Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

Changes since v1:
- code cleanup as asked during code review

This patch can also be pulled at:
	git://github.com/lucvoo/sparse.git fix-kill-ttsb-v2
from commit:
	97ebb345943918a0688b62cbc9bf878de01ccba4 (sparse-next-2017-03-07)
up to commit:
	7a0eaa532f289c6a252f30023581f58bae7a446a

 flow.c                       | 30 +++++++++++++++++++++++++++++-
 validation/kill-phi-ttsbb2.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 validation/kill-phi-ttsbb2.c

diff --git a/flow.c b/flow.c
index a5332203f..ff0b598f0 100644
--- a/flow.c
+++ b/flow.c
@@ -79,6 +79,34 @@ static int bb_depends_on(struct basic_block *target, struct basic_block *src)
 	return 0;
 }
 
+/*
+ * Return 1 if 'pseudo' is needed in some parent of 'bb'.
+ * Need liveness info.
+ */
+static int needed_phisrc(struct instruction *phi, struct basic_block *curr, unsigned long generation)
+{
+	pseudo_t target = phi->target;
+	struct basic_block *bb;
+
+	curr->generation = generation;
+	FOR_EACH_PTR(curr->children, bb) {
+		if (bb->generation == generation)
+			continue;
+		if (bb == phi->bb)
+			continue;
+		if (pseudo_in_list(bb->defines, target)) {
+			continue;
+		}
+		if (pseudo_in_list(bb->needs, target))
+			return 1;
+		if (needed_phisrc(phi, bb, generation))
+			return 1;
+
+	} END_FOR_EACH_PTR(bb);
+
+	return 0;
+}
+
 /*
  * When we reach here, we have:
  *  - a basic block that ends in a conditional branch and
@@ -121,7 +149,7 @@ static int try_to_simplify_bb(struct basic_block *bb, struct instruction *first,
 			continue;
 		changed |= rewrite_branch(source, &br->bb_true, bb, target);
 		changed |= rewrite_branch(source, &br->bb_false, bb, target);
-		if (changed)
+		if (changed && !needed_phisrc(first, source, ++bb_generation))
 			kill_use(THIS_ADDRESS(phi));
 	} END_FOR_EACH_PTR(phi);
 	return changed;
diff --git a/validation/kill-phi-ttsbb2.c b/validation/kill-phi-ttsbb2.c
new file mode 100644
index 000000000..c7d89aa0e
--- /dev/null
+++ b/validation/kill-phi-ttsbb2.c
@@ -0,0 +1,40 @@
+extern int error(int);
+
+int foo(int perr);
+int foo(int perr)
+{
+	int err = 0;
+	int rc = 0;
+	int j = 0;
+	int i = 1;
+
+	i && j++;
+
+	i-- && j;
+
+	i && j--;
+
+	if (j != 1) {
+		err = 1;
+		if (perr)
+			error(1);
+	}
+
+	if (err != 0)
+		rc = 1;
+
+	return rc;
+}
+
+/*
+ * check-name: kill-phi-ttsbb2
+ * check-description:
+ *	Verify if OP_PHI usage is adjusted after successful try_to_simplify_bb()
+ * check-warning: this test is sensitive to details of code generation
+ *                with proper bb packing (taking care of phi-nodes) it
+ *		  will be optimized away and test nothing. You have been warned.
+ * check-command: test-linearize $file
+ * check-output-ignore
+ *
+ * check-output-excludes: VOID
+ */
-- 
2.12.0

