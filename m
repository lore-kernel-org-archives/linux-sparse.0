From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 1/2] sparse, llvm: Simplify output_data() type logic
Date: Fri,  8 Jun 2012 15:34:36 +0300
Message-ID: <1339158877-32024-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44963 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167Ab2FHMeq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 08:34:46 -0400
Received: by lbbgm6 with SMTP id gm6so1307827lbb.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 05:34:45 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

Use LLVMTypeOf() in output_data() to simplify type handling logic.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 9226a21..a39bc02 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1192,7 +1192,7 @@ static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym)
 
 	name = show_ident(sym->ident);
 
-	data = LLVMAddGlobal(module, symbol_type(module, sym->ctype.base_type), name);
+	data = LLVMAddGlobal(module, LLVMTypeOf(initial_value), name);
 
 	LLVMSetLinkage(data, data_linkage(sym));
 
-- 
1.7.7.6

