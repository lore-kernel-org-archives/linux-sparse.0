From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 03/52] llvm: remove unneeded function::type
Date: Mon, 27 Mar 2017 23:23:27 +0200
Message-ID: <20170327212416.18536-4-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34568 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdC0V0f (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:35 -0400
Received: by mail-wr0-f193.google.com with SMTP id w43so14202272wrb.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:34 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
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

