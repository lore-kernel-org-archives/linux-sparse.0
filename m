From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 39/63] llvm: variadic functions are not being marked as such
Date: Tue, 21 Mar 2017 01:15:43 +0100
Message-ID: <20170321001607.75169-40-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34399 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755329AbdCUARD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:03 -0400
Received: by mail-wr0-f193.google.com with SMTP id u48so20449955wrc.1
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:01 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

