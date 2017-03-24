From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 43/51] llvm: fix mutated OP_PHISOURCE
Date: Sat, 25 Mar 2017 00:20:49 +0100
Message-ID: <20170324232057.15033-44-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33264 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934542AbdCXXYJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:24:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11so821776wma.0
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:24:08 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

