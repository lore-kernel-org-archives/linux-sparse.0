From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH] sparse, llvm: FP comparison op code generation
Date: Tue, 22 Nov 2011 21:53:41 +0200
Message-ID: <1321991621-8825-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39885 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367Ab1KVTxt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Nov 2011 14:53:49 -0500
Received: by bke11 with SMTP id 11so658052bke.19
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2011 11:53:47 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

This patch implements code generation for floating point versions of OP_BINCMP.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c                |   29 +++++++++++++++++++++++++++--
 validation/backend/cmp-ops.c |   30 ++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 4ef02a1..0674ef3 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -391,6 +391,25 @@ static LLVMTypeRef pseudo_type(struct function *fn, struct instruction *insn, ps
 	return result;
 }
 
+static LLVMRealPredicate translate_fop(int opcode)
+{
+	static const LLVMRealPredicate trans_tbl[] = {
+		[OP_SET_EQ]	= LLVMRealOEQ,
+		[OP_SET_NE]	= LLVMRealUNE,
+		[OP_SET_LE]	= LLVMRealOLE,
+		[OP_SET_GE]	= LLVMRealOGE,
+		[OP_SET_LT]	= LLVMRealOLT,
+		[OP_SET_GT]	= LLVMRealOGT,
+		/* Are these used with FP? */
+		[OP_SET_B]	= LLVMRealOLT,
+		[OP_SET_A]	= LLVMRealOGT,
+		[OP_SET_BE]	= LLVMRealOLE,
+		[OP_SET_AE]	= LLVMRealOGE,
+	};
+
+	return trans_tbl[opcode];
+}
+
 static LLVMIntPredicate translate_op(int opcode)
 {
 	static const LLVMIntPredicate trans_tbl[] = {
@@ -512,9 +531,15 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 
 	/* Binary comparison */
 	case OP_BINCMP ... OP_BINCMP_END: {
-		LLVMIntPredicate op = translate_op(insn->opcode);
+		if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMIntegerTypeKind) {
+			LLVMIntPredicate op = translate_op(insn->opcode);
 
-		target = LLVMBuildICmp(fn->builder, op, lhs, rhs, target_name);
+			target = LLVMBuildICmp(fn->builder, op, lhs, rhs, target_name);
+		} else {
+			LLVMRealPredicate op = translate_fop(insn->opcode);
+
+			target = LLVMBuildFCmp(fn->builder, op, lhs, rhs, target_name);
+		}
 		break;
 	}
 	default:
diff --git a/validation/backend/cmp-ops.c b/validation/backend/cmp-ops.c
index 7bbc81c..a5f736d 100644
--- a/validation/backend/cmp-ops.c
+++ b/validation/backend/cmp-ops.c
@@ -48,6 +48,36 @@ static int setae(unsigned int x, unsigned int y)
 	return x >= y;
 }
 
+static int setfe(float x, float y)
+{
+	return x == y;
+}
+
+static int setfne(float x, float y)
+{
+	return x != y;
+}
+
+static int setfl(float x, float y)
+{
+	return x < y;
+}
+
+static int setfg(float x, float y)
+{
+	return x > y;
+}
+
+static int setfle(float x, float y)
+{
+	return x <= y;
+}
+
+static int setfge(float x, float y)
+{
+	return x >= y;
+}
+
 /*
  * check-name: Comparison operator code generation
  * check-command: ./sparsec -c $file -o tmp.o
-- 
1.7.6.4

