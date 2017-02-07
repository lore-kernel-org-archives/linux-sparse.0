From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 1/5] move OP_MUL simplification in a separate function
Date: Tue,  7 Feb 2017 21:50:24 +0100
Message-ID: <20170207205028.35869-2-luc.vanoostenryck@gmail.com>
References: <CANeU7Q=67iWdgssXLEQyX0Saoe8iCf17jDCh7PWwwpeAuEhVAQ@mail.gmail.com>
 <20170207205028.35869-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34389 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754414AbdBGUxS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 15:53:18 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so30540344wmi.1
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 12:52:35 -0800 (PST)
In-Reply-To: <20170207205028.35869-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
index b5cd0ea77..b242b64d6 100644
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
index 000000000..ac8ac95b2
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
index 000000000..07b7b1a79
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
2.11.0

