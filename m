From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 36/51] llvm: let pseudo_to_value() directly use the type
Date: Sat, 25 Mar 2017 00:20:42 +0100
Message-ID: <20170324232057.15033-37-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34869 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936134AbdCXXYC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:24:02 -0400
Received: by mail-wr0-f194.google.com with SMTP id u108so606166wrb.2
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:24:01 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 8cf65c1d3..9f33c4e7a 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -372,7 +372,7 @@ static LLVMValueRef val_to_value(unsigned long long val, struct symbol *ctype)
 	return constant_value(val, dtype);
 }
 
-static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *insn, pseudo_t pseudo)
+static LLVMValueRef pseudo_to_value(struct function *fn, struct symbol *ctype, pseudo_t pseudo)
 {
 	LLVMValueRef result = NULL;
 
@@ -384,7 +384,7 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 		result = get_sym_value(fn, pseudo->sym);
 		break;
 	case PSEUDO_VAL:
-		result = val_to_value(pseudo->value, insn->type);
+		result = val_to_value(pseudo->value, ctype);
 		break;
 	case PSEUDO_ARG: {
 		result = LLVMGetParam(fn->fn, pseudo->nr - 1);
@@ -405,7 +405,7 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 
 static LLVMValueRef pseudo_to_rvalue(struct function *fn, struct instruction *insn, pseudo_t pseudo)
 {
-	LLVMValueRef val = pseudo_to_value(fn, insn, pseudo);
+	LLVMValueRef val = pseudo_to_value(fn, insn->type, pseudo);
 	LLVMTypeRef dtype = symbol_type(insn->type);
 	char name[MAX_PSEUDO_NAME];
 
@@ -515,10 +515,10 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 	LLVMValueRef lhs, rhs, target;
 	char target_name[64];
 
-	lhs = pseudo_to_value(fn, insn, insn->src1);
+	lhs = pseudo_to_value(fn, insn->type, insn->src1);
 	lhs = value_to_ivalue(fn, insn->type, lhs);
 
-	rhs = pseudo_to_value(fn, insn, insn->src2);
+	rhs = pseudo_to_value(fn, insn->type, insn->src2);
 	rhs = value_to_ivalue(fn, insn->type, rhs);
 
 	pseudo_name(insn->target, target_name);
@@ -629,11 +629,11 @@ static void output_op_compare(struct function *fn, struct instruction *insn)
 	LLVMValueRef lhs, rhs, target;
 	char target_name[64];
 
-	lhs = pseudo_to_value(fn, insn, insn->src1);
+	lhs = pseudo_to_value(fn, insn->type, insn->src1);
 	if (insn->src2->type == PSEUDO_VAL)
 		rhs = constant_value(insn->src2->value, LLVMTypeOf(lhs));
 	else
-		rhs = pseudo_to_value(fn, insn, insn->src2);
+		rhs = pseudo_to_value(fn, insn->type, insn->src2);
 
 	pseudo_name(insn->target, target_name);
 
@@ -672,7 +672,7 @@ static void output_op_ret(struct function *fn, struct instruction *insn)
 	pseudo_t pseudo = insn->src;
 
 	if (pseudo && pseudo != VOID) {
-		LLVMValueRef result = pseudo_to_value(fn, insn, pseudo);
+		LLVMValueRef result = pseudo_to_value(fn, insn->type, pseudo);
 
 		result = adjust_type(fn, insn->type, result);
 		LLVMBuildRet(fn->builder, result);
@@ -691,7 +691,7 @@ static LLVMValueRef calc_memop_addr(struct function *fn, struct instruction *ins
 	off = LLVMConstInt(int_type, insn->offset, 0);
 
 	/* convert src to the effective pointer type */
-	src = pseudo_to_value(fn, insn, insn->src);
+	src = pseudo_to_value(fn, insn->type, insn->src);
 	as = LLVMGetPointerAddressSpace(LLVMTypeOf(src));
 	addr_type = LLVMPointerType(insn_symbol_type(insn), as);
 	src = LLVMBuildPointerCast(fn->builder, src, addr_type, LLVMGetValueName(src));
@@ -739,7 +739,7 @@ static LLVMValueRef bool_value(struct function *fn, LLVMValueRef value)
 static void output_op_cbr(struct function *fn, struct instruction *br)
 {
 	LLVMValueRef cond = bool_value(fn,
-			pseudo_to_value(fn, br, br->cond));
+			pseudo_to_value(fn, br->type, br->cond));
 
 	LLVMBuildCondBr(fn->builder, cond,
 			br->bb_true->priv,
@@ -756,9 +756,9 @@ static void output_op_sel(struct function *fn, struct instruction *insn)
 	LLVMValueRef target, src1, src2, src3;
 	char name[MAX_PSEUDO_NAME];
 
-	src1 = bool_value(fn, pseudo_to_value(fn, insn, insn->src1));
-	src2 = pseudo_to_value(fn, insn, insn->src2);
-	src3 = pseudo_to_value(fn, insn, insn->src3);
+	src1 = bool_value(fn, pseudo_to_value(fn, insn->type, insn->src1));
+	src2 = pseudo_to_value(fn, insn->type, insn->src2);
+	src3 = pseudo_to_value(fn, insn->type, insn->src3);
 
 	pseudo_name(insn->target, name);
 	target = LLVMBuildSelect(fn->builder, src1, src2, src3, name);
@@ -780,7 +780,7 @@ static void output_op_switch(struct function *fn, struct instruction *insn)
 			def = jmp->target;
 	} END_FOR_EACH_PTR(jmp);
 
-	sw_val = pseudo_to_value(fn, insn, insn->target);
+	sw_val = pseudo_to_value(fn, insn->type, insn->target);
 	target = LLVMBuildSwitch(fn->builder, sw_val,
 				 def ? def->priv : NULL, n_jmp);
 
@@ -811,7 +811,7 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 		args[i++] = pseudo_to_rvalue(fn, arg, arg->src);
 	} END_FOR_EACH_PTR(arg);
 
-	func = pseudo_to_value(fn, insn, insn->func);
+	func = pseudo_to_value(fn, insn->type, insn->func);
 	pseudo_name(insn->target, name);
 	target = LLVMBuildCall(fn->builder, func, args, n_arg, name);
 
@@ -826,7 +826,7 @@ static void output_op_phisrc(struct function *fn, struct instruction *insn)
 	assert(insn->target->priv == NULL);
 
 	/* target = src */
-	v = pseudo_to_value(fn, insn, insn->phi_src);
+	v = pseudo_to_value(fn, insn->type, insn->phi_src);
 
 	FOR_EACH_PTR(insn->phi_users, phi) {
 		LLVMValueRef load, ptr;
@@ -862,7 +862,7 @@ static void output_op_ptrcast(struct function *fn, struct instruction *insn)
 
 	src = insn->src->priv;
 	if (!src)
-		src = pseudo_to_value(fn, insn, insn->src);
+		src = pseudo_to_value(fn, insn->type, insn->src);
 
 	pseudo_name(insn->target, target_name);
 
@@ -896,7 +896,7 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
 
 	src = insn->src->priv;
 	if (!src)
-		src = pseudo_to_value(fn, insn, insn->src);
+		src = pseudo_to_value(fn, insn->type, insn->src);
 
 	pseudo_name(insn->target, target_name);
 
@@ -1017,7 +1017,7 @@ static void output_insn(struct function *fn, struct instruction *insn)
 		LLVMValueRef src, target;
 		char target_name[64];
 
-		src = pseudo_to_value(fn, insn, insn->src);
+		src = pseudo_to_value(fn, insn->type, insn->src);
 
 		pseudo_name(insn->target, target_name);
 
@@ -1030,7 +1030,7 @@ static void output_insn(struct function *fn, struct instruction *insn)
 		LLVMValueRef src, target;
 		char target_name[64];
 
-		src = pseudo_to_value(fn, insn, insn->src);
+		src = pseudo_to_value(fn, insn->type, insn->src);
 
 		pseudo_name(insn->target, target_name);
 
-- 
2.12.0

