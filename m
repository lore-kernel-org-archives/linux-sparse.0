From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 19/51] llvm: add support for OP_NEG
Date: Sat, 25 Mar 2017 00:20:25 +0100
Message-ID: <20170324232057.15033-20-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34256 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935335AbdCXXXq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:23:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id u132so809849wmg.1
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:23:45 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

