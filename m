From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 27/51] llvm: variadic functions are not being marked as such
Date: Sat, 25 Mar 2017 00:20:33 +0100
Message-ID: <20170324232057.15033-28-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34962 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935781AbdCXXXy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:23:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id z133so808758wmb.2
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:23:53 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It appears that when a function is compiled, its variadic flag is not
being set in LLVM so LLVM complains when at call sites variable
arguments are passed.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Originally-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index b0ecc1972..10d29e299 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1087,7 +1087,7 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 
 	name = show_ident(sym->ident);
 
-	fun_type = LLVMFunctionType(ret_type, arg_types, nr_args, 0);
+	fun_type = LLVMFunctionType(ret_type, arg_types, nr_args, base_type->variadic);
 
 	function.fn = LLVMAddFunction(module, name, fun_type);
 	LLVMSetFunctionCallConv(function.fn, LLVMCCallConv);
-- 
2.12.0

