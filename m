From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2] llvm: fix output OP_ADD mixed with pointers
Date: Mon,  6 Mar 2017 22:15:29 +0100
Message-ID: <20170306211529.60199-1-luc.vanoostenryck@gmail.com>
References: <CANeU7QnS2_OgvaZo1T+_cfw=ZKFvZEM8dnMet4kfqhTzGWUDHQ@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33026 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753385AbdCFVRy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 16:17:54 -0500
Received: by mail-wm0-f68.google.com with SMTP id n11so15826960wma.0
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 13:17:35 -0800 (PST)
In-Reply-To: <CANeU7QnS2_OgvaZo1T+_cfw=ZKFvZEM8dnMet4kfqhTzGWUDHQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In sparse, pointer arithmetic and accessing the field
of a structure or an array is simply done via OP_ADD,
the offset being calculated at evaluation time.
On the other hand, LLVM allows addition only on two
integers and pointer arithmetic/member access must be
done either via 'getelementptr' or the pointer must be
casted to and fro an integer.

sparse-llvm didn't took this in account which resulted
in type error in 'add' instructions.

Fix this by catching addition involving pointer and
the already existing helper calc_gep() for these.

Originally-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

Changes since v1:
- use calc_gep() to issue the 'getelementptr' in order to use the
  offset value.

 sparse-llvm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 27cc1b88c..bd57730d4 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -472,6 +472,10 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 	case OP_ADD:
 		if (symbol_is_fp_type(insn->type))
 			target = LLVMBuildFAdd(fn->builder, lhs, rhs, target_name);
+		else if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMPointerTypeKind)
+			target = calc_gep(fn->builder, lhs, rhs);
+		else if (LLVMGetTypeKind(LLVMTypeOf(rhs)) == LLVMPointerTypeKind)
+			target = calc_gep(fn->builder, rhs, lhs);
 		else
 			target = LLVMBuildAdd(fn->builder, lhs, rhs, target_name);
 		break;
-- 
2.11.1

