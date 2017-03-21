From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 31/63] llvm: add support for OP_NEG
Date: Tue, 21 Mar 2017 01:15:35 +0100
Message-ID: <20170321001607.75169-32-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34758 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755973AbdCUAQy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id u132so263501wmg.1
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:53 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

sparse-llvm has not yet support for OP_NEG and stop on an assert
if one is encountered.

Fix this by invoking the appropriate LLVMBuild[F]Neg().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index ad69124e1..6cc01cdd9 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -951,9 +951,22 @@ static void output_insn(struct function *fn, struct instruction *insn)
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
+		if (is_float_type(insn->type))
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
2.12.0

