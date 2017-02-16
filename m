From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/16] fix clear_phi(), replace it by kill_instruction()
Date: Thu, 16 Feb 2017 05:56:57 +0100
Message-ID: <20170216045708.50661-6-luc.vanoostenryck@gmail.com>
References: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33115 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbdBPE5U (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:20 -0500
Received: by mail-wr0-f195.google.com with SMTP id i10so641686wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:20 -0800 (PST)
In-Reply-To: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

clear_phi() only replaces a phi-node's sources by VOID
without adjusting the usage of these sources.
As such it can't be used for cleaning things before
removing an OP_PHI.

Fix this by replacing calls to clear_phi() by calls
to kill_instruction().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/simplify.c b/simplify.c
index 17f1e2b61..ddd0aa9c5 100644
--- a/simplify.c
+++ b/simplify.c
@@ -110,7 +110,7 @@ static int if_convert_phi(struct instruction *insn)
 	 * the conditional branch too.
 	 */
 	insert_select(source, br, insn, p1, p2);
-	clear_phi(insn);
+	kill_instruction(insn);
 	return REPEAT_CSE;
 }
 
@@ -140,7 +140,7 @@ static int clean_up_phi(struct instruction *insn)
 	if (same) {
 		pseudo_t pseudo = last ? last->src1 : VOID;
 		convert_instruction_target(insn, pseudo);
-		clear_phi(insn);
+		kill_instruction(insn);
 		return REPEAT_CSE;
 	}
 
@@ -1142,7 +1142,7 @@ int simplify_instruction(struct instruction *insn)
 		return simplify_cast(insn);
 	case OP_PHI:
 		if (dead_insn(insn, NULL, NULL, NULL)) {
-			clear_phi(insn);
+			kill_use_list(insn->phi_list);
 			return REPEAT_CSE;
 		}
 		return clean_up_phi(insn);
-- 
2.11.0

