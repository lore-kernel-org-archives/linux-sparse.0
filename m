From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 42/63] llvm: give a name to all values
Date: Tue, 21 Mar 2017 01:15:46 +0100
Message-ID: <20170321001607.75169-43-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33248 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753279AbdCUARG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11so268836wma.0
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:05 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index bf76bbe77..6530d2d59 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -407,15 +407,18 @@ static LLVMValueRef pseudo_to_rvalue(struct function *fn, struct instruction *in
 {
 	LLVMValueRef val = pseudo_to_value(fn, insn, pseudo);
 	LLVMTypeRef dtype = symbol_type(insn->type);
+	char name[MAX_PSEUDO_NAME];
 
-	return LLVMBuildBitCast(fn->builder, val, dtype, "");
+	pseudo_name(pseudo, name);
+	return LLVMBuildBitCast(fn->builder, val, dtype, name);
 }
 
 static LLVMValueRef value_to_ivalue(struct function *fn, LLVMValueRef val)
 {
 	if (LLVMGetTypeKind(LLVMTypeOf(val)) == LLVMPointerTypeKind) {
 		LLVMTypeRef dtype = LLVMIntType(bits_in_pointer);
-		val = LLVMBuildPtrToInt(fn->builder, val, dtype, "");
+		const char *name = LLVMGetValueName(val);
+		val = LLVMBuildPtrToInt(fn->builder, val, dtype, name);
 	}
 	return val;
 }
@@ -424,7 +427,8 @@ static LLVMValueRef value_to_pvalue(struct function *fn, struct symbol *ctype, L
 {
 	if (LLVMGetTypeKind(LLVMTypeOf(val)) == LLVMIntegerTypeKind) {
 		LLVMTypeRef dtype = symbol_type(ctype);
-		val = LLVMBuildIntToPtr(fn->builder, val, dtype, "");
+		const char *name = LLVMGetValueName(val);
+		val = LLVMBuildIntToPtr(fn->builder, val, dtype, name);
 	}
 	return val;
 }
@@ -444,13 +448,14 @@ static LLVMValueRef calc_gep(LLVMBuilderRef builder, LLVMValueRef base, LLVMValu
 	unsigned int as = LLVMGetPointerAddressSpace(type);
 	LLVMTypeRef bytep = LLVMPointerType(LLVMInt8Type(), as);
 	LLVMValueRef addr;
+	const char *name = LLVMGetValueName(off);
 
 	/* convert base to char* type */
-	base = LLVMBuildPointerCast(builder, base, bytep, "");
+	base = LLVMBuildPointerCast(builder, base, bytep, name);
 	/* addr = base + off */
-	addr = LLVMBuildInBoundsGEP(builder, base, &off, 1, "");
+	addr = LLVMBuildInBoundsGEP(builder, base, &off, 1, name);
 	/* convert back to the actual pointer type */
-	addr = LLVMBuildPointerCast(builder, addr, type, "");
+	addr = LLVMBuildPointerCast(builder, addr, type, name);
 	return addr;
 }
 
@@ -576,8 +581,8 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 		LLVMValueRef lhs_nz, rhs_nz;
 		LLVMTypeRef dst_type;
 
-		lhs_nz = LLVMBuildIsNotNull(fn->builder, lhs, "");
-		rhs_nz = LLVMBuildIsNotNull(fn->builder, rhs, "");
+		lhs_nz = LLVMBuildIsNotNull(fn->builder, lhs, LLVMGetValueName(lhs));
+		rhs_nz = LLVMBuildIsNotNull(fn->builder, rhs, LLVMGetValueName(rhs));
 		target = LLVMBuildAnd(fn->builder, lhs_nz, rhs_nz, target_name);
 
 		dst_type = insn_symbol_type(insn);
@@ -588,8 +593,8 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 		LLVMValueRef lhs_nz, rhs_nz;
 		LLVMTypeRef dst_type;
 
-		lhs_nz = LLVMBuildIsNotNull(fn->builder, lhs, "");
-		rhs_nz = LLVMBuildIsNotNull(fn->builder, rhs, "");
+		lhs_nz = LLVMBuildIsNotNull(fn->builder, lhs, LLVMGetValueName(lhs));
+		rhs_nz = LLVMBuildIsNotNull(fn->builder, rhs, LLVMGetValueName(rhs));
 		target = LLVMBuildOr(fn->builder, lhs_nz, rhs_nz, target_name);
 
 		dst_type = insn_symbol_type(insn);
@@ -675,7 +680,7 @@ static LLVMValueRef calc_memop_addr(struct function *fn, struct instruction *ins
 	src = pseudo_to_value(fn, insn, insn->src);
 	as = LLVMGetPointerAddressSpace(LLVMTypeOf(src));
 	addr_type = LLVMPointerType(insn_symbol_type(insn), as);
-	src = LLVMBuildPointerCast(fn->builder, src, addr_type, "");
+	src = LLVMBuildPointerCast(fn->builder, src, addr_type, LLVMGetValueName(src));
 
 	/* addr = src + off */
 	addr = calc_gep(fn->builder, src, off);
@@ -686,11 +691,13 @@ static LLVMValueRef calc_memop_addr(struct function *fn, struct instruction *ins
 static void output_op_load(struct function *fn, struct instruction *insn)
 {
 	LLVMValueRef addr, target;
+	char name[MAX_PSEUDO_NAME];
 
 	addr = calc_memop_addr(fn, insn);
 
 	/* perform load */
-	target = LLVMBuildLoad(fn->builder, addr, "load_target");
+	pseudo_name(insn->target, name);
+	target = LLVMBuildLoad(fn->builder, addr, name);
 
 	insn->target->priv = target;
 }
@@ -710,7 +717,7 @@ static void output_op_store(struct function *fn, struct instruction *insn)
 static LLVMValueRef bool_value(struct function *fn, LLVMValueRef value)
 {
 	if (LLVMTypeOf(value) != LLVMInt1Type())
-		value = LLVMBuildIsNotNull(fn->builder, value, "cond");
+		value = LLVMBuildIsNotNull(fn->builder, value, LLVMGetValueName(value));
 
 	return value;
 }
@@ -733,12 +740,14 @@ static void output_op_br(struct function *fn, struct instruction *br)
 static void output_op_sel(struct function *fn, struct instruction *insn)
 {
 	LLVMValueRef target, src1, src2, src3;
+	char name[MAX_PSEUDO_NAME];
 
 	src1 = bool_value(fn, pseudo_to_value(fn, insn, insn->src1));
 	src2 = pseudo_to_value(fn, insn, insn->src2);
 	src3 = pseudo_to_value(fn, insn, insn->src3);
 
-	target = LLVMBuildSelect(fn->builder, src1, src2, src3, "select");
+	pseudo_name(insn->target, name);
+	target = LLVMBuildSelect(fn->builder, src1, src2, src3, name);
 
 	insn->target->priv = target;
 }
-- 
2.12.0

