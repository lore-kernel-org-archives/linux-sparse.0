From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 11/13] llvm: remove unneeded arg 'module'
Date: Sun,  5 Mar 2017 12:20:45 +0100
Message-ID: <20170305112047.3411-12-luc.vanoostenryck@gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35740 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752362AbdCEL1p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 06:27:45 -0500
Received: by mail-wr0-f196.google.com with SMTP id u108so14397617wrb.2
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 03:27:44 -0800 (PST)
In-Reply-To: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 72 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index c489009a6..35562e570 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -34,14 +34,14 @@ static inline bool symbol_is_fp_type(struct symbol *sym)
 	return sym->ctype.base_type == &fp_type;
 }
 
-static LLVMTypeRef symbol_type(LLVMModuleRef module, struct symbol *sym);
+static LLVMTypeRef symbol_type(struct symbol *sym);
 
-static LLVMTypeRef func_return_type(LLVMModuleRef module, struct symbol *sym)
+static LLVMTypeRef func_return_type(struct symbol *sym)
 {
-	return symbol_type(module, sym->ctype.base_type);
+	return symbol_type(sym->ctype.base_type);
 }
 
-static LLVMTypeRef sym_func_type(LLVMModuleRef module, struct symbol *sym)
+static LLVMTypeRef sym_func_type(struct symbol *sym)
 {
 	LLVMTypeRef *arg_type;
 	LLVMTypeRef func_type;
@@ -55,7 +55,7 @@ static LLVMTypeRef sym_func_type(LLVMModuleRef module, struct symbol *sym)
 	 * symbol declaration info.
 	 */
 
-	ret_type = func_return_type(module, sym);
+	ret_type = func_return_type(sym);
 
 	/* count args, build argument type information */
 	FOR_EACH_PTR(sym->arguments, arg) {
@@ -68,7 +68,7 @@ static LLVMTypeRef sym_func_type(LLVMModuleRef module, struct symbol *sym)
 	FOR_EACH_PTR(sym->arguments, arg) {
 		struct symbol *arg_sym = arg->ctype.base_type;
 
-		arg_type[idx++] = symbol_type(module, arg_sym);
+		arg_type[idx++] = symbol_type(arg_sym);
 	} END_FOR_EACH_PTR(arg);
 	func_type = LLVMFunctionType(ret_type, arg_type, n_arg,
 				     sym->variadic);
@@ -76,7 +76,7 @@ static LLVMTypeRef sym_func_type(LLVMModuleRef module, struct symbol *sym)
 	return func_type;
 }
 
-static LLVMTypeRef sym_array_type(LLVMModuleRef module, struct symbol *sym)
+static LLVMTypeRef sym_array_type(struct symbol *sym)
 {
 	LLVMTypeRef elem_type;
 	struct symbol *base_type;
@@ -85,7 +85,7 @@ static LLVMTypeRef sym_array_type(LLVMModuleRef module, struct symbol *sym)
 	/* empty struct is undefined [6.7.2.1(8)] */
 	assert(base_type->bit_size > 0);
 
-	elem_type = symbol_type(module, base_type);
+	elem_type = symbol_type(base_type);
 	if (!elem_type)
 		return NULL;
 
@@ -94,7 +94,7 @@ static LLVMTypeRef sym_array_type(LLVMModuleRef module, struct symbol *sym)
 
 #define MAX_STRUCT_MEMBERS 64
 
-static LLVMTypeRef sym_struct_type(LLVMModuleRef module, struct symbol *sym)
+static LLVMTypeRef sym_struct_type(struct symbol *sym)
 {
 	LLVMTypeRef elem_types[MAX_STRUCT_MEMBERS];
 	struct symbol *member;
@@ -112,7 +112,7 @@ static LLVMTypeRef sym_struct_type(LLVMModuleRef module, struct symbol *sym)
 
 		assert(nr < MAX_STRUCT_MEMBERS);
 
-		member_type = symbol_type(module, member);
+		member_type = symbol_type(member);
 
 		elem_types[nr++] = member_type; 
 	} END_FOR_EACH_PTR(member);
@@ -121,7 +121,7 @@ static LLVMTypeRef sym_struct_type(LLVMModuleRef module, struct symbol *sym)
 	return ret;
 }
 
-static LLVMTypeRef sym_union_type(LLVMModuleRef module, struct symbol *sym)
+static LLVMTypeRef sym_union_type(struct symbol *sym)
 {
 	LLVMTypeRef elements;
 	unsigned union_size;
@@ -138,7 +138,7 @@ static LLVMTypeRef sym_union_type(LLVMModuleRef module, struct symbol *sym)
 	return LLVMStructType(&elements, 1, 0 /* packed? */);
 }
 
-static LLVMTypeRef sym_ptr_type(LLVMModuleRef module, struct symbol *sym)
+static LLVMTypeRef sym_ptr_type(struct symbol *sym)
 {
 	LLVMTypeRef type;
 
@@ -146,7 +146,7 @@ static LLVMTypeRef sym_ptr_type(LLVMModuleRef module, struct symbol *sym)
 	if (is_void_type(sym->ctype.base_type))
 		type = LLVMInt8Type();
 	else
-		type = symbol_type(module, sym->ctype.base_type);
+		type = symbol_type(sym->ctype.base_type);
 
 	return LLVMPointerType(type, 0);
 }
@@ -199,13 +199,13 @@ static LLVMTypeRef sym_basetype_type(struct symbol *sym)
 	return ret;
 }
 
-static LLVMTypeRef symbol_type(LLVMModuleRef module, struct symbol *sym)
+static LLVMTypeRef symbol_type(struct symbol *sym)
 {
 	LLVMTypeRef ret = NULL;
 
 	/* don't cache the result for SYM_NODE */
 	if (sym->type == SYM_NODE)
-		return symbol_type(module, sym->ctype.base_type);
+		return symbol_type(sym->ctype.base_type);
 
 	if (sym->aux)
 		return sym->aux;
@@ -213,25 +213,25 @@ static LLVMTypeRef symbol_type(LLVMModuleRef module, struct symbol *sym)
 	switch (sym->type) {
 	case SYM_BITFIELD:
 	case SYM_ENUM:
-		ret = symbol_type(module, sym->ctype.base_type);
+		ret = symbol_type(sym->ctype.base_type);
 		break;
 	case SYM_BASETYPE:
 		ret = sym_basetype_type(sym);
 		break;
 	case SYM_PTR:
-		ret = sym_ptr_type(module, sym);
+		ret = sym_ptr_type(sym);
 		break;
 	case SYM_UNION:
-		ret = sym_union_type(module, sym);
+		ret = sym_union_type(sym);
 		break;
 	case SYM_STRUCT:
-		ret = sym_struct_type(module, sym);
+		ret = sym_struct_type(sym);
 		break;
 	case SYM_ARRAY:
-		ret = sym_array_type(module, sym);
+		ret = sym_array_type(sym);
 		break;
 	case SYM_FN:
-		ret = sym_func_type(module, sym);
+		ret = sym_func_type(sym);
 		break;
 	default:
 		assert(0);
@@ -242,10 +242,10 @@ static LLVMTypeRef symbol_type(LLVMModuleRef module, struct symbol *sym)
 	return ret;
 }
 
-static LLVMTypeRef insn_symbol_type(LLVMModuleRef module, struct instruction *insn)
+static LLVMTypeRef insn_symbol_type(struct instruction *insn)
 {
 	if (insn->type)
-		return symbol_type(module, insn->type);
+		return symbol_type(insn->type);
 
 	switch (insn->size) {
 		case 8:		return LLVMInt8Type();
@@ -310,7 +310,7 @@ static LLVMValueRef val_to_value(struct function *fn, unsigned long long val, st
 	LLVMValueRef result;
 
 	assert(ctype);
-	dtype = symbol_type(fn->module, ctype);
+	dtype = symbol_type(ctype);
 	switch (LLVMGetTypeKind(dtype)) {
 	case LLVMPointerTypeKind:
 		itype = LLVMIntType(bits_in_pointer);
@@ -369,7 +369,7 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 			}
 		} else {
 			const char *name = show_ident(sym->ident);
-			LLVMTypeRef type = symbol_type(fn->module, sym);
+			LLVMTypeRef type = symbol_type(sym);
 
 			if (LLVMGetTypeKind(type) == LLVMFunctionTypeKind) {
 				result = LLVMGetNamedFunction(fn->module, name);
@@ -547,7 +547,7 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 		rhs_nz = LLVMBuildIsNotNull(fn->builder, rhs, "");
 		target = LLVMBuildAnd(fn->builder, lhs_nz, rhs_nz, target_name);
 
-		dst_type = insn_symbol_type(fn->module, insn);
+		dst_type = insn_symbol_type(insn);
 		target = LLVMBuildZExt(fn->builder, target, dst_type, target_name);
 		break;
 	}
@@ -559,7 +559,7 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 		rhs_nz = LLVMBuildIsNotNull(fn->builder, rhs, "");
 		target = LLVMBuildOr(fn->builder, lhs_nz, rhs_nz, target_name);
 
-		dst_type = insn_symbol_type(fn->module, insn);
+		dst_type = insn_symbol_type(insn);
 		target = LLVMBuildZExt(fn->builder, target, dst_type, target_name);
 		break;
 	}
@@ -585,7 +585,7 @@ static void output_op_compare(struct function *fn, struct instruction *insn)
 
 	pseudo_name(insn->target, target_name);
 
-	LLVMTypeRef dst_type = insn_symbol_type(fn->module, insn);
+	LLVMTypeRef dst_type = insn_symbol_type(insn);
 
 	if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMIntegerTypeKind) {
 		LLVMIntPredicate op = translate_op(insn->opcode);
@@ -627,7 +627,7 @@ static LLVMValueRef calc_memop_addr(struct function *fn, struct instruction *ins
 	/* convert src to the effective pointer type */
 	src = pseudo_to_value(fn, insn, insn->src);
 	as = LLVMGetPointerAddressSpace(LLVMTypeOf(src));
-	addr_type = LLVMPointerType(insn_symbol_type(fn->module, insn), as);
+	addr_type = LLVMPointerType(insn_symbol_type(insn), as);
 	src = LLVMBuildPointerCast(fn->builder, src, addr_type, "");
 
 	/* addr = src + off */
@@ -812,7 +812,7 @@ static void output_op_ptrcast(struct function *fn, struct instruction *insn)
 
 	assert(!symbol_is_fp_type(insn->type));
 
-	dtype = insn_symbol_type(fn->module, insn);
+	dtype = insn_symbol_type(insn);
 	switch (LLVMGetTypeKind(LLVMTypeOf(src))) {
 	case LLVMPointerTypeKind:
 		op = LLVMBitCast;
@@ -846,7 +846,7 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
 
 	assert(!symbol_is_fp_type(insn->type));
 
-	dtype = insn_symbol_type(fn->module, insn);
+	dtype = insn_symbol_type(insn);
 	switch (LLVMGetTypeKind(LLVMTypeOf(src))) {
 	case LLVMPointerTypeKind:
 		op = LLVMPtrToInt;
@@ -1023,12 +1023,12 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 	FOR_EACH_PTR(base_type->arguments, arg) {
 		struct symbol *arg_base_type = arg->ctype.base_type;
 
-		arg_types[nr_args++] = symbol_type(module, arg_base_type);
+		arg_types[nr_args++] = symbol_type(arg_base_type);
 	} END_FOR_EACH_PTR(arg);
 
 	name = show_ident(sym->ident);
 
-	return_type = symbol_type(module, ret_type);
+	return_type = symbol_type(ret_type);
 
 	function.type = LLVMFunctionType(return_type, arg_types, nr_args, 0);
 
@@ -1065,7 +1065,7 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 			/* insert alloca into entry block */
 			entrybbr = LLVMGetEntryBasicBlock(function.fn);
 			LLVMPositionBuilderAtEnd(function.builder, entrybbr);
-			phi_type = insn_symbol_type(module, insn);
+			phi_type = insn_symbol_type(insn);
 			ptr = LLVMBuildAlloca(function.builder, phi_type, "");
 			/* emit forward load for phi */
 			LLVMClearInsertionPosition(function.builder);
@@ -1095,7 +1095,7 @@ static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym)
 	if (initializer) {
 		switch (initializer->type) {
 		case EXPR_VALUE:
-			initial_value = LLVMConstInt(symbol_type(module, sym), initializer->value, 1);
+			initial_value = LLVMConstInt(symbol_type(sym), initializer->value, 1);
 			break;
 		case EXPR_SYMBOL: {
 			struct symbol *sym = initializer->symbol;
@@ -1115,7 +1115,7 @@ static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym)
 			assert(0);
 		}
 	} else {
-		LLVMTypeRef type = symbol_type(module, sym);
+		LLVMTypeRef type = symbol_type(sym);
 
 		initial_value = LLVMConstNull(type);
 	}
-- 
2.11.1

