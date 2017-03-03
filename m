From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] llvm: fix output_op_[ptr]cast()
Date: Fri,  3 Mar 2017 06:24:59 +0100
Message-ID: <20170303052459.2351-1-luc.vanoostenryck@gmail.com>
References: <CACXZuxcd6q6c5VzsYME01nzUhKzLjzvxTDt3juSbNB226APTTg@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36413 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbdCCFdl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 3 Mar 2017 00:33:41 -0500
Received: by mail-wm0-f68.google.com with SMTP id v190so1389118wme.3
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 21:33:28 -0800 (PST)
In-Reply-To: <CACXZuxcd6q6c5VzsYME01nzUhKzLjzvxTDt3juSbNB226APTTg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>

This should fox the problems of mixed types in casts.
Without much testing but should be essentialy OK.

CC: Dibyendu Majumdar <mobile@majumdar.org.uk>
---
 sparse-llvm.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index edd0615ec..92ad26845 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -763,6 +763,8 @@ static void output_op_phi(struct function *fn, struct instruction *insn)
 static void output_op_ptrcast(struct function *fn, struct instruction *insn)
 {
 	LLVMValueRef src, target;
+	LLVMTypeRef dtype;
+	LLVMOpcode op;
 	char target_name[64];
 
 	src = insn->src->priv;
@@ -773,15 +775,31 @@ static void output_op_ptrcast(struct function *fn, struct instruction *insn)
 
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
@@ -791,11 +809,23 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
 
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

