From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 17/63] llvm: use pseudo_list_size() instead of open coding it
Date: Tue, 21 Mar 2017 01:15:21 +0100
Message-ID: <20170321001607.75169-18-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34297 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755840AbdCUAQj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:39 -0400
Received: by mail-wr0-f196.google.com with SMTP id u48so20449404wrc.1
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:38 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
