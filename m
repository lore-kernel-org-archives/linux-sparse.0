From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 9/9] kill dead stores when simplifying symbols
Date: Mon, 12 Feb 2018 23:02:46 +0100
Message-ID: <20180212220246.17750-10-luc.vanoostenryck@gmail.com>
References: <20180212220246.17750-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36569 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932732AbeBLWDE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Feb 2018 17:03:04 -0500
Received: by mail-wr0-f195.google.com with SMTP id y3so16727585wrh.3
        for <linux-sparse@vger.kernel.org>; Mon, 12 Feb 2018 14:03:03 -0800 (PST)
In-Reply-To: <20180212220246.17750-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In the initial simplify_symbols() and in simplify_memops()
when a store is simplified away, it's killed via kill_store()
where its ->bb is set to NULL and the usage is removed from
the value. However the usage is not removed from the address.
As consequence, code related to the address calculation
is not optimized away as it should be since the value is
wrongly considered as needed.

Fix this by using kill_instruction_force() to remove these
stores.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                             | 17 ++++-------------
 memops.c                           | 11 +----------
 validation/optim/store-dominated.c |  1 -
 3 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/flow.c b/flow.c
index 528c8f32d..495b118d2 100644
--- a/flow.c
+++ b/flow.c
@@ -542,15 +542,6 @@ found:
 	return 1;
 }
 
-static void kill_store(struct instruction *insn)
-{
-	if (insn) {
-		insn->bb = NULL;
-		insn->opcode = OP_SNOP;
-		kill_use(&insn->target);
-	}
-}
-
 /* Kill a pseudo that is dead on exit from the bb */
 static void kill_dead_stores(pseudo_t pseudo, unsigned long generation, struct basic_block *bb, int local)
 {
@@ -575,7 +566,7 @@ static void kill_dead_stores(pseudo_t pseudo, unsigned long generation, struct b
 		if (insn->src == pseudo) {
 			if (opcode == OP_LOAD)
 				return;
-			kill_store(insn);
+			kill_instruction_force(insn);
 			continue;
 		}
 		if (local)
@@ -606,7 +597,7 @@ static void kill_dominated_stores(pseudo_t pseudo, struct instruction *insn,
 
 	/* Unreachable store? Undo it */
 	if (!bb) {
-		kill_store(insn);
+		kill_instruction_force(insn);
 		return;
 	}
 	if (bb->generation == generation)
@@ -629,7 +620,7 @@ static void kill_dominated_stores(pseudo_t pseudo, struct instruction *insn,
 			return;
 		if (one->opcode == OP_LOAD)
 			return;
-		kill_store(one);
+		kill_instruction_force(one);
 	} END_FOR_EACH_PTR_REVERSE(one);
 
 	if (!found) {
@@ -721,7 +712,7 @@ external_visibility:
 		FOR_EACH_PTR(pseudo->users, pu) {
 			struct instruction *insn = pu->insn;
 			if (insn->opcode == OP_STORE)
-				kill_store(insn);
+				kill_instruction_force(insn);
 		} END_FOR_EACH_PTR(pu);
 	} else {
 		/*
diff --git a/memops.c b/memops.c
index 788ed2f2f..5762f4f2c 100644
--- a/memops.c
+++ b/memops.c
@@ -139,15 +139,6 @@ next_load:
 	} END_FOR_EACH_PTR_REVERSE(insn);
 }
 
-static void kill_store(struct instruction *insn)
-{
-	if (insn) {
-		insn->bb = NULL;
-		insn->opcode = OP_SNOP;
-		kill_use(&insn->target);
-	}
-}
-
 static void kill_dominated_stores(struct basic_block *bb)
 {
 	struct instruction *insn;
@@ -178,7 +169,7 @@ static void kill_dominated_stores(struct basic_block *bb)
 					if (dom->opcode == OP_LOAD)
 						goto next_store;
 					/* Yeehaa! Found one! */
-					kill_store(dom);
+					kill_instruction_force(dom);
 				}
 			} END_FOR_EACH_PTR_REVERSE(dom);
 
diff --git a/validation/optim/store-dominated.c b/validation/optim/store-dominated.c
index f1e2e6f29..d74db7790 100644
--- a/validation/optim/store-dominated.c
+++ b/validation/optim/store-dominated.c
@@ -9,7 +9,6 @@ static void foo(void)
 /*
  * check-name: store-dominated
  * check-command: test-linearize $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: add\.
-- 
2.16.0

