From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 53/63] llvm: fix mutated OP_SEL
Date: Tue, 21 Mar 2017 01:15:57 +0100
Message-ID: <20170321001607.75169-54-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33878 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755830AbdCUARS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id u132so264504wmg.1
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:17 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 23ef31421..7d4cdde3c 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -773,13 +773,13 @@ static void output_op_sel(struct function *fn, struct instruction *insn)
 	char name[MAX_PSEUDO_NAME];
 
 	src1 = bool_value(fn, pseudo_to_value(fn, NULL, insn->src1));
-	src2 = pseudo_to_value(fn, insn->type, insn->src2);
-	src3 = pseudo_to_value(fn, insn->type, insn->src3);
+	src2 = get_operand(fn, insn->type, insn->src2);
+	src3 = get_operand(fn, insn->type, insn->src3);
 
 	pseudo_name(insn->target, name);
 	target = LLVMBuildSelect(fn->builder, src1, src2, src3, name);
 
-	insn->target->priv = target;
+	insn->target->priv = adjust_type(fn, insn->type, target);
 }
 
 static void output_op_switch(struct function *fn, struct instruction *insn)
-- 
2.12.0

