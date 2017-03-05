From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 07/13] llvm: fix output OP_ADD mixed with pointers
Date: Sun,  5 Mar 2017 12:20:41 +0100
Message-ID: <20170305112047.3411-8-luc.vanoostenryck@gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33470 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbdCEL15 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 06:27:57 -0500
Received: by mail-wm0-f65.google.com with SMTP id n11so9496465wma.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 03:27:56 -0800 (PST)
In-Reply-To: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In sparse, pointer arithmetic and accessing the field
of a structure or an array is simply done via OP_ADD,
the offset being calculated at evaluation time.
On the other hand, LLVM allows addition only on two
integers and pointer arithmetic/member access is done
via 'getelementptr'.

sparse-llvm didn't took this in account which resulted
in type error in 'add' instructions.

Fix this by catching addition involving pointer and issuing
a getelementptr' instruction for these.

Originally-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 27cc1b88c..ee374b217 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -472,6 +472,10 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 	case OP_ADD:
 		if (symbol_is_fp_type(insn->type))
 			target = LLVMBuildFAdd(fn->builder, lhs, rhs, target_name);
+		else if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMPointerTypeKind)
+			target = LLVMBuildGEP(fn->builder, lhs, &rhs, 1, "");
+		else if (LLVMGetTypeKind(LLVMTypeOf(rhs)) == LLVMPointerTypeKind)
+			target = LLVMBuildGEP(fn->builder, rhs, &lhs, 1, "");
 		else
 			target = LLVMBuildAdd(fn->builder, lhs, rhs, target_name);
 		break;
-- 
2.11.1

