From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] llvm: fix typing when comparing to a constant
Date: Sun, 11 Dec 2016 10:49:19 +0100
Message-ID: <20161211094919.20894-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34315 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbcLKJt2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 11 Dec 2016 04:49:28 -0500
Received: by mail-wm0-f67.google.com with SMTP id g23so4386884wme.1
        for <linux-sparse@vger.kernel.org>; Sun, 11 Dec 2016 01:49:28 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Azat Khuzhin <a3at.mail@gmail.com>, Xi Wang <xi.wang@gmail.com>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>

In translation to LLVM, comparisons are processed like usual binary
operations. But contrary to, for example, an addition where the
result type and the type of both operands are all the same, a
comparison always returns an integer result (with boolean values)
which shouldn't depends on the type/size of its operands.

There is currently a bug regarding this when an operand of a
comparison is an integer constant:
    the type of this constant is assumed to be the type of the result
    of the comparison (in sparse's IR, the constants are typeless,
    we thus need to guess/retrieve their type from the context)

For example, with the following C code:
	_Bool foo(int a) { return a != 3; }

After linearization we can have the following very straightforward:
	setne.1    %rd <- %arg1, $3

And we expect the following LLVM IR:
	%rd = icmp ne i32 %0, 3

But what is built is the illegal:
	%rd = icmp ne i32 %0, i1 true
because is constant '3' is translated to 'i1 true' since
'setne.1' result type is boolean (i1 in LLVM parlance).

Fix this by separating the code for comparison from the others
binary operations and using the left-hand side type to interpret
the type of the constant (which is fine because the usual conversion
insure that both types match and there is never a constant on the lhs).

Cc: Azat Khuzhin <a3at.mail@gmail.com>
Cc: Xi Wang <xi.wang@gmail.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 53 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 6b41afd8..29b7cae0 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -535,24 +535,6 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 		target = LLVMBuildZExt(fn->builder, target, dst_type, target_name);
 		break;
 	}
-
-	/* Binary comparison */
-	case OP_BINCMP ... OP_BINCMP_END: {
-		LLVMTypeRef dst_type = insn_symbol_type(fn->module, insn);
-
-		if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMIntegerTypeKind) {
-			LLVMIntPredicate op = translate_op(insn->opcode);
-
-			target = LLVMBuildICmp(fn->builder, op, lhs, rhs, target_name);
-		} else {
-			LLVMRealPredicate op = translate_fop(insn->opcode);
-
-			target = LLVMBuildFCmp(fn->builder, op, lhs, rhs, target_name);
-		}
-
-		target = LLVMBuildZExt(fn->builder, target, dst_type, target_name);
-		break;
-	}
 	default:
 		assert(0);
 		break;
@@ -561,6 +543,37 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 	insn->target->priv = target;
 }
 
+static void output_op_compare(struct function *fn, struct instruction *insn)
+{
+	LLVMValueRef lhs, rhs, target;
+	char target_name[64];
+
+	lhs = pseudo_to_value(fn, insn, insn->src1);
+
+	if (insn->src2->type == PSEUDO_VAL)
+		rhs = LLVMConstInt(LLVMTypeOf(lhs), insn->src2->value, 1);
+	else
+		rhs = pseudo_to_value(fn, insn, insn->src2);
+
+	pseudo_name(insn->target, target_name);
+
+	LLVMTypeRef dst_type = insn_symbol_type(fn->module, insn);
+
+	if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMIntegerTypeKind) {
+		LLVMIntPredicate op = translate_op(insn->opcode);
+
+		target = LLVMBuildICmp(fn->builder, op, lhs, rhs, target_name);
+	} else {
+		LLVMRealPredicate op = translate_fop(insn->opcode);
+
+		target = LLVMBuildFCmp(fn->builder, op, lhs, rhs, target_name);
+	}
+
+	target = LLVMBuildZExt(fn->builder, target, dst_type, target_name);
+
+	insn->target->priv = target;
+}
+
 static void output_op_ret(struct function *fn, struct instruction *insn)
 {
 	pseudo_t pseudo = insn->src;
@@ -874,9 +887,11 @@ static void output_insn(struct function *fn, struct instruction *insn)
 		output_op_ptrcast(fn, insn);
 		break;
 	case OP_BINARY ... OP_BINARY_END:
-	case OP_BINCMP ... OP_BINCMP_END:
 		output_op_binary(fn, insn);
 		break;
+	case OP_BINCMP ... OP_BINCMP_END:
+		output_op_compare(fn, insn);
+		break;
 	case OP_SEL:
 		output_op_sel(fn, insn);
 		break;
-- 
2.10.2

