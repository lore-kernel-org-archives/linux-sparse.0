From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] move OP_MUL simplification in a separate function
Date: Wed,  7 Dec 2016 16:46:51 +0100
Message-ID: <20161207154655.98109-2-luc.vanoostenryck@gmail.com>
References: <20161207154655.98109-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35122 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932177AbcLGPrG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 10:47:06 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so28723355wme.2
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 07:47:05 -0800 (PST)
In-Reply-To: <20161207154655.98109-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This patch contains no functional changes.
It just moves the code for simplification of OP_MUL{U,S} with
constant operands in its own function in preparation for some
additional simplifications coming in the same serie.

Also add some test cases for the concerned simplifications.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                        | 17 +++++++++++++++++
 validation/optim/muldiv-by-one.c  | 13 +++++++++++++
 validation/optim/muldiv-by-zero.c | 13 +++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 validation/optim/muldiv-by-one.c
 create mode 100644 validation/optim/muldiv-by-zero.c

diff --git a/simplify.c b/simplify.c
index b5cd0ea7..b242b64d 100644
--- a/simplify.c
+++ b/simplify.c
@@ -310,6 +310,21 @@ static int simplify_asr(struct instruction *insn, pseudo_t pseudo, long long val
 	return 0;
 }
 
+static int simplify_mul_div(struct instruction *insn, long long value)
+{
+	if (value == 1)
+		return replace_with_pseudo(insn, insn->src1);
+
+	switch (insn->opcode) {
+	case OP_MULS:
+	case OP_MULU:
+		if (value == 0)
+			return replace_with_pseudo(insn, insn->src2);
+	}
+
+	return 0;
+}
+
 static int simplify_constant_rightside(struct instruction *insn)
 {
 	long long value = insn->src2->value;
@@ -334,6 +349,8 @@ static int simplify_constant_rightside(struct instruction *insn)
 		return simplify_asr(insn, insn->src1, value);
 
 	case OP_MULU: case OP_MULS:
+		return simplify_mul_div(insn, value);
+
 	case OP_AND_BOOL:
 		if (value == 1)
 			return replace_with_pseudo(insn, insn->src1);
diff --git a/validation/optim/muldiv-by-one.c b/validation/optim/muldiv-by-one.c
new file mode 100644
index 00000000..ac8ac95b
--- /dev/null
+++ b/validation/optim/muldiv-by-one.c
@@ -0,0 +1,13 @@
+typedef	unsigned int ui;
+typedef	         int si;
+
+si smul1(si a) {  return a * 1; }
+ui umul1(ui a) {  return a * 1; }
+
+/*
+ * check-name: muldiv-by-one
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-excludes: mul[us]\\.
+ */
diff --git a/validation/optim/muldiv-by-zero.c b/validation/optim/muldiv-by-zero.c
new file mode 100644
index 00000000..07b7b1a7
--- /dev/null
+++ b/validation/optim/muldiv-by-zero.c
@@ -0,0 +1,13 @@
+typedef	unsigned int ui;
+typedef	         int si;
+
+si smul0(si a) {  return a * 0; }
+ui umul0(ui a) {  return a * 0; }
+
+/*
+ * check-name: muldiv-by-zero
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-excludes: mul[us]\\.
+ */
-- 
2.10.2

