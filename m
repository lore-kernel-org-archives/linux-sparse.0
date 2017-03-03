From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] llvm: add support for OP_NEG
Date: Fri,  3 Mar 2017 11:23:32 +0100
Message-ID: <20170303102332.43997-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33767 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdCCNEQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 3 Mar 2017 08:04:16 -0500
Received: by mail-wm0-f68.google.com with SMTP id n11so3053196wma.0
        for <linux-sparse@vger.kernel.org>; Fri, 03 Mar 2017 05:03:21 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>

CC: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index fac19713a..2feff885f 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -950,9 +950,22 @@ static void output_insn(struct function *fn, struct instruction *insn)
 		insn->target->priv = target;
 		break;
 	}
-	case OP_NEG:
-		assert(0);
+	case OP_NEG: {
+		LLVMValueRef src, target;
+		char target_name[64];
+
+		src = pseudo_to_value(fn, insn, insn->src);
+
+		pseudo_name(insn->target, target_name);
+
+		if (symbol_is_fp_type(insn->type))
+			target = LLVMBuildFNeg(fn->builder, src, target_name);
+		else
+			target = LLVMBuildNeg(fn->builder, src, target_name);
+
+		insn->target->priv = target;
 		break;
+	}
 	case OP_CONTEXT:
 		assert(0);
 		break;
-- 
2.11.1

