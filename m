From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 05/52] llvm: use pseudo_list_size() instead of open coding it
Date: Mon, 27 Mar 2017 23:23:29 +0200
Message-ID: <20170327212416.18536-6-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33216 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdC0V0c (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:32 -0400
Received: by mail-wr0-f193.google.com with SMTP id 20so17041635wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:30 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
