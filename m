From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 3/8] fix killing OP_PHI instructions
Date: Sun, 29 Jan 2017 11:48:03 +0100
Message-ID: <20170129104808.2500-4-luc.vanoostenryck@gmail.com>
References: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34351 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbdA2Ksv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Jan 2017 05:48:51 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so69911811wmi.1
        for <linux-sparse@vger.kernel.org>; Sun, 29 Jan 2017 02:48:51 -0800 (PST)
In-Reply-To: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently kill_instruction() doesn't do anything with the
sources of OP_PHI instructions. But when these instructions
are removed the 'usage' of the associated sources must also
be removed. This is not done and as result the instructions
producing the phi-sources are not optimized away as expected.

This patch fixes that by calling clear_phi() when killing a
phi-instruction.

For example, when looking at the output of test-linearize,
the following function:
	void foo(int a, int *b, unsigned int g);
	void foo(int a, int *b, unsigned int g)
	{
		int d = 0;

		if ((!a || *b) && g)
			d = 16;
		else
			d = 8;
	}

gives this output without the patch:
	foo:
		br          %arg1, .L1, .L2
	.L1:
		phisrc.32   %phi1 <- $1
		br          .L3
	.L2:
		load.32     %r3 <- 0[%arg2]
		phisrc.32   %phi2 <- %r3
		br          .L3
	.L3:
		ret

The 'phisrc' instructions are obviously unneeded but nevertheless present.

With the patch, the output is much closer to what's expected:
	foo:
		br          %arg1, .L3, .L2
	.L2:
		load.32     %r3 <- 0[%arg2]
		br          .L3
	.L3:
		ret

Note 1) The 'load' instruction is also dead and should have been removed
but it's separate problem.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                 |  1 +
 validation/kill-phi-node.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 validation/kill-phi-node.c

diff --git a/simplify.c b/simplify.c
index ed41e441a..90998021d 100644
--- a/simplify.c
+++ b/simplify.c
@@ -202,6 +202,7 @@ void kill_instruction(struct instruction *insn)
 		return;
 
 	case OP_PHI:
+		clear_phi(insn);
 		insn->bb = NULL;
 		repeat_phase |= REPEAT_CSE;
 		return;
diff --git a/validation/kill-phi-node.c b/validation/kill-phi-node.c
new file mode 100644
index 000000000..88de9f962
--- /dev/null
+++ b/validation/kill-phi-node.c
@@ -0,0 +1,18 @@
+void foo(int a, int *b, unsigned int g);
+void foo(int a, int *b, unsigned int g)
+{
+	int d = 0;
+
+	if ((!a || *b) && g)
+		d = 16;
+	else
+		d = 8;
+}
+
+/*
+ * check-name: kill-phi-node
+ * check-command: test-linearize $file
+ *
+ * check-output-ignore
+ * check-output-excludes: phisrc\\.
+ */
-- 
2.11.0

