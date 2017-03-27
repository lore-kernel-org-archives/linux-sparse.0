From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 05/15] canonicalize compare instructions
Date: Mon, 27 Mar 2017 19:33:55 +0200
Message-ID: <20170327173405.11405-6-luc.vanoostenryck@gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34595 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbdC0RhN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 13:37:13 -0400
Received: by mail-wr0-f195.google.com with SMTP id w43so12462276wrb.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 10:36:18 -0700 (PDT)
In-Reply-To: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently only commutative instructions are canonicalized
(the "simpler" operands, often a constant, is forced, if present
to be in the second operand). This improve CSE (more cases are
considered as equivalent) and help to reduce the number of "pattern"
to be handled at simplification.

Do this also for compare instructions since in thsi case we can
swap the order of the operands if at the same time we also swap
the 'direction' on the comparison.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 opcode.c                         |  20 +++----
 opcode.h                         |   1 +
 simplify.c                       |  20 +++++--
 validation/optim/canonical-cmp.c | 124 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 151 insertions(+), 14 deletions(-)
 create mode 100644 validation/optim/canonical-cmp.c

diff --git a/opcode.c b/opcode.c
index 0aed1ca1f..102bef68d 100644
--- a/opcode.c
+++ b/opcode.c
@@ -23,14 +23,14 @@
 #include "linearize.h"
 
 const struct opcode_table opcode_table[OP_LAST] = {
-	[OP_SET_EQ] = {	.negate = OP_SET_NE, },
-	[OP_SET_NE] = {	.negate = OP_SET_EQ, },
-	[OP_SET_LT] = {	.negate = OP_SET_GE, },
-	[OP_SET_LE] = {	.negate = OP_SET_GT, },
-	[OP_SET_GE] = {	.negate = OP_SET_LT, },
-	[OP_SET_GT] = {	.negate = OP_SET_LE, },
-	[OP_SET_B ] = {	.negate = OP_SET_AE, },
-	[OP_SET_BE] = {	.negate = OP_SET_A , },
-	[OP_SET_AE] = {	.negate = OP_SET_B , },
-	[OP_SET_A ] = {	.negate = OP_SET_BE, },
+	[OP_SET_EQ] = {	.negate = OP_SET_NE, .swap = OP_SET_EQ, },
+	[OP_SET_NE] = {	.negate = OP_SET_EQ, .swap = OP_SET_NE, },
+	[OP_SET_LT] = {	.negate = OP_SET_GE, .swap = OP_SET_GT, },
+	[OP_SET_LE] = {	.negate = OP_SET_GT, .swap = OP_SET_GE, },
+	[OP_SET_GE] = {	.negate = OP_SET_LT, .swap = OP_SET_LE, },
+	[OP_SET_GT] = {	.negate = OP_SET_LE, .swap = OP_SET_LT, },
+	[OP_SET_B ] = {	.negate = OP_SET_AE, .swap = OP_SET_A , },
+	[OP_SET_BE] = {	.negate = OP_SET_A , .swap = OP_SET_AE, },
+	[OP_SET_AE] = {	.negate = OP_SET_B , .swap = OP_SET_BE, },
+	[OP_SET_A ] = {	.negate = OP_SET_BE, .swap = OP_SET_B , },
 };
diff --git a/opcode.h b/opcode.h
index 3a89de05e..4a9b102f2 100644
--- a/opcode.h
+++ b/opcode.h
@@ -4,6 +4,7 @@
 
 extern const struct opcode_table {
 	int	negate:8;
+	int	swap:8;
 } opcode_table[];
 
 #endif
diff --git a/simplify.c b/simplify.c
index 90f51e2a9..21ed39d78 100644
--- a/simplify.c
+++ b/simplify.c
@@ -720,6 +720,16 @@ static int canonicalize_commutative(struct instruction *insn)
 	return repeat_phase |= REPEAT_CSE;
 }
 
+static int canonicalize_compare(struct instruction *insn)
+{
+	if (canonical_order(insn->src1, insn->src2))
+		return 0;
+
+	switch_pseudo(insn, &insn->src1, insn, &insn->src2);
+	insn->opcode = opcode_table[insn->opcode].swap;
+	return repeat_phase |= REPEAT_CSE;
+}
+
 static inline int simple_pseudo(pseudo_t pseudo)
 {
 	return pseudo->type == PSEUDO_VAL || pseudo->type == PSEUDO_SYM;
@@ -1115,15 +1125,17 @@ int simplify_instruction(struct instruction *insn)
 		canonicalize_commutative(insn);
 		return simplify_binop(insn);
 
+	case OP_SET_LE: case OP_SET_GE:
+	case OP_SET_LT: case OP_SET_GT:
+	case OP_SET_B:  case OP_SET_A:
+	case OP_SET_BE: case OP_SET_AE:
+		canonicalize_compare(insn);
+		/* fall through */
 	case OP_SUB:
 	case OP_DIVU: case OP_DIVS:
 	case OP_MODU: case OP_MODS:
 	case OP_SHL:
 	case OP_LSR: case OP_ASR:
-	case OP_SET_LE: case OP_SET_GE:
-	case OP_SET_LT: case OP_SET_GT:
-	case OP_SET_B:  case OP_SET_A:
-	case OP_SET_BE: case OP_SET_AE:
 		return simplify_binop(insn);
 
 	case OP_NOT: case OP_NEG:
diff --git a/validation/optim/canonical-cmp.c b/validation/optim/canonical-cmp.c
new file mode 100644
index 000000000..19b416310
--- /dev/null
+++ b/validation/optim/canonical-cmp.c
@@ -0,0 +1,124 @@
+typedef	  signed int	sint;
+typedef	unsigned int	uint;
+
+sint seq(sint p, sint a) { return (123 == p) ? a : 0; }
+sint sne(sint p, sint a) { return (123 != p) ? a : 0; }
+
+sint slt(sint p, sint a) { return (123 >  p) ? a : 0; }
+sint sle(sint p, sint a) { return (123 >= p) ? a : 0; }
+sint sge(sint p, sint a) { return (123 <= p) ? a : 0; }
+sint sgt(sint p, sint a) { return (123 <  p) ? a : 0; }
+
+uint ueq(uint p, uint a) { return (123 == p) ? a : 0; }
+uint une(uint p, uint a) { return (123 != p) ? a : 0; }
+
+uint ubt(uint p, uint a) { return (123 >  p) ? a : 0; }
+uint ube(uint p, uint a) { return (123 >= p) ? a : 0; }
+uint uae(uint p, uint a) { return (123 <= p) ? a : 0; }
+uint uat(uint p, uint a) { return (123 <  p) ? a : 0; }
+
+/*
+ * check-name: canonical-cmp
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-exclude: \$123,
+ *
+ * check-output-start
+seq:
+.L0:
+	<entry-point>
+	seteq.32    %r4 <- %arg1, $123
+	select.32   %r5 <- %r4, %arg2, $0
+	ret.32      %r5
+
+
+sne:
+.L2:
+	<entry-point>
+	setne.32    %r11 <- %arg1, $123
+	select.32   %r12 <- %r11, %arg2, $0
+	ret.32      %r12
+
+
+slt:
+.L4:
+	<entry-point>
+	setlt.32    %r18 <- %arg1, $123
+	select.32   %r19 <- %r18, %arg2, $0
+	ret.32      %r19
+
+
+sle:
+.L6:
+	<entry-point>
+	setle.32    %r25 <- %arg1, $123
+	select.32   %r26 <- %r25, %arg2, $0
+	ret.32      %r26
+
+
+sge:
+.L8:
+	<entry-point>
+	setge.32    %r32 <- %arg1, $123
+	select.32   %r33 <- %r32, %arg2, $0
+	ret.32      %r33
+
+
+sgt:
+.L10:
+	<entry-point>
+	setgt.32    %r39 <- %arg1, $123
+	select.32   %r40 <- %r39, %arg2, $0
+	ret.32      %r40
+
+
+ueq:
+.L12:
+	<entry-point>
+	seteq.32    %r45 <- %arg1, $123
+	select.32   %r46 <- %r45, %arg2, $0
+	ret.32      %r46
+
+
+une:
+.L14:
+	<entry-point>
+	setne.32    %r50 <- %arg1, $123
+	select.32   %r51 <- %r50, %arg2, $0
+	ret.32      %r51
+
+
+ubt:
+.L16:
+	<entry-point>
+	setb.32     %r55 <- %arg1, $123
+	select.32   %r56 <- %r55, %arg2, $0
+	ret.32      %r56
+
+
+ube:
+.L18:
+	<entry-point>
+	setbe.32    %r60 <- %arg1, $123
+	select.32   %r61 <- %r60, %arg2, $0
+	ret.32      %r61
+
+
+uae:
+.L20:
+	<entry-point>
+	setae.32    %r65 <- %arg1, $123
+	select.32   %r66 <- %r65, %arg2, $0
+	ret.32      %r66
+
+
+uat:
+.L22:
+	<entry-point>
+	seta.32     %r70 <- %arg1, $123
+	select.32   %r71 <- %r70, %arg2, $0
+	ret.32      %r71
+
+
+ * check-output-end
+ */
-- 
2.12.0

