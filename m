From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] fix support of floating-point compare
Date: Tue, 28 Mar 2017 16:18:28 +0200
Message-ID: <20170328141829.21421-4-luc.vanoostenryck@gmail.com>
References: <20170328141829.21421-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33019 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752012AbdC1O1n (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 10:27:43 -0400
Received: by mail-wr0-f196.google.com with SMTP id u18so3772877wrc.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 07:27:32 -0700 (PDT)
In-Reply-To: <20170328141829.21421-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Comparision of floating-point values can't be done
like for integral values because of the possibility to have
NaNs which can't be ordered with normal values or even between
themselves.
The real difference appears once there is any "reasoning"
done with the result of the comparison. For example, once NaNs
are taken in account: "!(a < b)" and "(a >= b)" are not the same.

In fact the usual comparison operators must be reinterpreted
as implicitely first testing if any of the operand is a Nan
and return 'false' if it is the case. Thus "a < b" becomes
"!isnan(a) && !isnan(b) && (a < b)".
If we need to negate the comparison we get "!(a < b)" which
naturally becomes "isnan(a) || isnan(b) || (a >= b)".

We thus need two sets of operators for comparison of floats:
one for the "ordered" values (only true if neither operand
is a Nan) and one for the "values" (also true if either
operand is a NaN). A negation of the comparison switch from one
of the set to the other.

So, introduce another set of instructions for the comparison
of floats.

Note: the C standard requires that:
	*) "x == x" is false if x is a NaN,
	*) "x != x" is true  if x is a NaN,
and this is coherent with "x != x" <-> "!(x == x)".

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                       |  21 ++++++-
 linearize.h                       |  18 ++++++
 liveness.c                        |   1 +
 opcode.c                          |  38 ++++++++----
 opcode.h                          |  10 ++++
 simplify.c                        |   2 +-
 sparse-llvm.c                     |  27 +++++----
 validation/optim/canonical-fcmp.c | 123 ++++++++++++++++++++++++++++++++++++++
 8 files changed, 215 insertions(+), 25 deletions(-)
 create mode 100644 validation/optim/canonical-fcmp.c

diff --git a/linearize.c b/linearize.c
index ed649a86a..37c201496 100644
--- a/linearize.c
+++ b/linearize.c
@@ -208,6 +208,22 @@ static const char *opcodes[] = {
 	[OP_SET_BE] = "setbe",
 	[OP_SET_AE] = "setae",
 
+	/* floating-point comparison */
+	[OP_FCMP_ORD] = "fcmpord",
+	[OP_FCMP_OEQ] = "fcmpoeq",
+	[OP_FCMP_ONE] = "fcmpone",
+	[OP_FCMP_OLE] = "fcmpole",
+	[OP_FCMP_OGE] = "fcmpoge",
+	[OP_FCMP_OLT] = "fcmpolt",
+	[OP_FCMP_OGT] = "fcmpogt",
+	[OP_FCMP_UEQ] = "fcmpueq",
+	[OP_FCMP_UNE] = "fcmpune",
+	[OP_FCMP_ULE] = "fcmpule",
+	[OP_FCMP_UGE] = "fcmpuge",
+	[OP_FCMP_ULT] = "fcmpult",
+	[OP_FCMP_UGT] = "fcmpugt",
+	[OP_FCMP_UNO] = "fcmpuno",
+
 	/* Uni */
 	[OP_NOT] = "not",
 	[OP_NEG] = "neg",
@@ -437,6 +453,7 @@ const char *show_instruction(struct instruction *insn)
 			show_pseudo(insn->src));
 		break;
 	case OP_BINARY ... OP_BINARY_END:
+	case OP_FPCMP ... OP_FPCMP_END:
 	case OP_BINCMP ... OP_BINCMP_END:
 		buf += sprintf(buf, "%s <- %s, %s", show_pseudo(insn->target), show_pseudo(insn->src1), show_pseudo(insn->src2));
 		break;
@@ -1465,10 +1482,10 @@ static pseudo_t linearize_compare(struct entrypoint *ep, struct expression *expr
 		[SPECIAL_UNSIGNED_LTE] = OP_SET_BE,
 		[SPECIAL_UNSIGNED_GTE] = OP_SET_AE,
 	};
-
+	int op = opcode_float(cmpop[expr->op], expr->right->ctype);
 	pseudo_t src1 = linearize_expression(ep, expr->left);
 	pseudo_t src2 = linearize_expression(ep, expr->right);
-	pseudo_t dst = add_binary_op(ep, expr->ctype, cmpop[expr->op], src1, src2);
+	pseudo_t dst = add_binary_op(ep, expr->ctype, op, src1, src2);
 	return dst;
 }
 
diff --git a/linearize.h b/linearize.h
index ce065fe76..3bb9426ca 100644
--- a/linearize.h
+++ b/linearize.h
@@ -170,6 +170,24 @@ enum opcode {
 	OP_OR_BOOL,
 	OP_BINARY_END = OP_OR_BOOL,
 
+	/* floating-point comparison */
+	OP_FPCMP,
+	OP_FCMP_ORD = OP_FPCMP,
+	OP_FCMP_OEQ,
+	OP_FCMP_ONE,
+	OP_FCMP_OLE,
+	OP_FCMP_OGE,
+	OP_FCMP_OLT,
+	OP_FCMP_OGT,
+	OP_FCMP_UEQ,
+	OP_FCMP_UNE,
+	OP_FCMP_ULE,
+	OP_FCMP_UGE,
+	OP_FCMP_ULT,
+	OP_FCMP_UGT,
+	OP_FCMP_UNO,
+	OP_FPCMP_END = OP_FCMP_UNO,
+
 	/* Binary comparison */
 	OP_BINCMP,
 	OP_SET_EQ = OP_BINCMP,
diff --git a/liveness.c b/liveness.c
index 7b5b1693a..f7c0414b5 100644
--- a/liveness.c
+++ b/liveness.c
@@ -66,6 +66,7 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 	
 	/* Binary */
 	case OP_BINARY ... OP_BINARY_END:
+	case OP_FPCMP ... OP_FPCMP_END:
 	case OP_BINCMP ... OP_BINCMP_END:
 		USES(src1); USES(src2); DEFINES(target);
 		break;
diff --git a/opcode.c b/opcode.c
index 102bef68d..c28a08859 100644
--- a/opcode.c
+++ b/opcode.c
@@ -23,14 +23,32 @@
 #include "linearize.h"
 
 const struct opcode_table opcode_table[OP_LAST] = {
-	[OP_SET_EQ] = {	.negate = OP_SET_NE, .swap = OP_SET_EQ, },
-	[OP_SET_NE] = {	.negate = OP_SET_EQ, .swap = OP_SET_NE, },
-	[OP_SET_LT] = {	.negate = OP_SET_GE, .swap = OP_SET_GT, },
-	[OP_SET_LE] = {	.negate = OP_SET_GT, .swap = OP_SET_GE, },
-	[OP_SET_GE] = {	.negate = OP_SET_LT, .swap = OP_SET_LE, },
-	[OP_SET_GT] = {	.negate = OP_SET_LE, .swap = OP_SET_LT, },
-	[OP_SET_B ] = {	.negate = OP_SET_AE, .swap = OP_SET_A , },
-	[OP_SET_BE] = {	.negate = OP_SET_A , .swap = OP_SET_AE, },
-	[OP_SET_AE] = {	.negate = OP_SET_B , .swap = OP_SET_BE, },
-	[OP_SET_A ] = {	.negate = OP_SET_BE, .swap = OP_SET_B , },
+	[OP_SET_EQ] = {	.negate = OP_SET_NE, .swap = OP_SET_EQ, .to_float = OP_FCMP_OEQ, },
+	[OP_SET_NE] = {	.negate = OP_SET_EQ, .swap = OP_SET_NE, .to_float = OP_FCMP_UNE, },
+	[OP_SET_LT] = {	.negate = OP_SET_GE, .swap = OP_SET_GT, .to_float = OP_FCMP_OLT, },
+	[OP_SET_LE] = {	.negate = OP_SET_GT, .swap = OP_SET_GE, .to_float = OP_FCMP_OLE, },
+	[OP_SET_GE] = {	.negate = OP_SET_LT, .swap = OP_SET_LE, .to_float = OP_FCMP_OGE, },
+	[OP_SET_GT] = {	.negate = OP_SET_LE, .swap = OP_SET_LT, .to_float = OP_FCMP_OGT, },
+	[OP_SET_B ] = {	.negate = OP_SET_AE, .swap = OP_SET_A , .to_float = OP_FCMP_OLT, },
+	[OP_SET_BE] = {	.negate = OP_SET_A , .swap = OP_SET_AE, .to_float = OP_FCMP_OLE, },
+	[OP_SET_AE] = {	.negate = OP_SET_B , .swap = OP_SET_BE, .to_float = OP_FCMP_OGE, },
+	[OP_SET_A ] = {	.negate = OP_SET_BE, .swap = OP_SET_B , .to_float = OP_FCMP_OGT, },
+
+	[OP_FCMP_ORD] = { .negate = OP_FCMP_UNO, .swap = OP_FCMP_ORD, },
+	[OP_FCMP_UNO] = { .negate = OP_FCMP_ORD, .swap = OP_FCMP_UNO, },
+
+	[OP_FCMP_OEQ] = { .negate = OP_FCMP_UNE, .swap = OP_FCMP_OEQ, },
+	[OP_FCMP_ONE] = { .negate = OP_FCMP_UEQ, .swap = OP_FCMP_ONE, },
+	[OP_FCMP_UEQ] = { .negate = OP_FCMP_ONE, .swap = OP_FCMP_UEQ, },
+	[OP_FCMP_UNE] = { .negate = OP_FCMP_OEQ, .swap = OP_FCMP_UNE, },
+
+	[OP_FCMP_OLT] = { .negate = OP_FCMP_UGE, .swap = OP_FCMP_OGT, },
+	[OP_FCMP_OLE] = { .negate = OP_FCMP_UGT, .swap = OP_FCMP_OGE, },
+	[OP_FCMP_OGE] = { .negate = OP_FCMP_ULT, .swap = OP_FCMP_OLE, },
+	[OP_FCMP_OGT] = { .negate = OP_FCMP_ULE, .swap = OP_FCMP_OLT, },
+
+	[OP_FCMP_ULT] = { .negate = OP_FCMP_OGE, .swap = OP_FCMP_UGT, },
+	[OP_FCMP_ULE] = { .negate = OP_FCMP_OGT, .swap = OP_FCMP_UGE, },
+	[OP_FCMP_UGE] = { .negate = OP_FCMP_OLT, .swap = OP_FCMP_ULE, },
+	[OP_FCMP_UGT] = { .negate = OP_FCMP_OLE, .swap = OP_FCMP_ULT, },
 };
diff --git a/opcode.h b/opcode.h
index 4a9b102f2..eda4c3a74 100644
--- a/opcode.h
+++ b/opcode.h
@@ -1,10 +1,20 @@
 #ifndef OPCODE_H
 #define OPCODE_H
 
+#include "symbol.h"
 
 extern const struct opcode_table {
 	int	negate:8;
 	int	swap:8;
+	int	to_float:8;
 } opcode_table[];
 
+
+static inline int opcode_float(int opcode, struct symbol *type)
+{
+	if (!type || !is_float_type(type))
+		return opcode;
+	return opcode_table[opcode].to_float;
+}
+
 #endif
diff --git a/simplify.c b/simplify.c
index 7ca727416..2286440e0 100644
--- a/simplify.c
+++ b/simplify.c
@@ -429,7 +429,7 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 	inverse = (insn->opcode == OP_SET_NE) == value;
 	opcode = def->opcode;
 	switch (opcode) {
-	case OP_BINCMP ... OP_BINCMP_END:
+	case OP_FPCMP ... OP_BINCMP_END:
 		// Convert:
 		//	setcc.n	%t <- %a, %b
 		//	setne.m %r <- %t, $0
diff --git a/sparse-llvm.c b/sparse-llvm.c
index b82fbefa1..c21c38947 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -492,17 +492,20 @@ static LLVMValueRef calc_gep(LLVMBuilderRef builder, LLVMValueRef base, LLVMValu
 static LLVMRealPredicate translate_fop(int opcode)
 {
 	static const LLVMRealPredicate trans_tbl[] = {
-		[OP_SET_EQ]	= LLVMRealOEQ,
-		[OP_SET_NE]	= LLVMRealUNE,
-		[OP_SET_LE]	= LLVMRealOLE,
-		[OP_SET_GE]	= LLVMRealOGE,
-		[OP_SET_LT]	= LLVMRealOLT,
-		[OP_SET_GT]	= LLVMRealOGT,
-		/* Are these used with FP? */
-		[OP_SET_B]	= LLVMRealOLT,
-		[OP_SET_A]	= LLVMRealOGT,
-		[OP_SET_BE]	= LLVMRealOLE,
-		[OP_SET_AE]	= LLVMRealOGE,
+		[OP_FCMP_ORD]	= LLVMRealORD,
+		[OP_FCMP_OEQ]	= LLVMRealOEQ,
+		[OP_FCMP_ONE]	= LLVMRealONE,
+		[OP_FCMP_OLE]	= LLVMRealOLE,
+		[OP_FCMP_OGE]	= LLVMRealOGE,
+		[OP_FCMP_OLT]	= LLVMRealOLT,
+		[OP_FCMP_OGT]	= LLVMRealOGT,
+		[OP_FCMP_UEQ]	= LLVMRealUEQ,
+		[OP_FCMP_UNE]	= LLVMRealUNE,
+		[OP_FCMP_ULE]	= LLVMRealULE,
+		[OP_FCMP_UGE]	= LLVMRealUGE,
+		[OP_FCMP_ULT]	= LLVMRealULT,
+		[OP_FCMP_UGT]	= LLVMRealUGT,
+		[OP_FCMP_UNO]	= LLVMRealUNO,
 	};
 
 	return trans_tbl[opcode];
@@ -1029,7 +1032,7 @@ static void output_insn(struct function *fn, struct instruction *insn)
 	case OP_BINARY ... OP_BINARY_END:
 		output_op_binary(fn, insn);
 		break;
-	case OP_BINCMP ... OP_BINCMP_END:
+	case OP_FPCMP ... OP_BINCMP_END:
 		output_op_compare(fn, insn);
 		break;
 	case OP_SEL:
diff --git a/validation/optim/canonical-fcmp.c b/validation/optim/canonical-fcmp.c
new file mode 100644
index 000000000..e3e758a9b
--- /dev/null
+++ b/validation/optim/canonical-fcmp.c
@@ -0,0 +1,123 @@
+extern double g;
+
+int  fcmp_eq(double a) { return  (g == a); }
+int  fcmp_ne(double a) { return  (g != a); }
+
+int  fcmp_gt(double a) { return  (g >  a); }
+int  fcmp_ge(double a) { return  (g >= a); }
+int  fcmp_le(double a) { return  (g <= a); }
+int  fcmp_lt(double a) { return  (g <  a); }
+
+int nfcmp_ne(double a) { return !(g == a); }
+int nfcmp_eq(double a) { return !(g != a); }
+
+int nfcmp_le(double a) { return !(g >  a); }
+int nfcmp_lt(double a) { return !(g >= a); }
+int nfcmp_gt(double a) { return !(g <= a); }
+int nfcmp_ge(double a) { return !(g <  a); }
+
+/*
+ * check-name: canonical-cmp
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-exclude: \$123,
+ *
+ * check-output-start
+fcmp_eq:
+.L0:
+	<entry-point>
+	load.64     %r1 <- 0[g]
+	fcmpoeq.32  %r3 <- %r1, %arg1
+	ret.32      %r3
+
+
+fcmp_ne:
+.L2:
+	<entry-point>
+	load.64     %r5 <- 0[g]
+	fcmpune.32  %r7 <- %r5, %arg1
+	ret.32      %r7
+
+
+fcmp_gt:
+.L4:
+	<entry-point>
+	load.64     %r9 <- 0[g]
+	fcmpogt.32  %r11 <- %r9, %arg1
+	ret.32      %r11
+
+
+fcmp_ge:
+.L6:
+	<entry-point>
+	load.64     %r13 <- 0[g]
+	fcmpoge.32  %r15 <- %r13, %arg1
+	ret.32      %r15
+
+
+fcmp_le:
+.L8:
+	<entry-point>
+	load.64     %r17 <- 0[g]
+	fcmpole.32  %r19 <- %r17, %arg1
+	ret.32      %r19
+
+
+fcmp_lt:
+.L10:
+	<entry-point>
+	load.64     %r21 <- 0[g]
+	fcmpolt.32  %r23 <- %r21, %arg1
+	ret.32      %r23
+
+
+nfcmp_ne:
+.L12:
+	<entry-point>
+	load.64     %r25 <- 0[g]
+	fcmpune.32  %r28 <- %r25, %arg1
+	ret.32      %r28
+
+
+nfcmp_eq:
+.L14:
+	<entry-point>
+	load.64     %r30 <- 0[g]
+	fcmpoeq.32  %r33 <- %r30, %arg1
+	ret.32      %r33
+
+
+nfcmp_le:
+.L16:
+	<entry-point>
+	load.64     %r35 <- 0[g]
+	fcmpule.32  %r38 <- %r35, %arg1
+	ret.32      %r38
+
+
+nfcmp_lt:
+.L18:
+	<entry-point>
+	load.64     %r40 <- 0[g]
+	fcmpult.32  %r43 <- %r40, %arg1
+	ret.32      %r43
+
+
+nfcmp_gt:
+.L20:
+	<entry-point>
+	load.64     %r45 <- 0[g]
+	fcmpugt.32  %r48 <- %r45, %arg1
+	ret.32      %r48
+
+
+nfcmp_ge:
+.L22:
+	<entry-point>
+	load.64     %r50 <- 0[g]
+	fcmpuge.32  %r53 <- %r50, %arg1
+	ret.32      %r53
+
+
+ * check-output-end
+ */
-- 
2.12.0

