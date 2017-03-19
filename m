From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 30/30] llvm: fix type of switch constants
Date: Sun, 19 Mar 2017 02:42:27 +0100
Message-ID: <20170319014227.8833-31-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34330 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbdCSBnJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:43:09 -0400
Received: by mail-wr0-f196.google.com with SMTP id u48so13843300wrc.1
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:43:08 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In sparse-llvm, the type of switch constants are hardcoded
to 'i32'.

Fix this by using the right type as given by the instruction.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index bae55de3b..c01d3ea41 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -771,7 +771,7 @@ static void output_op_switch(struct function *fn, struct instruction *insn)
 	FOR_EACH_PTR(insn->multijmp_list, jmp) {
 		if (jmp->begin == jmp->end) {		/* case N */
 			LLVMAddCase(target,
-				LLVMConstInt(LLVMInt32Type(), jmp->begin, 0),
+				val_to_value(jmp->begin, insn->type),
 				jmp->target->priv);
 		} else if (jmp->begin < jmp->end) {	/* case M..N */
 			assert(0);
-- 
2.12.0

