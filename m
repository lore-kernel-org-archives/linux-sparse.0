From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 08/27] llvm: give a name to call return values
Date: Sat, 11 Mar 2017 10:06:47 +0100
Message-ID: <20170311090706.17171-9-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35127 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755129AbdCKJHa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:30 -0500
Received: by mail-wm0-f65.google.com with SMTP id z63so2304692wmg.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:29 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
index c593f831f..c143cfb28 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -298,6 +298,9 @@ static void pseudo_name(pseudo_t pseudo, char *buf)
 	case PSEUDO_PHI:
 		snprintf(buf, MAX_PSEUDO_NAME, "PHI%d", pseudo->nr);
 		break;
+	case PSEUDO_VOID:
+		buf[0] = '\0';
+		break;
 	default:
 		assert(0);
 	}
@@ -731,6 +734,8 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 	int n_arg = 0, i;
 	struct pseudo *arg;
 	LLVMValueRef *args;
+	char name[64];
+
 
 	FOR_EACH_PTR(insn->arguments, arg) {
 		n_arg++;
@@ -744,7 +749,8 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 	} END_FOR_EACH_PTR(arg);
 
 	func = pseudo_to_value(fn, insn, insn->func);
-	target = LLVMBuildCall(fn->builder, func, args, n_arg, "");
+	pseudo_name(insn->target, name);
+	target = LLVMBuildCall(fn->builder, func, args, n_arg, name);
 
 	insn->target->priv = target;
 }
-- 
2.11.1

