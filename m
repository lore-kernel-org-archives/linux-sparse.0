From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] llvm: initialize at declaration time
Date: Wed, 14 Feb 2018 00:52:09 +0100
Message-ID: <20180213235209.21615-3-luc.vanoostenryck@gmail.com>
References: <20180213235209.21615-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33363 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966267AbeBMXyZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 18:54:25 -0500
Received: by mail-wm0-f66.google.com with SMTP id x4so15346857wmc.0
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 15:54:25 -0800 (PST)
In-Reply-To: <20180213235209.21615-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In sym_func_type(), a few variables are initialized
just after they are declared.

Change this to initialize them directly at their
declaration, which is simpler and more idiomatic.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 96b1499de..2f296ead4 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -34,26 +34,19 @@ static LLVMTypeRef func_return_type(struct symbol *sym)
 
 static LLVMTypeRef sym_func_type(struct symbol *sym)
 {
-	LLVMTypeRef *arg_type;
-	LLVMTypeRef func_type;
-	LLVMTypeRef ret_type;
+	int n_arg = symbol_list_size(sym->arguments);
+	LLVMTypeRef *arg_type = calloc(n_arg, sizeof(LLVMTypeRef));
+	LLVMTypeRef ret_type = func_return_type(sym);
 	struct symbol *arg;
-	int n_arg;
-
-	ret_type = func_return_type(sym);
-	n_arg = symbol_list_size(sym->arguments);
-	arg_type = calloc(n_arg, sizeof(LLVMTypeRef));
