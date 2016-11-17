From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/8] kill uses of replaced instructions
Date: Thu, 17 Nov 2016 15:35:00 +0100
Message-ID: <20161117143507.3598-2-luc.vanoostenryck@gmail.com>
References: <20161117143507.3598-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33619 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752673AbcKQSqY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 13:46:24 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so23911803wmu.0
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 10:46:23 -0800 (PST)
In-Reply-To: <20161117143507.3598-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When an instruction is replaced by a pseudo, the 'usage' of its
operands should be removed too but it's not the case.

The fix consists in calling kill_use() for each operands after
the pseudo is replaced.
Not all types of instruction are considered, only those which
can be replaced by a pseudo.

The following example illustrate the situation. When looking at
the output of test-linearize, the following function:

	static int kill_add(int a, int b)
	{
		return (a + b) && 0;
	}

without the patch, gives this output:

	kill_add:
		add.32      %r3 <- %arg1, %arg2
		ret.32      $0

The 'add' instruction is obviously unneeded but nevertheless present.

Before any optimization the code was something like:

	kill_add:
		add.32      %r3 <- %arg1, %arg2
		and_bool.32 %r4 <- %r3, $0
		ret.32      %r4

During the simplification phase, the result of the 'and' instruction (%r4)
have been replaced by '0' and the instruction itself is discarded.
But '%r3' usage has not been adjusted and the further phases are not
aware that '%r3' is not needed anymore and so the 'add' instruction is kept
while not needed by anything.

With the patch the 'add' instruction is correctly discarded, giving the
expected output:

	kill_add:
		ret.32      $0

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                      | 20 +++++++++++++++
 validation/kill-replaced-insn.c | 54 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 validation/kill-replaced-insn.c

diff --git a/simplify.c b/simplify.c
index b5cd0ea7..85da5bec 100644
--- a/simplify.c
+++ b/simplify.c
@@ -253,6 +253,26 @@ static inline int constant(pseudo_t pseudo)
 static int replace_with_pseudo(struct instruction *insn, pseudo_t pseudo)
 {
 	convert_instruction_target(insn, pseudo);
+
+	switch (insn->opcode) {
+	case OP_SEL:
+	case OP_RANGE:
+		kill_use(&insn->src3);
+	case OP_BINARY ... OP_BINCMP_END:
+		kill_use(&insn->src2);
+	case OP_NOT:
+	case OP_NEG:
+	case OP_SYMADDR:
+	case OP_CAST:
+	case OP_SCAST:
+	case OP_FPCAST:
+	case OP_PTRCAST:
+		kill_use(&insn->src1);
+		break;
+
+	default:
+		assert(0);
+	}
 	insn->bb = NULL;
 	return REPEAT_CSE;
 }
diff --git a/validation/kill-replaced-insn.c b/validation/kill-replaced-insn.c
new file mode 100644
index 00000000..be031b6c
--- /dev/null
+++ b/validation/kill-replaced-insn.c
@@ -0,0 +1,54 @@
+// See if the replaced operation is effectively killed or not
+
+static int kill_add(int a, int b)
+{
+	return (a + b) && 0;
+}
+
+static int kill_scast(short a)
+{
+	return ((int) a) && 0;
+}
+
+static int kill_ucast(unsigned char a)
+{
+	return ((int) a) && 0;
+}
+
+static int kill_pcast(int *a)
+{
+	return ((void*) a) && 0;
+}
+
+static int kill_fcast(double a)
+{
+	return ((int) a) && 0;
+}
+
+static int kill_select(int a)
+{
+	return (a ? 1 : 0) && 0;
+}
+
+static int kill_load(int *a)
+{
+	return *a && 0;
+}
+
+static int kill_store(int *a)
+{
+	return (*a = 1) && 0;
+}
+
+/*
+ * check-name: kill-replaced-insn
+ * check-command: test-linearize $file
+ *
+ * check-output-ignore
+ * check-output-excludes: add\\.
+ * check-output-excludes: scast\\.
+ * check-output-excludes: \\<cast\\.
+ * check-output-excludes: ptrcast\\.
+ * check-output-excludes: fpcast\\.
+ * check-output-excludes: sel\\.
+ */
-- 
2.10.2

