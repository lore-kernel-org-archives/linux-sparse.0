From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 5/8] fix killing OP_SELECT
Date: Sun, 29 Jan 2017 11:48:05 +0100
Message-ID: <20170129104808.2500-6-luc.vanoostenryck@gmail.com>
References: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35510 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdA2Ksx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Jan 2017 05:48:53 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so1548702wmu.2
        for <linux-sparse@vger.kernel.org>; Sun, 29 Jan 2017 02:48:52 -0800 (PST)
In-Reply-To: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently kill_instruction() doesn't do anything with the
operands of select instructions (OP_SELECT). But when these
instructions are removed we must also remove the operands 'usage'.
Without this the instructions which provides the select's
operands are not optimized away as expected.

This patch fixes this by doing for OP_SELECTs the basic
kill_instruction() for ternary instruction, like OP_RANGE.

As an example, when looking at the output of test-linearize,
the following code:

	void foo(int x)
	{
		unsigned int ui;

		ui = x + 1;
		ui = ui ? 0 : 1;
	}

gives this output:

	foo:
		add.32      %r2 <- %arg1, $1
		ret

Since the result of the ?: is never used, the whole code should be
optimized away. The 'select' instruction itself is indeed discarded
but the 'add' is not.

With the patch, the output is much closer to what's expected:

	foo:
		ret

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c               |  1 +
 validation/kill-select.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 validation/kill-select.c

diff --git a/simplify.c b/simplify.c
index fc6bae791..1e4aa63b4 100644
--- a/simplify.c
+++ b/simplify.c
@@ -216,6 +216,7 @@ void kill_instruction(struct instruction *insn)
 		repeat_phase |= REPEAT_CSE | REPEAT_SYMBOL_CLEANUP;
 		return;
 
+	case OP_SEL:
 	case OP_RANGE:
 		insn->bb = NULL;
 		repeat_phase |= REPEAT_CSE;
diff --git a/validation/kill-select.c b/validation/kill-select.c
new file mode 100644
index 000000000..445472be8
--- /dev/null
+++ b/validation/kill-select.c
@@ -0,0 +1,16 @@
+void foo(int x);
+void foo(int x)
+{
+	unsigned int ui;
+
+	ui = x + 1;
+	ui = ui ? 0 : 1;
+}
+
+/*
+ * check-name: kill-select
+ * check-command: test-linearize $file
+ *
+ * check-output-ignore
+ * check-output-excludes: add\\.
+ */
-- 
2.11.0

