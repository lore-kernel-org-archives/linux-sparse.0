From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] simplify '(x op x)' to '0', '1' or 'x'
Date: Wed,  7 Dec 2016 17:32:56 +0100
Message-ID: <20161207163257.22287-2-luc.vanoostenryck@gmail.com>
References: <20161207163257.22287-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35257 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932442AbcLGQdg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 11:33:36 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so28989634wme.2
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 08:33:07 -0800 (PST)
In-Reply-To: <20161207163257.22287-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Most binops can be simplified when their two operands are
identical. For example '(x ^ x)' can be simplified into '0'.

The cases '(x / x)' and '(x % x)' are not simplified since this
is correct only when x is not zero.
The cases '(x || x)' and '(x && x)' are not simplified because
it's only correct when the operands are booleans/have already
been compared against zero and the linearization don't enforce that.

This patch add the code for these simplifications as well as
their corresponding test cases.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                          | 35 ++++++++++++++++++++++++++
 validation/optim/binops-same-args.c | 49 +++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 validation/optim/binops-same-args.c

diff --git a/simplify.c b/simplify.c
index b5cd0ea7..fde72f0a 100644
--- a/simplify.c
+++ b/simplify.c
@@ -488,6 +488,39 @@ static int simplify_constant_binop(struct instruction *insn)
 	return REPEAT_CSE;
 }
 
+static int simplify_binop_same_args(struct instruction *insn, pseudo_t arg)
+{
+	switch (insn->opcode) {
+	case OP_SET_NE:
+	case OP_SET_LT: case OP_SET_GT:
+	case OP_SET_B:  case OP_SET_A:
+	case OP_SUB:
+	case OP_XOR:
+		return replace_with_pseudo(insn, value_pseudo(0));
+
+	case OP_SET_EQ:
+	case OP_SET_LE: case OP_SET_GE:
+	case OP_SET_BE: case OP_SET_AE:
+		return replace_with_pseudo(insn, value_pseudo(1));
+
+	case OP_AND:
+	case OP_OR:
+		return replace_with_pseudo(insn, arg);
+
+	case OP_AND_BOOL:
+	case OP_OR_BOOL:
+		// simplification is correct only if the operands
+		// have already been compared against zero which
+		// is not enforced.
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int simplify_binop(struct instruction *insn)
 {
 	if (dead_insn(insn, &insn->src1, &insn->src2, NULL))
@@ -499,6 +532,8 @@ static int simplify_binop(struct instruction *insn)
 	}
 	if (constant(insn->src2))
 		return simplify_constant_rightside(insn);
+	if (insn->src1 == insn->src2)
+		return simplify_binop_same_args(insn, insn->src1);
 	return 0;
 }
 
diff --git a/validation/optim/binops-same-args.c b/validation/optim/binops-same-args.c
new file mode 100644
index 00000000..9285655d
--- /dev/null
+++ b/validation/optim/binops-same-args.c
@@ -0,0 +1,49 @@
+typedef unsigned int u32;
+
+int ssub(int a) { return a - a; }
+u32 usub(u32 a) { return a - a; }
+
+int sdiv(int a) { return a / a; }
+u32 udiv(u32 a) { return a / a; }
+int smod(int a) { return a % a; }
+u32 umod(u32 a) { return a % a; }
+
+int seq(int a) { return a == a; }
+int sne(int a) { return a != a; }
+int slt(int a) { return a < a; }
+int sgt(int a) { return a > a; }
+int sle(int a) { return a <= a; }
+int sge(int a) { return a >= a; }
+
+u32 ueq(u32 a) { return a == a; }
+u32 une(u32 a) { return a != a; }
+u32 ult(u32 a) { return a < a; }
+u32 ugt(u32 a) { return a > a; }
+u32 ule(u32 a) { return a <= a; }
+u32 uge(u32 a) { return a >= a; }
+
+u32 xor(u32 a) { return a ^ a; }
+
+u32 ior(u32 a) { return a | a; }
+u32 and(u32 a) { return a & a; }
+
+/*
+ * check-name: double-unop
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-excludes: sub\\.
+ * check-output-contains: divs\\.
+ * check-output-contains: divu\\.
+ * check-output-contains: mods\\.
+ * check-output-contains: modu\\.
+ * check-output-excludes: seteq\\.
+ * check-output-excludes: setne\\.
+ * check-output-excludes: set[gl]t\\.
+ * check-output-excludes: set[gl]e\\.
+ * check-output-excludes: set[ab]\\.
+ * check-output-excludes: set[ab]e\\.
+ * check-output-excludes: xor\\.
+ * check-output-excludes: or\\.
+ * check-output-excludes: and\\.
+ */
-- 
2.10.2

