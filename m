From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 16/16] fix OP_PHI usage in try_to_simplify_bb()
Date: Thu, 16 Feb 2017 05:57:08 +0100
Message-ID: <20170216045708.50661-17-luc.vanoostenryck@gmail.com>
References: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34595 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753237AbdBPE5a (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:30 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so1298825wmi.1
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:30 -0800 (PST)
In-Reply-To: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In try_to_simplify_bb(), simplification is attempted when a constant
phisrc whose corresponding phi-node control a conditional branch.
In this case, for the path between the phisrc and the conditional
branch, the following OP_PHI is sort of unneeded since the constant
determine which branch will be taken.

If this simplification can be made, it means that the OP_PHI
doesn't depend anymore on the constant phisrc. In fact the OP_PHI's bb
won't be anymore reachable from the constant phisrc's bb.
But currently, the OP_PHI usage is not adjusted and this leads to all
sort of oddities and causes to miss further simplifications.

The situation can be more concretly seen on test-linearize's output,
here an extract of Linux's kernel/futex.c:get_futex_key().
	.L594:
		...
		br          %r1294, .L651, .L656
	.L651:
		phisrc.32   %phi85 <- $1
		br          .L649
	.L656:
		...
		and.64      %r1340 <- %r1339, $1
		phisrc.32   %phi87 <- %r1340
		phi.32      %r1343 <- %phi85, %phi87
		br          %r1343, .L649, .L648

The constant phisrc is %phi85 in .L651, the OP_PHI and the conditional
branch are .L656's last instructions (which have been packed with its
now unique parent which is sign of a problem). One can see that the
OP_PHi seems to depend on %phi85 (it's in its phi_list) but in fact
depends only on %phi87 (.L656 can't be reached from .L651 where %phi85
is defined since after the simplification .L651 directly branches to
one of the .L656's children, here .L649).

The fix consists in adjusting the OP_PHI's usage when the
simplification is made.

On the same code extract we can now see that the situation is more
"normal". In fact the OP_PHI have now been able to be optimized away
together, as well as .L651:
	.L594:
		...
		br          %r1294, .L649, .L656
	.L656:
		...
		and.64      %r1340 <- %r1339, $1
		br          %r1340, .L649, .L648

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                      |  2 ++
 validation/kill-phi-ttsbb.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 validation/kill-phi-ttsbb.c

diff --git a/flow.c b/flow.c
index fbac9336c..088c21785 100644
--- a/flow.c
+++ b/flow.c
@@ -121,6 +121,8 @@ static int try_to_simplify_bb(struct basic_block *bb, struct instruction *first,
 			continue;
 		changed |= rewrite_branch(source, &br->bb_true, bb, target);
 		changed |= rewrite_branch(source, &br->bb_false, bb, target);
+		if (changed)
+			kill_use(THIS_ADDRESS(phi));
 	} END_FOR_EACH_PTR(phi);
 	return changed;
 }
diff --git a/validation/kill-phi-ttsbb.c b/validation/kill-phi-ttsbb.c
new file mode 100644
index 000000000..178a65d19
--- /dev/null
+++ b/validation/kill-phi-ttsbb.c
@@ -0,0 +1,28 @@
+int def(void);
+void use(int);
+
+static int foo(int a, int b)
+{
+	int c;
+
+	if (a)
+		c = 1;
+	else
+		c = def();
+
+	if (c)
+		use(1);
+	else
+		use(0);
+}
+
+/*
+ * check-name: kill-phi-ttsbb
+ * check-description:
+ *	Verify if OP_PHI usage is adjusted after successful try_to_simplify_bb()
+ * check-command: test-linearize $file
+ * check-output-ignore
+ *
+ * check-output-excludes: phi\\.
+ * check-output-excludes: phisrc\\.
+ */
-- 
2.11.0

