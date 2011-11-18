From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 2/2] sparse, llvm: Function pointer code generation
Date: Fri, 18 Nov 2011 17:30:59 +0200
Message-ID: <1321630259-2213-2-git-send-email-penberg@kernel.org>
References: <1321630259-2213-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56579 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757808Ab1KRPbV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 Nov 2011 10:31:21 -0500
Received: by mail-bw0-f46.google.com with SMTP id 11so3557738bke.19
        for <linux-sparse@vger.kernel.org>; Fri, 18 Nov 2011 07:31:21 -0800 (PST)
In-Reply-To: <1321630259-2213-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

This patch implements support for function pointer types and function pointer
calls to the LLVM backend.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c                     |   54 +++++++++++++++++++++++++++++++++++-
 validation/backend/function-ptr.c |   11 +++++++
 2 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100644 validation/backend/function-ptr.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 7f46c8a..c037e02 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -34,6 +34,46 @@ static inline bool symbol_is_fp_type(struct symbol *sym)
 
 static LLVMTypeRef symbol_type(LLVMModuleRef module, struct symbol *sym);
 
+static LLVMTypeRef func_return_type(LLVMModuleRef module, struct symbol *sym)
+{
+	return symbol_type(module, sym->ctype.base_type);
+}
+
+static LLVMTypeRef sym_func_type(LLVMModuleRef module, struct symbol *sym)
+{
+	LLVMTypeRef *arg_type;
+	LLVMTypeRef func_type;
+	LLVMTypeRef ret_type;
+	struct symbol *arg;
+	int n_arg = 0;
+
+	/* to avoid strangeness with varargs [for now], we build
+	 * the function and type anew, for each call.  This
+	 * is probably wrong.  We should look up the
+	 * symbol declaration info.
+	 */
+
+	ret_type = func_return_type(module, sym);
+
+	/* count args, build argument type information */
+	FOR_EACH_PTR(sym->arguments, arg) {
+		n_arg++;
+	} END_FOR_EACH_PTR(arg);
+
+	arg_type = calloc(n_arg, sizeof(LLVMTypeRef));
+
+	int idx = 0;
+	FOR_EACH_PTR(sym->arguments, arg) {
+		struct symbol *arg_sym = arg->ctype.base_type;
+
+		arg_type[idx++] = symbol_type(module, arg_sym);
+	} END_FOR_EACH_PTR(arg);
+	func_type = LLVMFunctionType(ret_type, arg_type, n_arg,
+				     /* varargs? */ 0);
+
+	return func_type;
+}
+
 static LLVMTypeRef sym_array_type(LLVMModuleRef module, struct symbol *sym)
 {
 	LLVMTypeRef elem_type;
@@ -172,6 +212,9 @@ static LLVMTypeRef symbol_type(LLVMModuleRef module, struct symbol *sym)
 	case SYM_ARRAY:
 		ret = sym_array_type(module, sym);
 		break;
+	case SYM_FN:
+		ret = sym_func_type(module, sym);
+		break;
 	default:
 		assert(0);
 	}
@@ -638,7 +681,10 @@ static LLVMTypeRef get_func_type(struct function *fn, struct instruction *insn)
 	int n_arg = 0;
 	LLVMTypeRef *arg_type;
 
-	sprintf(buffer, "%.*s", sym->ident->len, sym->ident->name);
+	if (sym->ident)
+		sprintf(buffer, "%.*s", sym->ident->len, sym->ident->name);
+	else
+		sprintf(buffer, "<anon sym %p>", sym);
 
 	/* VERIFY: is this correct, for functions? */
 	func_type = LLVMGetTypeByName(fn->module, buffer);
@@ -682,7 +728,11 @@ static LLVMValueRef get_function(struct function *fn, struct instruction *insn)
 	LLVMValueRef func;
 	struct llfunc *f;
 
-	sprintf(buffer, "%.*s", sym->ident->len, sym->ident->name);
+	if (sym->ident)
+		sprintf(buffer, "%.*s", sym->ident->len, sym->ident->name);
+	else
+		sprintf(buffer, "<anon sym %p>", sym);
+
 
 	/* search for pre-built function type definition */
 	FOR_EACH_PTR(mi.llfunc_list, f) {
diff --git a/validation/backend/function-ptr.c b/validation/backend/function-ptr.c
new file mode 100644
index 0000000..fc022b3
--- /dev/null
+++ b/validation/backend/function-ptr.c
@@ -0,0 +1,11 @@
+typedef int (*fn_t)(int x, int y);
+
+static int run(fn_t fn, int x, int y)
+{
+	return fn(x, y);
+}
+
+/*
+ * check-name: Function pointer code generation
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
-- 
1.7.6.4

