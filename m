From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/8] integrate add_load_dominators() into rewrite_load_instruction()
Date: Thu, 13 Apr 2017 18:55:49 +0200
Message-ID: <20170413165551.2785-7-luc.vanoostenryck@gmail.com>
References: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33353 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754032AbdDMQ4E (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Apr 2017 12:56:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id o81so13661561wmb.0
        for <linux-sparse@vger.kernel.org>; Thu, 13 Apr 2017 09:56:04 -0700 (PDT)
In-Reply-To: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c   | 12 ++++++++----
 flow.h   |  4 +---
 memops.c |  4 +---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/flow.c b/flow.c
index 678f9ba86..b64a3f74a 100644
--- a/flow.c
+++ b/flow.c
@@ -406,6 +406,7 @@ found_dominator:
 	return 1;
 }		
 
+static
 void add_dominator(struct pseudo_list **phi_list, struct instruction *insn,
 	struct instruction *dom, struct ident *ident)
 {
@@ -417,6 +418,7 @@ void add_dominator(struct pseudo_list **phi_list, struct instruction *insn,
 	use_pseudo(insn, phi, add_pseudo(phi_list, phi));
 }
 
+static
 struct pseudo_list *add_load_dominators(struct instruction *insn, struct instruction_list *doms,
 	struct ident *ident)
 {
@@ -433,10 +435,14 @@ struct pseudo_list *add_load_dominators(struct instruction *insn, struct instruc
  * We should probably sort the phi list just to make it easier to compare
  * later for equality. 
  */
-void rewrite_load_instruction(struct instruction *insn, struct pseudo_list *dominators)
+void rewrite_load_instruction(struct instruction *insn, struct instruction_list *doms,
+	struct ident *ident)
 {
+	struct pseudo_list *dominators;
 	pseudo_t new, phi;
 
+	dominators = add_load_dominators(insn, doms, ident);
+
 	/*
 	 * Check for somewhat common case of duplicate
 	 * phi nodes.
@@ -473,7 +479,6 @@ static int find_dominating_stores(pseudo_t pseudo, struct instruction *insn,
 	struct basic_block *bb = insn->bb;
 	struct instruction *one, *dom = NULL;
 	struct instruction_list *dominators;
-	struct pseudo_list *phi_list;
 	int partial;
 
 	/* Unreachable load? Undo it */
@@ -535,8 +540,7 @@ found:
 	 * have to turn the load into a phi-node of the
 	 * dominators.
 	 */
-	phi_list = add_load_dominators(insn, dominators, pseudo->ident);
-	rewrite_load_instruction(insn, phi_list);
+	rewrite_load_instruction(insn, dominators, pseudo->ident);
 	return 1;
 }
 
diff --git a/flow.h b/flow.h
index a6d0881c2..99bfcc879 100644
--- a/flow.h
+++ b/flow.h
@@ -37,9 +37,7 @@ static inline void kill_instruction_force(struct instruction *insn)
 
 void check_access(struct instruction *insn);
 void convert_load_instruction(struct instruction *, pseudo_t);
-void rewrite_load_instruction(struct instruction *, struct pseudo_list *);
-void add_dominator(struct pseudo_list **, struct instruction *, struct instruction *, struct ident*);
-struct pseudo_list *add_load_dominators(struct instruction *, struct instruction_list *, struct ident*);
+void rewrite_load_instruction(struct instruction *, struct instruction_list *, struct ident*);
 int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom, int local);
 
 extern void clear_liveness(struct entrypoint *ep);
diff --git a/memops.c b/memops.c
index 39469e260..bbb1831af 100644
--- a/memops.c
+++ b/memops.c
@@ -115,7 +115,6 @@ static void simplify_loads(struct basic_block *bb)
 			bb->generation = generation;
 			dominators = NULL;
 			if (find_dominating_parents(pseudo, insn, bb, generation, &dominators, local)) {
-				struct pseudo_list *phi_list;
 				/* This happens with initial assignments to structures etc.. */
 				if (!dominators) {
 					if (local) {
@@ -124,8 +123,7 @@ static void simplify_loads(struct basic_block *bb)
 					}
 					goto next_load;
 				}
-				phi_list = add_load_dominators(insn, dominators, NULL);
-				rewrite_load_instruction(insn, phi_list);
+				rewrite_load_instruction(insn, dominators, NULL);
 			}
 		}
 next_load:
-- 
2.12.0

