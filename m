From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 27/52] llvm: variadic functions are not being marked as such
Date: Mon, 27 Mar 2017 23:23:51 +0200
Message-ID: <20170327212416.18536-28-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33471 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbdC0V05 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:57 -0400
Received: by mail-wr0-f195.google.com with SMTP id 20so17043388wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:56 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
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
index dad330443..7978579f3 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1088,7 +1088,7 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 
 	name = show_ident(sym->ident);
 
-	fun_type = LLVMFunctionType(ret_type, arg_types, nr_args, 0);
+	fun_type = LLVMFunctionType(ret_type, arg_types, nr_args, base_type->variadic);
 
 	function.fn = LLVMAddFunction(module, name, fun_type);
 	LLVMSetFunctionCallConv(function.fn, LLVMCCallConv);
-- 
2.12.0

