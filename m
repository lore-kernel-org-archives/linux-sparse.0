From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 07/27] llvm: fix output_op_[ptr]cast()
Date: Sat, 11 Mar 2017 10:06:46 +0100
Message-ID: <20170311090706.17171-8-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36001 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755108AbdCKJH3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:29 -0500
Received: by mail-wm0-f68.google.com with SMTP id v190so2299208wme.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:28 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

OP_PTRCASTs can't always be directly translated into LLVM bitcasts and
OP_[S]CASTs can't always be translated into LLVM's trunc/sext/zext
because integer to pointer and pointer to integer must be handled too.

Fix this in output_op_ptrcast() & output_op_cast() by issuing
LLVMBuildIntToPtr/PtrToInt when appropriate.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 665b6c7dc..c593f831f 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -787,6 +787,8 @@ static void output_op_phi(struct function *fn, struct instruction *insn)
 static void output_op_ptrcast(struct function *fn, struct instruction *insn)
 {
 	LLVMValueRef src, target;
+	LLVMTypeRef dtype;
+	LLVMOpcode op;
 	char target_name[64];
 
 	src = insn->src->priv;
@@ -797,15 +799,31 @@ static void output_op_ptrcast(struct function *fn, struct instruction *insn)
 
 	assert(!symbol_is_fp_type(insn->type));
 
-	target = LLVMBuildBitCast(fn->builder, src, insn_symbol_type(fn->module, insn), target_name);
+	dtype = insn_symbol_type(fn->module, insn);
+	switch (LLVMGetTypeKind(LLVMTypeOf(src))) {
+	case LLVMPointerTypeKind:
+		op = LLVMBitCast;
+		break;
+	case LLVMIntegerTypeKind:
+		op = LLVMIntToPtr;
+		break;
+	default:
+		assert(0);
+	}
 
+	target = LLVMBuildCast(fn->builder, op, src, dtype, target_name);
 	insn->target->priv = target;
 }
 
 static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOpcode op)
 {
 	LLVMValueRef src, target;
+	LLVMTypeRef dtype;
 	char target_name[64];
+	unsigned int width;
+
+	if (is_ptr_type(insn->type))
+		return output_op_ptrcast(fn, insn);
 
 	src = insn->src->priv;
 	if (!src)
@@ -815,11 +833,23 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
 
 	assert(!symbol_is_fp_type(insn->type));
 
-	if (insn->size < LLVMGetIntTypeWidth(LLVMTypeOf(src)))
-		target = LLVMBuildTrunc(fn->builder, src, insn_symbol_type(fn->module, insn), target_name);
-	else
-		target = LLVMBuildCast(fn->builder, op, src, insn_symbol_type(fn->module, insn), target_name);
+	dtype = insn_symbol_type(fn->module, insn);
+	switch (LLVMGetTypeKind(LLVMTypeOf(src))) {
+	case LLVMPointerTypeKind:
+		op = LLVMPtrToInt;
+		break;
+	case LLVMIntegerTypeKind:
+		width = LLVMGetIntTypeWidth(LLVMTypeOf(src));
+		if (insn->size < width)
+			op = LLVMTrunc;
+		else if (insn->size == width)
+			op = LLVMBitCast;
+		break;
+	default:
+		assert(0);
+	}
 
+	target = LLVMBuildCast(fn->builder, op, src, dtype, target_name);
 	insn->target->priv = target;
 }
 
-- 
2.11.1

