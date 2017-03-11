From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 01/27] give a type to OP_PHISOURCE
Date: Sat, 11 Mar 2017 10:06:40 +0100
Message-ID: <20170311090706.17171-2-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33042 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbdCKJHW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:22 -0500
Received: by mail-wm0-f65.google.com with SMTP id n11so2314476wma.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:21 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, OP_PHISOURCEs are given a size but not a type.

There is no good reasons for that and it complicates
further correct processing or makes it impossible.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c      |  2 +-
 linearize.c | 16 +++++++---------
 linearize.h |  2 +-
 memops.c    |  2 +-
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/flow.c b/flow.c
index a5332203f..8111e1ae6 100644
--- a/flow.c
+++ b/flow.c
@@ -370,7 +370,7 @@ found_dominator:
 		if (dominators && phisrc_in_bb(*dominators, parent))
 			continue;
 		br = delete_last_instruction(&parent->insns);
-		phi = alloc_phi(parent, one->target, one->size);
+		phi = alloc_phi(parent, one->target, one->type);
 		phi->ident = phi->ident ? : pseudo->ident;
 		add_instruction(&parent->insns, br);
 		use_pseudo(insn, phi, add_pseudo(dominators, phi));
diff --git a/linearize.c b/linearize.c
index 5199b6b02..3a9c8f2e2 100644
--- a/linearize.c
+++ b/linearize.c
@@ -815,9 +815,9 @@ static pseudo_t argument_pseudo(struct entrypoint *ep, int nr)
 	return pseudo;
 }
 
-pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, int size)
+pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, struct symbol *type)
 {
-	struct instruction *insn = alloc_instruction(OP_PHISOURCE, size);
+	struct instruction *insn = alloc_typed_instruction(OP_PHISOURCE, type);
 	pseudo_t phi = __alloc_pseudo(0);
 	static int nr = 0;
 
@@ -1350,19 +1350,18 @@ static pseudo_t linearize_short_conditional(struct entrypoint *ep, struct expres
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
@@ -1376,7 +1375,6 @@ static pseudo_t linearize_conditional(struct entrypoint *ep, struct expression *
 	pseudo_t src1, src2;
 	pseudo_t phi1, phi2;
 	struct basic_block *bb_true, *bb_false, *merge;
-	int size = type_size(expr->ctype);
 
 	if (!cond || !expr_true || !expr_false || !ep->active)
 		return VOID;
@@ -1388,12 +1386,12 @@ static pseudo_t linearize_conditional(struct entrypoint *ep, struct expression *
 
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
@@ -1875,7 +1873,7 @@ static pseudo_t linearize_return(struct entrypoint *ep, struct statement *stmt)
 			phi_node->bb = bb_return;
 			add_instruction(&bb_return->insns, phi_node);
 		}
-		phi = alloc_phi(active, src, type_size(expr->ctype));
+		phi = alloc_phi(active, src, expr->ctype);
 		phi->ident = &return_ident;
 		use_pseudo(phi_node, phi, add_pseudo(&phi_node->phi_list, phi));
 	}
diff --git a/linearize.h b/linearize.h
index bac82d7ff..c03940eea 100644
--- a/linearize.h
+++ b/linearize.h
@@ -331,7 +331,7 @@ struct entrypoint {
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
2.11.1

