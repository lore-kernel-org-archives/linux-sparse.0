From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 31/52] llvm: add support for OP_SWITCH with a range
Date: Mon, 27 Mar 2017 23:23:55 +0200
Message-ID: <20170327212416.18536-32-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33864 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbdC0V04 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:56 -0400
Received: by mail-wr0-f194.google.com with SMTP id w43so14204645wrb.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:55 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 3c7b669fe..5b25bb0c1 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -760,10 +760,8 @@ static void output_op_switch(struct function *fn, struct instruction *insn)
 	int n_jmp = 0;
 
 	FOR_EACH_PTR(insn->multijmp_list, jmp) {
-		if (jmp->begin == jmp->end) {		/* case N */
-			n_jmp++;
-		} else if (jmp->begin < jmp->end) {	/* case M..N */
-			assert(0);
+		if (jmp->begin <= jmp->end) {
+			n_jmp += (jmp->end - jmp->begin) + 1;
 		} else					/* default case */
 			def = jmp->target;
 	} END_FOR_EACH_PTR(jmp);
@@ -773,12 +771,11 @@ static void output_op_switch(struct function *fn, struct instruction *insn)
 				 def ? def->priv : NULL, n_jmp);
 
 	FOR_EACH_PTR(insn->multijmp_list, jmp) {
-		if (jmp->begin == jmp->end) {		/* case N */
-			LLVMAddCase(target,
-				val_to_value(jmp->begin, insn->type),
-				jmp->target->priv);
-		} else if (jmp->begin < jmp->end) {	/* case M..N */
-			assert(0);
+		long val;
+
+		for (val = jmp->begin; val <= jmp->end; val++) {
+			LLVMValueRef Val = val_to_value(val, insn->type);
+			LLVMAddCase(target, Val, jmp->target->priv);
 		}
 	} END_FOR_EACH_PTR(jmp);
 
-- 
2.12.0

