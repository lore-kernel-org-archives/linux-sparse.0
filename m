From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 13/27] llvm: add support for OP_SYMADDR
Date: Sat, 11 Mar 2017 10:06:52 +0100
Message-ID: <20170311090706.17171-14-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33822 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752678AbdCKJHg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:36 -0500
Received: by mail-wm0-f66.google.com with SMTP id u132so2312936wmg.1
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:34 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

sparse-llvm don't yet support OP_SYMADDR instructions.

Fix this by add the needed support for it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index e3c8cafed..a3606a86e 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -895,9 +895,18 @@ static void output_insn(struct function *fn, struct instruction *insn)
 	case OP_CBR:
 		output_op_cbr(fn, insn);
 		break;
-	case OP_SYMADDR:
-		assert(0);
+	case OP_SYMADDR: {
+		LLVMValueRef res, src;
+		LLVMTypeRef dtype;
+		char name[64];
+
+		src = pseudo_to_value(fn, insn, insn->symbol);
+		dtype = symbol_type(fn->module, insn->type);
+		pseudo_name(insn->target, name);
+		res = LLVMBuildBitCast(fn->builder, src, dtype, name);
+		insn->target->priv = res;
 		break;
+	}
 	case OP_SETVAL:
 		assert(0);
 		break;
-- 
2.11.1

