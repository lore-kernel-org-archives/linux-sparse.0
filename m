From: Xi Wang <xi.wang@gmail.com>
Subject: [RFC][PATCH 3/3] sparse, llvm: sync with new struct instruction
Date: Mon,  4 Jun 2012 02:54:37 -0400
Message-ID: <1338792878-25898-4-git-send-email-xi.wang@gmail.com>
References: <1338792878-25898-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:62939 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279Ab2FDGzn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Jun 2012 02:55:43 -0400
Received: by qabj40 with SMTP id j40so2085894qab.1
        for <linux-sparse@vger.kernel.org>; Sun, 03 Jun 2012 23:55:43 -0700 (PDT)
In-Reply-To: <1338792878-25898-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Xi Wang <xi.wang@gmail.com>

This patch is basically substitutes insn->type and insn->size with
insn->target->ctype and instruction_size(insn), respectively.  With
the new ->ctype in struct pseudo, generating LLVM IR should be much
simpler.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 sparse-llvm.c |   50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 9226a21..49c00ca 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -236,17 +236,17 @@ static LLVMTypeRef symbol_type(LLVMModuleRef module, struct symbol *sym)
 
 static LLVMTypeRef insn_symbol_type(LLVMModuleRef module, struct instruction *insn)
 {
-	if (insn->type)
-		return symbol_type(module, insn->type);
+	if (insn->target && insn->target->ctype)
+		return symbol_type(module, insn->target->ctype);
 
-	switch (insn->size) {
+	switch (instruction_size(insn)) {
 		case 8:		return LLVMInt8Type();
 		case 16:	return LLVMInt16Type();
 		case 32:	return LLVMInt32Type();
 		case 64:	return LLVMInt64Type();
 
 		default:
-			die("invalid bit size %d", insn->size);
+			die("invalid bit size %d", instruction_size(insn));
 			break;
 	}
 
@@ -364,7 +364,7 @@ static LLVMTypeRef pseudo_type(struct function *fn, struct instruction *insn, ps
 
 	switch (pseudo->type) {
 	case PSEUDO_REG:
-		result = symbol_type(fn->module, pseudo->def->type);
+		result = symbol_type(fn->module, pseudo->def->target->ctype);
 		break;
 	case PSEUDO_SYM: {
 		struct symbol *sym = pseudo->sym;
@@ -455,75 +455,75 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 	switch (insn->opcode) {
 	/* Binary */
 	case OP_ADD:
-		if (symbol_is_fp_type(insn->type))
+		if (symbol_is_fp_type(insn->target->ctype))
 			target = LLVMBuildFAdd(fn->builder, lhs, rhs, target_name);
 		else
 			target = LLVMBuildAdd(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_SUB:
-		if (symbol_is_fp_type(insn->type))
+		if (symbol_is_fp_type(insn->target->ctype))
 			target = LLVMBuildFSub(fn->builder, lhs, rhs, target_name);
 		else
 			target = LLVMBuildSub(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_MULU:
-		if (symbol_is_fp_type(insn->type))
+		if (symbol_is_fp_type(insn->target->ctype))
 			target = LLVMBuildFMul(fn->builder, lhs, rhs, target_name);
 		else
 			target = LLVMBuildMul(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_MULS:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!symbol_is_fp_type(insn->target->ctype));
 		target = LLVMBuildMul(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_DIVU:
-		if (symbol_is_fp_type(insn->type))
+		if (symbol_is_fp_type(insn->target->ctype))
 			target = LLVMBuildFDiv(fn->builder, lhs, rhs, target_name);
 		else
 			target = LLVMBuildUDiv(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_DIVS:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!symbol_is_fp_type(insn->target->ctype));
 		target = LLVMBuildSDiv(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_MODU:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!symbol_is_fp_type(insn->target->ctype));
 		target = LLVMBuildURem(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_MODS:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!symbol_is_fp_type(insn->target->ctype));
 		target = LLVMBuildSRem(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_SHL:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!symbol_is_fp_type(insn->target->ctype));
 		target = LLVMBuildShl(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_LSR:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!symbol_is_fp_type(insn->target->ctype));
 		target = LLVMBuildLShr(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_ASR:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!symbol_is_fp_type(insn->target->ctype));
 		target = LLVMBuildAShr(fn->builder, lhs, rhs, target_name);
 		break;
 	
 	/* Logical */
 	case OP_AND:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!symbol_is_fp_type(insn->target->ctype));
 		target = LLVMBuildAnd(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_OR:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!symbol_is_fp_type(insn->target->ctype));
 		target = LLVMBuildOr(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_XOR:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!symbol_is_fp_type(insn->target->ctype));
 		target = LLVMBuildXor(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_AND_BOOL: {
 		LLVMValueRef x, y;
 
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!symbol_is_fp_type(insn->target->ctype));
 
 		y = LLVMBuildICmp(fn->builder, LLVMIntNE, lhs, LLVMConstInt(LLVMTypeOf(lhs), 0, 0), "y");
 		x = LLVMBuildICmp(fn->builder, LLVMIntNE, rhs, LLVMConstInt(LLVMTypeOf(rhs), 0, 0), "x");
@@ -534,7 +534,7 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 	case OP_OR_BOOL: {
 		LLVMValueRef tmp;
 
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!symbol_is_fp_type(insn->target->ctype));
 
 		tmp = LLVMBuildOr(fn->builder, rhs, lhs, "tmp");
 
@@ -914,7 +914,7 @@ static void output_op_ptrcast(struct function *fn, struct instruction *insn)
 
 	pseudo_name(insn->target, target_name);
 
-	assert(!symbol_is_fp_type(insn->type));
+	assert(!symbol_is_fp_type(insn->target->ctype));
 
 	target = LLVMBuildBitCast(fn->builder, src, insn_symbol_type(fn->module, insn), target_name);
 
@@ -932,9 +932,9 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
 
 	pseudo_name(insn->target, target_name);
 
-	assert(!symbol_is_fp_type(insn->type));
+	assert(!symbol_is_fp_type(insn->target->ctype));
 
-	if (insn->size < LLVMGetIntTypeWidth(LLVMTypeOf(src)))
+	if (instruction_size(insn) < LLVMGetIntTypeWidth(LLVMTypeOf(src)))
 		target = LLVMBuildTrunc(fn->builder, src, insn_symbol_type(fn->module, insn), target_name);
 	else
 		target = LLVMBuildCast(fn->builder, op, src, insn_symbol_type(fn->module, insn), target_name);
@@ -960,7 +960,7 @@ static void output_op_copy(struct function *fn, struct instruction *insn,
 	 * than using "X + 0" simply to produce a new LLVM pseudo
 	 */
 
-	if (symbol_is_fp_type(insn->type))
+	if (symbol_is_fp_type(insn->target->ctype))
 		target = LLVMBuildFAdd(fn->builder, src,
 			LLVMConstReal(const_type, 0.0), target_name);
 	else
-- 
1.7.9.5

