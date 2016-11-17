From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/8] fix killing OP_COMPUTEDGOTO
Date: Thu, 17 Nov 2016 15:35:05 +0100
Message-ID: <20161117143507.3598-7-luc.vanoostenryck@gmail.com>
References: <20161117143507.3598-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34634 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933932AbcKQSLc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 13:11:32 -0500
Received: by mail-wm0-f65.google.com with SMTP id g23so23763611wme.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 10:11:31 -0800 (PST)
In-Reply-To: <20161117143507.3598-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently kill_instruction() doesn't do anything with the
operands of computed gotos (OP_COMPUTEDGOTO). But when these
instructions are removed we must also remove the operands 'usage'.
Without this some instructions, which provides the select's
operands, are not optimized away as expected.

The fix consists by killing it's operand much like what is done for
conditional branches.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                     |  1 +
 validation/kill-computedgoto.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 validation/kill-computedgoto.c

diff --git a/simplify.c b/simplify.c
index 1dd1bda6..1be9b3d0 100644
--- a/simplify.c
+++ b/simplify.c
@@ -226,6 +226,7 @@ void kill_instruction(struct instruction *insn)
 		kill_use(&insn->src3);
 		return;
 	case OP_BR:
+	case OP_COMPUTEDGOTO:
 		insn->bb = NULL;
 		repeat_phase |= REPEAT_CSE;
 		if (insn->cond)
diff --git a/validation/kill-computedgoto.c b/validation/kill-computedgoto.c
new file mode 100644
index 00000000..3b3ed8ff
--- /dev/null
+++ b/validation/kill-computedgoto.c
@@ -0,0 +1,17 @@
+void foo(int a);
+void foo(int a)
+{
+	void *l = &&end + 3;
+
+end:
+	if (a * 0)
+		goto *l;
+}
+
+/*
+ * check-name: kill-computedgoto
+ * check-command: test-linearize $file
+ *
+ * check-output-ignore
+ * check-output-excludes: add\\.
+ */
-- 
2.10.2

