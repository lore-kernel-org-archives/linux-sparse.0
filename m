From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 44/52] llvm: fix mutated OP_[PTR]CAST
Date: Mon, 27 Mar 2017 23:24:08 +0200
Message-ID: <20170327212416.18536-45-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35329 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752344AbdC0V1X (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:27:23 -0400
Received: by mail-wr0-f194.google.com with SMTP id p52so14122237wrc.2
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:27:08 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 4e9bf930b..cd527eb1c 100644
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

