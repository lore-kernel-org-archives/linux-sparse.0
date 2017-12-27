From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] llvm: fix: previous function ref MUST be reused
Date: Wed, 27 Dec 2017 16:18:58 +0100
Message-ID: <20171227151858.75533-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38604 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbdL0PTK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 27 Dec 2017 10:19:10 -0500
Received: by mail-wm0-f67.google.com with SMTP id 64so39754574wme.3
        for <linux-sparse@vger.kernel.org>; Wed, 27 Dec 2017 07:19:09 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>

In sparse-llvm, when  a reference to a function is made via
get_sym_value(), for example for a call, the reference is
created with LLVMAddFunction() and if needed later, the existing
reference is returned via LLVMGetNamedFunction().
This is the correct way to do it.

However, when emitting the code for a function definition, a fresh
reference is always made. If a previous reference to this function
already existed, the second one will have a slightly different name:
the given name suffixed by ".<somenumber>". LLVM does this for every
created references, to disambiguate them. As consequence, the
compiled function will not be name "<functionname>", as expected,
but "<functionname>.<somenumber>".

Fix this by always using get_sym_value() when emitting the code
for the function definition as this will return the reference
for the given function name if it already exist.
This has the added bonus to remove some code duplication.

CC: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c               | 25 ++-----------------------
 validation/backend/fn-ref.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 23 deletions(-)
 create mode 100644 validation/backend/fn-ref.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index a8186df5b..3ee014daf 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -40,12 +40,6 @@ static LLVMTypeRef sym_func_type(struct symbol *sym)
 	struct symbol *arg;
 	int n_arg = 0;
 
-	/* to avoid strangeness with varargs [for now], we build
-	 * the function and type anew, for each call.  This
-	 * is probably wrong.  We should look up the
-	 * symbol declaration info.
-	 */
-
 	ret_type = func_return_type(sym);
 
 	/* count args, build argument type information */
@@ -1128,34 +1122,19 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 {
 	struct symbol *sym = ep->name;
 	struct symbol *base_type = sym->ctype.base_type;
-	LLVMTypeRef arg_types[MAX_ARGS];
-	LLVMTypeRef ret_type = symbol_type(base_type->ctype.base_type);
-	LLVMTypeRef fun_type;
 	struct function function = { .module = module };
 	struct basic_block *bb;
-	struct symbol *arg;
-	const char *name;
 	int nr_args = 0;
 	int i;
 
-	FOR_EACH_PTR(base_type->arguments, arg) {
-		struct symbol *arg_base_type = arg->ctype.base_type;
-
-		arg_types[nr_args++] = symbol_type(arg_base_type);
-	} END_FOR_EACH_PTR(arg);
-
-	name = show_ident(sym->ident);
-
-	fun_type = LLVMFunctionType(ret_type, arg_types, nr_args, base_type->variadic);
-
-	function.fn = LLVMAddFunction(module, name, fun_type);
+	function.fn = get_sym_value(&function, sym);
 	LLVMSetFunctionCallConv(function.fn, LLVMCCallConv);
-
 	LLVMSetLinkage(function.fn, function_linkage(sym));
 
 	function.builder = LLVMCreateBuilder();
 
 	/* give a name to each argument */
+	nr_args = symbol_list_size(base_type->arguments);
 	for (i = 0; i < nr_args; i++) {
 		char name[MAX_PSEUDO_NAME];
 		LLVMValueRef arg;
diff --git a/validation/backend/fn-ref.c b/validation/backend/fn-ref.c
new file mode 100644
index 000000000..d987a28b8
--- /dev/null
+++ b/validation/backend/fn-ref.c
@@ -0,0 +1,32 @@
+extern int fun0(int a);
+extern int fun1(int a);
+
+int foo(int a);
+int foo(int a)
+{
+	int v = fun0(a);
+	return v;
+}
+
+void *bar(int a)
+{
+	return fun1;
+}
+
+int fun0(int a)
+{
+	return a + 0;
+}
+
+int fun1(int a)
+{
+	return a + 1;
+}
+
+/*
+ * check-name: llvm function reference
+ * check-command: sparse-llvm-dis -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: fun[0-9]\.[1-9]
+ */
-- 
2.15.0

