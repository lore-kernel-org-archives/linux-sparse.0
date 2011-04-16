From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: Re: [PATCH 2/2] better dealing with OP_PHISOURCE insn
Date: Sat, 16 Apr 2011 13:16:46 +0200
Message-ID: <4DA97A9E.5050508@seznam.cz>
References: <4DA048C2.8060501@seznam.cz> <4DA04BE8.9060706@seznam.cz> <4DA8CC33.1050307@seznam.cz> <4DA975DD.2050908@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep20.mx.upcmail.net ([62.179.121.40]:50428 "EHLO
	fep20.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759274Ab1DPLQw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 16 Apr 2011 07:16:52 -0400
In-Reply-To: <4DA975DD.2050908@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

(Sorry, I do not use tabs normally so not aware of all these
exceptions as with continued "if")

Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
---
 liveness.c |   29 ++++++++++++++++++++---------
 1 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/liveness.c b/liveness.c
index eeff0f7..90c9d56 100644
--- a/liveness.c
+++ b/liveness.c
@@ -13,21 +13,32 @@
 #include "flow.h"
 
 static void phi_defines(struct instruction * phi_node, pseudo_t target,
-	void (*defines)(struct basic_block *, struct instruction *, pseudo_t))
+	void (*defines)(struct basic_block *, struct instruction *, pseudo_t),
+	unsigned long generation)
 {
 	pseudo_t phi;
 	FOR_EACH_PTR(phi_node->phi_list, phi) {
-		struct instruction *def;
 		if (phi == VOID)
 			continue;
-		def = phi->def;
-		if (!def || !def->bb)
-			continue;
-		if (def->opcode == OP_PHI) {
-			phi_defines(def, target, defines);
+		if (!phi->def || !phi->def->bb)
 			continue;
+
+		/*
+		 * In case of "(PHISOURCE->PHI->)+ PHISOURCE->PHI" chain, move
+		 * "defines" information upstream to the very first PHISOURCE;
+		 * recursion guarded by generation marking of PHI instructions BBs.
+		 */
+		pseudo_t src_pseudo = phi->def->phi_src;
+		if (src_pseudo->type == PSEUDO_REG
+		    && src_pseudo->def->opcode == OP_PHI) {
+			phi_node->bb->generation = generation;
+			if (src_pseudo->def->bb->generation != generation) {
+				phi_defines(src_pseudo->def, target, defines, generation);
+				continue;
+			}
 		}
-		defines(def->bb, phi->def, target);
+
+		defines(phi->def->bb, phi->def, target);
 	} END_FOR_EACH_PTR(phi);
 }
 
@@ -103,7 +114,7 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 	/* Other */
 	case OP_PHI:
 		/* Phi-nodes are "backwards" nodes. Their def doesn't matter */
-		phi_defines(insn, insn->target, def);
+		phi_defines(insn, insn->target, def, ++bb_generation);
 		break;
 
 	case OP_PHISOURCE:
-- 
1.7.1
