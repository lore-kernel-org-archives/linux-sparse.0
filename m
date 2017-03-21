From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 15/63] llvm: remove unneeded function::type
Date: Tue, 21 Mar 2017 01:15:19 +0100
Message-ID: <20170321001607.75169-16-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35767 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755840AbdCUAQh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id z133so257745wmb.2
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:36 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

