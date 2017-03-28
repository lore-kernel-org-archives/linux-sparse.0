From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] add support of floating-point specific arithmetic ops
Date: Tue, 28 Mar 2017 16:18:29 +0200
Message-ID: <20170328141829.21421-5-luc.vanoostenryck@gmail.com>
References: <20170328141829.21421-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33369 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbdC1O2Z (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 10:28:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id o81so16213wmb.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 07:28:23 -0700 (PDT)
In-Reply-To: <20170328141829.21421-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Floating-point arithmetic is quite different from the
arithmetic on integers or the one of real numbers.
In particular, most transformations, simplifications that can
be done on integers are invalid when done on floats.
For example:
- associativity doesn't hold
- distributivity doesn't hold
- comparison is tricky & complex
This is because (among others things):
- limited precision, rounding everywhere
- presence of signed zeroes
- presence of infinities
- presence of NaNs (signaling or quiet)
- presence of numbers without inverse
- several kind of exceptions.

Since they don't follow the same rules as their integer
counterpart, better to give them a specific opcode
instead of having to test the type of the operands at
each manipulation.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cse.c                               | 14 +++++++++
 linearize.c                         | 19 ++++++++++---
 linearize.h                         |  7 +++++
 opcode.c                            |  8 ++++++
 sparse-llvm.c                       | 37 +++++++++++++-----------
 validation/backend/arithmetic-ops.c | 20 +++++++++++++
 validation/fp-ops.c                 | 57 +++++++++++++++++++++++++++++++++++++
 7 files changed, 141 insertions(+), 21 deletions(-)
 create mode 100644 validation/fp-ops.c

diff --git a/cse.c b/cse.c
index 0d3815c5a..f535636b4 100644
--- a/cse.c
+++ b/cse.c
@@ -70,11 +70,18 @@ static void clean_up_one_instruction(struct basic_block *bb, struct instruction
 	case OP_SET_LT: case OP_SET_GT:
 	case OP_SET_B:  case OP_SET_A:
 	case OP_SET_BE: case OP_SET_AE:
+
+	/* floating-point arithmetic */
+	case OP_FADD:
+	case OP_FSUB:
+	case OP_FMUL:
+	case OP_FDIV:
 		hash += hashval(insn->src2);
 		/* Fall through */
 	
 	/* Unary */
 	case OP_NOT: case OP_NEG:
+	case OP_FNEG:
 		hash += hashval(insn->src1);
 		break;
 
@@ -205,6 +212,12 @@ static int insn_compare(const void *_i1, const void *_i2)
 	case OP_SET_LT: case OP_SET_GT:
 	case OP_SET_B:  case OP_SET_A:
 	case OP_SET_BE: case OP_SET_AE:
+
+	/* floating-point arithmetic */
+	case OP_FADD:
+	case OP_FSUB:
+	case OP_FMUL:
+	case OP_FDIV:
 	case_binops:
 		if (i1->src2 != i2->src2)
 			return i1->src2 < i2->src2 ? -1 : 1;
@@ -212,6 +225,7 @@ static int insn_compare(const void *_i1, const void *_i2)
 
 	/* Unary */
 	case OP_NOT: case OP_NEG:
+	case OP_FNEG:
 		if (i1->src1 != i2->src1)
 			return i1->src1 < i2->src1 ? -1 : 1;
 		break;
diff --git a/linearize.c b/linearize.c
index 37c201496..902d45087 100644
--- a/linearize.c
+++ b/linearize.c
@@ -189,6 +189,12 @@ static const char *opcodes[] = {
 	[OP_LSR] = "lsr",
 	[OP_ASR] = "asr",
 	
+	/* Floating-point Binary */
+	[OP_FADD] = "fadd",
+	[OP_FSUB] = "fsub",
+	[OP_FMUL] = "fmul",
+	[OP_FDIV] = "fdiv",
+
 	/* Logical */
 	[OP_AND] = "and",
 	[OP_OR] = "or",
@@ -227,6 +233,7 @@ static const char *opcodes[] = {
 	/* Uni */
 	[OP_NOT] = "not",
 	[OP_NEG] = "neg",
+	[OP_FNEG] = "fneg",
 
 	/* Special three-input */
 	[OP_SEL] = "select",
@@ -468,6 +475,7 @@ const char *show_instruction(struct instruction *insn)
 		break;
 
 	case OP_NOT: case OP_NEG:
+	case OP_FNEG:
 		buf += sprintf(buf, "%s <- %s", show_pseudo(insn->target), show_pseudo(insn->src1));
 		break;
 
@@ -1067,6 +1075,7 @@ static pseudo_t linearize_inc_dec(struct entrypoint *ep, struct expression *expr
 		return VOID;
 
 	old = linearize_load_gen(ep, &ad);
+	op = opcode_float(op, expr->ctype);
 	if (is_float_type(expr->ctype))
 		one = add_setfval(ep, expr->ctype, expr->op_value);
 	else
@@ -1115,7 +1124,7 @@ static pseudo_t linearize_regular_preop(struct entrypoint *ep, struct expression
 	case '~':
 		return add_uniop(ep, expr, OP_NOT, pre);
 	case '-':
-		return add_uniop(ep, expr, OP_NEG, pre);
+		return add_uniop(ep, expr, opcode_float(OP_NEG, expr->ctype), pre);
 	}
 	return VOID;
 }
@@ -1183,8 +1192,10 @@ static pseudo_t cast_pseudo(struct entrypoint *ep, pseudo_t src, struct symbol *
 	return result;
 }
 
-static int opcode_sign(int opcode, struct symbol *ctype)
+static int map_opcode(int opcode, struct symbol *ctype)
 {
+	if (ctype && is_float_type(ctype))
+		return opcode_table[opcode].to_float;
 	if (ctype && (ctype->ctype.modifiers & MOD_SIGNED)) {
 		switch(opcode) {
 		case OP_MULU: case OP_DIVU: case OP_MODU: case OP_LSR:
@@ -1227,7 +1238,7 @@ static pseudo_t linearize_assignment(struct entrypoint *ep, struct expression *e
 
 		ctype = src->ctype;
 		oldvalue = cast_pseudo(ep, oldvalue, target->ctype, ctype);
-		opcode = opcode_sign(op_trans[expr->op - SPECIAL_BASE], ctype);
+		opcode = map_opcode(op_trans[expr->op - SPECIAL_BASE], ctype);
 		dst = add_binary_op(ep, ctype, opcode, oldvalue, value);
 		value = cast_pseudo(ep, dst, ctype, expr->ctype);
 	}
@@ -1353,7 +1364,7 @@ static pseudo_t linearize_binop(struct entrypoint *ep, struct expression *expr)
 
 	src1 = linearize_expression(ep, expr->left);
 	src2 = linearize_expression(ep, expr->right);
-	op = opcode_sign(opcode[expr->op], expr->ctype);
+	op = map_opcode(opcode[expr->op], expr->ctype);
 	dst = add_binary_op(ep, expr->ctype, op, src1, src2);
 	return dst;
 }
diff --git a/linearize.h b/linearize.h
index 3bb9426ca..7e8c0eb2c 100644
--- a/linearize.h
+++ b/linearize.h
@@ -162,6 +162,12 @@ enum opcode {
 	OP_SHL,
 	OP_LSR, OP_ASR,
 	
+	/* Floating-point binops */
+	OP_FADD,
+	OP_FSUB,
+	OP_FMUL,
+	OP_FDIV,
+
 	/* Logical */
 	OP_AND,
 	OP_OR,
@@ -205,6 +211,7 @@ enum opcode {
 	/* Uni */
 	OP_NOT,
 	OP_NEG,
+	OP_FNEG,
 
 	/* Select - three input values */
 	OP_SEL,
diff --git a/opcode.c b/opcode.c
index c28a08859..b5eaae6ad 100644
--- a/opcode.c
+++ b/opcode.c
@@ -51,4 +51,12 @@ const struct opcode_table opcode_table[OP_LAST] = {
 	[OP_FCMP_ULE] = { .negate = OP_FCMP_OGT, .swap = OP_FCMP_UGE, },
 	[OP_FCMP_UGE] = { .negate = OP_FCMP_OLT, .swap = OP_FCMP_ULE, },
 	[OP_FCMP_UGT] = { .negate = OP_FCMP_OLE, .swap = OP_FCMP_ULT, },
+
+	[OP_ADD] = {	.to_float = OP_FADD, },
+	[OP_SUB] = {	.to_float = OP_FSUB, },
+	[OP_MULS] = {	.to_float = OP_FMUL, },
+	[OP_MULU] = {	.to_float = OP_FMUL, },
+	[OP_DIVS] = {	.to_float = OP_FDIV, },
+	[OP_DIVU] = {	.to_float = OP_FDIV, },
+	[OP_NEG] = {	.to_float = OP_FNEG, },
 };
diff --git a/sparse-llvm.c b/sparse-llvm.c
index c21c38947..415f29607 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -542,32 +542,20 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 	switch (insn->opcode) {
 	/* Binary */
 	case OP_ADD:
-		if (is_float_type(insn->type))
-			target = LLVMBuildFAdd(fn->builder, lhs, rhs, target_name);
-		else
-			target = LLVMBuildAdd(fn->builder, lhs, rhs, target_name);
+		target = LLVMBuildAdd(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_SUB:
-		if (is_float_type(insn->type))
-			target = LLVMBuildFSub(fn->builder, lhs, rhs, target_name);
-		else
-			target = LLVMBuildSub(fn->builder, lhs, rhs, target_name);
+		target = LLVMBuildSub(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_MULU:
-		if (is_float_type(insn->type))
-			target = LLVMBuildFMul(fn->builder, lhs, rhs, target_name);
-		else
-			target = LLVMBuildMul(fn->builder, lhs, rhs, target_name);
+		target = LLVMBuildMul(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_MULS:
 		assert(!is_float_type(insn->type));
 		target = LLVMBuildMul(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_DIVU:
-		if (is_float_type(insn->type))
-			target = LLVMBuildFDiv(fn->builder, lhs, rhs, target_name);
-		else
-			target = LLVMBuildUDiv(fn->builder, lhs, rhs, target_name);
+		target = LLVMBuildUDiv(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_DIVS:
 		assert(!is_float_type(insn->type));
@@ -593,6 +581,20 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 		assert(!is_float_type(insn->type));
 		target = LLVMBuildAShr(fn->builder, lhs, rhs, target_name);
 		break;
+
+	/* floating-point */
+	case OP_FADD:
+		target = LLVMBuildFAdd(fn->builder, lhs, rhs, target_name);
+		break;
+	case OP_FSUB:
+		target = LLVMBuildFSub(fn->builder, lhs, rhs, target_name);
+		break;
+	case OP_FMUL:
+		target = LLVMBuildFMul(fn->builder, lhs, rhs, target_name);
+		break;
+	case OP_FDIV:
+		target = LLVMBuildFDiv(fn->builder, lhs, rhs, target_name);
+		break;
 	
 	/* Logical */
 	case OP_AND:
@@ -1054,6 +1056,7 @@ static void output_insn(struct function *fn, struct instruction *insn)
 		insn->target->priv = target;
 		break;
 	}
+	case OP_FNEG:
 	case OP_NEG: {
 		LLVMValueRef src, target;
 		char target_name[64];
@@ -1062,7 +1065,7 @@ static void output_insn(struct function *fn, struct instruction *insn)
 
 		pseudo_name(insn->target, target_name);
 
-		if (is_float_type(insn->type))
+		if (insn->opcode == OP_FNEG)
 			target = LLVMBuildFNeg(fn->builder, src, target_name);
 		else
 			target = LLVMBuildNeg(fn->builder, src, target_name);
diff --git a/validation/backend/arithmetic-ops.c b/validation/backend/arithmetic-ops.c
index 7c299d033..d2988a0f6 100644
--- a/validation/backend/arithmetic-ops.c
+++ b/validation/backend/arithmetic-ops.c
@@ -88,6 +88,26 @@ static unsigned int umod(unsigned int x, unsigned int y)
 	return x % y;
 }
 
+static int neg(int x)
+{
+	return -x;
+}
+
+static unsigned int uneg(unsigned int x)
+{
+	return -x;
+}
+
+static float fneg(float x)
+{
+	return -x;
+}
+
+static double dneg(double x)
+{
+	return -x;
+}
+
 /*
  * check-name: Arithmetic operator code generation
  * check-command: ./sparsec -c $file -o tmp.o
diff --git a/validation/fp-ops.c b/validation/fp-ops.c
new file mode 100644
index 000000000..7f58a72fc
--- /dev/null
+++ b/validation/fp-ops.c
@@ -0,0 +1,57 @@
+double fadd(double x, double y) { return x + y; }
+double fsub(double x, double y) { return x - y; }
+double fmul(double x, double y) { return x * y; }
+double fdiv(double x, double y) { return x / y; }
+double fneg(double x)           { return -x; }
+_Bool  ftst(double x)           { return !x; }
+
+/*
+ * check-name: floating-point ops
+ * check-command: ./test-linearize -Wno-decl $file
+
+ * check-output-start
+fadd:
+.L0:
+	<entry-point>
+	fadd.64     %r3 <- %arg1, %arg2
+	ret.64      %r3
+
+
+fsub:
+.L2:
+	<entry-point>
+	fsub.64     %r7 <- %arg1, %arg2
+	ret.64      %r7
+
+
+fmul:
+.L4:
+	<entry-point>
+	fmul.64     %r11 <- %arg1, %arg2
+	ret.64      %r11
+
+
+fdiv:
+.L6:
+	<entry-point>
+	fdiv.64     %r15 <- %arg1, %arg2
+	ret.64      %r15
+
+
+fneg:
+.L8:
+	<entry-point>
+	fneg.64     %r18 <- %arg1
+	ret.64      %r18
+
+
+ftst:
+.L10:
+	<entry-point>
+	set.64      %r21 <- 0.000000
+	fcmpoeq.1   %r23 <- %arg1, %r21
+	ret.1       %r23
+
+
+ * check-output-end
+ */
-- 
2.12.0

