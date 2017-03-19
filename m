From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 18/30] llvm: fix output_op_[ptr]cast()
Date: Sun, 19 Mar 2017 02:42:15 +0100
Message-ID: <20170319014227.8833-19-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34297 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbdCSBm5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:42:57 -0400
Received: by mail-wr0-f193.google.com with SMTP id u48so13843099wrc.1
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:42:56 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
index e01406281..733fc467c 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -792,6 +792,8 @@ static void output_op_phi(struct function *fn, struct instruction *insn)
 static void output_op_ptrcast(struct function *fn, struct instruction *insn)
 {
 	LLVMValueRef src, target;
+	LLVMTypeRef dtype;
+	LLVMOpcode op;
 	char target_name[64];
 
 	src = insn->src->priv;
@@ -802,15 +804,31 @@ static void output_op_ptrcast(struct function *fn, struct instruction *insn)
 
 	assert(!is_float_type(insn->type));
 
-	target = LLVMBuildBitCast(fn->builder, src, insn_symbol_type(insn), target_name);
+	dtype = insn_symbol_type(insn);
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
@@ -820,11 +838,23 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
 
 	assert(!is_float_type(insn->type));
 
-	if (insn->size < LLVMGetIntTypeWidth(LLVMTypeOf(src)))
-		target = LLVMBuildTrunc(fn->builder, src, insn_symbol_type(insn), target_name);
-	else
-		target = LLVMBuildCast(fn->builder, op, src, insn_symbol_type(insn), target_name);
+	dtype = insn_symbol_type(insn);
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
2.12.0

