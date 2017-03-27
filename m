From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 08/52] llvm: avoid useless temp variable
Date: Mon, 27 Mar 2017 23:23:32 +0200
Message-ID: <20170327212416.18536-9-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34636 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752238AbdC0V0k (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:40 -0400
Received: by mail-wr0-f195.google.com with SMTP id w43so14202690wrb.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:33 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 8de144e2a..db38bcda5 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -932,9 +932,8 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 {
 	struct symbol *sym = ep->name;
 	struct symbol *base_type = sym->ctype.base_type;
-	struct symbol *ret_type = sym->ctype.base_type->ctype.base_type;
 	LLVMTypeRef arg_types[MAX_ARGS];
-	LLVMTypeRef return_type;
+	LLVMTypeRef ret_type = symbol_type(base_type->ctype.base_type);
 	LLVMTypeRef fun_type;
 	struct function function = { .module = module };
 	struct basic_block *bb;
@@ -951,9 +950,7 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 
 	name = show_ident(sym->ident);
 
-	return_type = symbol_type(ret_type);
