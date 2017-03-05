From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/13] llvm: fix type of literal integer passed as arguments
Date: Sun,  5 Mar 2017 12:20:40 +0100
Message-ID: <20170305112047.3411-7-luc.vanoostenryck@gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34016 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752474AbdCELaH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 06:30:07 -0500
Received: by mail-wr0-f193.google.com with SMTP id u48so18395949wrc.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 03:30:06 -0800 (PST)
In-Reply-To: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Like for all others instructions, LLVM needs the type
of each operands. However this information is not always
available via the pseudo, like here when passing a integer
constant as argument since for sparse constants are typeless.

Fix this by getting the type via the function prototype.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index c593f831f..27cc1b88c 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -740,7 +740,16 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 
 	i = 0;
 	FOR_EACH_PTR(insn->arguments, arg) {
-		args[i++] = pseudo_to_value(fn, insn, arg);
+		LLVMValueRef value;
+		if (arg->type == PSEUDO_VAL) {
+			/* Value pseudos do not have type information. */
+			/* Use the function prototype to get the type. */
+			struct symbol *ctype = get_nth1_arg(insn->func->sym, i + 1);
+			value = val_to_value(fn, arg->value, ctype);
+		} else {
+			value = pseudo_to_value(fn, insn, arg);
+		}
+		args[i++] = value;
 	} END_FOR_EACH_PTR(arg);
 
 	func = pseudo_to_value(fn, insn, insn->func);
-- 
2.11.1

