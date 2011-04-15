From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: Re: [PATCH 2/2] better dealing with OP_PHISOURCE insn
Date: Sat, 16 Apr 2011 00:52:35 +0200
Message-ID: <4DA8CC33.1050307@seznam.cz>
References: <4DA048C2.8060501@seznam.cz> <4DA04BE8.9060706@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep13.mx.upcmail.net ([62.179.121.33]:46051 "EHLO
	fep13.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab1DOWwj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 15 Apr 2011 18:52:39 -0400
In-Reply-To: <4DA04BE8.9060706@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

This is my proposal of how to fix incorrect handling of a recursive
"(PHISOURCE->PHI->)+ PHISOURCE->PHI" chain in `phi_defines'.

It should be applied instead of my previous 2/2 patch posted on
2011-04-09 which treated this case unwisely as spotted by Chris Li
who also outlined respective correction in his reply from 2011-04-14.

The fix required to move `trackable_pseudo' (if we want to avoid
a forward declaration).

I also added `src_pseudo' in the role of a shortcut and removed `def' to
reduce the number of levels of such shortcuts (to keep it more readable).

I tried few comparisons (some of them in very carefully) and it seems to
do the job (as explained in included comment) right.

Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
---
 liveness.c |   39 +++++++++++++++++++++++++--------------
 1 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/liveness.c b/liveness.c
index eeff0f7..c9460de 100644
--- a/liveness.c
+++ b/liveness.c
@@ -12,22 +12,38 @@
 #include "linearize.h"
 #include "flow.h"
 
+
+static inline int trackable_pseudo(pseudo_t pseudo)
+{
+	return pseudo && (pseudo->type == PSEUDO_REG || pseudo->type == PSEUDO_ARG);
+}
+
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
+		 * "defines" information upstream to the BB of a very first PHISOURCE
+		 * (recursion guarded using "generation" marking of PHI insn BBs).
+		 */
+		pseudo_t src_pseudo = phi->def->phi_src;
+		if (trackable_pseudo(src_pseudo) && src_pseudo->def->opcode == OP_PHI) {
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
 
@@ -103,7 +119,7 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 	/* Other */
 	case OP_PHI:
 		/* Phi-nodes are "backwards" nodes. Their def doesn't matter */
-		phi_defines(insn, insn->target, def);
+		phi_defines(insn, insn->target, def, ++bb_generation);
 		break;
 
 	case OP_PHISOURCE:
@@ -179,11 +195,6 @@ static void add_pseudo_exclusive(struct pseudo_list **list, pseudo_t pseudo)
 	}
 }
 
-static inline int trackable_pseudo(pseudo_t pseudo)
-{
-	return pseudo && (pseudo->type == PSEUDO_REG || pseudo->type == PSEUDO_ARG);
-}
