From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 10/30] llvm: use pseudo_list_size() instead of open coding it
Date: Sun, 19 Mar 2017 02:42:07 +0100
Message-ID: <20170319014227.8833-11-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34275 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbdCSBmt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:42:49 -0400
Received: by mail-wr0-f195.google.com with SMTP id u48so13842931wrc.1
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:42:48 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 51fd6a96a..23ae482e1 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -709,10 +709,7 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 	struct instruction *arg;
 	LLVMValueRef *args;
 
-	FOR_EACH_PTR(insn->arguments, arg) {
-		n_arg++;
-	} END_FOR_EACH_PTR(arg);
