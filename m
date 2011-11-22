From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 2/2] sparse, llvm: OP_SET_B and OP_SET_A code generation
Date: Tue, 22 Nov 2011 17:27:41 +0200
Message-ID: <1321975661-1692-2-git-send-email-penberg@kernel.org>
References: <1321975661-1692-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33827 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756481Ab1KVP1w (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Nov 2011 10:27:52 -0500
Received: by bke11 with SMTP id 11so327055bke.19
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2011 07:27:50 -0800 (PST)
In-Reply-To: <1321975661-1692-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

This patch implement unsigned less than and greater than comparison operator
LLVM code generation.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c                |    4 ++--
 validation/backend/cmp-ops.c |   10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index e3d8883..6402666 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -516,10 +516,10 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 		target = LLVMBuildICmp(fn->builder, LLVMIntSGT, lhs, rhs, target_name);
 		break;
 	case OP_SET_B:
-		assert(0);
+		target = LLVMBuildICmp(fn->builder, LLVMIntULT, lhs, rhs, target_name);
 		break;
 	case OP_SET_A:
-		assert(0);
+		target = LLVMBuildICmp(fn->builder, LLVMIntUGT, lhs, rhs, target_name);
 		break;
 	case OP_SET_BE:
 		assert(0);
diff --git a/validation/backend/cmp-ops.c b/validation/backend/cmp-ops.c
index 5a89bee..b1ad227 100644
--- a/validation/backend/cmp-ops.c
+++ b/validation/backend/cmp-ops.c
@@ -18,6 +18,16 @@ static int setg(int x, int y)
 	return x > y;
 }
 
+static int setb(unsigned int x, unsigned int y)
+{
+	return x < y;
+}
+
+static int seta(unsigned int x, unsigned int y)
+{
+	return x > y;
+}
+
 /*
  * check-name: Comparison operator code generation
  * check-command: ./sparsec -c $file -o tmp.o
-- 
1.7.6.4

