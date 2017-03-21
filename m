From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 50/63] llvm: introduce get_ioperand()
Date: Tue, 21 Mar 2017 01:15:54 +0100
Message-ID: <20170321001607.75169-51-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34991 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755793AbdCUARP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id z133so259465wmb.2
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:13 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 4e7a42285..ba70b0e6b 100644
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
