From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 26/27] llvm: remove unneeded function::type
Date: Sat, 11 Mar 2017 10:07:05 +0100
Message-ID: <20170311090706.17171-27-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36476 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752678AbdCKJHu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:50 -0500
Received: by mail-wr0-f194.google.com with SMTP id l37so14058032wrc.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:48 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 4fc5777c7..831a56207 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -21,7 +21,6 @@
 
 struct function {
 	LLVMBuilderRef			builder;
-	LLVMTypeRef			type;
 	LLVMValueRef			fn;
 	LLVMModuleRef			module;
 };
@@ -1046,6 +1045,7 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 	struct symbol *ret_type = sym->ctype.base_type->ctype.base_type;
 	LLVMTypeRef arg_types[MAX_ARGS];
 	LLVMTypeRef return_type;
+	LLVMTypeRef fun_type;
 	struct function function = { .module = module };
 	struct basic_block *bb;
 	struct symbol *arg;
@@ -1062,9 +1062,9 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 
 	return_type = symbol_type(ret_type);
 
-	function.type = LLVMFunctionType(return_type, arg_types, nr_args, 0);
+	fun_type = LLVMFunctionType(return_type, arg_types, nr_args, 0);
 
-	function.fn = LLVMAddFunction(module, name, function.type);
+	function.fn = LLVMAddFunction(module, name, fun_type);
 	LLVMSetFunctionCallConv(function.fn, LLVMCCallConv);
 
 	LLVMSetLinkage(function.fn, function_linkage(sym));
-- 
2.11.1

