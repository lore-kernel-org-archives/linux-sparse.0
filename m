From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 29/30] llvm: variadic functions are not being marked as such
Date: Sun, 19 Mar 2017 02:42:26 +0100
Message-ID: <20170319014227.8833-30-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36192 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbdCSBnJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:43:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id l37so13792343wrc.3
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:43:07 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
index f320f7288..bae55de3b 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1068,7 +1068,7 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 
 	name = show_ident(sym->ident);
 
-	fun_type = LLVMFunctionType(ret_type, arg_types, nr_args, 0);
+	fun_type = LLVMFunctionType(ret_type, arg_types, nr_args, base_type->variadic);
 
 	function.fn = LLVMAddFunction(module, name, fun_type);
 	LLVMSetFunctionCallConv(function.fn, LLVMCCallConv);
-- 
2.12.0

