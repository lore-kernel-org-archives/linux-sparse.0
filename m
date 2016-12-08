From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] recursive phi_defines cannot happen
Date: Thu,  8 Dec 2016 04:34:38 +0100
Message-ID: <20161208033438.7607-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:33296 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933175AbcLHDeq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 22:34:46 -0500
Received: by mail-wj0-f196.google.com with SMTP id kp2so52680282wjc.0
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 19:34:46 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The function phi_defines() does the liveness tracking of phi-pseudos
(pseudos in OP_PHIs args). While doing this, the function is
recursively called when the pseudo would be defined by another phi-node;
but this condition is impossible because all phi-pseudos are defined
by OP_PHISOURCE instructions.

This patch remove the recursive call and its associated test.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 liveness.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/liveness.c b/liveness.c
index eeff0f79..fb696720 100644
--- a/liveness.c
+++ b/liveness.c
@@ -23,10 +23,6 @@ static void phi_defines(struct instruction * phi_node, pseudo_t target,
 		def = phi->def;
 		if (!def || !def->bb)
 			continue;
-		if (def->opcode == OP_PHI) {
-			phi_defines(def, target, defines);
-			continue;
-		}
 		defines(def->bb, phi->def, target);
 	} END_FOR_EACH_PTR(phi);
 }
-- 
2.10.2

