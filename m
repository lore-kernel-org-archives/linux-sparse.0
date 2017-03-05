From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/13] llvm: add support for OP_NEG
Date: Sun,  5 Mar 2017 12:20:42 +0100
Message-ID: <20170305112047.3411-9-luc.vanoostenryck@gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35958 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbdCEL1b (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 06:27:31 -0500
Received: by mail-wr0-f196.google.com with SMTP id l37so18335646wrc.3
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 03:27:30 -0800 (PST)
In-Reply-To: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

sparse-llvm has not yet support for OP_NEG (which
need to be done via a subtraction from zero).

Fix this by issuing the appropriate substraction.

CC: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index ee374b217..c489009a6 100644
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

