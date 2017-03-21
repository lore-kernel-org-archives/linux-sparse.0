From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 52/63] llvm: fix mutated OP_RET
Date: Tue, 21 Mar 2017 01:15:56 +0100
Message-ID: <20170321001607.75169-53-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33317 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755818AbdCUARR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11so269174wma.0
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:15 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
