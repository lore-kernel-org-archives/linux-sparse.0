From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 42/52] llvm: fix mutated OP_SWITCH
Date: Mon, 27 Mar 2017 23:24:06 +0200
Message-ID: <20170327212416.18536-43-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35867 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbdC0V1M (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:27:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id u1so17118967wra.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:27:11 -0700 (PDT)
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
index 8051f19f7..50b82e221 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -796,7 +796,7 @@ static void output_op_switch(struct function *fn, struct instruction *insn)
 			def = jmp->target;
 	} END_FOR_EACH_PTR(jmp);
 
-	sw_val = pseudo_to_value(fn, insn->type, insn->target);
+	sw_val = get_ioperand(fn, insn->type, insn->target);
 	target = LLVMBuildSwitch(fn->builder, sw_val,
 				 def ? def->priv : NULL, n_jmp);
 
-- 
2.12.0

