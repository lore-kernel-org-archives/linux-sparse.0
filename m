From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 31/51] llvm: add support for OP_SWITCH with a range
Date: Sat, 25 Mar 2017 00:20:37 +0100
Message-ID: <20170324232057.15033-32-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34346 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935953AbdCXXX5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:23:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id u132so810381wmg.1
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:23:56 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

