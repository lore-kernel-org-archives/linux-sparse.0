From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 1/2] sparse, llvm: Pointer cast code generation
Date: Tue, 22 Nov 2011 17:27:40 +0200
Message-ID: <1321975661-1692-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59438 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756562Ab1KVP1u (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Nov 2011 10:27:50 -0500
Received: by fagn18 with SMTP id n18so521573fag.19
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2011 07:27:49 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

This patch implement code generation for OP_PTRCAST using LLVMBuildBitCast().

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c                |   20 +++++++++++++++++++-
 validation/backend/ptrcast.c |    9 +++++++++
 2 files changed, 28 insertions(+), 1 deletions(-)
 create mode 100644 validation/backend/ptrcast.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 1a2a34d..e3d8883 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -812,6 +812,24 @@ static void output_op_phi(struct function *fn, struct instruction *insn)
 	insn->target->priv = target;
 }
 
+static void output_op_ptrcast(struct function *fn, struct instruction *insn)
+{
+	LLVMValueRef src, target;
+	char target_name[64];
+
+	src = insn->src->priv;
+	if (!src)
+		src = pseudo_to_value(fn, insn, insn->src);
+
+	pseudo_name(insn->target, target_name);
+
+	assert(!symbol_is_fp_type(insn->type));
+
+	target = LLVMBuildBitCast(fn->builder, src, insn_symbol_type(fn->module, insn), target_name);
+
+	insn->target->priv = target;
+}
+
 static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOpcode op)
 {
 	LLVMValueRef src, target;
@@ -917,7 +935,7 @@ static void output_insn(struct function *fn, struct instruction *insn)
 		assert(0);
 		break;
 	case OP_PTRCAST:
-		assert(0);
+		output_op_ptrcast(fn, insn);
 		break;
 	case OP_BINARY ... OP_BINARY_END:
 	case OP_BINCMP ... OP_BINCMP_END:
diff --git a/validation/backend/ptrcast.c b/validation/backend/ptrcast.c
new file mode 100644
index 0000000..46f8add
--- /dev/null
+++ b/validation/backend/ptrcast.c
@@ -0,0 +1,9 @@
+static char *ptrcast(unsigned long *x)
+{
+	return (unsigned char *) x;
+}
+
+/*
+ * check-name: Pointer cast code generation
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
-- 
1.7.6.4

