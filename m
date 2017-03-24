From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 50/51] llvm: add support for cast from floats
Date: Sat, 25 Mar 2017 00:20:56 +0100
Message-ID: <20170324232057.15033-51-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34691 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936164AbdCXXYQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:24:16 -0400
Received: by mail-wr0-f195.google.com with SMTP id y90so607445wrb.1
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:24:15 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c             | 10 +++++++++-
 validation/backend/cast.c |  2 --
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index cdeb38d8e..b8a52b9ac 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -914,7 +914,7 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
 
 	assert(!is_float_type(insn->type));
 
-	dtype = insn_symbol_type(insn);
+	dtype = symbol_type(insn->type);
 	switch (LLVMGetTypeKind(LLVMTypeOf(src))) {
 	case LLVMPointerTypeKind:
 		op = LLVMPtrToInt;
@@ -926,6 +926,14 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
 		else if (insn->size == width)
 			op = LLVMBitCast;
 		break;
+	case LLVMHalfTypeKind:
+	case LLVMFloatTypeKind:
+	case LLVMDoubleTypeKind:
+	case LLVMX86_FP80TypeKind:
+	case LLVMFP128TypeKind:
+	case LLVMPPC_FP128TypeKind:
+		op = (op == LLVMZExt) ? LLVMFPToUI : LLVMFPToSI;
+		break;
 	default:
 		assert(0);
 	}
diff --git a/validation/backend/cast.c b/validation/backend/cast.c
index 4c308dfe8..b3728c21e 100644
--- a/validation/backend/cast.c
+++ b/validation/backend/cast.c
@@ -40,10 +40,8 @@ DEFINE_CASTS(long)
 DEFINE_CASTS(ulong)
 DEFINE_CASTS(longlong)
 DEFINE_CASTS(ulonglong)
-/*
 DEFINE_CASTS(float)
 DEFINE_CASTS(double)
-*/
 
 /*
  * check-name: Cast code generation
-- 
2.12.0

