From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] simplify 'x | ~0' and 'x & ~0'
Date: Wed, 12 Apr 2017 16:18:00 +0200
Message-ID: <20170412141802.81231-2-luc.vanoostenryck@gmail.com>
References: <20170412141802.81231-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35129 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753244AbdDLOUM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 10:20:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id l44so4423193wrc.2
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 07:20:11 -0700 (PDT)
In-Reply-To: <20170412141802.81231-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                       | 11 ++++++++++-
 validation/optim/bool-not-zero.c | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 validation/optim/bool-not-zero.c

diff --git a/simplify.c b/simplify.c
index 2286440e0..e4ccb6c5f 100644
--- a/simplify.c
+++ b/simplify.c
@@ -453,6 +453,8 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 static int simplify_constant_rightside(struct instruction *insn)
 {
 	long long value = insn->src2->value;
+	long long sbit = 1ULL << (insn->size - 1);
+	long long bits = sbit | (sbit - 1);
 
 	switch (insn->opcode) {
 	case OP_OR_BOOL:
@@ -460,6 +462,11 @@ static int simplify_constant_rightside(struct instruction *insn)
 			return replace_with_pseudo(insn, insn->src2);
 		goto case_neutral_zero;
 
+	case OP_OR:
+		if ((value & bits) == bits)
+			return replace_with_pseudo(insn, insn->src2);
+		goto case_neutral_zero;
+
 	case OP_SUB:
 		if (value) {
 			insn->opcode = OP_ADD;
@@ -468,7 +475,7 @@ static int simplify_constant_rightside(struct instruction *insn)
 		}
 	/* Fall through */
 	case OP_ADD:
-	case OP_OR: case OP_XOR:
+	case OP_XOR:
 	case OP_SHL:
 	case OP_LSR:
 	case_neutral_zero:
@@ -492,6 +499,8 @@ static int simplify_constant_rightside(struct instruction *insn)
 			return replace_with_pseudo(insn, insn->src1);
 	/* Fall through */
 	case OP_AND:
+		if ((value & bits) == bits)
+			return replace_with_pseudo(insn, insn->src1);
 		if (!value)
 			return replace_with_pseudo(insn, insn->src2);
 		return 0;
diff --git a/validation/optim/bool-not-zero.c b/validation/optim/bool-not-zero.c
new file mode 100644
index 000000000..ce74705e8
--- /dev/null
+++ b/validation/optim/bool-not-zero.c
@@ -0,0 +1,22 @@
+int  or_not0(int a) { return a | ~0; }
+int and_not0(int a) { return a & ~0; }
+
+/*
+ * check-name: bool-not-zero
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+or_not0:
+.L0:
+	<entry-point>
+	ret.32      $0xffffffff
+
+
+and_not0:
+.L2:
+	<entry-point>
+	ret.32      %arg1
+
+
+ * check-output-end
+ */
-- 
2.12.0

