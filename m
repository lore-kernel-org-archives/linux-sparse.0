From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 14/52] llvm: take care of degenerated rvalues
Date: Mon, 27 Mar 2017 23:23:38 +0200
Message-ID: <20170327212416.18536-15-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33327 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752238AbdC0V0p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:45 -0400
Received: by mail-wr0-f196.google.com with SMTP id 20so17042260wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:44 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index c5af97141..0e7670ed6 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -408,6 +408,14 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 	return result;
 }
 
+static LLVMValueRef pseudo_to_rvalue(struct function *fn, struct instruction *insn, pseudo_t pseudo)
+{
+	LLVMValueRef val = pseudo_to_value(fn, insn, pseudo);
+	LLVMTypeRef dtype = symbol_type(insn->type);
+
+	return LLVMBuildBitCast(fn->builder, val, dtype, "");
+}
+
 static LLVMValueRef calc_gep(LLVMBuilderRef builder, LLVMValueRef base, LLVMValueRef off)
 {
 	LLVMTypeRef type = LLVMTypeOf(base);
@@ -655,7 +663,7 @@ static void output_op_store(struct function *fn, struct instruction *insn)
 
 	addr = calc_memop_addr(fn, insn);
 
-	target_in = pseudo_to_value(fn, insn, insn->target);
+	target_in = pseudo_to_rvalue(fn, insn, insn->target);
 
 	/* perform store */
 	LLVMBuildStore(fn->builder, target_in, addr);
@@ -744,7 +752,7 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 
 	i = 0;
 	FOR_EACH_PTR(insn->arguments, arg) {
-		args[i++] = pseudo_to_value(fn, arg, arg->src);
+		args[i++] = pseudo_to_rvalue(fn, arg, arg->src);
 	} END_FOR_EACH_PTR(arg);
 
 	func = pseudo_to_value(fn, insn, insn->func);
-- 
2.12.0

