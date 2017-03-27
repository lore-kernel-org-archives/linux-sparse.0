From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 41/52] llvm: fix mutated OP_SEL
Date: Mon, 27 Mar 2017 23:24:05 +0200
Message-ID: <20170327212416.18536-42-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33641 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbdC0V1G (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:27:06 -0400
Received: by mail-wr0-f193.google.com with SMTP id 20so17044620wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:27:05 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 9d8ece69d..8051f19f7 100644
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

