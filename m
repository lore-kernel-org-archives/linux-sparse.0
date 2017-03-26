From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v5 04/14] rewrite compare_opcode() like
 swap_compare_opcode()
Date: Sun, 26 Mar 2017 01:22:21 +0100
Message-ID: <20170326002220.iizbx4k3e7xm4qit@macpro.local>
References: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
 <20170324231421.14869-5-luc.vanoostenryck@gmail.com>
 <CA+55aFzgt9iAKQqNzBPDFT=kTL9sP=OyjsQOJ+mxuJYQRwPQkg@mail.gmail.com>
 <CAMHZB6Fb2Zjpr720P88RPCe-TBtak0G9qiBAiTk0eLpeFCV31g@mail.gmail.com>
 <CANeU7Qm_6_PtvOE=WpubgPgyo7SSGXvX3j8rq5m4UzR1EiHxQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32935 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbdCZAbA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 25 Mar 2017 20:31:00 -0400
Received: by mail-wr0-f196.google.com with SMTP id 20so3465505wrx.0
        for <linux-sparse@vger.kernel.org>; Sat, 25 Mar 2017 17:30:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qm_6_PtvOE=WpubgPgyo7SSGXvX3j8rq5m4UzR1EiHxQQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Mar 25, 2017 at 04:35:39PM -0700, Christopher Li wrote:
> On Fri, Mar 24, 2017 at 4:54 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Yes, indeed.
> > I've some plan to add better handling of floating-point and the compare
> > is part of it. It'll need a new set of instructions to do it correctly
> > (precisely
> > because for fp numbers once you care about NaNs/unordered "a < b" is *not*
> > the same as "!(a >= b)").
> > But there is also a number of bugs I want to solve, especially one related to
> > the misplacement of phi-node and another about missing reloads. For the moment
> > I think we can pretend that all the fp values we deal with are ordered ones.
> 
> Can we detect it is the floating point type then avoid doing the
> compare swap for
> floating point?

Yes, surely but I prefer a real solution, something like this patch:

From c4cc158772315a127534e4aac5b8d369097484db Mon Sep 17 00:00:00 2001
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Sat, 25 Mar 2017 03:01:17 +0100
Subject: [PATCH] fix support of floating-point compare

---
 linearize.c                       |  29 ++++++++-
 linearize.h                       |  19 ++++++
 liveness.c                        |   1 +
 simplify.c                        |  84 ++++++++++++++++++--------
 sparse-llvm.c                     |  27 +++++----
 validation/optim/canonical-fcmp.c | 123 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 245 insertions(+), 38 deletions(-)
 create mode 100644 validation/optim/canonical-fcmp.c

diff --git a/linearize.c b/linearize.c
index 7bef5a251..90280945e 100644
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
@@ -433,6 +449,7 @@ const char *show_instruction(struct instruction *insn)
 			show_pseudo(insn->src));
 		break;
 	case OP_BINARY ... OP_BINARY_END:
+	case OP_FP_CMP ... OP_FP_CMP_END:
 	case OP_BINCMP ... OP_BINCMP_END:
 		buf += sprintf(buf, "%s <- %s, %s", show_pseudo(insn->target), show_pseudo(insn->src1), show_pseudo(insn->src2));
 		break;
@@ -1448,10 +1465,20 @@ static pseudo_t linearize_compare(struct entrypoint *ep, struct expression *expr
 		[SPECIAL_UNSIGNED_LTE] = OP_SET_BE,
 		[SPECIAL_UNSIGNED_GTE] = OP_SET_AE,
 	};
+	static const int fcmpop[] = {
+		['>'] = OP_FCMP_OGT,
+		['<'] = OP_FCMP_OLT,
+		[SPECIAL_EQUAL] = OP_FCMP_OEQ,
+		[SPECIAL_NOTEQUAL] = OP_FCMP_ONE,
+		[SPECIAL_GTE] = OP_FCMP_OGE,
+		[SPECIAL_LTE] = OP_FCMP_OLE,
+	};
 
+	struct symbol *ctype = expr->right->ctype;
+	int op = is_float_type(ctype) ? fcmpop[expr->op] : cmpop[expr->op];
 	pseudo_t src1 = linearize_expression(ep, expr->left);
 	pseudo_t src2 = linearize_expression(ep, expr->right);
-	pseudo_t dst = add_binary_op(ep, expr->ctype, cmpop[expr->op], src1, src2);
+	pseudo_t dst = add_binary_op(ep, expr->ctype, op, src1, src2);
 	return dst;
 }
 
diff --git a/linearize.h b/linearize.h
index f0e76c098..b65fc5a53 100644
--- a/linearize.h
+++ b/linearize.h
@@ -169,6 +169,24 @@ enum opcode {
 	OP_OR_BOOL,
 	OP_BINARY_END = OP_OR_BOOL,
 
+	/* floating-point comparison */
+	OP_FP_CMP,
+	OP_FCMP_ORD = OP_FP_CMP,
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
+	OP_FP_CMP_END = OP_FCMP_UNO,
+
 	/* Binary comparison */
 	OP_BINCMP,
 	OP_SET_EQ = OP_BINCMP,
@@ -186,6 +204,7 @@ enum opcode {
 	/* Uni */
 	OP_NOT,
 	OP_NEG,
+	OP_ISNAN,
 
 	/* Select - three input values */
 	OP_SEL,
diff --git a/liveness.c b/liveness.c
index 7b5b1693a..a6fd017d5 100644
--- a/liveness.c
+++ b/liveness.c
@@ -66,6 +66,7 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 	
 	/* Binary */
 	case OP_BINARY ... OP_BINARY_END:
+	case OP_FP_CMP ... OP_FP_CMP_END:
 	case OP_BINCMP ... OP_BINCMP_END:
 		USES(src1); USES(src2); DEFINES(target);
 		break;
diff --git a/simplify.c b/simplify.c
index 97750cddd..b500f6135 100644
--- a/simplify.c
+++ b/simplify.c
@@ -415,44 +415,78 @@ static int simplify_mul_div(struct instruction *insn, long long value)
 static int negate_compare_opcode(int opcode, int inverse)
 {
 	static const unsigned char opcode_tbl[] = {
-		[OP_SET_EQ - OP_BINCMP] = OP_SET_NE,
-		[OP_SET_NE - OP_BINCMP] = OP_SET_EQ,
-		[OP_SET_GT - OP_BINCMP] = OP_SET_LE,
-		[OP_SET_GE - OP_BINCMP] = OP_SET_LT,
-		[OP_SET_LE - OP_BINCMP] = OP_SET_GT,
-		[OP_SET_LT - OP_BINCMP] = OP_SET_GE,
-		[OP_SET_A  - OP_BINCMP] = OP_SET_BE,
-		[OP_SET_AE - OP_BINCMP] = OP_SET_B ,
-		[OP_SET_BE - OP_BINCMP] = OP_SET_A ,
-		[OP_SET_B  - OP_BINCMP] = OP_SET_AE,
+		[OP_FCMP_ORD - OP_FP_CMP] = OP_FCMP_UNO,
+		[OP_FCMP_UNO - OP_FP_CMP] = OP_FCMP_ORD,
+
+		[OP_FCMP_OEQ - OP_FP_CMP] = OP_FCMP_UNE,
+		[OP_FCMP_ONE - OP_FP_CMP] = OP_FCMP_UEQ,
+		[OP_FCMP_OGT - OP_FP_CMP] = OP_FCMP_ULE,
+		[OP_FCMP_OGE - OP_FP_CMP] = OP_FCMP_ULT,
+		[OP_FCMP_OLE - OP_FP_CMP] = OP_FCMP_UGT,
+		[OP_FCMP_OLT - OP_FP_CMP] = OP_FCMP_UGE,
+
+		[OP_FCMP_UEQ - OP_FP_CMP] = OP_FCMP_ONE,
+		[OP_FCMP_UNE - OP_FP_CMP] = OP_FCMP_OEQ,
+		[OP_FCMP_UGT - OP_FP_CMP] = OP_FCMP_OLE,
+		[OP_FCMP_UGE - OP_FP_CMP] = OP_FCMP_OLT,
+		[OP_FCMP_ULE - OP_FP_CMP] = OP_FCMP_OGT,
+		[OP_FCMP_ULT - OP_FP_CMP] = OP_FCMP_OGE,
+
+		[OP_SET_EQ - OP_FP_CMP] = OP_SET_NE,
+		[OP_SET_NE - OP_FP_CMP] = OP_SET_EQ,
+		[OP_SET_GT - OP_FP_CMP] = OP_SET_LE,
+		[OP_SET_GE - OP_FP_CMP] = OP_SET_LT,
+		[OP_SET_LE - OP_FP_CMP] = OP_SET_GT,
+		[OP_SET_LT - OP_FP_CMP] = OP_SET_GE,
+		[OP_SET_A  - OP_FP_CMP] = OP_SET_BE,
+		[OP_SET_AE - OP_FP_CMP] = OP_SET_B ,
+		[OP_SET_BE - OP_FP_CMP] = OP_SET_A ,
+		[OP_SET_B  - OP_FP_CMP] = OP_SET_AE,
 	};
 
-	assert(opcode >= OP_BINCMP && opcode <= OP_BINCMP_END);
+	assert(opcode >= OP_FP_CMP && opcode <= OP_BINCMP_END);
 
 	if (!inverse)
 		return opcode;
 
-	return opcode_tbl[opcode - OP_BINCMP];
+	return opcode_tbl[opcode - OP_FP_CMP];
 }
 
 static int swap_compare_opcode(int opcode)
 {
 	static const unsigned char opcode_tbl[] = {
-		[OP_SET_EQ - OP_BINCMP] = OP_SET_EQ,
-		[OP_SET_NE - OP_BINCMP] = OP_SET_NE,
-		[OP_SET_GT - OP_BINCMP] = OP_SET_LT,
-		[OP_SET_GE - OP_BINCMP] = OP_SET_LE,
-		[OP_SET_LE - OP_BINCMP] = OP_SET_GE,
-		[OP_SET_LT - OP_BINCMP] = OP_SET_GT,
-		[OP_SET_A  - OP_BINCMP] = OP_SET_B ,
-		[OP_SET_AE - OP_BINCMP] = OP_SET_BE,
-		[OP_SET_BE - OP_BINCMP] = OP_SET_AE,
-		[OP_SET_B  - OP_BINCMP] = OP_SET_A ,
+		[OP_FCMP_ORD - OP_FP_CMP] = OP_FCMP_ORD,
+		[OP_FCMP_UNO - OP_FP_CMP] = OP_FCMP_UNO,
+
+		[OP_FCMP_OEQ - OP_FP_CMP] = OP_FCMP_OEQ,
+		[OP_FCMP_ONE - OP_FP_CMP] = OP_FCMP_ONE,
+		[OP_FCMP_OGT - OP_FP_CMP] = OP_FCMP_OLT,
+		[OP_FCMP_OGE - OP_FP_CMP] = OP_FCMP_OLE,
+		[OP_FCMP_OLE - OP_FP_CMP] = OP_FCMP_OGE,
+		[OP_FCMP_OLT - OP_FP_CMP] = OP_FCMP_OGT,
+
+		[OP_FCMP_UEQ - OP_FP_CMP] = OP_FCMP_UEQ,
+		[OP_FCMP_UNE - OP_FP_CMP] = OP_FCMP_UNE,
+		[OP_FCMP_UGT - OP_FP_CMP] = OP_FCMP_ULT,
+		[OP_FCMP_UGE - OP_FP_CMP] = OP_FCMP_ULE,
+		[OP_FCMP_ULE - OP_FP_CMP] = OP_FCMP_UGE,
+		[OP_FCMP_ULT - OP_FP_CMP] = OP_FCMP_UGT,
+
+		[OP_SET_EQ - OP_FP_CMP] = OP_SET_EQ,
+		[OP_SET_NE - OP_FP_CMP] = OP_SET_NE,
+		[OP_SET_GT - OP_FP_CMP] = OP_SET_LT,
+		[OP_SET_GE - OP_FP_CMP] = OP_SET_LE,
+		[OP_SET_LE - OP_FP_CMP] = OP_SET_GE,
+		[OP_SET_LT - OP_FP_CMP] = OP_SET_GT,
+		[OP_SET_A  - OP_FP_CMP] = OP_SET_B ,
+		[OP_SET_AE - OP_FP_CMP] = OP_SET_BE,
+		[OP_SET_BE - OP_FP_CMP] = OP_SET_AE,
+		[OP_SET_B  - OP_FP_CMP] = OP_SET_A ,
 	};
 
-	assert(opcode >= OP_BINCMP && opcode <= OP_BINCMP_END);
+	assert(opcode >= OP_FP_CMP && opcode <= OP_BINCMP_END);
 
-	return opcode_tbl[opcode - OP_BINCMP];
+	return opcode_tbl[opcode - OP_FP_CMP];
 }
 
 static int simplify_seteq_setne(struct instruction *insn, long long value)
@@ -472,7 +506,7 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 	inverse = (insn->opcode == OP_SET_NE) == value;
 	opcode = def->opcode;
 	switch (opcode) {
-	case OP_BINCMP ... OP_BINCMP_END:
+	case OP_FP_CMP ... OP_BINCMP_END:
 		// Convert:
 		//	setcc.n	%t <- %a, %b
 		//	setne.m %r <- %t, $0
diff --git a/sparse-llvm.c b/sparse-llvm.c
index deb0054c8..c5773b060 100644
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
+	case OP_FP_CMP ... OP_BINCMP_END:
 		output_op_compare(fn, insn);
 		break;
 	case OP_SEL:
diff --git a/validation/optim/canonical-fcmp.c b/validation/optim/canonical-fcmp.c
new file mode 100644
index 000000000..91dc139d0
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
+	fcmpone.32  %r7 <- %r5, %arg1
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
+	fcmpueq.32  %r33 <- %r30, %arg1
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

