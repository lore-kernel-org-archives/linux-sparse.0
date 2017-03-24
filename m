From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 03/14] canonicalize compare instructions
Date: Sat, 25 Mar 2017 00:14:10 +0100
Message-ID: <20170324231421.14869-4-luc.vanoostenryck@gmail.com>
References: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35880 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755322AbdCXXOd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:14:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id x124so780160wmf.3
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:14:31 -0700 (PDT)
In-Reply-To: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
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
 simplify.c                       |  38 ++++++++++--
 validation/optim/canonical-cmp.c | 124 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+), 4 deletions(-)
 create mode 100644 validation/optim/canonical-cmp.c

diff --git a/simplify.c b/simplify.c
index 66035bbce..e3296a830 100644
--- a/simplify.c
+++ b/simplify.c
@@ -427,6 +427,26 @@ static int compare_opcode(int opcode, int inverse)
 	}
 }
 
+static int swap_compare_opcode(int opcode)
+{
+	static const unsigned char opcode_tbl[] = {
+		[OP_SET_EQ - OP_BINCMP] = OP_SET_EQ,
+		[OP_SET_NE - OP_BINCMP] = OP_SET_NE,
+		[OP_SET_GT - OP_BINCMP] = OP_SET_LT,
+		[OP_SET_GE - OP_BINCMP] = OP_SET_LE,
+		[OP_SET_LE - OP_BINCMP] = OP_SET_GE,
+		[OP_SET_LT - OP_BINCMP] = OP_SET_GT,
+		[OP_SET_A  - OP_BINCMP] = OP_SET_B ,
+		[OP_SET_AE - OP_BINCMP] = OP_SET_BE,
+		[OP_SET_BE - OP_BINCMP] = OP_SET_AE,
+		[OP_SET_B  - OP_BINCMP] = OP_SET_A ,
+	};
+
+	assert(opcode >= OP_BINCMP && opcode <= OP_BINCMP_END);
+
+	return opcode_tbl[opcode - OP_BINCMP];
+}
+
 static int simplify_seteq_setne(struct instruction *insn, long long value)
 {
 	pseudo_t old = insn->src1;
@@ -744,6 +764,14 @@ static int canonicalize_commutative(struct instruction *insn)
 	return repeat_phase |= REPEAT_CSE;
 }
 
+static int canonicalize_compare(struct instruction *insn)
+{
+	int repeat = canonicalize_commutative(insn);
+	if (repeat)
+		insn->opcode = swap_compare_opcode(insn->opcode);
+	return repeat;
+}
+
 static inline int simple_pseudo(pseudo_t pseudo)
 {
 	return pseudo->type == PSEUDO_VAL || pseudo->type == PSEUDO_SYM;
@@ -1139,15 +1167,17 @@ int simplify_instruction(struct instruction *insn)
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

