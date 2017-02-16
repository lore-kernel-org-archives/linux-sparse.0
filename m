From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 14/16] use kill_instruction() when killing an OP_PHI during CSE
Date: Thu, 16 Feb 2017 05:57:06 +0100
Message-ID: <20170216045708.50661-15-luc.vanoostenryck@gmail.com>
References: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36208 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753021AbdBPE52 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:28 -0500
Received: by mail-wm0-f66.google.com with SMTP id r18so1284908wmd.3
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:28 -0800 (PST)
In-Reply-To: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

cse_one_instruction() contains some code to be executed when
an OP_PHI is eliminated. This code is roughly equivalent to
what is done in kill_instruction() for OP_PHI but not complete
since it doesn't recursively try to kill others instructions
which are used only by this OP_PHI.

Fix this and avoid duplicated code by replacing this code by
a call to kill_instruction().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cse.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/cse.c b/cse.c
index e8fbe344f..165b862af 100644
--- a/cse.c
+++ b/cse.c
@@ -252,15 +252,7 @@ static struct instruction * cse_one_instruction(struct instruction *insn, struct
 	convert_instruction_target(insn, def->target);
 
 	if (insn->opcode == OP_PHI) {
-		/* Remove the instruction from PHI users */
-		pseudo_t phi;
-		FOR_EACH_PTR(insn->phi_list, phi) {
-			struct pseudo_user *pu;
-			FOR_EACH_PTR(phi->users, pu) {
-				if (pu->insn == insn)
-					DELETE_CURRENT_PTR(pu);
-			} END_FOR_EACH_PTR(pu);
-		} END_FOR_EACH_PTR(phi);
+		kill_instruction(insn);
 	}
 
 	insn->opcode = OP_NOP;
-- 
2.11.0

