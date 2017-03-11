From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 24/27] llvm: remove unneeded arg 'fn'
Date: Sat, 11 Mar 2017 10:07:03 +0100
Message-ID: <20170311090706.17171-25-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36469 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755554AbdCKJHr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:47 -0500
Received: by mail-wr0-f194.google.com with SMTP id l37so14057971wrc.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:46 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 824bd790e..e35ac01a2 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -306,7 +306,7 @@ static void pseudo_name(pseudo_t pseudo, char *buf)
 	}
 }
 
-static LLVMValueRef val_to_value(struct function *fn, unsigned long long val, struct symbol *ctype)
+static LLVMValueRef val_to_value(unsigned long long val, struct symbol *ctype)
 {
 	LLVMTypeRef dtype;
 	LLVMTypeRef itype;
@@ -387,7 +387,7 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 		break;
 	}
 	case PSEUDO_VAL:
-		result = val_to_value(fn, pseudo->value, insn->type);
+		result = val_to_value(pseudo->value, insn->type);
 		break;
 	case PSEUDO_ARG: {
 		result = LLVMGetParam(fn->fn, pseudo->nr - 1);
@@ -774,7 +774,7 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 			atype = get_nth_symbol(ftype->arguments, i);
 			/* Value pseudos do not have type information. */
 			/* Use the function prototype to get the type. */
-			value = val_to_value(fn, arg->value, atype);
+			value = val_to_value(arg->value, atype);
 		} else {
 			value = pseudo_to_value(fn, insn, arg);
 		}
-- 
2.11.1

