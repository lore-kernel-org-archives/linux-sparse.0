From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 15/30] llvm: fix test of floating-point type
Date: Sun, 19 Mar 2017 02:42:12 +0100
Message-ID: <20170319014227.8833-16-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34291 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdCSBmz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:42:55 -0400
Received: by mail-wr0-f193.google.com with SMTP id u48so13843056wrc.1
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:42:54 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index d7e8ee725..ee3857c49 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -25,14 +25,6 @@ struct function {
 	LLVMModuleRef			module;
 };
 
-static inline bool symbol_is_fp_type(struct symbol *sym)
-{
-	if (!sym)
-		return false;
-
-	return sym->ctype.base_type == &fp_type;
-}
-
 static LLVMTypeRef symbol_type(struct symbol *sym);
 
 static LLVMTypeRef func_return_type(struct symbol *sym)
@@ -154,7 +146,7 @@ static LLVMTypeRef sym_basetype_type(struct symbol *sym)
 {
 	LLVMTypeRef ret = NULL;
 
-	if (symbol_is_fp_type(sym)) {
+	if (is_float_type(sym)) {
 		switch (sym->bit_size) {
 		case 32:
 			ret = LLVMFloatType();
@@ -454,69 +446,69 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 	switch (insn->opcode) {
 	/* Binary */
 	case OP_ADD:
-		if (symbol_is_fp_type(insn->type))
+		if (is_float_type(insn->type))
 			target = LLVMBuildFAdd(fn->builder, lhs, rhs, target_name);
 		else
 			target = LLVMBuildAdd(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_SUB:
-		if (symbol_is_fp_type(insn->type))
+		if (is_float_type(insn->type))
 			target = LLVMBuildFSub(fn->builder, lhs, rhs, target_name);
 		else
 			target = LLVMBuildSub(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_MULU:
-		if (symbol_is_fp_type(insn->type))
+		if (is_float_type(insn->type))
 			target = LLVMBuildFMul(fn->builder, lhs, rhs, target_name);
 		else
 			target = LLVMBuildMul(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_MULS:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!is_float_type(insn->type));
 		target = LLVMBuildMul(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_DIVU:
-		if (symbol_is_fp_type(insn->type))
+		if (is_float_type(insn->type))
 			target = LLVMBuildFDiv(fn->builder, lhs, rhs, target_name);
 		else
 			target = LLVMBuildUDiv(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_DIVS:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!is_float_type(insn->type));
 		target = LLVMBuildSDiv(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_MODU:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!is_float_type(insn->type));
 		target = LLVMBuildURem(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_MODS:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!is_float_type(insn->type));
 		target = LLVMBuildSRem(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_SHL:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!is_float_type(insn->type));
 		target = LLVMBuildShl(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_LSR:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!is_float_type(insn->type));
 		target = LLVMBuildLShr(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_ASR:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!is_float_type(insn->type));
 		target = LLVMBuildAShr(fn->builder, lhs, rhs, target_name);
 		break;
 	
 	/* Logical */
 	case OP_AND:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!is_float_type(insn->type));
 		target = LLVMBuildAnd(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_OR:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!is_float_type(insn->type));
 		target = LLVMBuildOr(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_XOR:
-		assert(!symbol_is_fp_type(insn->type));
+		assert(!is_float_type(insn->type));
 		target = LLVMBuildXor(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_AND_BOOL: {
@@ -781,7 +773,7 @@ static void output_op_ptrcast(struct function *fn, struct instruction *insn)
 
 	pseudo_name(insn->target, target_name);
 
-	assert(!symbol_is_fp_type(insn->type));
+	assert(!is_float_type(insn->type));
 
 	target = LLVMBuildBitCast(fn->builder, src, insn_symbol_type(insn), target_name);
 
@@ -799,7 +791,7 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
 
 	pseudo_name(insn->target, target_name);
 
-	assert(!symbol_is_fp_type(insn->type));
+	assert(!is_float_type(insn->type));
 
 	if (insn->size < LLVMGetIntTypeWidth(LLVMTypeOf(src)))
 		target = LLVMBuildTrunc(fn->builder, src, insn_symbol_type(insn), target_name);
-- 
2.12.0

