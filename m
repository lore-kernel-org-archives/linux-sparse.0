From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 14/14] cast: specialize integer casts
Date: Thu, 17 Aug 2017 06:05:29 +0200
Message-ID: <20170817040529.7289-15-luc.vanoostenryck@gmail.com>
References: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34694 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdHQEGK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 00:06:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id x43so6182099wrb.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 21:06:09 -0700 (PDT)
In-Reply-To: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Aoo cast to unsigned integer and signed integer used to be
done with 2 instructions: OP_CAST & OP_SCAST.

Those are not very convenient as they don't reflect the real
operation that need to be done.
This patch specialize thises instruction in 4:
- OP_TRUNC, for casts to a smaller type
- OP_ZEXT,  for cast that need a zero extension
- OP_SEXT,  for cast that need a sign extension
Integer-to-integer casts of the same size are treated
as a NOP and in fact are never emitted.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.md                    |  11 +-
 cse.c                                  |   8 +-
 example.c                              |   9 +-
 linearize.c                            |  27 +++--
 linearize.h                            |   5 +-
 liveness.c                             |   4 +-
 simplify.c                             |  36 +++----
 sparse-llvm.c                          |  15 ++-
 sparse.c                               |   5 +-
 validation/bitfield-size.c             |   5 +-
 validation/builtin-bswap-variable.c    |   4 +-
 validation/cast-kinds-check.c          |   5 -
 validation/cast-kinds.c                | 179 ++++++++++++++++-----------------
 validation/cast-weirds.c               |   8 +-
 validation/compound-assign-type.c      |   3 +-
 validation/linear/bitfield-init-zero.c |   8 +-
 validation/memops-volatile.c           |   4 +-
 validation/optim/bool-simplify.c       |   4 +-
 18 files changed, 171 insertions(+), 169 deletions(-)

diff --git a/Documentation/IR.md b/Documentation/IR.md
index dcfd89bb6..e0299aba0 100644
--- a/Documentation/IR.md
+++ b/Documentation/IR.md
@@ -160,11 +160,14 @@ They all have the following signature:
 Currently, a cast to a void pointer is treated like a
 cast to an unsigned integer of the same size.
 
-### OP_CAST
-Cast to unsigned integer.
+### OP_TRUNC
+Cast from integer to an integer of a smaller size.
 
-### OP_SCAST
-Cast to signed integer.
+### OP_SEXT
+Cast from integer to an integer of a bigger size with sign extension.
+
+### OP_ZEXT
+Cast from integer to an integer of a bigger size with zero extension.
 
 ### OP_UTPTR
 Cast from pointer-sized unsigned integer to pointer type.
diff --git a/cse.c b/cse.c
index 166b7cda6..790e7b663 100644
--- a/cse.c
+++ b/cse.c
@@ -86,8 +86,8 @@ static void clean_up_one_instruction(struct basic_block *bb, struct instruction
 		hash += hashval(insn->symbol);
 		break;
 
-	case OP_CAST:
-	case OP_SCAST:
+	case OP_SEXT: case OP_ZEXT:
+	case OP_TRUNC:
 	case OP_PTRCAST:
 	case OP_UTPTR: case OP_PTRTU:
 		/*
@@ -231,8 +231,8 @@ static int insn_compare(const void *_i1, const void *_i2)
 	case OP_PHI:
 		return phi_list_compare(i1->phi_list, i2->phi_list);
 
-	case OP_CAST:
-	case OP_SCAST:
+	case OP_SEXT: case OP_ZEXT:
+	case OP_TRUNC:
 	case OP_PTRCAST:
 	case OP_UTPTR: case OP_PTRTU:
 		/*
diff --git a/example.c b/example.c
index 3a0ec0747..7192fc462 100644
--- a/example.c
+++ b/example.c
@@ -81,8 +81,9 @@ static const char *opcodes[] = {
 	[OP_PHI] = "phi",
 	[OP_PHISOURCE] = "phisrc",
 	[OP_COPY] = "copy",
-	[OP_CAST] = "cast",
-	[OP_SCAST] = "scast",
+	[OP_SEXT] = "sext",
+	[OP_ZEXT] = "zext",
+	[OP_TRUNC] = "trunc",
 	[OP_FCVTU] = "fcvtu",
 	[OP_FCVTS] = "fcvts",
 	[OP_UCVTF] = "ucvtf",
@@ -1426,7 +1427,9 @@ static void generate_one_insn(struct instruction *insn, struct bb_state *state)
 		generate_compare(state, insn);
 		break;
 
-	case OP_CAST: case OP_SCAST: case OP_PTRCAST:
+	case OP_SEXT: case OP_ZEXT:
+	case OP_TRUNC:
+	case OP_PTRCAST:
 	case OP_UTPTR:
 	case OP_PTRTU:
 	case OP_FCVTU: case OP_FCVTS:
diff --git a/linearize.c b/linearize.c
index 5d6cf7385..da33fe09b 100644
--- a/linearize.c
+++ b/linearize.c
@@ -228,8 +228,9 @@ static const char *opcodes[] = {
 	/* Other */
 	[OP_PHI] = "phi",
 	[OP_PHISOURCE] = "phisrc",
-	[OP_CAST] = "cast",
-	[OP_SCAST] = "scast",
+	[OP_SEXT] = "sext",
+	[OP_ZEXT] = "zext",
+	[OP_TRUNC] = "trunc",
 	[OP_FCVTU] = "fcvtu",
 	[OP_FCVTS] = "fcvts",
 	[OP_UCVTF] = "ucvtf",
@@ -429,8 +430,8 @@ const char *show_instruction(struct instruction *insn)
 		} END_FOR_EACH_PTR(arg);
 		break;
 	}
-	case OP_CAST:
-	case OP_SCAST:
+	case OP_SEXT: case OP_ZEXT:
+	case OP_TRUNC:
 	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
@@ -1194,13 +1195,14 @@ static int get_cast_opcode(struct symbol *dst, struct symbol *src)
 		case MTYPE_PTR:
 		case MTYPE_VPTR:
 		case MTYPE_UINT:
-			return OP_CAST;
+			stype = MTYPE_UINT;
+			/* fall through */
 		case MTYPE_SINT:
-			return OP_SCAST;
+			break;
 		default:
 			return OP_BADOP;
-			break;
 		}
+		/* fall through */
 	case MTYPE_UINT:
 	case MTYPE_SINT:
 		switch (stype) {
@@ -1210,15 +1212,18 @@ static int get_cast_opcode(struct symbol *dst, struct symbol *src)
 			return OP_PTRTU;
 		case MTYPE_VPTR:
 		case MTYPE_UINT:
-			return OP_CAST;
 		case MTYPE_SINT:
-			return OP_SCAST;
+			if (dst->bit_size ==src->bit_size)
+				return OP_NOP;
+			if (dst->bit_size  < src->bit_size)
+				return OP_TRUNC;
+			return stype == MTYPE_SINT ? OP_SEXT : OP_ZEXT;
 		default:
-			break;
+			return OP_BADOP;
 		}
 		/* fall through */
 	default:
-		return OP_CAST;
+		return OP_BADOP;
 	}
 }
 
diff --git a/linearize.h b/linearize.h
index 165d2b579..5f2c94e86 100644
--- a/linearize.h
+++ b/linearize.h
@@ -196,8 +196,9 @@ enum opcode {
 	/* Other */
 	OP_PHI,
 	OP_PHISOURCE,
-	OP_CAST,
-	OP_SCAST,
+	OP_SEXT,
+	OP_ZEXT,
+	OP_TRUNC,
 	OP_FCVTU, OP_FCVTS,
 	OP_UCVTF, OP_SCVTF,
 	OP_FCVTF,
diff --git a/liveness.c b/liveness.c
index ef2030f3e..bf98bcca0 100644
--- a/liveness.c
+++ b/liveness.c
@@ -111,8 +111,8 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 		USES(phi_src);
 		break;
 
-	case OP_CAST:
-	case OP_SCAST:
+	case OP_SEXT: case OP_ZEXT:
+	case OP_TRUNC:
 	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
diff --git a/simplify.c b/simplify.c
index 86512cc84..dcd29f427 100644
--- a/simplify.c
+++ b/simplify.c
@@ -236,8 +236,8 @@ void kill_insn(struct instruction *insn, int force)
 		kill_use(&insn->src2);
 		/* fall through */
 
-	case OP_CAST:
-	case OP_SCAST:
+	case OP_SEXT: case OP_ZEXT:
+	case OP_TRUNC:
 	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
@@ -342,8 +342,8 @@ static int replace_with_pseudo(struct instruction *insn, pseudo_t pseudo)
 	case OP_NOT:
 	case OP_NEG:
 	case OP_SYMADDR:
-	case OP_CAST:
-	case OP_SCAST:
+	case OP_SEXT: case OP_ZEXT:
+	case OP_TRUNC:
 	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
@@ -386,7 +386,7 @@ static unsigned int operand_size(struct instruction *insn, pseudo_t pseudo)
 
 	if (pseudo->type == PSEUDO_REG) {
 		struct instruction *src = pseudo->def;
-		if (src && src->opcode == OP_CAST && src->orig_type) {
+		if (src && src->opcode == OP_ZEXT && src->orig_type) {
 			unsigned int orig_size = src->orig_type->bit_size;
 			if (orig_size < size)
 				size = orig_size;
@@ -978,11 +978,14 @@ static int simplify_cast(struct instruction *insn)
 	}
 
 	if (size == orig_size) {
-		int op = (orig_type->ctype.modifiers & MOD_SIGNED) ? OP_SCAST : OP_CAST;
-		if (insn->opcode == op)
-			goto simplify;
-		if (insn->opcode == OP_FCVTF)
+		switch (insn->opcode) {
+		//case OP_NOPCAST:	// FIXME: what to do?
+		//case OP_PTRCAST:	// FIXME: what to do?
+		case OP_FCVTF:
 			goto simplify;
+		default:
+			break;
+		}
 	}
 
 	return 0;
@@ -1131,13 +1134,10 @@ static int simplify_branch(struct instruction *insn)
 				return REPEAT_CSE;
 			}
 		}
-		if (def->opcode == OP_CAST || def->opcode == OP_SCAST) {
-			int orig_size = def->orig_type ? def->orig_type->bit_size : 0;
-			if (def->size > orig_size) {
-				use_pseudo(insn, def->src, &insn->cond);
-				remove_usage(cond, &insn->cond);
-				return REPEAT_CSE;
-			}
+		if (def->opcode == OP_SEXT || def->opcode == OP_ZEXT) {
+			use_pseudo(insn, def->src, &insn->cond);
+			remove_usage(cond, &insn->cond);
+			return REPEAT_CSE;
 		}
 	}
 	return 0;
@@ -1207,8 +1207,8 @@ int simplify_instruction(struct instruction *insn)
 		if (dead_insn(insn, NULL, NULL, NULL))
 			return REPEAT_CSE | REPEAT_SYMBOL_CLEANUP;
 		return replace_with_pseudo(insn, insn->symbol);
-	case OP_CAST:
-	case OP_SCAST:
+	case OP_SEXT: case OP_ZEXT:
+	case OP_TRUNC:
 	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
diff --git a/sparse-llvm.c b/sparse-llvm.c
index 8dd6a5185..debf0cb7a 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -790,13 +790,7 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
 		src = pseudo_to_value(fn, insn, insn->src);
 
 	pseudo_name(insn->target, target_name);
-
-	assert(!symbol_is_fp_type(insn->type));
-
-	if (insn->size < LLVMGetIntTypeWidth(LLVMTypeOf(src)))
-		target = LLVMBuildTrunc(fn->builder, src, insn_symbol_type(fn->module, insn), target_name);
-	else
-		target = LLVMBuildCast(fn->builder, op, src, insn_symbol_type(fn->module, insn), target_name);
+	target = LLVMBuildCast(fn->builder, op, src, insn_symbol_type(fn->module, insn), target_name);
 
 	insn->target->priv = target;
 }
@@ -849,12 +843,15 @@ static void output_insn(struct function *fn, struct instruction *insn)
 	case OP_CALL:
 		output_op_call(fn, insn);
 		break;
-	case OP_CAST:
+	case OP_ZEXT:
 		output_op_cast(fn, insn, LLVMZExt);
 		break;
-	case OP_SCAST:
+	case OP_SEXT:
 		output_op_cast(fn, insn, LLVMSExt);
 		break;
+	case OP_TRUNC:
+		output_op_cast(fn, insn, LLVMTrunc);
+		break;
 	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
diff --git a/sparse.c b/sparse.c
index bceacd94e..b4d14aeec 100644
--- a/sparse.c
+++ b/sparse.c
@@ -120,7 +120,7 @@ static void check_cast_instruction(struct instruction *insn)
 		int old = orig_type->bit_size;
 		int new = insn->size;
 		int oldsigned = (orig_type->ctype.modifiers & MOD_SIGNED) != 0;
-		int newsigned = insn->opcode == OP_SCAST;
+		int newsigned = insn->opcode == OP_SEXT;
 
 		if (new > old) {
 			if (oldsigned == newsigned)
@@ -214,7 +214,8 @@ static void check_call_instruction(struct instruction *insn)
 static void check_one_instruction(struct instruction *insn)
 {
 	switch (insn->opcode) {
-	case OP_CAST: case OP_SCAST:
+	case OP_SEXT: case OP_ZEXT:
+	case OP_TRUNC:
 		if (verbose)
 			check_cast_instruction(insn);
 		break;
diff --git a/validation/bitfield-size.c b/validation/bitfield-size.c
index ce78ecf21..c708a52db 100644
--- a/validation/bitfield-size.c
+++ b/validation/bitfield-size.c
@@ -35,7 +35,8 @@ unsigned int get_pbfi_b(struct bfi *bf) { return bf->b; }
  * check-command: test-linearize -Wno-decl $file
  * check-output-ignore
  *
- * check-output-pattern-24-times: cast\\.
- * check-output-pattern-12-times: cast\\.4
+ * check-output-pattern-8-times: zext\\.
+ * check-output-pattern-4-times: sext\\.
+ * check-output-pattern-12-times: trunc\\.4
  * check-output-pattern-6-times: lsr\\..*\\$6
  */
diff --git a/validation/builtin-bswap-variable.c b/validation/builtin-bswap-variable.c
index 738ba2a45..40ad64134 100644
--- a/validation/builtin-bswap-variable.c
+++ b/validation/builtin-bswap-variable.c
@@ -25,8 +25,8 @@ static u64 swap64v(u32 a)
  *
  * check-output-ignore
  * check-output-contains:call.16 .* __builtin_bswap16
- * check-output-contains:cast.32 .* (64) %arg1
+ * check-output-contains:trunc.32 .* (64) %arg1
  * check-output-contains:call.32 .* __builtin_bswap32
- * check-output-contains:cast.64 .* (32) %arg1
+ * check-output-contains:zext.64 .* (32) %arg1
  * check-output-contains:call.64 .* __builtin_bswap64
  */
diff --git a/validation/cast-kinds-check.c b/validation/cast-kinds-check.c
index fe0f83e24..4654dbda2 100644
--- a/validation/cast-kinds-check.c
+++ b/validation/cast-kinds-check.c
@@ -13,11 +13,6 @@ cast-kinds.c:12:48: warning: cast drops bits
 cast-kinds.c:13:50: warning: cast drops bits
 cast-kinds.c:14:49: warning: cast drops bits
 cast-kinds.c:15:48: warning: cast drops bits
-cast-kinds.c:21:49: warning: cast wasn't removed
-cast-kinds.c:28:52: warning: cast wasn't removed
-cast-kinds.c:34:52: warning: cast wasn't removed
-cast-kinds.c:35:54: warning: cast wasn't removed
-cast-kinds.c:36:52: warning: cast wasn't removed
 cast-kinds.c:37:42: warning: non size-preserving integer to pointer cast
 cast-kinds.c:38:44: warning: non size-preserving integer to pointer cast
  * check-error-end
diff --git a/validation/cast-kinds.c b/validation/cast-kinds.c
index 3ac95c3dc..7d977f91b 100644
--- a/validation/cast-kinds.c
+++ b/validation/cast-kinds.c
@@ -74,44 +74,44 @@ uint_2_int:
 long_2_int:
 .L2:
 	<entry-point>
-	scast.32    %r5 <- (64) %arg1
-	ret.32      %r5
+	trunc.32    %r4 <- (64) %arg1
+	ret.32      %r4
 
 
 ulong_2_int:
 .L4:
 	<entry-point>
-	cast.32     %r8 <- (64) %arg1
-	ret.32      %r8
+	trunc.32    %r7 <- (64) %arg1
+	ret.32      %r7
 
 
 vptr_2_int:
 .L6:
 	<entry-point>
-	cast.32     %r11 <- (64) %arg1
-	ret.32      %r11
+	trunc.32    %r10 <- (64) %arg1
+	ret.32      %r10
 
 
 iptr_2_int:
 .L8:
 	<entry-point>
-	ptrtu.64    %r14 <- (64) %arg1
-	cast.32     %r15 <- (64) %r14
-	ret.32      %r15
+	ptrtu.64    %r13 <- (64) %arg1
+	trunc.32    %r14 <- (64) %r13
+	ret.32      %r14
 
 
 float_2_int:
 .L10:
 	<entry-point>
-	fcvts.32    %r18 <- (32) %arg1
-	ret.32      %r18
+	fcvts.32    %r17 <- (32) %arg1
+	ret.32      %r17
 
 
 double_2_int:
 .L12:
 	<entry-point>
-	fcvts.32    %r21 <- (64) %arg1
-	ret.32      %r21
+	fcvts.32    %r20 <- (64) %arg1
+	ret.32      %r20
 
 
 int_2_uint:
@@ -123,58 +123,58 @@ int_2_uint:
 long_2_uint:
 .L16:
 	<entry-point>
-	scast.32    %r27 <- (64) %arg1
-	ret.32      %r27
+	trunc.32    %r25 <- (64) %arg1
+	ret.32      %r25
 
 
 ulong_2_uint:
 .L18:
 	<entry-point>
-	cast.32     %r30 <- (64) %arg1
-	ret.32      %r30
+	trunc.32    %r28 <- (64) %arg1
+	ret.32      %r28
 
 
 vptr_2_uint:
 .L20:
 	<entry-point>
-	cast.32     %r33 <- (64) %arg1
-	ret.32      %r33
+	trunc.32    %r31 <- (64) %arg1
+	ret.32      %r31
 
 
 iptr_2_uint:
 .L22:
 	<entry-point>
-	ptrtu.64    %r36 <- (64) %arg1
-	cast.32     %r37 <- (64) %r36
-	ret.32      %r37
+	ptrtu.64    %r34 <- (64) %arg1
+	trunc.32    %r35 <- (64) %r34
+	ret.32      %r35
 
 
 float_2_uint:
 .L24:
 	<entry-point>
-	fcvtu.32    %r40 <- (32) %arg1
-	ret.32      %r40
+	fcvtu.32    %r38 <- (32) %arg1
+	ret.32      %r38
 
 
 double_2_uint:
 .L26:
 	<entry-point>
-	fcvtu.32    %r43 <- (64) %arg1
-	ret.32      %r43
+	fcvtu.32    %r41 <- (64) %arg1
+	ret.32      %r41
 
 
 int_2_long:
 .L28:
 	<entry-point>
-	scast.64    %r46 <- (32) %arg1
-	ret.64      %r46
+	sext.64     %r44 <- (32) %arg1
+	ret.64      %r44
 
 
 uint_2_long:
 .L30:
 	<entry-point>
-	cast.64     %r49 <- (32) %arg1
-	ret.64      %r49
+	zext.64     %r47 <- (32) %arg1
+	ret.64      %r47
 
 
 ulong_2_long:
@@ -186,43 +186,42 @@ ulong_2_long:
 vptr_2_long:
 .L34:
 	<entry-point>
-	cast.64     %r55 <- (64) %arg1
-	ret.64      %r55
+	ret.64      %arg1
 
 
 iptr_2_long:
 .L36:
 	<entry-point>
-	ptrtu.64    %r58 <- (64) %arg1
-	ret.64      %r58
+	ptrtu.64    %r54 <- (64) %arg1
+	ret.64      %r54
 
 
 float_2_long:
 .L38:
 	<entry-point>
-	fcvts.64    %r61 <- (32) %arg1
-	ret.64      %r61
+	fcvts.64    %r57 <- (32) %arg1
+	ret.64      %r57
 
 
 double_2_long:
 .L40:
 	<entry-point>
-	fcvts.64    %r64 <- (64) %arg1
-	ret.64      %r64
+	fcvts.64    %r60 <- (64) %arg1
+	ret.64      %r60
 
 
 int_2_ulong:
 .L42:
 	<entry-point>
-	scast.64    %r67 <- (32) %arg1
-	ret.64      %r67
+	sext.64     %r63 <- (32) %arg1
+	ret.64      %r63
 
 
 uint_2_ulong:
 .L44:
 	<entry-point>
-	cast.64     %r70 <- (32) %arg1
-	ret.64      %r70
+	zext.64     %r66 <- (32) %arg1
+	ret.64      %r66
 
 
 long_2_ulong:
@@ -234,171 +233,167 @@ long_2_ulong:
 vptr_2_ulong:
 .L48:
 	<entry-point>
-	cast.64     %r76 <- (64) %arg1
-	ret.64      %r76
+	ret.64      %arg1
 
 
 iptr_2_ulong:
 .L50:
 	<entry-point>
-	ptrtu.64    %r79 <- (64) %arg1
-	ret.64      %r79
+	ptrtu.64    %r73 <- (64) %arg1
+	ret.64      %r73
 
 
 float_2_ulong:
 .L52:
 	<entry-point>
-	fcvtu.64    %r82 <- (32) %arg1
-	ret.64      %r82
+	fcvtu.64    %r76 <- (32) %arg1
+	ret.64      %r76
 
 
 double_2_ulong:
 .L54:
 	<entry-point>
-	fcvtu.64    %r85 <- (64) %arg1
-	ret.64      %r85
+	fcvtu.64    %r79 <- (64) %arg1
+	ret.64      %r79
 
 
 int_2_vptr:
 .L56:
 	<entry-point>
-	scast.64    %r88 <- (32) %arg1
-	ret.64      %r88
+	sext.64     %r82 <- (32) %arg1
+	ret.64      %r82
 
 
 uint_2_vptr:
 .L58:
 	<entry-point>
-	cast.64     %r91 <- (32) %arg1
-	ret.64      %r91
+	zext.64     %r85 <- (32) %arg1
+	ret.64      %r85
 
 
 long_2_vptr:
 .L60:
 	<entry-point>
-	scast.64    %r94 <- (64) %arg1
-	ret.64      %r94
+	ret.64      %arg1
 
 
 ulong_2_vptr:
 .L62:
 	<entry-point>
-	cast.64     %r97 <- (64) %arg1
-	ret.64      %r97
+	ret.64      %arg1
 
 
 iptr_2_vptr:
 .L64:
 	<entry-point>
-	cast.64     %r100 <- (64) %arg1
-	ret.64      %r100
+	ret.64      %arg1
 
 
 int_2_iptr:
 .L66:
 	<entry-point>
-	scast.64    %r103 <- (32) %arg1
-	utptr.64    %r104 <- (64) %r103
-	ret.64      %r104
+	sext.64     %r94 <- (32) %arg1
+	utptr.64    %r95 <- (64) %r94
+	ret.64      %r95
 
 
 uint_2_iptr:
 .L68:
 	<entry-point>
-	cast.64     %r107 <- (32) %arg1
-	utptr.64    %r108 <- (64) %r107
-	ret.64      %r108
+	zext.64     %r98 <- (32) %arg1
+	utptr.64    %r99 <- (64) %r98
+	ret.64      %r99
 
 
 long_2_iptr:
 .L70:
 	<entry-point>
-	utptr.64    %r111 <- (64) %arg1
-	ret.64      %r111
+	utptr.64    %r102 <- (64) %arg1
+	ret.64      %r102
 
 
 ulong_2_iptr:
 .L72:
 	<entry-point>
-	utptr.64    %r114 <- (64) %arg1
-	ret.64      %r114
+	utptr.64    %r105 <- (64) %arg1
+	ret.64      %r105
 
 
 vptr_2_iptr:
 .L74:
 	<entry-point>
-	ptrcast.64  %r117 <- (64) %arg1
-	ret.64      %r117
+	ptrcast.64  %r108 <- (64) %arg1
+	ret.64      %r108
 
 
 int_2_float:
 .L76:
 	<entry-point>
-	scvtf.32    %r120 <- (32) %arg1
-	ret.32      %r120
+	scvtf.32    %r111 <- (32) %arg1
+	ret.32      %r111
 
 
 uint_2_float:
 .L78:
 	<entry-point>
-	ucvtf.32    %r123 <- (32) %arg1
-	ret.32      %r123
+	ucvtf.32    %r114 <- (32) %arg1
+	ret.32      %r114
 
 
 long_2_float:
 .L80:
 	<entry-point>
-	scvtf.32    %r126 <- (64) %arg1
-	ret.32      %r126
+	scvtf.32    %r117 <- (64) %arg1
+	ret.32      %r117
 
 
 ulong_2_float:
 .L82:
 	<entry-point>
-	ucvtf.32    %r129 <- (64) %arg1
-	ret.32      %r129
+	ucvtf.32    %r120 <- (64) %arg1
+	ret.32      %r120
 
 
 double_2_float:
 .L84:
 	<entry-point>
-	fcvtf.32    %r132 <- (64) %arg1
-	ret.32      %r132
+	fcvtf.32    %r123 <- (64) %arg1
+	ret.32      %r123
 
 
 int_2_double:
 .L86:
 	<entry-point>
-	scvtf.64    %r135 <- (32) %arg1
-	ret.64      %r135
+	scvtf.64    %r126 <- (32) %arg1
+	ret.64      %r126
 
 
 uint_2_double:
 .L88:
 	<entry-point>
-	ucvtf.64    %r138 <- (32) %arg1
-	ret.64      %r138
+	ucvtf.64    %r129 <- (32) %arg1
+	ret.64      %r129
 
 
 long_2_double:
 .L90:
 	<entry-point>
-	scvtf.64    %r141 <- (64) %arg1
-	ret.64      %r141
+	scvtf.64    %r132 <- (64) %arg1
+	ret.64      %r132
 
 
 ulong_2_double:
 .L92:
 	<entry-point>
-	ucvtf.64    %r144 <- (64) %arg1
-	ret.64      %r144
+	ucvtf.64    %r135 <- (64) %arg1
+	ret.64      %r135
 
 
 float_2_double:
 .L94:
 	<entry-point>
-	fcvtf.64    %r147 <- (32) %arg1
-	ret.64      %r147
+	fcvtf.64    %r138 <- (32) %arg1
+	ret.64      %r138
 
 
 float_2_float:
diff --git a/validation/cast-weirds.c b/validation/cast-weirds.c
index 71e52ff57..a99c65d25 100644
--- a/validation/cast-weirds.c
+++ b/validation/cast-weirds.c
@@ -20,7 +20,7 @@ cast-weirds.c:5:44: warning: non size-preserving integer to pointer cast
 int_2_iptr:
 .L0:
 	<entry-point>
-	scast.64    %r2 <- (32) %arg1
+	sext.64     %r2 <- (32) %arg1
 	utptr.64    %r3 <- (64) %r2
 	ret.64      %r3
 
@@ -28,7 +28,7 @@ int_2_iptr:
 uint_2_iptr:
 .L2:
 	<entry-point>
-	cast.64     %r6 <- (32) %arg1
+	zext.64     %r6 <- (32) %arg1
 	utptr.64    %r7 <- (64) %r6
 	ret.64      %r7
 
@@ -36,14 +36,14 @@ uint_2_iptr:
 int_2_vptr:
 .L4:
 	<entry-point>
-	scast.64    %r10 <- (32) %arg1
+	sext.64     %r10 <- (32) %arg1
 	ret.64      %r10
 
 
 uint_2_vptr:
 .L6:
 	<entry-point>
-	cast.64     %r13 <- (32) %arg1
+	zext.64     %r13 <- (32) %arg1
 	ret.64      %r13
 
 
diff --git a/validation/compound-assign-type.c b/validation/compound-assign-type.c
index 450fa26d9..e13dcfcd2 100644
--- a/validation/compound-assign-type.c
+++ b/validation/compound-assign-type.c
@@ -11,5 +11,6 @@ static unsigned int foo(unsigned int x, long a)
  *
  * check-output-excludes: divu\\.32
  * check-output-contains: divs\\.64
- * check-output-contains: scast\\.32
+ * check-output-contains: zext.64 .* (32) %arg1
+ * check-output-contains: trunc.32 .* (64)
  */
diff --git a/validation/linear/bitfield-init-zero.c b/validation/linear/bitfield-init-zero.c
index 39a64345e..7a410a7c4 100644
--- a/validation/linear/bitfield-init-zero.c
+++ b/validation/linear/bitfield-init-zero.c
@@ -57,7 +57,7 @@ int bfs_get0(void)
 bfuu_init:
 .L0:
 	<entry-point>
-	cast.9      %r2 <- (32) %arg1
+	trunc.9     %r2 <- (32) %arg1
 	shl.32      %r4 <- %r2, $11
 	ret.32      %r4
 
@@ -65,7 +65,7 @@ bfuu_init:
 bfus_init:
 .L2:
 	<entry-point>
-	scast.9     %r10 <- (32) %arg1
+	trunc.9     %r10 <- (32) %arg1
 	shl.32      %r12 <- %r10, $11
 	ret.32      %r12
 
@@ -79,7 +79,7 @@ bfu_get0:
 bfsu_init:
 .L6:
 	<entry-point>
-	cast.9      %r23 <- (32) %arg1
+	trunc.9     %r23 <- (32) %arg1
 	shl.32      %r25 <- %r23, $11
 	ret.32      %r25
 
@@ -87,7 +87,7 @@ bfsu_init:
 bfss_init:
 .L8:
 	<entry-point>
-	scast.9     %r31 <- (32) %arg1
+	trunc.9     %r31 <- (32) %arg1
 	shl.32      %r33 <- %r31, $11
 	ret.32      %r33
 
diff --git a/validation/memops-volatile.c b/validation/memops-volatile.c
index 0f3e12ad2..3b8662f1e 100644
--- a/validation/memops-volatile.c
+++ b/validation/memops-volatile.c
@@ -13,8 +13,8 @@ foo:
 .L0:
 	<entry-point>
 	store.32    %arg2 -> 0[%arg1]
-	load.32     %r5 <- 0[%arg1]
-	ret.32      %r5
+	load.32     %r4 <- 0[%arg1]
+	ret.32      %r4
 
 
  * check-output-end
diff --git a/validation/optim/bool-simplify.c b/validation/optim/bool-simplify.c
index 05be11497..5b3cf449e 100644
--- a/validation/optim/bool-simplify.c
+++ b/validation/optim/bool-simplify.c
@@ -33,7 +33,7 @@ and_1:
 .L2:
 	<entry-point>
 	setne.1     %r8 <- %arg1, $0
-	cast.32     %r11 <- (1) %r8
+	zext.32     %r11 <- (1) %r8
 	ret.32      %r11
 
 
@@ -41,7 +41,7 @@ or_0:
 .L4:
 	<entry-point>
 	setne.1     %r14 <- %arg1, $0
-	cast.32     %r17 <- (1) %r14
+	zext.32     %r17 <- (1) %r14
 	ret.32      %r17
 
 
-- 
2.14.0

