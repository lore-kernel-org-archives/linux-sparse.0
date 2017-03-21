From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 40/63] llvm: fix type of switch constants
Date: Tue, 21 Mar 2017 01:15:44 +0100
Message-ID: <20170321001607.75169-41-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33422 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753819AbdCUARE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:04 -0400
Received: by mail-wr0-f193.google.com with SMTP id g10so20441897wrg.0
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:02 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In sparse-llvm, the type of switch constants are hardcoded
to 'i32'.

Fix this by using the right type as given by the instruction.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 10d29e299..a64125fe8 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -771,7 +771,7 @@ static void output_op_switch(struct function *fn, struct instruction *insn)
 	FOR_EACH_PTR(insn->multijmp_list, jmp) {
 		if (jmp->begin == jmp->end) {		/* case N */
 			LLVMAddCase(target,
-				LLVMConstInt(LLVMInt32Type(), jmp->begin, 0),
+				val_to_value(jmp->begin, insn->type),
 				jmp->target->priv);
 		} else if (jmp->begin < jmp->end) {	/* case M..N */
 			assert(0);
-- 
2.12.0

