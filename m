From: David Holmer <odinguru@gmail.com>
Subject: [PATCH] Fix context checking detection of a reversed lock-pair within a basic block
Date: Tue, 17 Nov 2015 12:17:58 -0500
Message-ID: <1447780678-7431-1-git-send-email-odinguru@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:35036 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbbKQRSc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 17 Nov 2015 12:18:32 -0500
Received: by ykba77 with SMTP id a77so17271665ykb.2
        for <linux-sparse@vger.kernel.org>; Tue, 17 Nov 2015 09:18:32 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: David Holmer <odinguru@gmail.com>

This commit adds a new validation test case with a simple lock context
issue that was not previously caught by sparse. This test case is a simple
"reversed" lock pair (unlock/lock instead of lock/unlock):
+static void warn_reverse(void)
+{
+    r();
+    a();
+}

Previously, sparse would not flag this context imbalance because it happens
WITHIN a single basic block and imbalance checking was only done at the
boundaries of basic blocks. In this case, the lock following the unlock
results in a net context change of zero for this basic block, so checking
only at the boundaries of basic blocks is insufficient.

Primarily, this commit moves the checking for "unexpected unlock" inside
the context_increase function where it can correctly detect the new test
case as well as all other existing test cases.

In order to accommodate the primary change, some additional ancillary
changes are made:
* The entry point is added as an argument to context_increase() so that it
  can be passed to imbalance() if needed.
* The two arguments entry and exit are removed from imbalance() as they are
  currently unused in the function and it simplifies calling it in the new
  location (all call sites of imbalance() are changed).
* A prototype for imbalance() is added at top of the file as a call is now
  made before the function is defined.

Signed-off-by: David Holmer <odinguru@gmail.com>
---
 sparse.c             | 19 ++++++++++++-------
 validation/context.c |  8 ++++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/sparse.c b/sparse.c
index 6b3324c..85b92e9 100644
--- a/sparse.c
+++ b/sparse.c
@@ -40,7 +40,9 @@
 #include "expression.h"
 #include "linearize.h"
 
-static int context_increase(struct basic_block *bb, int entry)
+static int imbalance(struct entrypoint *ep, struct basic_block *bb, const char *why);
+
+static int context_increase(struct entrypoint *ep, struct basic_block *bb, int entry)
 {
 	int sum = 0;
 	struct instruction *insn;
@@ -61,11 +63,15 @@ static int context_increase(struct basic_block *bb, int entry)
 			continue;
 		}
 		sum += val;
+		if (entry + sum < 0) {
+			imbalance(ep, bb, "unexpected unlock");
+			return sum;
+		}
 	} END_FOR_EACH_PTR(insn);
 	return sum;
 }
 
-static int imbalance(struct entrypoint *ep, struct basic_block *bb, int entry, int exit, const char *why)
+static int imbalance(struct entrypoint *ep, struct basic_block *bb, const char *why)
 {
 	if (Wcontext) {
 		struct symbol *sym = ep->name;
@@ -85,7 +91,7 @@ static int check_children(struct entrypoint *ep, struct basic_block *bb, int ent
 	if (!insn)
 		return 0;
 	if (insn->opcode == OP_RET)
-		return entry != exit ? imbalance(ep, bb, entry, exit, "wrong count at exit") : 0;
+		return entry != exit ? imbalance(ep, bb, "wrong count at exit") : 0;
 
 	FOR_EACH_PTR(bb->children, child) {
 		if (check_bb_context(ep, child, entry, exit))
@@ -103,12 +109,11 @@ static int check_bb_context(struct entrypoint *ep, struct basic_block *bb, int e
 
 	/* Now that's not good.. */
 	if (bb->context >= 0)
-		return imbalance(ep, bb, entry, bb->context, "different lock contexts for basic block");
+		return imbalance(ep, bb, "different lock contexts for basic block");
 
 	bb->context = entry;
-	entry += context_increase(bb, entry);
-	if (entry < 0)
-		return imbalance(ep, bb, entry, exit, "unexpected unlock");
+	entry += context_increase(ep, bb, entry);
+	if (entry < 0) return -1;
 
 	return check_children(ep, bb, entry, exit);
 }
diff --git a/validation/context.c b/validation/context.c
index 33b70b8..c0a5357 100644
--- a/validation/context.c
+++ b/validation/context.c
@@ -314,6 +314,13 @@ static void warn_cond_lock1(void)
         condition2 = 1; /* do stuff */
     r();
 }
+
+static void warn_reverse(void)
+{
+    r();
+    a();
+}
+
 /*
  * check-name: Check -Wcontext
  *
@@ -332,5 +339,6 @@ context.c:274:13: warning: context imbalance in 'warn_goto1' - wrong count at ex
 context.c:283:13: warning: context imbalance in 'warn_goto2' - wrong count at exit
 context.c:300:5: warning: context imbalance in 'warn_goto3' - different lock contexts for basic block
 context.c:315:5: warning: context imbalance in 'warn_cond_lock1' - different lock contexts for basic block
+context.c:318:13: warning: context imbalance in 'warn_reverse' - unexpected unlock
  * check-error-end
  */
-- 
1.9.1

