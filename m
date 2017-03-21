From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 20/63] llvm: avoid useless temp variable
Date: Tue, 21 Mar 2017 01:15:24 +0100
Message-ID: <20170321001607.75169-21-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35950 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755839AbdCUAQm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id x124so253177wmf.3
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:41 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index dd7ff3398..072cf2638 100644
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
@@ -950,9 +949,7 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 
 	name = show_ident(sym->ident);
 
-	return_type = symbol_type(ret_type);
