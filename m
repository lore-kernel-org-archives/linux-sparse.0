From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 13/13] llvm: fix: do not mix pointers and floats when doing compares
Date: Sun,  5 Mar 2017 12:20:47 +0100
Message-ID: <20170305112047.3411-14-luc.vanoostenryck@gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34994 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbdCEL3O (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 06:29:14 -0500
Received: by mail-wr0-f196.google.com with SMTP id u108so14400001wrb.2
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 03:29:13 -0800 (PST)
In-Reply-To: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In output_op_compare() everything that is not of interger
type is treated as floats, pointers disagree.

Fix this by rearranging the code and use a switch to easily
treat pointers like integers as required for LLVM's icmp.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 7c7b70027..be47c5e75 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -587,14 +587,27 @@ static void output_op_compare(struct function *fn, struct instruction *insn)
 
 	LLVMTypeRef dst_type = insn_symbol_type(insn);
 
-	if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMIntegerTypeKind) {
+	switch  (LLVMGetTypeKind(LLVMTypeOf(lhs))) {
+	case LLVMPointerTypeKind:
+	case LLVMIntegerTypeKind: {
 		LLVMIntPredicate op = translate_op(insn->opcode);
 
 		target = LLVMBuildICmp(fn->builder, op, lhs, rhs, target_name);
-	} else {
+		break;
+	}
+	case LLVMHalfTypeKind:
+	case LLVMFloatTypeKind:
+	case LLVMDoubleTypeKind:
+	case LLVMX86_FP80TypeKind:
+	case LLVMFP128TypeKind:
+	case LLVMPPC_FP128TypeKind: {
 		LLVMRealPredicate op = translate_fop(insn->opcode);
 
 		target = LLVMBuildFCmp(fn->builder, op, lhs, rhs, target_name);
+		break;
+	}
+	default:
+		assert(0);
 	}
 
 	target = LLVMBuildZExt(fn->builder, target, dst_type, target_name);
-- 
2.11.1

