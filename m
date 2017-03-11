From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 20/27] llvm: fix pointer/float mixup in comparisons
Date: Sat, 11 Mar 2017 10:06:59 +0100
Message-ID: <20170311090706.17171-21-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35021 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755338AbdCKJHn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:43 -0500
Received: by mail-wr0-f193.google.com with SMTP id u108so14120688wrb.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:42 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In output_op_compare() everything that is not of interger
type is treated as floats. Pointers disagree.

Fix this by rearranging the code and treat pointers like integers
as required for LLVM's icmp.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c                    | 17 +++++++++++++++--
 validation/backend/pointer-cmp.c |  9 +++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)
 create mode 100644 validation/backend/pointer-cmp.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index ccc019322..18a38a339 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -590,14 +590,27 @@ static void output_op_compare(struct function *fn, struct instruction *insn)
 
 	LLVMTypeRef dst_type = insn_symbol_type(fn->module, insn);
 
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
diff --git a/validation/backend/pointer-cmp.c b/validation/backend/pointer-cmp.c
new file mode 100644
index 000000000..fa76d1b57
--- /dev/null
+++ b/validation/backend/pointer-cmp.c
@@ -0,0 +1,9 @@
+int cmpint(   int x,   int y)	{ return x == y; }
+int cmpflt( float x, float y)	{ return x == y; }
+int cmpvptr(void *x, void *y)	{ return x == y; }
+int cmpiptr(int  *x, int  *y)	{ return x == y; }
+
+/*
+ * check-name: pointer comparison
+ * check-command: ./sparsec -Wno-decl -c $file -o tmp.o
+ */
-- 
2.11.1

