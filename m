From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 42/51] llvm: fix mutated OP_SWITCH
Date: Sat, 25 Mar 2017 00:20:48 +0100
Message-ID: <20170324232057.15033-43-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33258 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935781AbdCXXYI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:24:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11so821736wma.0
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:24:07 -0700 (PDT)
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
index 7d4cdde3c..dc8c17e18 100644
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

