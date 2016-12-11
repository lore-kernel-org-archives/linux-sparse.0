From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] llvm: remove unneeded OP_COPY support
Date: Sun, 11 Dec 2016 11:17:29 +0100
Message-ID: <20161211101729.26791-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:32831 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbcLKKTl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 11 Dec 2016 05:19:41 -0500
Received: by mail-wj0-f196.google.com with SMTP id kp2so7570912wjc.0
        for <linux-sparse@vger.kernel.org>; Sun, 11 Dec 2016 02:19:40 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Azat Khuzhin <a3at.mail@gmail.com>, Xi Wang <xi.wang@gmail.com>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>

OP_COPY instructions are only introduced by the 'unSSA' phase
which is not used by sparse-llvm.

Remove the code which tried to handle this.

Cc: Azat Khuzhin <a3at.mail@gmail.com>
Cc: Xi Wang <xi.wang@gmail.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 6b41afd8..5af473a3 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -788,34 +788,6 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
 	insn->target->priv = target;
 }
 
-static void output_op_copy(struct function *fn, struct instruction *insn,
-			   pseudo_t pseudo)
-{
-	LLVMValueRef src, target;
-	LLVMTypeRef const_type;
-	char target_name[64];
-
-	pseudo_name(insn->target, target_name);
-	src = pseudo_to_value(fn, insn, pseudo);
-	const_type = insn_symbol_type(fn->module, insn);
-
-	/*
-	 * This is nothing more than 'target = src'
-	 *
-	 * TODO: find a better way to provide an identity function,
-	 * than using "X + 0" simply to produce a new LLVM pseudo
-	 */
-
-	if (symbol_is_fp_type(insn->type))
-		target = LLVMBuildFAdd(fn->builder, src,
-			LLVMConstReal(const_type, 0.0), target_name);
-	else
-		target = LLVMBuildAdd(fn->builder, src,
-			LLVMConstInt(const_type, 0, 0), target_name);
-
-	insn->target->priv = target;
-}
