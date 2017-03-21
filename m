From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 43/63] llvm: add support for OP_SWITCH with a range
Date: Tue, 21 Mar 2017 01:15:47 +0100
Message-ID: <20170321001607.75169-44-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34419 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbdCUARH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:07 -0400
Received: by mail-wr0-f193.google.com with SMTP id u48so20450057wrc.1
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:06 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 6530d2d59..035c7b42d 100644
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

