From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] missing load simplification
Date: Wed,  4 Jan 2017 04:03:21 +0100
Message-ID: <20170104030321.28019-5-luc.vanoostenryck@gmail.com>
References: <20170104030321.28019-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35283 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753489AbdADDEM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 3 Jan 2017 22:04:12 -0500
Received: by mail-wm0-f66.google.com with SMTP id l2so64006991wml.2
        for <linux-sparse@vger.kernel.org>; Tue, 03 Jan 2017 19:03:38 -0800 (PST)
In-Reply-To: <20170104030321.28019-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In memops:find_dominating_parents(), the 'load-load optimization'
(see commit cf07903a "Don't bother finding dominating loads if ...")
cause some loads simplification to be missed.
For example, with the following code:
	int foo(int *i, int *j)
	{
		*i = 6;
		*j = 1;

		do {
			if (*i != 6)
				(*i)++;
			(*i)++;
		} while (*i != *j);

		return *j;
	}

test-linearize returns something like:
	foo:
	.L0:
		<entry-point>
		store.32    $6 -> 0[%arg1]
		store.32    $1 -> 0[%arg2]
		br          .L1

	.L1:
		load.32     %r4 <- 0[%arg1]
		setne.32    %r5 <- %r4, $6
		br          %r5, .L4, .L5

	.L4:
		add.32      %r8 <- %r4, $1
		store.32    %r8 -> 0[%arg1]
		br          .L5

	.L5:
		load.32     %r10 <- 0[%arg1]
		add.32      %r11 <- %r10, $1
		store.32    %r11 -> 0[%arg1]
		load.32     %r15 <- 0[%arg2]
		setne.32    %r16 <- %r11, %r15
		br          %r16, .L1, .L6

	.L6:
		ret.32      %r15

where we can notice that the first load in .L5 is not needed,
the value could be retrieved from %r4 and %r8, like:
	@@ -8,15 +8,17 @@
	 .L1:
	 	load.32     %r4 <- 0[%arg1]
	 	setne.32    %r5 <- %r4, $6
	+	phisrc.32   %phi4 <- %r4
	 	br          %r5, .L4, .L5

	 .L4:
	 	add.32      %r8 <- %r4, $1
	 	store.32    %r8 -> 0[%arg1]
	+	phisrc.32   %phi5 <- %r8
	 	br          .L5

	 .L5:
	-	load.32     %r10 <- 0[%arg1]
	+	phi.32      %r10 <- %phi4, %phi5
	 	add.32      %r11 <- %r10, $1
	 	store.32    %r11 -> 0[%arg1]
	 	load.32     %r15 <- 0[%arg2]

The fix essentially consists in reverting commit cf07903a but on
memops.c's version of find_dominating_parents().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/memops.c b/memops.c
index 6dac1f57..5efdd6f2 100644
--- a/memops.c
+++ b/memops.c
@@ -18,12 +18,10 @@
 
 static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
 	struct basic_block *bb, unsigned long generation, struct pseudo_list **dominators,
-	int local, int loads)
+	int local)
 {
 	struct basic_block *parent;
 
-	if (bb_list_size(bb->parents) > 1)
-		loads = 0;
 	FOR_EACH_PTR(bb->parents, parent) {
 		struct instruction *one;
 		struct instruction *br;
@@ -41,8 +39,6 @@ static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
 			}
 			if (!dominance)
 				continue;
-			if (one->opcode == OP_LOAD && !loads)
-				continue;
 			goto found_dominator;
 		} END_FOR_EACH_PTR_REVERSE(one);
 no_dominance:
@@ -50,7 +46,7 @@ no_dominance:
 			continue;
 		parent->generation = generation;
 
-		if (!find_dominating_parents(pseudo, insn, parent, generation, dominators, local, loads))
+		if (!find_dominating_parents(pseudo, insn, parent, generation, dominators, local))
 			return 0;
 		continue;
 
@@ -124,7 +120,7 @@ static void simplify_loads(struct basic_block *bb)
 			generation = ++bb_generation;
 			bb->generation = generation;
 			dominators = NULL;
-			if (find_dominating_parents(pseudo, insn, bb, generation, &dominators, local, 1)) {
+			if (find_dominating_parents(pseudo, insn, bb, generation, &dominators, local)) {
 				/* This happens with initial assignments to structures etc.. */
 				if (!dominators) {
 					if (local) {
-- 
2.11.0

