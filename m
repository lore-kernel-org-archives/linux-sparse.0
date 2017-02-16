From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 15/16] use kill_instruction() when killing any instructions during CSE
Date: Thu, 16 Feb 2017 05:57:07 +0100
Message-ID: <20170216045708.50661-16-luc.vanoostenryck@gmail.com>
References: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36212 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753394AbdBPE53 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:29 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so1284939wmd.3
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:29 -0800 (PST)
In-Reply-To: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Instructions removed during CSE had their ->bb simply set to NULL
and the usage of their operand was not adjusted.

Fix that by calling kill_instruction().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cse.c                 |  7 +------
 validation/kill-cse.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 6 deletions(-)
 create mode 100644 validation/kill-cse.c

diff --git a/cse.c b/cse.c
index 165b862af..048a3eb79 100644
--- a/cse.c
+++ b/cse.c
@@ -251,12 +251,7 @@ static struct instruction * cse_one_instruction(struct instruction *insn, struct
 {
 	convert_instruction_target(insn, def->target);
 
-	if (insn->opcode == OP_PHI) {
-		kill_instruction(insn);
-	}
-
-	insn->opcode = OP_NOP;
-	insn->bb = NULL;
+	kill_instruction(insn);
 	repeat_phase |= REPEAT_CSE;
 	return def;
 }
diff --git a/validation/kill-cse.c b/validation/kill-cse.c
new file mode 100644
index 000000000..2e2b10246
--- /dev/null
+++ b/validation/kill-cse.c
@@ -0,0 +1,21 @@
+int foo(int a)
+{
+	return ((a == 0) + 1) != ((a == 0) + 1);
+}
+
+/*
+ * check-name: kill-cse
+ * check-description:
+ *	Verify that instructions removed at CSE are
+ *	properly adjust the usage of their operands.
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+foo:
+.L0:
+	<entry-point>
+	ret.32      $0
+
+
+ * check-output-end
+ */
-- 
2.11.0

