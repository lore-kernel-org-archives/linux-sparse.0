From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 55/63] llvm: fix mutated OP_PHISOURCE
Date: Tue, 21 Mar 2017 01:15:59 +0100
Message-ID: <20170321001607.75169-56-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33337 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755830AbdCUARU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11so269272wma.0
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:19 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index dc8c17e18..0b711473d 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -845,7 +845,7 @@ static void output_op_phisrc(struct function *fn, struct instruction *insn)
 	assert(insn->target->priv == NULL);
 
 	/* target = src */
-	v = pseudo_to_value(fn, insn->type, insn->phi_src);
+	v = get_operand(fn, insn->type, insn->phi_src);
 
 	FOR_EACH_PTR(insn->phi_users, phi) {
 		LLVMValueRef load, ptr;
-- 
2.12.0

