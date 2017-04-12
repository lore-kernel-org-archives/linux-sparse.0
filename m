From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/6] llvm: no need to special-case OP_AND_BOOL and OP_OR_BOOL
Date: Wed, 12 Apr 2017 21:33:43 +0200
Message-ID: <20170412193344.95935-6-luc.vanoostenryck@gmail.com>
References: <20170412193344.95935-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36097 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755100AbdDLTd6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 15:33:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id q125so8531630wmd.3
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 12:33:57 -0700 (PDT)
In-Reply-To: <20170412193344.95935-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Now that OP_AND_BOOL and OP_OR_BOOL are not generated anymore,
we can remove the (special case) code that handled them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index da9f2ce25..b8acbd53d 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -609,30 +609,6 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 		assert(!is_float_type(insn->type));
 		target = LLVMBuildXor(fn->builder, lhs, rhs, target_name);
 		break;
-	case OP_AND_BOOL: {
-		LLVMValueRef lhs_nz, rhs_nz;
-		LLVMTypeRef dst_type;
-
-		lhs_nz = LLVMBuildIsNotNull(fn->builder, lhs, LLVMGetValueName(lhs));
-		rhs_nz = LLVMBuildIsNotNull(fn->builder, rhs, LLVMGetValueName(rhs));
-		target = LLVMBuildAnd(fn->builder, lhs_nz, rhs_nz, target_name);
-
-		dst_type = insn_symbol_type(insn);
-		target = LLVMBuildZExt(fn->builder, target, dst_type, target_name);
-		break;
-	}
-	case OP_OR_BOOL: {
-		LLVMValueRef lhs_nz, rhs_nz;
-		LLVMTypeRef dst_type;
-
-		lhs_nz = LLVMBuildIsNotNull(fn->builder, lhs, LLVMGetValueName(lhs));
-		rhs_nz = LLVMBuildIsNotNull(fn->builder, rhs, LLVMGetValueName(rhs));
-		target = LLVMBuildOr(fn->builder, lhs_nz, rhs_nz, target_name);
