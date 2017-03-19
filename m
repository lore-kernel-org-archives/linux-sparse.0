From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 12/30] llvm: give a name to call's return values
Date: Sun, 19 Mar 2017 02:42:09 +0100
Message-ID: <20170319014227.8833-13-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35288 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbdCSBmw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:42:52 -0400
Received: by mail-wr0-f194.google.com with SMTP id u108so13841198wrb.2
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:42:50 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, a name is given to the result of instruction like
binops, compares, ... but not to function calls.

Functionally, it doesn't change anything but those names are
useful by easing reading while debugging, reading the generated
code, ...

Fix this by giving a name to OP_CALL's result too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index b9176e19d..dd7ff3398 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -297,6 +297,9 @@ static void pseudo_name(pseudo_t pseudo, char *buf)
 	case PSEUDO_PHI:
 		snprintf(buf, MAX_PSEUDO_NAME, "PHI%d", pseudo->nr);
 		break;
+	case PSEUDO_VOID:
+		buf[0] = '\0';
+		break;
 	default:
 		assert(0);
 	}
@@ -708,6 +711,8 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 	int n_arg = 0, i;
 	struct instruction *arg;
 	LLVMValueRef *args;
+	char name[64];
+
 
 	n_arg = instruction_list_size(insn->arguments);
 	args = calloc(n_arg, sizeof(LLVMValueRef));
@@ -718,7 +723,8 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 	} END_FOR_EACH_PTR(arg);
 
 	func = pseudo_to_value(fn, insn, insn->func);
-	target = LLVMBuildCall(fn->builder, func, args, n_arg, "");
+	pseudo_name(insn->target, name);
+	target = LLVMBuildCall(fn->builder, func, args, n_arg, name);
 
 	insn->target->priv = target;
 }
-- 
2.12.0

