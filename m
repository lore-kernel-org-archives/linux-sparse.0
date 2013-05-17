From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH RFC] sparse, llvm: simplify function generation
Date: Fri, 17 May 2013 03:05:59 -0400
Message-ID: <1368774359-5475-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f175.google.com ([209.85.161.175]:51978 "EHLO
	mail-gg0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750Ab3EQHII (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 17 May 2013 03:08:08 -0400
Received: by mail-gg0-f175.google.com with SMTP id v1so2347ggn.6
        for <linux-sparse@vger.kernel.org>; Fri, 17 May 2013 00:08:07 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Xi Wang <xi.wang@gmail.com>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jgarzik@redhat.com>

Remove repeated code, such as get_func_type() vs sym_func_type(),
pseudo_type() vs symbol_type().

Fix generating variadic functions.

Add a test case using printf().

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
To run `make check' (with llvm's jit), apply "fix phi generation" first:

	https://patchwork.kernel.org/patch/2575381/

This patch doesn't depend on the previous one though.
---
 sparse-llvm.c            | 175 ++++-------------------------------------------
 sparsei                  |  13 ++++
 validation/backend/sum.c |  28 ++++++++
 3 files changed, 53 insertions(+), 163 deletions(-)
 create mode 100755 sparsei
 create mode 100644 validation/backend/sum.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 81ac764..00ace6e 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -70,7 +70,7 @@ static LLVMTypeRef sym_func_type(LLVMModuleRef module, struct symbol *sym)
 		arg_type[idx++] = symbol_type(module, arg_sym);
 	} END_FOR_EACH_PTR(arg);
 	func_type = LLVMFunctionType(ret_type, arg_type, n_arg,
-				     sym->ctype.base_type->variadic);
+				     sym->variadic);
 
 	return func_type;
 }
@@ -336,11 +336,16 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 			}
 		} else {
 			const char *name = show_ident(sym->ident);
-
-			result = LLVMGetNamedGlobal(fn->module, name);
-			if (!result) {
-				LLVMTypeRef type = symbol_type(fn->module, sym);
-				result = LLVMAddGlobal(fn->module, type, name);
+			LLVMTypeRef type = symbol_type(fn->module, sym);
+
+			if (LLVMGetTypeKind(type) == LLVMFunctionTypeKind) {
+				result = LLVMGetNamedFunction(fn->module, name);
+				if (!result)
+					result = LLVMAddFunction(fn->module, name, type);
+			} else {
+				result = LLVMGetNamedGlobal(fn->module, name);
+				if (!result)
+					result = LLVMAddGlobal(fn->module, type, name);
 			}
 		}
 		break;
@@ -365,58 +370,6 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 	return result;
 }
 
-static LLVMTypeRef pseudo_type(struct function *fn, struct instruction *insn, pseudo_t pseudo)
-{
-	LLVMValueRef v;
-	LLVMTypeRef result = NULL;
-
-	if (pseudo->priv) {
-		v = pseudo->priv;
-		return LLVMTypeOf(v);
-	}
-
-	switch (pseudo->type) {
-	case PSEUDO_REG:
-		result = symbol_type(fn->module, pseudo->def->type);
-		break;
-	case PSEUDO_SYM: {
-		struct symbol *sym = pseudo->sym;
-		struct expression *expr;
-
-		assert(sym->bb_target == NULL);
-		assert(sym->ident == NULL);
-
-		expr = sym->initializer;
-		if (expr) {
-			switch (expr->type) {
-			case EXPR_STRING:
-				result = LLVMPointerType(LLVMInt8Type(), 0);
-				break;
-			default:
-				assert(0);
-			}
-		}
-		break;
-	}
-	case PSEUDO_VAL:
-		result = insn_symbol_type(fn->module, insn);
-		break;
-	case PSEUDO_ARG:
-		result = LLVMTypeOf(LLVMGetParam(fn->fn, pseudo->nr - 1));
-		break;
-	case PSEUDO_PHI:
-		assert(0);
-		break;
-	case PSEUDO_VOID:
-		result = LLVMVoidType();
-		break;
-	default:
-		assert(0);
-	}
-
-	return result;
-}
-
 static LLVMRealPredicate translate_fop(int opcode)
 {
 	static const LLVMRealPredicate trans_tbl[] = {
@@ -709,102 +662,6 @@ static void output_op_switch(struct function *fn, struct instruction *insn)
 	insn->target->priv = target;
 }
 
-struct llfunc {
-	char		name[256];	/* wasteful */
-	LLVMValueRef	func;
-};
-
-DECLARE_ALLOCATOR(llfunc);
-DECLARE_PTR_LIST(llfunc_list, struct llfunc);
-ALLOCATOR(llfunc, "llfuncs");
-
-static struct local_module {
-	struct llfunc_list	*llfunc_list;
-} mi;
-
-static LLVMTypeRef get_func_type(struct function *fn, struct instruction *insn)
-{
-	struct symbol *sym = insn->func->sym;
-	char buffer[256];
-	LLVMTypeRef func_type, ret_type;
-	struct pseudo *arg;
-	int n_arg = 0;
-	LLVMTypeRef *arg_type;
-
-	if (sym->ident)
-		sprintf(buffer, "%.*s", sym->ident->len, sym->ident->name);
-	else
-		sprintf(buffer, "<anon sym %p>", sym);
-
-	/* VERIFY: is this correct, for functions? */
-	func_type = LLVMGetTypeByName(fn->module, buffer);
-	if (func_type)
-		return func_type;
-
-	/* to avoid strangeness with varargs [for now], we build
-	 * the function and type anew, for each call.  This
-	 * is probably wrong.  We should look up the
-	 * symbol declaration info.
-	 */
-
-	/* build return type */
-	if (insn->target && insn->target != VOID)
-		ret_type = pseudo_type(fn, insn, insn->target);
-	else
-		ret_type = LLVMVoidType();
-
-	/* count args, build argument type information */
-	FOR_EACH_PTR(insn->arguments, arg) {
-		n_arg++;
-	} END_FOR_EACH_PTR(arg);
-
-	arg_type = calloc(n_arg, sizeof(LLVMTypeRef));
-
-	int idx = 0;
-	FOR_EACH_PTR(insn->arguments, arg) {
-		arg_type[idx++] = pseudo_type(fn, insn, arg);
-	} END_FOR_EACH_PTR(arg);
-
-	func_type = LLVMFunctionType(ret_type, arg_type, n_arg,
-				     insn->fntype->variadic);
-
-	return func_type;
-}
-
-static LLVMValueRef get_function(struct function *fn, struct instruction *insn)
-{
-	struct symbol *sym = insn->func->sym;
-	char buffer[256];
-	LLVMValueRef func;
-	struct llfunc *f;
-
-	if (sym->ident)
-		sprintf(buffer, "%.*s", sym->ident->len, sym->ident->name);
-	else
-		sprintf(buffer, "<anon sym %p>", sym);
-
-
-	/* search for pre-built function type definition */
-	FOR_EACH_PTR(mi.llfunc_list, f) {
-		if (!strcmp(f->name, buffer))
-			return f->func;		/* found match; return */
-	} END_FOR_EACH_PTR(f);
-
-	/* build function type definition */
-	LLVMTypeRef func_type = get_func_type(fn, insn);
-
-	func = LLVMAddFunction(fn->module, buffer, func_type);
-
-	/* store built function on list, for later referencing */
-	f = calloc(1, sizeof(*f));
-	strncpy(f->name, buffer, sizeof(f->name) - 1);
-	f->func = func;
-
-	add_ptr_list(&mi.llfunc_list, f);
-
-	return func;
-}
-
 static void output_op_call(struct function *fn, struct instruction *insn)
 {
 	LLVMValueRef target, func;
@@ -823,7 +680,7 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 		args[i++] = pseudo_to_value(fn, insn, arg);
 	} END_FOR_EACH_PTR(arg);
 
-	func = get_function(fn, insn);
+	func = pseudo_to_value(fn, insn, insn->func);
 	target = LLVMBuildCall(fn->builder, func, args, n_arg, "");
 
 	insn->target->priv = target;
@@ -1066,7 +923,6 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 	struct symbol *arg;
 	const char *name;
 	int nr_args = 0;
-	struct llfunc *f;
 
 	FOR_EACH_PTR(base_type->arguments, arg) {
 		struct symbol *arg_base_type = arg->ctype.base_type;
@@ -1085,13 +941,6 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 
 	LLVMSetLinkage(function.fn, function_linkage(sym));
 
-	/* store built function on list, for later referencing */
-	f = calloc(1, sizeof(*f));
-	strncpy(f->name, name, sizeof(f->name) - 1);
-	f->func = function.fn;
-
-	add_ptr_list(&mi.llfunc_list, f);
-
 	function.builder = LLVMCreateBuilder();
 
 	static int nr_bb;
diff --git a/sparsei b/sparsei
new file mode 100755
index 0000000..4632154
--- /dev/null
+++ b/sparsei
@@ -0,0 +1,13 @@
+#!/bin/sh
+
+set +e
+
+DIRNAME=`dirname $0`
+LLI=`llvm-config --bindir`/lli
+
+if [ $# -eq 0 ]; then
+  echo "`basename $0`: no input files"
+  exit 1
+fi
+
+$DIRNAME/sparse-llvm $@ | $LLI
diff --git a/validation/backend/sum.c b/validation/backend/sum.c
new file mode 100644
index 0000000..c9451d4
--- /dev/null
+++ b/validation/backend/sum.c
@@ -0,0 +1,28 @@
+#include <stdio.h>
+#include <stdlib.h>
+
+static int sum(int n)
+{
+	int i, result = 0;
+
+	for (i = 1; i <= n; ++i)
+		result += i;
+	return result;
+}
+
+int main(int argc, char **argv)
+{
+	printf("%d\n", sum(5));
+	printf("%d\n", sum(100));
+	return 0;
+}
+
+/*
+ * check-name: sum from 1 to n
+ * check-command: ./sparsei $file
+ *
+ * check-output-start
+15
+5050
+ * check-output-end
+ */
-- 
1.8.1.2

