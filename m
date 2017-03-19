From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 08/30] llvm: remove unneeded function::type
Date: Sun, 19 Mar 2017 02:42:05 +0100
Message-ID: <20170319014227.8833-9-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34998 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbdCSBmr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:42:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id z133so8937091wmb.2
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:42:46 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index f41fbe6e3..68bd94181 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -21,7 +21,6 @@
 
 struct function {
 	LLVMBuilderRef			builder;
-	LLVMTypeRef			type;
 	LLVMValueRef			fn;
 	LLVMModuleRef			module;
 };
@@ -933,6 +932,7 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 	struct symbol *ret_type = sym->ctype.base_type->ctype.base_type;
 	LLVMTypeRef arg_types[MAX_ARGS];
 	LLVMTypeRef return_type;
+	LLVMTypeRef fun_type;
 	struct function function = { .module = module };
 	struct basic_block *bb;
 	struct symbol *arg;
@@ -949,9 +949,9 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 
 	return_type = symbol_type(ret_type);
 
-	function.type = LLVMFunctionType(return_type, arg_types, nr_args, 0);
+	fun_type = LLVMFunctionType(return_type, arg_types, nr_args, 0);
 
-	function.fn = LLVMAddFunction(module, name, function.type);
+	function.fn = LLVMAddFunction(module, name, fun_type);
 	LLVMSetFunctionCallConv(function.fn, LLVMCCallConv);
 
 	LLVMSetLinkage(function.fn, function_linkage(sym));
-- 
2.12.0

