From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] simplify comparisons followed by an equality test against 0 or 1
Date: Sun, 11 Dec 2016 22:13:27 +0100
Message-ID: <20161211211328.26735-3-luc.vanoostenryck@gmail.com>
References: <20161211211328.26735-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37077 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753790AbcLKVQD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 11 Dec 2016 16:16:03 -0500
Received: by mail-wm0-f42.google.com with SMTP id t79so40147199wmt.0
        for <linux-sparse@vger.kernel.org>; Sun, 11 Dec 2016 13:16:02 -0800 (PST)
In-Reply-To: <20161211211328.26735-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Expressions involving equality testing against zero are ubiquitious
and can often be simplified with previous comparisons.

For example, when using test-linearize on the following code:
	_Bool foo(int a) { return !(a < 3); }
the following was emitted:
	setlt.32    %r2 <- %arg1, $3
	seteq.32    %r3 <- %r2, $0
	setne.1     %r4 <- %r3, $0
	ret.1       %r4

but this can be simplified into:
	setge.1     %r4 <- %arg1, $3
	ret.1       %r4

Implement this simplification and add associated test cases.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                     | 65 ++++++++++++++++++++++++++++++++++++++++++
 validation/optim/setcc-setcc.c | 19 ++++++++++++
 validation/optim/setcc-seteq.c | 13 +++++++++
 validation/optim/setcc-setne.c | 13 +++++++++
 4 files changed, 110 insertions(+)
 create mode 100644 validation/optim/setcc-setcc.c
 create mode 100644 validation/optim/setcc-seteq.c
 create mode 100644 validation/optim/setcc-setne.c

diff --git a/simplify.c b/simplify.c
index b29b3ebb..d076ebb5 100644
--- a/simplify.c
+++ b/simplify.c
@@ -310,6 +310,67 @@ static int simplify_asr(struct instruction *insn, pseudo_t pseudo, long long val
 	return 0;
 }
 
+static int compare_opcode(int opcode, int inverse)
+{
+	if (!inverse)
+		return opcode;
+
+	switch (opcode) {
+	case OP_SET_EQ:	return OP_SET_NE;
+	case OP_SET_NE:	return OP_SET_EQ;
+
+	case OP_SET_LT:	return OP_SET_GE;
+	case OP_SET_LE:	return OP_SET_GT;
+	case OP_SET_GT:	return OP_SET_LE;
+	case OP_SET_GE:	return OP_SET_LT;
+
+	case OP_SET_A:	return OP_SET_BE;
+	case OP_SET_AE:	return OP_SET_B;
+	case OP_SET_B:	return OP_SET_AE;
+	case OP_SET_BE:	return OP_SET_A;
+
+	default:
+		return opcode;
+	}
+}
+
+static int simplify_seteq_setne(struct instruction *insn, long long value)
+{
+	struct instruction *def = insn->src1->def;
+	pseudo_t src1, src2;
+	int inverse;
+	int opcode;
+
+	if (value != 0 && value != 1)
+		return 0;
+
+	if (!def)
+		return 0;
+
+	inverse = (insn->opcode == OP_SET_NE) == value;
+	opcode = def->opcode;
+	switch (opcode) {
+	case OP_BINCMP ... OP_BINCMP_END:
+		// Convert:
+		//	setcc.n	%t <- %a, %b
+		//	setne.m %r <- %t, $0
+		// into:
+		//	setcc.n	%t <- %a, %b
+		//	setcc.m %r <- %a, $b
+		// and similar for setne/eq ... 0/1
+		src1 = def->src1;
+		src2 = def->src2;
+		remove_usage(insn->src1, &insn->src1);
+		insn->opcode = compare_opcode(opcode, inverse);
+		use_pseudo(insn, src1, &insn->src1);
+		use_pseudo(insn, src2, &insn->src2);
+		return REPEAT_CSE;
+
+	default:
+		return 0;
+	}
+}
+
 static int simplify_constant_rightside(struct instruction *insn)
 {
 	long long value = insn->src2->value;
@@ -342,6 +403,10 @@ static int simplify_constant_rightside(struct instruction *insn)
 		if (!value)
 			return replace_with_pseudo(insn, insn->src2);
 		return 0;
+
+	case OP_SET_NE:
+	case OP_SET_EQ:
+		return simplify_seteq_setne(insn, value);
 	}
 	return 0;
 }
diff --git a/validation/optim/setcc-setcc.c b/validation/optim/setcc-setcc.c
new file mode 100644
index 00000000..fac7520e
--- /dev/null
+++ b/validation/optim/setcc-setcc.c
@@ -0,0 +1,19 @@
+static _Bool blt(int a, int b)	{ return  (a <  b); }
+static _Bool bnge(int a, int b)	{ return !(a >= b); }
+static _Bool bgt(int a, int b)	{ return  (a >  b); }
+static _Bool bnle(int a, int b)	{ return !(a <= b); }
+static _Bool ble(int a, int b)	{ return  (a <= b); }
+static _Bool bngt(int a, int b)	{ return !(a >  b); }
+static _Bool bge(int a, int b)	{ return  (a >= b); }
+static _Bool bnlt(int a, int b)	{ return !(a <  b); }
+
+/*
+ * check-name: optim/setcc-setcc
+ * check-command: test-linearize $file
+ * check-output-ignore
+ *
+ * check-output-excludes: set..\\.32
+ * check-output-excludes: setne\\.1
+ * check-output-excludes: seteq\\.1
+ * check-output-contains: set[gt][te]\\.1
+ */
diff --git a/validation/optim/setcc-seteq.c b/validation/optim/setcc-seteq.c
new file mode 100644
index 00000000..d8765fe1
--- /dev/null
+++ b/validation/optim/setcc-seteq.c
@@ -0,0 +1,13 @@
+static _Bool beq0(int a)	{ return  (a == 0); }
+static _Bool bnotneq0(int a)	{ return !(a != 0); }
+static _Bool bnot(int a)	{ return !a; }
+
+/*
+ * check-name: optim/setcc-seteq
+ * check-command: test-linearize $file
+ * check-output-ignore
+ *
+ * check-output-excludes: set..\\.32
+ * check-output-excludes: setne\\.1
+ * check-output-contains: seteq\\.1
+ */
diff --git a/validation/optim/setcc-setne.c b/validation/optim/setcc-setne.c
new file mode 100644
index 00000000..f982eb34
--- /dev/null
+++ b/validation/optim/setcc-setne.c
@@ -0,0 +1,13 @@
+static _Bool bnoteq0(int a)	{ return !(a == 0); }
+static _Bool bne0(int a)	{ return  (a != 0); }
+static _Bool bnotnot(int a)	{ return !!a; }
+
+/*
+ * check-name: optim/setcc-setne
+ * check-command: test-linearize $file
+ * check-output-ignore
+ *
+ * check-output-excludes: set..\\.32
+ * check-output-excludes: seteq\\.1
+ * check-output-contains: setne\\.1
+ */
-- 
2.10.2

