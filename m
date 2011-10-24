From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 2/2] sparse, llvm: Fix struct code generation
Date: Mon, 24 Oct 2011 18:37:22 +0300
Message-ID: <1319470642-21031-2-git-send-email-penberg@kernel.org>
References: <1319470642-21031-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39731 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932799Ab1JXPhf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 24 Oct 2011 11:37:35 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt19so8339129bkb.19
        for <linux-sparse@vger.kernel.org>; Mon, 24 Oct 2011 08:37:35 -0700 (PDT)
In-Reply-To: <1319470642-21031-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

Use LLVMGetTypeByName() to look up struct data types to fix code generation for
structs that refer to themselves.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c               |   50 +++++++++++++++++++++++-------------------
 validation/backend/struct.c |    1 +
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 14744e5..5d1b79c 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -32,11 +32,11 @@ static inline bool symbol_is_fp_type(struct symbol *sym)
 	return sym->ctype.base_type == &fp_type;
 }
 
-static LLVMTypeRef symbol_type(struct symbol *sym);
+static LLVMTypeRef symbol_type(LLVMModuleRef module, struct symbol *sym);
 
 #define MAX_STRUCT_MEMBERS 64
 
-static LLVMTypeRef sym_struct_type(struct symbol *sym)
+static LLVMTypeRef sym_struct_type(LLVMModuleRef module, struct symbol *sym)
 {
 	LLVMTypeRef elem_types[MAX_STRUCT_MEMBERS];
 	struct symbol *member;
@@ -46,6 +46,10 @@ static LLVMTypeRef sym_struct_type(struct symbol *sym)
 
 	sprintf(buffer, "%.*s", sym->ident->len, sym->ident->name);
 
+	ret = LLVMGetTypeByName(module, buffer);
+	if (ret)
+		return ret;
+
 	ret = LLVMStructCreateNamed(LLVMGetGlobalContext(), buffer);
 
 	FOR_EACH_PTR(sym->symbol_list, member) {
@@ -53,7 +57,7 @@ static LLVMTypeRef sym_struct_type(struct symbol *sym)
 
 		assert(nr < MAX_STRUCT_MEMBERS);
 
-		member_type = symbol_type(member);
+		member_type = symbol_type(module, member);
 
 		elem_types[nr++] = member_type; 
 	} END_FOR_EACH_PTR(member);
@@ -62,9 +66,9 @@ static LLVMTypeRef sym_struct_type(struct symbol *sym)
 	return ret;
 }
 
-static LLVMTypeRef sym_ptr_type(struct symbol *sym)
+static LLVMTypeRef sym_ptr_type(LLVMModuleRef module, struct symbol *sym)
 {
-	LLVMTypeRef type = symbol_type(sym->ctype.base_type);
+	LLVMTypeRef type = symbol_type(module, sym->ctype.base_type);
 
 	return LLVMPointerType(type, 0);
 }
@@ -112,22 +116,22 @@ static LLVMTypeRef sym_basetype_type(struct symbol *sym)
 	return ret;
 }
 
-static LLVMTypeRef symbol_type(struct symbol *sym)
+static LLVMTypeRef symbol_type(LLVMModuleRef module, struct symbol *sym)
 {
 	LLVMTypeRef ret = NULL;
 
 	switch (sym->type) {
 	case SYM_NODE:
-		ret = symbol_type(sym->ctype.base_type);
+		ret = symbol_type(module, sym->ctype.base_type);
 		break;
 	case SYM_BASETYPE:
 		ret = sym_basetype_type(sym);
 		break;
 	case SYM_PTR:
-		ret = sym_ptr_type(sym);
+		ret = sym_ptr_type(module, sym);
 		break;
 	case SYM_STRUCT:
-		ret = sym_struct_type(sym);
+		ret = sym_struct_type(module, sym);
 		break;
 	default:
 		assert(0);
@@ -135,10 +139,10 @@ static LLVMTypeRef symbol_type(struct symbol *sym)
 	return ret;
 }
 
-static LLVMTypeRef insn_symbol_type(struct instruction *insn)
+static LLVMTypeRef insn_symbol_type(LLVMModuleRef module, struct instruction *insn)
 {
 	if (insn->type)
-		return symbol_type(insn->type);
+		return symbol_type(module, insn->type);
 
 	switch (insn->size) {
 		case 8:		return LLVMInt8Type();
@@ -234,7 +238,7 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 		break;
 	}
 	case PSEUDO_VAL:
-		result = LLVMConstInt(insn_symbol_type(insn), pseudo->value, 1);
+		result = LLVMConstInt(insn_symbol_type(fn->module, insn), pseudo->value, 1);
 		break;
 	case PSEUDO_ARG: {
 		result = LLVMGetParam(fn->fn, pseudo->nr - 1);
@@ -265,7 +269,7 @@ static LLVMTypeRef pseudo_type(struct function *fn, struct instruction *insn, ps
 
 	switch (pseudo->type) {
 	case PSEUDO_REG:
-		result = symbol_type(pseudo->def->type);
+		result = symbol_type(fn->module, pseudo->def->type);
 		break;
 	case PSEUDO_SYM: {
 		struct symbol *sym = pseudo->sym;
@@ -287,7 +291,7 @@ static LLVMTypeRef pseudo_type(struct function *fn, struct instruction *insn, ps
 		break;
 	}
 	case PSEUDO_VAL:
-		result = insn_symbol_type(insn);
+		result = insn_symbol_type(fn->module, insn);
 		break;
 	case PSEUDO_ARG:
 		result = LLVMTypeOf(LLVMGetParam(fn->fn, pseudo->nr - 1));
@@ -691,7 +695,7 @@ static void output_op_phi(struct function *fn, struct instruction *insn)
 	pseudo_t phi;
 	LLVMValueRef target;
 
-	target = LLVMBuildPhi(fn->builder, insn_symbol_type(insn),
+	target = LLVMBuildPhi(fn->builder, insn_symbol_type(fn->module, insn),
 				"phi");
 	int pll = 0;
 	FOR_EACH_PTR(insn->phi_list, phi) {
@@ -733,9 +737,9 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
 	assert(!symbol_is_fp_type(insn->type));
 
 	if (insn->size < LLVMGetIntTypeWidth(LLVMTypeOf(src)))
-		target = LLVMBuildTrunc(fn->builder, src, insn_symbol_type(insn), target_name);
+		target = LLVMBuildTrunc(fn->builder, src, insn_symbol_type(fn->module, insn), target_name);
 	else
-		target = LLVMBuildCast(fn->builder, op, src, insn_symbol_type(insn), target_name);
+		target = LLVMBuildCast(fn->builder, op, src, insn_symbol_type(fn->module, insn), target_name);
 
 	insn->target->priv = target;
 }
@@ -749,7 +753,7 @@ static void output_op_copy(struct function *fn, struct instruction *insn,
 
 	pseudo_name(insn->target, target_name);
 	src = pseudo_to_value(fn, insn, pseudo);
-	const_type = insn_symbol_type(insn);
+	const_type = insn_symbol_type(fn->module, insn);
 
 	/*
 	 * This is nothing more than 'target = src'
@@ -910,12 +914,12 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 	FOR_EACH_PTR(base_type->arguments, arg) {
 		struct symbol *arg_base_type = arg->ctype.base_type;
 
-		arg_types[nr_args++] = symbol_type(arg_base_type);
+		arg_types[nr_args++] = symbol_type(module, arg_base_type);
 	} END_FOR_EACH_PTR(arg);
 
 	name = show_ident(sym->ident);
 
-	return_type = symbol_type(ret_type);
+	return_type = symbol_type(module, ret_type);
 
 	function.module = module;
 
@@ -972,7 +976,7 @@ static int output_data(LLVMModuleRef module, struct symbol *sym)
 	if (initializer) {
 		switch (initializer->type) {
 		case EXPR_VALUE:
-			initial_value = LLVMConstInt(symbol_type(sym), initializer->value, 1);
+			initial_value = LLVMConstInt(symbol_type(module, sym), initializer->value, 1);
 			break;
 		case EXPR_SYMBOL: {
 			struct symbol *sym = initializer->symbol;
@@ -984,14 +988,14 @@ static int output_data(LLVMModuleRef module, struct symbol *sym)
 			assert(0);
 		}
 	} else {
-		LLVMTypeRef type = symbol_type(sym);
+		LLVMTypeRef type = symbol_type(module, sym);
 
 		initial_value = LLVMConstNull(type);
 	}
 
 	name = show_ident(sym->ident);
 
-	data = LLVMAddGlobal(module, symbol_type(sym->ctype.base_type), name);
+	data = LLVMAddGlobal(module, symbol_type(module, sym->ctype.base_type), name);
 
 	LLVMSetLinkage(data, data_linkage(sym));
 
diff --git a/validation/backend/struct.c b/validation/backend/struct.c
index 9d0cb56..1afaf2d 100644
--- a/validation/backend/struct.c
+++ b/validation/backend/struct.c
@@ -6,6 +6,7 @@ struct symbol {
 	void			*p;
 	const char		*name;
 	struct ctype		ctype;
+	struct symbol		*next_id;
 };
 
 static struct symbol sym;
-- 
1.7.6.4

