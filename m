From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC] rationale for systematic elimination of OP_SYMADDR instructions
Date: Thu,  9 Mar 2017 15:20:44 +0100
Message-ID: <20170309142044.96408-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33035 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754559AbdCIO1w (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Mar 2017 09:27:52 -0500
Received: by mail-wr0-f195.google.com with SMTP id g10so8124197wrg.0
        for <linux-sparse@vger.kernel.org>; Thu, 09 Mar 2017 06:27:50 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

While investigating some problems related to code generation
I realized that OP_SYMADDR are systematically eliminated,
the target address are simply replaced by the symbol itself.

While it's not wrong per se as it all depends to the semantic
we want to give to pseudos and the instructions and how high-
or low-level we want to IR, I don't think it was the intention
to remove them and more importantly I don't think it's desirable.

Those OP_SYMADDR allowed to make a clear separation between a symbol
(a name with a type and info for storage & linkage) and its address
(which can be stored in memory or in a register and on which
arithmetic operations can then be done on it). Once these addresses
are replaced by the symbol itself, those symbols can appears almost
everywhere in the linearized code:
- in calls' arguments,
- in adds and subs (while doing pointer arithmetic),
- in casts,
- in load & stores,
- ...
and they complicate things considerably once you begin to be
interested concretly in things after linearization & simplification
since soon or later you will need the address anyway.

So my question is:
	"is there a good reason to eliminate those instructions?",
and ultimately:
	"is there any objections to the following patch?".


-- Luc Van Oostenryck


---
diff --git a/simplify.c b/simplify.c
index 5d00937f1..a84e4787f 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1159,7 +1159,7 @@ int simplify_instruction(struct instruction *insn)
 	case OP_SYMADDR:
 		if (dead_insn(insn, NULL, NULL, NULL))
 			return REPEAT_CSE | REPEAT_SYMBOL_CLEANUP;
-		return replace_with_pseudo(insn, insn->symbol);
+		return 0;
 	case OP_CAST:
 	case OP_SCAST:
 	case OP_FPCAST:
