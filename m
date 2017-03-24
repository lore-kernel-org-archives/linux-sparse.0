From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 40/51] llvm: fix mutated OP_RET
Date: Sat, 25 Mar 2017 00:20:46 +0100
Message-ID: <20170324232057.15033-41-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34641 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936164AbdCXXYG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:24:06 -0400
Received: by mail-wr0-f195.google.com with SMTP id y90so607111wrb.1
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:24:05 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 6fd33cbe9..23ef31421 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -690,9 +690,7 @@ static void output_op_ret(struct function *fn, struct instruction *insn)
 	pseudo_t pseudo = insn->src;
 
 	if (pseudo && pseudo != VOID) {
-		LLVMValueRef result = pseudo_to_value(fn, insn->type, pseudo);
