From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] fix phisrc mixup
Date: Wed,  4 Jan 2017 04:03:20 +0100
Message-ID: <20170104030321.28019-4-luc.vanoostenryck@gmail.com>
References: <20170104030321.28019-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:35774 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753485AbdADDEM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 3 Jan 2017 22:04:12 -0500
Received: by mail-wj0-f195.google.com with SMTP id hb5so40765744wjc.2
        for <linux-sparse@vger.kernel.org>; Tue, 03 Jan 2017 19:03:37 -0800 (PST)
In-Reply-To: <20170104030321.28019-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In some cases phi sources are all mixed-up.
For example, on the following case:
	static int foo(void)
	{
		int i = 6;
		int j = 1;
		do {
			if (i != 6)
				i++;
			i++;
		} while (i != j);
		return j;
	}

test-linearize returns something like:
	.L0:
		phisrc.32   %phi3(i) <- $6
		phisrc.32   %phi7(i) <- $6
		br          .L1
	.L1:
		phi.32      %r1(i) <- %phi7(i), %phi8(i)
		setne.32    %r2 <- %r1(i), $6
		br          %r2, .L4, .L5
	.L4:
		add.32      %r4 <- %r1(i), $1
		phisrc.32   %phi5(i) <- %r4
		br          .L5
	.L5:
		phi.32      %r5 <- %phi3(i), %phi4(i), %phi5(i)
		add.32      %r6(i) <- %r5, $1
		phisrc.32   %phi4(i) <- %r6(i)
		phisrc.32   %phi8(i) <- %r6(i)
		setne.32    %r8 <- %r6(i), $1
		br          %r8, .L1, .L6
	.L6:
		ret.32      $1

The phi-node in .L5 is odd: .L5 has 2 parents (.L1 & .L4), we thus
expect to have 2 phisrc, one in .L1 and another one in .L4. There is
other oddities with phisrc: the redundant ones in .L0 and .L5.
In fact there is some sort of mixup with the phi & phisrc of .L1
and the ones in .L5 (and investigation showed it doesn't come from
further simplification phase but are already there since the creation
of these phi & phisrc).

The fix essentially consists in a revert of
  (commit cf07903a "Don't bother finding dominating loads if we have to search multiple paths")
which was already partially reverted in
  (commit c040f2e0 "Remove incorrect left-over from (not useful) old load-load dominance trials.")

We then get the more expected:
	.L0:
		phisrc.32   %phi6(i) <- $6
		br          .L1
	.L1:
		phi.32      %r1(i) <- %phi6(i), %phi7(i)
		setne.32    %r2 <- %r1(i), $6
		phisrc.32   %phi3(i) <- %r1(i)
		br          %r2, .L4, .L5
	.L4:
		add.32      %r4 <- %r1(i), $1
		phisrc.32   %phi4(i) <- %r4
		br          .L5
	.L5:
		phi.32      %r5 <- %phi3(i), %phi4(i)
		add.32      %r6(i) <- %r5, $1
		phisrc.32   %phi7(i) <- %r6(i)
		setne.32    %r8 <- %r6(i), $1
		br          %r8, .L1, .L6
	.L6:
		ret.32      $1

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/flow.c b/flow.c
index d8e253b1..ef07b6db 100644
--- a/flow.c
+++ b/flow.c
@@ -329,15 +329,13 @@ static int phisrc_in_bb(struct pseudo_list *list, struct basic_block *bb)
 
 static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
 	struct basic_block *bb, unsigned long generation, struct pseudo_list **dominators,
-	int local, int loads)
+	int local)
 {
 	struct basic_block *parent;
 
 	if (!bb->parents)
 		return !!local;
 
-	if (bb_list_size(bb->parents) > 1)
-		loads = 0;
 	FOR_EACH_PTR(bb->parents, parent) {
 		struct instruction *one;
 		struct instruction *br;
@@ -355,8 +353,6 @@ static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
 			}
 			if (!dominance)
 				continue;
-			if (one->opcode == OP_LOAD && !loads)
-				continue;
 			goto found_dominator;
 		} END_FOR_EACH_PTR_REVERSE(one);
 no_dominance:
@@ -364,7 +360,7 @@ no_dominance:
 			continue;
 		parent->generation = generation;
 
-		if (!find_dominating_parents(pseudo, insn, parent, generation, dominators, local, loads))
+		if (!find_dominating_parents(pseudo, insn, parent, generation, dominators, local))
 			return 0;
 		continue;
 
@@ -467,7 +463,7 @@ found:
 	bb->generation = generation;
 
 	dominators = NULL;
-	if (!find_dominating_parents(pseudo, insn, bb, generation, &dominators, local, 1))
+	if (!find_dominating_parents(pseudo, insn, bb, generation, &dominators, local))
 		return 0;
 
 	/* This happens with initial assignments to structures etc.. */
-- 
2.11.0

