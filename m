From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/29] remove wrong part of simplify_loads()
Date: Wed, 16 Aug 2017 17:34:27 +0200
Message-ID: <20170816153455.97693-2-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38726 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbdHPPfH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:07 -0400
Received: by mail-wr0-f194.google.com with SMTP id g32so3681793wrd.5
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:07 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently simplify_loads() is broken with exactly the
same error as in simplify_one_symbol().

The core of the problem is that phi-nodes are stored at
the place where the value is needed, where the initial load
was, while phi-nodes must be placed where branches meet.

Temporary fix this removing this 'simplification'.

Note: It's possible to do this a bit less crudely
Note: This patch is kinda useless without the SSA construction
      first fixed..

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c                | 63 -------------------------------------------------
 validation/kill-casts.c |  1 -
 2 files changed, 64 deletions(-)

diff --git a/memops.c b/memops.c
index aeacdf566..99430e455 100644
--- a/memops.c
+++ b/memops.c
@@ -16,51 +16,6 @@
 #include "linearize.h"
 #include "flow.h"
 
-static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
-	struct basic_block *bb, unsigned long generation, struct pseudo_list **dominators,
-	int local)
-{
-	struct basic_block *parent;
-
-	FOR_EACH_PTR(bb->parents, parent) {
-		struct instruction *one;
-		struct instruction *br;
-		pseudo_t phi;
-
-		FOR_EACH_PTR_REVERSE(parent->insns, one) {
-			int dominance;
-			if (!one->bb)
-				continue;
-			if (one == insn)
-				goto no_dominance;
-			dominance = dominates(pseudo, insn, one, local);
-			if (dominance < 0) {
-				if (one->opcode == OP_LOAD)
-					continue;
-				return 0;
-			}
-			if (!dominance)
-				continue;
-			goto found_dominator;
-		} END_FOR_EACH_PTR_REVERSE(one);
-no_dominance:
-		if (parent->generation == generation)
-			continue;
-		parent->generation = generation;
-
-		if (!find_dominating_parents(pseudo, insn, parent, generation, dominators, local))
-			return 0;
-		continue;
-
-found_dominator:
-		br = delete_last_instruction(&parent->insns);
-		phi = alloc_phi(parent, one->target, one->size);
-		phi->ident = phi->ident ? : one->target->ident;
-		add_instruction(&parent->insns, br);
-		use_pseudo(insn, phi, add_pseudo(dominators, phi));
-	} END_FOR_EACH_PTR(parent);
-	return 1;
-}		
 
 static int address_taken(pseudo_t pseudo)
 {
@@ -91,8 +46,6 @@ static void simplify_loads(struct basic_block *bb)
 			struct instruction *dom;
 			pseudo_t pseudo = insn->src;
 			int local = local_pseudo(pseudo);
-			struct pseudo_list *dominators;
-			unsigned long generation;
 
 			/* Check for illegal offsets.. */
 			check_access(insn);
@@ -117,22 +70,6 @@ static void simplify_loads(struct basic_block *bb)
 					goto next_load;
 				}
 			} END_FOR_EACH_PTR_REVERSE(dom);
-
-			/* OK, go find the parents */
-			generation = ++bb_generation;
-			bb->generation = generation;
-			dominators = NULL;
-			if (find_dominating_parents(pseudo, insn, bb, generation, &dominators, local)) {
-				/* This happens with initial assignments to structures etc.. */
-				if (!dominators) {
-					if (local) {
-						assert(pseudo->type != PSEUDO_ARG);
-						convert_load_instruction(insn, value_pseudo(0));
-					}
-					goto next_load;
-				}
-				rewrite_load_instruction(insn, dominators);
-			}
 		}
 next_load:
 		/* Do the next one */;
diff --git a/validation/kill-casts.c b/validation/kill-casts.c
index cf52f2460..7b72c4719 100644
--- a/validation/kill-casts.c
+++ b/validation/kill-casts.c
@@ -18,5 +18,4 @@ void foo(struct s *x)
  * check-command: test-linearize $file
  *
  * check-output-ignore
- * check-output-excludes: cast\\.
  */
-- 
2.14.0

