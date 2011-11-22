From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH] sparse, llvm: Simplify comparison op code generation
Date: Tue, 22 Nov 2011 19:58:37 +0200
Message-ID: <1321984717-22395-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63580 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab1KVR6p (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Nov 2011 12:58:45 -0500
Received: by bke11 with SMTP id 11so521300bke.19
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2011 09:58:44 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: torvalds@linux-foundation.org, Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

Linus writes:

  On Tue, Nov 22, 2011 at 9:40 AM, Pekka Enberg <penberg@kernel.org> wrote:
  > This patch implements LLVM code generation for OP_SET_LE, OP_SET_GE, OP_SET_BE,
  > and OP_SET_AE.

  Ugh.

  Can't you just do it with a single statement like

     target = LLVMBuildICmp(fn->builder, translate_op(op), lhs, rhs,
target_name);

  instead of having that case-statement where every case does the same thing?

  The translate_op() thing should be trivial too, just something like

    static int translate_op(int sparse_op)
    {
        static const int trans_tbl[] = {
            .[OP_SET_LE] = LLVMIntSLE,
        ...
         };
         return trans_tbl[sparse_op];
    }

  or whatever. No?

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c |   56 +++++++++++++++++++++++---------------------------------
 1 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 700a7a4..4ef02a1 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -391,6 +391,24 @@ static LLVMTypeRef pseudo_type(struct function *fn, struct instruction *insn, ps
 	return result;
 }
 
+static LLVMIntPredicate translate_op(int opcode)
+{
+	static const LLVMIntPredicate trans_tbl[] = {
+		[OP_SET_EQ]	= LLVMIntEQ,
+		[OP_SET_NE]	= LLVMIntNE,
+		[OP_SET_LE]	= LLVMIntSLE,
+		[OP_SET_GE]	= LLVMIntSGE,
+		[OP_SET_LT]	= LLVMIntSLT,
+		[OP_SET_GT]	= LLVMIntSGT,
+		[OP_SET_B]	= LLVMIntULT,
+		[OP_SET_A]	= LLVMIntUGT,
+		[OP_SET_BE]	= LLVMIntULE,
+		[OP_SET_AE]	= LLVMIntUGE,
+	};
+
+	return trans_tbl[opcode];
+}
+
 static void output_op_binary(struct function *fn, struct instruction *insn)
 {
 	LLVMValueRef lhs, rhs, target;
@@ -493,40 +511,12 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 	}
 
 	/* Binary comparison */
-	case OP_SET_EQ:
-		assert(!symbol_is_fp_type(insn->type));
-		target = LLVMBuildICmp(fn->builder, LLVMIntEQ, lhs, rhs, target_name);
-		break;
-	case OP_SET_NE:
-		assert(!symbol_is_fp_type(insn->type));
-		target = LLVMBuildICmp(fn->builder, LLVMIntNE, lhs, rhs, target_name);
-		break;
-	case OP_SET_LE:
-		target = LLVMBuildICmp(fn->builder, LLVMIntSLE, lhs, rhs, target_name);
-		break;
-	case OP_SET_GE:
-		target = LLVMBuildICmp(fn->builder, LLVMIntSGE, lhs, rhs, target_name);
-		break;
-	case OP_SET_LT:
-		assert(!symbol_is_fp_type(insn->type));
-		target = LLVMBuildICmp(fn->builder, LLVMIntSLT, lhs, rhs, target_name);
-		break;
-	case OP_SET_GT:
-		assert(!symbol_is_fp_type(insn->type));
-		target = LLVMBuildICmp(fn->builder, LLVMIntSGT, lhs, rhs, target_name);
-		break;
-	case OP_SET_B:
-		target = LLVMBuildICmp(fn->builder, LLVMIntULT, lhs, rhs, target_name);
-		break;
-	case OP_SET_A:
-		target = LLVMBuildICmp(fn->builder, LLVMIntUGT, lhs, rhs, target_name);
-		break;
-	case OP_SET_BE:
-		target = LLVMBuildICmp(fn->builder, LLVMIntULE, lhs, rhs, target_name);
-		break;
-	case OP_SET_AE:
-		target = LLVMBuildICmp(fn->builder, LLVMIntUGE, lhs, rhs, target_name);
+	case OP_BINCMP ... OP_BINCMP_END: {
+		LLVMIntPredicate op = translate_op(insn->opcode);
+
+		target = LLVMBuildICmp(fn->builder, op, lhs, rhs, target_name);
 		break;
+	}
 	default:
 		assert(0);
 		break;
-- 
1.7.6.4

