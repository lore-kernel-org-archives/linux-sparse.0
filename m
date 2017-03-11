From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 21/27] llvm: use pseudo_list_size() instead of open coding it
Date: Sat, 11 Mar 2017 10:07:00 +0100
Message-ID: <20170311090706.17171-22-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36451 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755496AbdCKJHo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:44 -0500
Received: by mail-wr0-f195.google.com with SMTP id l37so14057785wrc.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:43 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 18a38a339..bbff47877 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -761,11 +761,7 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 	LLVMValueRef *args;
 	char name[64];
 
-
-	FOR_EACH_PTR(insn->arguments, arg) {
-		n_arg++;
-	} END_FOR_EACH_PTR(arg);
