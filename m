From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 19/27] llvm: add support for OP_NEG
Date: Sat, 11 Mar 2017 10:06:58 +0100
Message-ID: <20170311090706.17171-20-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35016 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755493AbdCKJHm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:42 -0500
Received: by mail-wr0-f193.google.com with SMTP id u108so14120653wrb.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:41 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

sparse-llvm has not yet support for OP_NEG and stop on an assert
if one is encountered.

Fix this by invoking the appropriate LLVMBuild[F]Neg().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index a3606a86e..ccc019322 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -977,9 +977,22 @@ static void output_insn(struct function *fn, struct instruction *insn)
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

