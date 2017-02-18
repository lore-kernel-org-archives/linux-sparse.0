From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] split OP_BR between unconditional & conditional: OP_CBR
Date: Sat, 18 Feb 2017 02:28:47 +0100
Message-ID: <20170218012848.27417-2-luc.vanoostenryck@gmail.com>
References: <20170218012848.27417-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33432 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752448AbdBRB3F (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Feb 2017 20:29:05 -0500
Received: by mail-wm0-f65.google.com with SMTP id v77so5147318wmv.0
        for <linux-sparse@vger.kernel.org>; Fri, 17 Feb 2017 17:29:04 -0800 (PST)
In-Reply-To: <20170218012848.27417-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

OP_BR instructions exist in two flavours: conditional &
non-conditional. There is some significant differences
between them:
1) one has an operand (and thus needs correct handling of
   its usage, must be handled in liveness analysis, ..) while
   the other has none
2) one has two BB targets, the other only one.

There is essentially no places in the code where both flavours
are handled the same. Sometimes they both must be handled but
each with their specificities but in most cases only one of
them is concerned and we need to filter out the other one.
In both cases it means that we need to make to make a test
to know what kind we're dealing with.

There is a problem with this because there is several ways
to test this and they are not exactly equivalent:
1) testing if insn->cond is NULL
2) testing if one of insn->bb_true or ->bb_false is NULL.
There exist also an helper (is_branch_goto()) which does
the second tests but which is never used.

It appears that the first test should not be used because
in some cases an conditional OP_BR is changed into
a non-conditional one by (amongst others things) setting
it's ->cond to VOID. We should thus always use the second
test (which need two compares with NULL).

This could be corrected in several ways (like changing all
the places wheer the first test is used, use the helper
everywhere or never set ->cond to VOID) but the simplest
is to simply split them in two separated instructions:
OP_BR & OP_CBR, especailly given the fact that in most cases
the OP_BR was first selected by a switch (opcode).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 example.c                       |   2 +
 flow.c                          |  13 ++--
 linearize.c                     |  14 +++--
 linearize.h                     |   1 +
 liveness.c                      |   3 +-
 simplify.c                      |  11 ++--
 sparse-llvm.c                   |  25 ++++----
 validation/loop-linearization.c | 136 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 176 insertions(+), 29 deletions(-)
 create mode 100644 validation/loop-linearization.c

diff --git a/example.c b/example.c
index 24444c6c0..691e0f97c 100644
--- a/example.c
+++ b/example.c
@@ -23,6 +23,7 @@ static const char *opcodes[] = {
 	/* Terminator */
 	[OP_RET] = "ret",
 	[OP_BR] = "br",
+	[OP_CBR] = "cbr",
 	[OP_SWITCH] = "switch",
 	[OP_INVOKE] = "invoke",
 	[OP_COMPUTEDGOTO] = "jmp *",
@@ -1428,6 +1429,7 @@ static void generate_one_insn(struct instruction *insn, struct bb_state *state)
 		break;
 
 	case OP_BR:
+	case OP_CBR:
 		generate_branch(state, insn);
 		break;
 
diff --git a/flow.c b/flow.c
index 088c21785..7730e70f1 100644
--- a/flow.c
+++ b/flow.c
@@ -111,7 +111,7 @@ static int try_to_simplify_bb(struct basic_block *bb, struct instruction *first,
 		br = last_instruction(source->insns);
 		if (!br)
 			continue;
-		if (br->opcode != OP_BR)
+		if (br->opcode != OP_CBR && br->opcode != OP_BR)
 			continue;
 		true = pseudo_truth_value(pseudo);
 		if (true < 0)
@@ -176,7 +176,7 @@ static int simplify_branch_branch(struct basic_block *bb, struct instruction *br
 	if (target == bb)
 		return 0;
 	insn = last_instruction(target->insns);
-	if (!insn || insn->opcode != OP_BR || insn->cond != br->cond)
+	if (!insn || insn->opcode != OP_CBR  || insn->cond != br->cond)
 		return 0;
 	/*
 	 * Ahhah! We've found a branch to a branch on the same conditional!
@@ -218,7 +218,7 @@ static int simplify_branch_nodes(struct entrypoint *ep)
 	FOR_EACH_PTR(ep->bbs, bb) {
 		struct instruction *br = last_instruction(bb->insns);
 
-		if (!br || br->opcode != OP_BR || !br->bb_false)
+		if (!br || br->opcode != OP_CBR)
 			continue;
 		changed |= simplify_one_branch(bb, br);
 	} END_FOR_EACH_PTR(bb);
@@ -811,9 +811,10 @@ static int rewrite_parent_branch(struct basic_block *bb, struct basic_block *old
 		return 0;
 
 	switch (insn->opcode) {
+	case OP_CBR:
+		changed |= rewrite_branch(bb, &insn->bb_false, old, new);
 	case OP_BR:
 		changed |= rewrite_branch(bb, &insn->bb_true, old, new);
-		changed |= rewrite_branch(bb, &insn->bb_false, old, new);
 		assert(changed);
 		return changed;
 	case OP_SWITCH: {
@@ -886,9 +887,10 @@ static void vrfy_children(struct basic_block *bb)
 	}
 	switch (br->opcode) {
 		struct multijmp *jmp;
+	case OP_CBR:
+		vrfy_bb_in_list(br->bb_false, bb->children);
 	case OP_BR:
 		vrfy_bb_in_list(br->bb_true, bb->children);
-		vrfy_bb_in_list(br->bb_false, bb->children);
 		break;
 	case OP_SWITCH:
 	case OP_COMPUTEDGOTO:
@@ -945,6 +947,7 @@ void pack_basic_blocks(struct entrypoint *ep)
 			switch (first->opcode) {
 			case OP_NOP: case OP_LNOP: case OP_SNOP:
 				continue;
+			case OP_CBR:
 			case OP_BR: {
 				struct basic_block *replace;
 				replace = rewrite_branch_bb(bb, first);
diff --git a/linearize.c b/linearize.c
index 99203d915..3b4741822 100644
--- a/linearize.c
+++ b/linearize.c
@@ -169,6 +169,7 @@ static const char *opcodes[] = {
 	/* Terminator */
 	[OP_RET] = "ret",
 	[OP_BR] = "br",
+	[OP_CBR] = "cbr",
 	[OP_SWITCH] = "switch",
 	[OP_INVOKE] = "invoke",
 	[OP_COMPUTEDGOTO] = "jmp *",
@@ -303,12 +304,13 @@ const char *show_instruction(struct instruction *insn)
 		if (insn->src && insn->src != VOID)
 			buf += sprintf(buf, "%s", show_pseudo(insn->src));
 		break;
+
+	case OP_CBR:
+		buf += sprintf(buf, "%s, .L%u, .L%u", show_pseudo(insn->cond), insn->bb_true->nr, insn->bb_false->nr);
+		break;
+
 	case OP_BR:
-		if (insn->bb_true && insn->bb_false) {
-			buf += sprintf(buf, "%s, .L%u, .L%u", show_pseudo(insn->cond), insn->bb_true->nr, insn->bb_false->nr);
-			break;
-		}
-		buf += sprintf(buf, ".L%u", insn->bb_true ? insn->bb_true->nr : insn->bb_false->nr);
+		buf += sprintf(buf, ".L%u", insn->bb_true->nr);
 		break;
 
 	case OP_SYMADDR: {
@@ -723,7 +725,7 @@ static void add_branch(struct entrypoint *ep, struct expression *expr, pseudo_t
 	struct instruction *br;
 
 	if (bb_reachable(bb)) {
-       		br = alloc_instruction(OP_BR, 0);
+		br = alloc_instruction(OP_CBR, 0);
 		use_pseudo(br, cond, &br->cond);
 		br->bb_true = bb_true;
 		br->bb_false = bb_false;
diff --git a/linearize.h b/linearize.h
index 5c938cd5d..2aa255154 100644
--- a/linearize.h
+++ b/linearize.h
@@ -137,6 +137,7 @@ enum opcode {
 	OP_TERMINATOR,
 	OP_RET = OP_TERMINATOR,
 	OP_BR,
+	OP_CBR,
 	OP_SWITCH,
 	OP_INVOKE,
 	OP_COMPUTEDGOTO,
diff --git a/liveness.c b/liveness.c
index 2e5139433..7461738b4 100644
--- a/liveness.c
+++ b/liveness.c
@@ -56,7 +56,8 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 		USES(src);
 		break;
 
-	case OP_BR: case OP_SWITCH:
+	case OP_CBR:
+	case OP_SWITCH:
 		USES(cond);
 		break;
 
diff --git a/simplify.c b/simplify.c
index 3bc9985e8..c157c6153 100644
--- a/simplify.c
+++ b/simplify.c
@@ -67,7 +67,7 @@ static int if_convert_phi(struct instruction *insn)
 	 * stuff. Verify that here.
 	 */
 	br = last_instruction(source->insns);
-	if (!br || br->opcode != OP_BR)
+	if (!br || br->opcode != OP_CBR)
 		return 0;
 
 	assert(br->cond);
@@ -227,11 +227,7 @@ void kill_insn(struct instruction *insn, int force)
 		repeat_phase |= REPEAT_SYMBOL_CLEANUP;
 		break;
 
-	case OP_BR:
-		if (!insn->bb_true || !insn->bb_false)
-			break;
-		/* fall through */
-
+	case OP_CBR:
 	case OP_COMPUTEDGOTO:
 		kill_use(&insn->cond);
 		break;
@@ -266,6 +262,7 @@ void kill_insn(struct instruction *insn, int force)
 		/* ignore */
 		return;
 
+	case OP_BR:
 	default:
 		break;
 	}
@@ -1052,6 +1049,7 @@ static int simplify_branch(struct instruction *insn)
 		insn->bb_false = NULL;
 		kill_use(&insn->cond);
 		insn->cond = NULL;
+		insn->opcode = OP_BR;
 		return REPEAT_CSE;
 	}
 
@@ -1181,6 +1179,7 @@ int simplify_instruction(struct instruction *insn)
 		break;
 	case OP_SEL:
 		return simplify_select(insn);
+	case OP_CBR:
 	case OP_BR:
 		return simplify_branch(insn);
 	case OP_SWITCH:
diff --git a/sparse-llvm.c b/sparse-llvm.c
index 3d2218ef6..9f362b3ed 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -642,19 +642,19 @@ static LLVMValueRef bool_value(struct function *fn, LLVMValueRef value)
 	return value;
 }
 
-static void output_op_br(struct function *fn, struct instruction *br)
+static void output_op_cbr(struct function *fn, struct instruction *br)
 {
-	if (br->cond) {
-		LLVMValueRef cond = bool_value(fn,
-				pseudo_to_value(fn, br, br->cond));
+	LLVMValueRef cond = bool_value(fn,
+			pseudo_to_value(fn, br, br->cond));
 
-		LLVMBuildCondBr(fn->builder, cond,
-				br->bb_true->priv,
-				br->bb_false->priv);
-	} else
-		LLVMBuildBr(fn->builder,
-			    br->bb_true ? br->bb_true->priv :
-			    br->bb_false->priv);
+	LLVMBuildCondBr(fn->builder, cond,
+			br->bb_true->priv,
+			br->bb_false->priv);
+}
+
+static void output_op_br(struct function *fn, struct instruction *br)
+{
+	LLVMBuildBr(fn->builder, br->bb_true->priv);
 }
 
 static void output_op_sel(struct function *fn, struct instruction *insn)
@@ -810,6 +810,9 @@ static void output_insn(struct function *fn, struct instruction *insn)
 	case OP_BR:
 		output_op_br(fn, insn);
 		break;
+	case OP_CBR:
+		output_op_cbr(fn, insn);
+		break;
 	case OP_SYMADDR:
 		assert(0);
 		break;
diff --git a/validation/loop-linearization.c b/validation/loop-linearization.c
new file mode 100644
index 000000000..25c6dfb87
--- /dev/null
+++ b/validation/loop-linearization.c
@@ -0,0 +1,136 @@
+extern int p(int);
+
+static int ffor(void)
+{
+	int i;
+	for (int i = 0; i < 10; i++) {
+		if (!p(i))
+			return 0;
+	}
+	return 1;
+}
+
+static int fwhile(void)
+{
+	int i = 0;
+	while (i < 10) {
+		if (!p(i))
+			return 0;
+		i++;
+	}
+	return 1;
+}
+
+static int fdo(void)
+{
+	int i = 0;
+	do {
+		if (!p(i))
+			return 0;
+	} while (i++ < 10);
+	return 1;
+}
+
+/*
+ * check-name: loop-linearization
+ * check-command: test-linearize $file
+ *
+ * check-output-start
+ffor:
+.L0:
+	<entry-point>
+	phisrc.32   %phi5(i) <- $0
+	br          .L4
+
+.L4:
+	phi.32      %r1(i) <- %phi5(i), %phi6(i)
+	setlt.32    %r2 <- %r1(i), $10
+	cbr         %r2, .L1, .L3
+
+.L1:
+	call.32     %r4 <- p, %r1(i)
+	cbr         %r4, .L2, .L5
+
+.L5:
+	phisrc.32   %phi1(return) <- $0
+	br          .L7
+
+.L2:
+	add.32      %r7 <- %r1(i), $1
+	phisrc.32   %phi6(i) <- %r7
+	br          .L4
+
+.L3:
+	phisrc.32   %phi2(return) <- $1
+	br          .L7
+
+.L7:
+	phi.32      %r5 <- %phi1(return), %phi2(return)
+	ret.32      %r5
+
+
+fwhile:
+.L8:
+	<entry-point>
+	phisrc.32   %phi11(i) <- $0
+	br          .L12
+
+.L12:
+	phi.32      %r8(i) <- %phi11(i), %phi12(i)
+	setlt.32    %r9 <- %r8(i), $10
+	cbr         %r9, .L9, .L11
+
+.L9:
+	call.32     %r11 <- p, %r8(i)
+	cbr         %r11, .L14, .L13
+
+.L13:
+	phisrc.32   %phi7(return) <- $0
+	br          .L15
+
+.L14:
+	add.32      %r14 <- %r8(i), $1
+	phisrc.32   %phi12(i) <- %r14
+	br          .L12
+
+.L11:
+	phisrc.32   %phi8(return) <- $1
+	br          .L15
+
+.L15:
+	phi.32      %r12 <- %phi7(return), %phi8(return)
+	ret.32      %r12
+
+
+fdo:
+.L16:
+	<entry-point>
+	phisrc.32   %phi16(i) <- $0
+	br          .L17
+
+.L17:
+	phi.32      %r15(i) <- %phi16(i), %phi17(i)
+	call.32     %r16 <- p, %r15(i)
+	cbr         %r16, .L18, .L20
+
+.L20:
+	phisrc.32   %phi13(return) <- $0
+	br          .L22
+
+.L18:
+	add.32      %r19 <- %r15(i), $1
+	setlt.32    %r20 <- %r15(i), $10
+	phisrc.32   %phi17(i) <- %r19
+	cbr         %r20, .L17, .L19
+
+.L19:
+	phisrc.32   %phi14(return) <- $1
+	br          .L22
+
+.L22:
+	phi.32      %r17 <- %phi13(return), %phi14(return)
+	ret.32      %r17
+
+
+ * check-output-end
+ */
-- 
2.11.0

