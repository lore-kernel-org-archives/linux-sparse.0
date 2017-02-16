From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] CSE: use commutativity to identify equivalent instructions
Date: Fri, 17 Feb 2017 00:12:29 +0100
Message-ID: <20170216231231.5781-3-luc.vanoostenryck@gmail.com>
References: <20170216231231.5781-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36479 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933736AbdBPXOm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Feb 2017 18:14:42 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so5244163wmd.3
        for <linux-sparse@vger.kernel.org>; Thu, 16 Feb 2017 15:14:41 -0800 (PST)
In-Reply-To: <20170216231231.5781-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

By definition a commutative operation give the same result if its
operands are exchanged.
CSE can use this property when comparing instructions to find
more equivalent instructions and thus eliminate more of them..

Implement this by special-casing commutative ops in insn_compare().

Note: this come for free when all instructions are properly
canonicalized, which is not yet the case.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cse.c                                | 22 ++++++++++++++--------
 validation/optim/cse-commutativity.c | 22 ++++++++++++++++++++++
 2 files changed, 36 insertions(+), 8 deletions(-)
 create mode 100644 validation/optim/cse-commutativity.c

diff --git a/cse.c b/cse.c
index 048a3eb79..5380f4ccd 100644
--- a/cse.c
+++ b/cse.c
@@ -174,30 +174,36 @@ static int insn_compare(const void *_i1, const void *_i2)
 		return i1->opcode < i2->opcode ? -1 : 1;
 
 	switch (i1->opcode) {
+
+	/* commutative binop */
+	case OP_ADD:
+	case OP_MULU: case OP_MULS:
+	case OP_AND_BOOL: case OP_OR_BOOL:
+	case OP_AND: case OP_OR:
+	case OP_XOR:
+	case OP_SET_EQ: case OP_SET_NE:
+		if (i1->src1 == i2->src2 && i1->src2 == i2->src1)
+			return 0;
+		goto case_binops;
+
 	case OP_SEL:
 		if (i1->src3 != i2->src3)
 			return i1->src3 < i2->src3 ? -1 : 1;
 		/* Fall-through to binops */
 
 	/* Binary arithmetic */
-	case OP_ADD: case OP_SUB:
-	case OP_MULU: case OP_MULS:
+	case OP_SUB:
 	case OP_DIVU: case OP_DIVS:
 	case OP_MODU: case OP_MODS:
 	case OP_SHL:
 	case OP_LSR: case OP_ASR:
-	case OP_AND: case OP_OR:
-
-	/* Binary logical */
-	case OP_XOR: case OP_AND_BOOL:
-	case OP_OR_BOOL:
 
 	/* Binary comparison */
-	case OP_SET_EQ: case OP_SET_NE:
 	case OP_SET_LE: case OP_SET_GE:
 	case OP_SET_LT: case OP_SET_GT:
 	case OP_SET_B:  case OP_SET_A:
 	case OP_SET_BE: case OP_SET_AE:
+	case_binops:
 		if (i1->src2 != i2->src2)
 			return i1->src2 < i2->src2 ? -1 : 1;
 		/* Fall through to unops */
diff --git a/validation/optim/cse-commutativity.c b/validation/optim/cse-commutativity.c
new file mode 100644
index 000000000..826034781
--- /dev/null
+++ b/validation/optim/cse-commutativity.c
@@ -0,0 +1,22 @@
+static int add(int a, int b) { return (a + b) == (b + a); }
+static int mul(int a, int b) { return (a * b) == (b * a); }
+static int and(int a, int b) { return (a & b) == (b & a); }
+static int ior(int a, int b) { return (a | b) == (b | a); }
+static int xor(int a, int b) { return (a ^ b) == (b ^ a); }
+static int  eq(int a, int b) { return (a == b) == (b == a); }
+static int  ne(int a, int b) { return (a != b) == (b != a); }
+
+
+/*
+ * check-name: cse-commutativity
+ * check-command: test-linearize $file
+ * check-output-ignore
+ *
+ * check-output-excludes: add\\.
+ * check-output-excludes: muls\\.
+ * check-output-excludes: and\\.
+ * check-output-excludes: or\\.
+ * check-output-excludes: xor\\.
+ * check-output-excludes: seteq\\.
+ * check-output-excludes: setne\\.
+ */
-- 
2.11.0

