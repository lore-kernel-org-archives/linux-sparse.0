From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 56/63] llvm: fix mutated OP_[PTR]CAST
Date: Tue, 21 Mar 2017 01:16:00 +0100
Message-ID: <20170321001607.75169-57-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33908 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755844AbdCUARV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id u132so264688wmg.1
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:20 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 0b711473d..ac0093a3b 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -876,13 +876,12 @@ static void output_op_ptrcast(struct function *fn, struct instruction *insn)
 {
 	LLVMValueRef src, target;
 	LLVMTypeRef dtype;
+	struct symbol *otype = insn->orig_type;
 	LLVMOpcode op;
 	char target_name[64];
 
-	src = insn->src->priv;
-	if (!src)
-		src = pseudo_to_value(fn, insn->type, insn->src);
 
+	src = get_operand(fn, otype, insn->src);
 	pseudo_name(insn->target, target_name);
 
 	assert(!is_float_type(insn->type));
@@ -907,16 +906,15 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
 {
 	LLVMValueRef src, target;
 	LLVMTypeRef dtype;
+	struct symbol *otype = insn->orig_type;
 	char target_name[64];
 	unsigned int width;
 
 	if (is_ptr_type(insn->type))	// cast to void* is OP_CAST ...
 		return output_op_ptrcast(fn, insn);
 
-	src = insn->src->priv;
-	if (!src)
-		src = pseudo_to_value(fn, insn->type, insn->src);
 
+	src = get_operand(fn, otype, insn->src);
 	pseudo_name(insn->target, target_name);
 
 	assert(!is_float_type(insn->type));
-- 
2.12.0

