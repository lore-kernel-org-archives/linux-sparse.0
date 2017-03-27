From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 11/15] give a type to OP_PHISOURCEs
Date: Mon, 27 Mar 2017 19:34:01 +0200
Message-ID: <20170327173405.11405-12-luc.vanoostenryck@gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34711 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbdC0RhN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 13:37:13 -0400
Received: by mail-wr0-f196.google.com with SMTP id w43so12463429wrb.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 10:36:25 -0700 (PDT)
In-Reply-To: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, OP_PHISOURCEs are given a size but not a type.

For consistency and for sparse-LLVM which need it,
give them a type too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c      |  2 +-
 linearize.c | 16 +++++++---------
 linearize.h |  2 +-
 memops.c    |  2 +-
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/flow.c b/flow.c
index 04ef8cd1d..45bae773e 100644
--- a/flow.c
+++ b/flow.c
@@ -404,7 +404,7 @@ found_dominator:
 		if (dominators && phisrc_in_bb(*dominators, parent))
 			continue;
 		br = delete_last_instruction(&parent->insns);
-		phi = alloc_phi(parent, one->target, one->size);
+		phi = alloc_phi(parent, one->target, one->type);
 		phi->ident = phi->ident ? : pseudo->ident;
 		add_instruction(&parent->insns, br);
 		use_pseudo(insn, phi, add_pseudo(dominators, phi));
diff --git a/linearize.c b/linearize.c
index d4610de8f..4b6483efa 100644
--- a/linearize.c
+++ b/linearize.c
@@ -824,9 +824,9 @@ static pseudo_t argument_pseudo(struct entrypoint *ep, int nr)
 	return pseudo;
 }
 
-pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, int size)
+pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, struct symbol *type)
 {
-	struct instruction *insn = alloc_instruction(OP_PHISOURCE, size);
+	struct instruction *insn = alloc_typed_instruction(OP_PHISOURCE, type);
 	pseudo_t phi = __alloc_pseudo(0);
 	static int nr = 0;
 
@@ -1380,19 +1380,18 @@ static pseudo_t linearize_short_conditional(struct entrypoint *ep, struct expres
 	struct basic_block *bb_false;
 	struct basic_block *merge = alloc_basic_block(ep, expr->pos);
 	pseudo_t phi1, phi2;
-	int size = type_size(expr->ctype);
 
 	if (!expr_false || !ep->active)
 		return VOID;
 
 	bb_false = alloc_basic_block(ep, expr_false->pos);
 	src1 = linearize_expression(ep, cond);
-	phi1 = alloc_phi(ep->active, src1, size);
+	phi1 = alloc_phi(ep->active, src1, expr->ctype);
 	add_branch(ep, expr, src1, merge, bb_false);
 
 	set_activeblock(ep, bb_false);
 	src2 = linearize_expression(ep, expr_false);
-	phi2 = alloc_phi(ep->active, src2, size);
+	phi2 = alloc_phi(ep->active, src2, expr->ctype);
 	set_activeblock(ep, merge);
 
 	return add_join_conditional(ep, expr, phi1, phi2);
@@ -1406,7 +1405,6 @@ static pseudo_t linearize_conditional(struct entrypoint *ep, struct expression *
 	pseudo_t src1, src2;
 	pseudo_t phi1, phi2;
 	struct basic_block *bb_true, *bb_false, *merge;
-	int size = type_size(expr->ctype);
 
 	if (!cond || !expr_true || !expr_false || !ep->active)
 		return VOID;
@@ -1418,12 +1416,12 @@ static pseudo_t linearize_conditional(struct entrypoint *ep, struct expression *
 
 	set_activeblock(ep, bb_true);
 	src1 = linearize_expression(ep, expr_true);
-	phi1 = alloc_phi(ep->active, src1, size);
+	phi1 = alloc_phi(ep->active, src1, expr->ctype);
 	add_goto(ep, merge); 
 
 	set_activeblock(ep, bb_false);
 	src2 = linearize_expression(ep, expr_false);
-	phi2 = alloc_phi(ep->active, src2, size);
+	phi2 = alloc_phi(ep->active, src2, expr->ctype);
 	set_activeblock(ep, merge);
 
 	return add_join_conditional(ep, expr, phi1, phi2);
@@ -1905,7 +1903,7 @@ static pseudo_t linearize_return(struct entrypoint *ep, struct statement *stmt)
 			phi_node->bb = bb_return;
 			add_instruction(&bb_return->insns, phi_node);
 		}
-		phi = alloc_phi(active, src, type_size(expr->ctype));
+		phi = alloc_phi(active, src, expr->ctype);
 		phi->ident = &return_ident;
 		use_pseudo(phi_node, phi, add_pseudo(&phi_node->phi_list, phi));
 	}
diff --git a/linearize.h b/linearize.h
index 0d27012aa..0a70d8129 100644
--- a/linearize.h
+++ b/linearize.h
@@ -342,7 +342,7 @@ struct entrypoint {
 extern void insert_select(struct basic_block *bb, struct instruction *br, struct instruction *phi, pseudo_t if_true, pseudo_t if_false);
 extern void insert_branch(struct basic_block *bb, struct instruction *br, struct basic_block *target);
 
-pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, int size);
+pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, struct symbol *type);
 pseudo_t alloc_pseudo(struct instruction *def);
 pseudo_t value_pseudo(long long val);
 
diff --git a/memops.c b/memops.c
index 5efdd6f2d..187a63284 100644
--- a/memops.c
+++ b/memops.c
@@ -52,7 +52,7 @@ no_dominance:
 
 found_dominator:
 		br = delete_last_instruction(&parent->insns);
-		phi = alloc_phi(parent, one->target, one->size);
+		phi = alloc_phi(parent, one->target, one->type);
 		phi->ident = phi->ident ? : one->target->ident;
 		add_instruction(&parent->insns, br);
 		use_pseudo(insn, phi, add_pseudo(dominators, phi));
-- 
2.12.0

