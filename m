From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 49/63] llvm: remove unneeded pseudo_to_value() unneeded argument
Date: Tue, 21 Mar 2017 01:15:53 +0100
Message-ID: <20170321001607.75169-50-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36168 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbdCUARN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id x124so254645wmf.3
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:12 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 9f33c4e7a..4e7a42285 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -629,11 +629,11 @@ static void output_op_compare(struct function *fn, struct instruction *insn)
 	LLVMValueRef lhs, rhs, target;
 	char target_name[64];
 
-	lhs = pseudo_to_value(fn, insn->type, insn->src1);
+	lhs = pseudo_to_value(fn, NULL, insn->src1);
 	if (insn->src2->type == PSEUDO_VAL)
 		rhs = constant_value(insn->src2->value, LLVMTypeOf(lhs));
 	else
-		rhs = pseudo_to_value(fn, insn->type, insn->src2);
+		rhs = pseudo_to_value(fn, NULL, insn->src2);
 
 	pseudo_name(insn->target, target_name);
 
@@ -739,7 +739,7 @@ static LLVMValueRef bool_value(struct function *fn, LLVMValueRef value)
 static void output_op_cbr(struct function *fn, struct instruction *br)
 {
 	LLVMValueRef cond = bool_value(fn,
-			pseudo_to_value(fn, br->type, br->cond));
+			pseudo_to_value(fn, NULL, br->cond));
 
 	LLVMBuildCondBr(fn->builder, cond,
 			br->bb_true->priv,
@@ -756,7 +756,7 @@ static void output_op_sel(struct function *fn, struct instruction *insn)
 	LLVMValueRef target, src1, src2, src3;
 	char name[MAX_PSEUDO_NAME];
 
-	src1 = bool_value(fn, pseudo_to_value(fn, insn->type, insn->src1));
+	src1 = bool_value(fn, pseudo_to_value(fn, NULL, insn->src1));
 	src2 = pseudo_to_value(fn, insn->type, insn->src2);
 	src3 = pseudo_to_value(fn, insn->type, insn->src3);
 
@@ -811,7 +811,7 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 		args[i++] = pseudo_to_rvalue(fn, arg, arg->src);
 	} END_FOR_EACH_PTR(arg);
 
-	func = pseudo_to_value(fn, insn->type, insn->func);
+	func = pseudo_to_value(fn, NULL, insn->func);
 	pseudo_name(insn->target, name);
 	target = LLVMBuildCall(fn->builder, func, args, n_arg, name);
 
-- 
2.12.0

