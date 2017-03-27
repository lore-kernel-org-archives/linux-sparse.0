From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 50/52] llvm: add support for cast from floats
Date: Mon, 27 Mar 2017 23:24:14 +0200
Message-ID: <20170327212416.18536-51-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35981 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbdC0V1U (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:27:20 -0400
Received: by mail-wr0-f193.google.com with SMTP id u1so17119746wra.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:27:14 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
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
index 604b96842..a0b4293fa 100644
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

