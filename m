From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 43/52] llvm: fix mutated OP_PHISOURCE
Date: Mon, 27 Mar 2017 23:24:07 +0200
Message-ID: <20170327212416.18536-44-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33662 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752635AbdC0V11 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:27:27 -0400
Received: by mail-wr0-f196.google.com with SMTP id 20so17044775wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:27:12 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 50b82e221..4e9bf930b 100644
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

