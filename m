From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 07/52] llvm: give a name to call's return values
Date: Mon, 27 Mar 2017 23:23:31 +0200
Message-ID: <20170327212416.18536-8-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34873 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdC0V0i (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:38 -0400
Received: by mail-wr0-f193.google.com with SMTP id p52so14119073wrc.2
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:32 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
index 53c13122b..8de144e2a 100644
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

