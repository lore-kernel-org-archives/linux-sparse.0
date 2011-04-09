From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: [PATCH 2/2] better dealing with OP_PHISOURCE insn
Date: Sat, 09 Apr 2011 14:07:04 +0200
Message-ID: <4DA04BE8.9060706@seznam.cz>
References: <4DA048C2.8060501@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep14.mx.upcmail.net ([62.179.121.34]:42973 "EHLO
	fep14.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab1DIMHI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Apr 2011 08:07:08 -0400
In-Reply-To: <4DA048C2.8060501@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

Remove checking for a case that (most probably) never happens as the
only expected instruction is OP_PHISOURCE.

For the sake of assurance, assert added with a comment easing the fix if
the assumption of OP_PHISOURCE is wrong (better then masking a problem).

Also, use `def' as existing shortcut for `phi->def'.

Tested the same way as the previous patch (together).

Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
---
 liveness.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/liveness.c b/liveness.c
index eeff0f7..02ceed9 100644
--- a/liveness.c
+++ b/liveness.c
@@ -23,11 +23,9 @@ static void phi_defines(struct instruction * phi_node, pseudo_t target,
 		def = phi->def;
 		if (!def || !def->bb)
 			continue;
-		if (def->opcode == OP_PHI) {
-			phi_defines(def, target, defines);
-			continue;
-		}
-		defines(def->bb, phi->def, target);
+		/* if this ever fails (very unlikely), it's a sign of a regression */
+		assert(def->opcode == OP_PHISOURCE);
+		defines(def->bb, def, target);
 	} END_FOR_EACH_PTR(phi);
 }
 
-- 
1.7.1
