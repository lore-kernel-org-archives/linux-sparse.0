From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 19/63] llvm: give a name to call's return values
Date: Tue, 21 Mar 2017 01:15:23 +0100
Message-ID: <20170321001607.75169-20-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35791 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755901AbdCUAQl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id z133so257894wmb.2
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:40 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

