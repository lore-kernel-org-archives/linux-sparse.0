From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] llvm: use list_size() to count the numbers of arguments
Date: Wed, 14 Feb 2018 00:52:08 +0100
Message-ID: <20180213235209.21615-2-luc.vanoostenryck@gmail.com>
References: <20180213235209.21615-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36619 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966168AbeBMXyY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 18:54:24 -0500
Received: by mail-wr0-f196.google.com with SMTP id y3so20283741wrh.3
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 15:54:24 -0800 (PST)
In-Reply-To: <20180213235209.21615-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The function sym_func_type() contains a small loop
which count the number of arguments, one by one.

Do this more simply and more efficiently by using
symbol_list_size().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 3a1778083..96b1499de 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -38,15 +38,10 @@ static LLVMTypeRef sym_func_type(struct symbol *sym)
 	LLVMTypeRef func_type;
 	LLVMTypeRef ret_type;
 	struct symbol *arg;
-	int n_arg = 0;
+	int n_arg;
 
 	ret_type = func_return_type(sym);
-
-	/* count args, build argument type information */
-	FOR_EACH_PTR(sym->arguments, arg) {
-		n_arg++;
-	} END_FOR_EACH_PTR(arg);
