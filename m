From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH] sparse, llvm: More comparison ops code generation
Date: Tue, 22 Nov 2011 19:40:32 +0200
Message-ID: <1321983632-8458-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40450 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab1KVRkl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Nov 2011 12:40:41 -0500
Received: by bke11 with SMTP id 11so495345bke.19
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2011 09:40:39 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

This patch implements LLVM code generation for OP_SET_LE, OP_SET_GE, OP_SET_BE,
and OP_SET_AE.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c                |    8 ++++----
 validation/backend/cmp-ops.c |   20 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 6402666..700a7a4 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -502,10 +502,10 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 		target = LLVMBuildICmp(fn->builder, LLVMIntNE, lhs, rhs, target_name);
 		break;
 	case OP_SET_LE:
-		assert(0);
+		target = LLVMBuildICmp(fn->builder, LLVMIntSLE, lhs, rhs, target_name);
 		break;
 	case OP_SET_GE:
-		assert(0);
+		target = LLVMBuildICmp(fn->builder, LLVMIntSGE, lhs, rhs, target_name);
 		break;
 	case OP_SET_LT:
 		assert(!symbol_is_fp_type(insn->type));
@@ -522,10 +522,10 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 		target = LLVMBuildICmp(fn->builder, LLVMIntUGT, lhs, rhs, target_name);
 		break;
 	case OP_SET_BE:
-		assert(0);
+		target = LLVMBuildICmp(fn->builder, LLVMIntULE, lhs, rhs, target_name);
 		break;
 	case OP_SET_AE:
-		assert(0);
+		target = LLVMBuildICmp(fn->builder, LLVMIntUGE, lhs, rhs, target_name);
 		break;
 	default:
 		assert(0);
diff --git a/validation/backend/cmp-ops.c b/validation/backend/cmp-ops.c
index b1ad227..7bbc81c 100644
--- a/validation/backend/cmp-ops.c
+++ b/validation/backend/cmp-ops.c
@@ -18,6 +18,16 @@ static int setg(int x, int y)
 	return x > y;
 }
 
+static int setle(int x, int y)
+{
+	return x <= y;
+}
+
+static int setge(int x, int y)
+{
+	return x >= y;
+}
+
 static int setb(unsigned int x, unsigned int y)
 {
 	return x < y;
@@ -28,6 +38,16 @@ static int seta(unsigned int x, unsigned int y)
 	return x > y;
 }
 
+static int setbe(unsigned int x, unsigned int y)
+{
+	return x <= y;
+}
+
+static int setae(unsigned int x, unsigned int y)
+{
+	return x >= y;
+}
+
 /*
  * check-name: Comparison operator code generation
  * check-command: ./sparsec -c $file -o tmp.o
-- 
1.7.6.4

