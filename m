From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 12/13] llvm: remove unneeded arg 'fn'
Date: Sun,  5 Mar 2017 12:20:46 +0100
Message-ID: <20170305112047.3411-13-luc.vanoostenryck@gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35974 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbdCEL1f (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 06:27:35 -0500
Received: by mail-wr0-f196.google.com with SMTP id l37so18335883wrc.3
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 03:27:34 -0800 (PST)
In-Reply-To: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 35562e570..7c7b70027 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -303,7 +303,7 @@ static void pseudo_name(pseudo_t pseudo, char *buf)
 	}
 }
 
-static LLVMValueRef val_to_value(struct function *fn, unsigned long long val, struct symbol *ctype)
+static LLVMValueRef val_to_value(unsigned long long val, struct symbol *ctype)
 {
 	LLVMTypeRef dtype;
 	LLVMTypeRef itype;
@@ -384,7 +384,7 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 		break;
 	}
 	case PSEUDO_VAL:
-		result = val_to_value(fn, pseudo->value, insn->type);
+		result = val_to_value(pseudo->value, insn->type);
 		break;
 	case PSEUDO_ARG: {
 		result = LLVMGetParam(fn->fn, pseudo->nr - 1);
@@ -749,7 +749,7 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 			/* Value pseudos do not have type information. */
 			/* Use the function prototype to get the type. */
 			struct symbol *ctype = get_nth1_arg(insn->func->sym, i + 1);
-			value = val_to_value(fn, arg->value, ctype);
+			value = val_to_value(arg->value, ctype);
 		} else {
 			value = pseudo_to_value(fn, insn, arg);
 		}
-- 
2.11.1

