From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 03/51] llvm: remove unneeded function::type
Date: Sat, 25 Mar 2017 00:20:09 +0100
Message-ID: <20170324232057.15033-4-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32959 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934542AbdCXXXb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:23:31 -0400
Received: by mail-wr0-f195.google.com with SMTP id 20so611525wrx.0
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:23:30 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

