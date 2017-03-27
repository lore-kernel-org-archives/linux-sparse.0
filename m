From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 51/52] llvm: cleanup of output_[ptr]cast()
Date: Mon, 27 Mar 2017 23:24:15 +0200
Message-ID: <20170327212416.18536-52-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33752 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752635AbdC0V1a (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:27:30 -0400
Received: by mail-wr0-f193.google.com with SMTP id 20so17045462wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:27:29 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index a0b4293fa..b82fbefa1 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -875,21 +875,17 @@ static void output_op_ptrcast(struct function *fn, struct instruction *insn)
 	LLVMOpcode op;
 	char target_name[64];
 
+	assert(is_ptr_type(insn->type));
 
 	src = get_operand(fn, otype, insn->src);
 	pseudo_name(insn->target, target_name);
 
-	assert(!is_float_type(insn->type));
-
-	dtype = insn_symbol_type(insn);
-	switch (LLVMGetTypeKind(LLVMTypeOf(src))) {
-	case LLVMPointerTypeKind:
+	dtype = symbol_type(insn->type);
+	if (is_ptr_type(otype)) {
 		op = LLVMBitCast;
-		break;
-	case LLVMIntegerTypeKind:
+	} else if (is_int_type(otype)) {
 		op = LLVMIntToPtr;
-		break;
-	default:
+	} else {
 		assert(0);
 	}
 
@@ -903,38 +899,27 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
 	LLVMTypeRef dtype;
 	struct symbol *otype = insn->orig_type;
 	char target_name[64];
-	unsigned int width;
 
 	if (is_ptr_type(insn->type))	// cast to void* is OP_CAST ...
 		return output_op_ptrcast(fn, insn);
 
+	assert(is_int_type(insn->type));
 
 	src = get_operand(fn, otype, insn->src);
 	pseudo_name(insn->target, target_name);
 
-	assert(!is_float_type(insn->type));
-
 	dtype = symbol_type(insn->type);
-	switch (LLVMGetTypeKind(LLVMTypeOf(src))) {
-	case LLVMPointerTypeKind:
+	if (is_ptr_type(otype)) {
 		op = LLVMPtrToInt;
-		break;
-	case LLVMIntegerTypeKind:
-		width = LLVMGetIntTypeWidth(LLVMTypeOf(src));
+	} else if (is_float_type(otype)) {
+		op = (op == LLVMZExt) ? LLVMFPToUI : LLVMFPToSI;
+	} else if (is_int_type(otype)) {
+		unsigned int width = otype->bit_size;
 		if (insn->size < width)
 			op = LLVMTrunc;
 		else if (insn->size == width)
 			op = LLVMBitCast;
-		break;
-	case LLVMHalfTypeKind:
-	case LLVMFloatTypeKind:
-	case LLVMDoubleTypeKind:
-	case LLVMX86_FP80TypeKind:
-	case LLVMFP128TypeKind:
-	case LLVMPPC_FP128TypeKind:
-		op = (op == LLVMZExt) ? LLVMFPToUI : LLVMFPToSI;
-		break;
-	default:
+	} else {
 		assert(0);
 	}
 
-- 
2.12.0

