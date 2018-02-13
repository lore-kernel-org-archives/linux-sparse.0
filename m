From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 04/10] kill dead stores when simplifying symbols
Date: Tue, 13 Feb 2018 22:58:06 +0100
Message-ID: <20180213215812.18735-5-luc.vanoostenryck@gmail.com>
References: <20180213215812.18735-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40194 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965865AbeBMWAY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 17:00:24 -0500
Received: by mail-wm0-f68.google.com with SMTP id v123so18592043wmd.5
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 14:00:23 -0800 (PST)
In-Reply-To: <20180213215812.18735-1-luc.vanoostenryck@gmail.com>
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
index 62658b920..e6f99a0de 100644
--- a/flow.c
+++ b/flow.c
@@ -544,15 +544,6 @@ found:
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
@@ -577,7 +568,7 @@ static void kill_dead_stores(pseudo_t pseudo, unsigned long generation, struct b
 		if (insn->src == pseudo) {
 			if (opcode == OP_LOAD)
 				return;
-			kill_store(insn);
+			kill_instruction_force(insn);
 			continue;
 		}
 		if (local)
@@ -608,7 +599,7 @@ static void kill_dominated_stores(pseudo_t pseudo, struct instruction *insn,
 
 	/* Unreachable store? Undo it */
 	if (!bb) {
-		kill_store(insn);
+		kill_instruction_force(insn);
 		return;
 	}
 	if (bb->generation == generation)
@@ -631,7 +622,7 @@ static void kill_dominated_stores(pseudo_t pseudo, struct instruction *insn,
 			return;
 		if (one->opcode == OP_LOAD)
 			return;
-		kill_store(one);
+		kill_instruction_force(one);
 	} END_FOR_EACH_PTR_REVERSE(one);
 
 	if (!found) {
@@ -723,7 +714,7 @@ external_visibility:
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

