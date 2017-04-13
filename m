From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/8] extract add_dominator() from find_dominating_parents()
Date: Thu, 13 Apr 2017 18:55:44 +0200
Message-ID: <20170413165551.2785-2-luc.vanoostenryck@gmail.com>
References: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36705 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753970AbdDMQz7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Apr 2017 12:55:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id q125so13647643wmd.3
        for <linux-sparse@vger.kernel.org>; Thu, 13 Apr 2017 09:55:59 -0700 (PDT)
In-Reply-To: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c   | 19 ++++++++++++-------
 flow.h   |  1 +
 memops.c |  8 +-------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/flow.c b/flow.c
index 45bae773e..50507a5e7 100644
--- a/flow.c
+++ b/flow.c
@@ -374,8 +374,6 @@ static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
 
 	FOR_EACH_PTR(bb->parents, parent) {
 		struct instruction *one;
-		struct instruction *br;
-		pseudo_t phi;
 
 		FOR_EACH_PTR_REVERSE(parent->insns, one) {
 			int dominance;
@@ -403,15 +401,22 @@ no_dominance:
 found_dominator:
 		if (dominators && phisrc_in_bb(*dominators, parent))
 			continue;
-		br = delete_last_instruction(&parent->insns);
-		phi = alloc_phi(parent, one->target, one->type);
-		phi->ident = phi->ident ? : pseudo->ident;
-		add_instruction(&parent->insns, br);
-		use_pseudo(insn, phi, add_pseudo(dominators, phi));
+		add_dominator(dominators, insn, one, pseudo->ident);
 	} END_FOR_EACH_PTR(parent);
 	return 1;
 }		
 
+void add_dominator(struct pseudo_list **phi_list, struct instruction *insn,
+	struct instruction *dom, struct ident *ident)
+{
+	struct basic_block *bb = dom->bb;
+	struct instruction *br = delete_last_instruction(&bb->insns);
+	pseudo_t phi = alloc_phi(bb, dom->target, dom->type);
+	phi->ident = phi->ident ? : ident ? : dom->target->ident;
+	add_instruction(&bb->insns, br);
+	use_pseudo(insn, phi, add_pseudo(phi_list, phi));
+}
+
 /*
  * We should probably sort the phi list just to make it easier to compare
  * later for equality. 
diff --git a/flow.h b/flow.h
index 31ed80d40..800585547 100644
--- a/flow.h
+++ b/flow.h
@@ -38,6 +38,7 @@ static inline void kill_instruction_force(struct instruction *insn)
 void check_access(struct instruction *insn);
 void convert_load_instruction(struct instruction *, pseudo_t);
 void rewrite_load_instruction(struct instruction *, struct pseudo_list *);
+void add_dominator(struct pseudo_list **, struct instruction *, struct instruction *, struct ident*);
 int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom, int local);
 
 extern void clear_liveness(struct entrypoint *ep);
diff --git a/memops.c b/memops.c
index 187a63284..ac43b6a0a 100644
--- a/memops.c
+++ b/memops.c
@@ -24,8 +24,6 @@ static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
 
 	FOR_EACH_PTR(bb->parents, parent) {
 		struct instruction *one;
-		struct instruction *br;
-		pseudo_t phi;
 
 		FOR_EACH_PTR_REVERSE(parent->insns, one) {
 			int dominance;
@@ -51,11 +49,7 @@ no_dominance:
 		continue;
 
 found_dominator:
-		br = delete_last_instruction(&parent->insns);
-		phi = alloc_phi(parent, one->target, one->type);
-		phi->ident = phi->ident ? : one->target->ident;
-		add_instruction(&parent->insns, br);
-		use_pseudo(insn, phi, add_pseudo(dominators, phi));
+		add_dominator(dominators, insn, one, NULL);
 	} END_FOR_EACH_PTR(parent);
 	return 1;
 }		
-- 
2.12.0

