From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 38/52] llvm: introduce get_ioperand()
Date: Mon, 27 Mar 2017 23:24:02 +0200
Message-ID: <20170327212416.18536-39-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33966 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbdC0V1I (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:27:08 -0400
Received: by mail-wr0-f195.google.com with SMTP id w43so14205292wrb.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:27:07 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 58fe8e213..0c92eab23 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -456,6 +456,27 @@ static LLVMValueRef adjust_type(struct function *fn, struct symbol *ctype, LLVMV
 	return val;
 }
 
+/*
+ * Get the LLVMValue corresponding to the pseudo
+ * and force the type corresponding to ctype.
+ */
+static LLVMValueRef get_operand(struct function *fn, struct symbol *ctype, pseudo_t pseudo)
+{
+	LLVMValueRef target = pseudo_to_value(fn, ctype, pseudo);
+	return adjust_type(fn, ctype, target);
+}
+
+/*
+ * Get the LLVMValue corresponding to the pseudo
+ * and force the type corresponding to ctype but
+ * map all pointers to intptr_t.
+ */
+static LLVMValueRef get_ioperand(struct function *fn, struct symbol *ctype, pseudo_t pseudo)
+{
+	LLVMValueRef target = pseudo_to_value(fn, ctype, pseudo);
+	return value_to_ivalue(fn, ctype, target);
+}
+
 static LLVMValueRef calc_gep(LLVMBuilderRef builder, LLVMValueRef base, LLVMValueRef off)
 {
 	LLVMTypeRef type = LLVMTypeOf(base);
@@ -515,11 +536,8 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 	LLVMValueRef lhs, rhs, target;
 	char target_name[64];
 
-	lhs = pseudo_to_value(fn, insn->type, insn->src1);
-	lhs = value_to_ivalue(fn, insn->type, lhs);
