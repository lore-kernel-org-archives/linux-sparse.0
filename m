From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 62/63] llvm: add support for cast from floats
Date: Tue, 21 Mar 2017 01:16:06 +0100
Message-ID: <20170321001607.75169-63-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35088 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753377AbdCUARq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id z133so260167wmb.2
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:45 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

