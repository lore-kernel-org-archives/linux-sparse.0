From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 13/48] extract alloc_phisrc() from alloc_phi()
Date: Wed, 23 Aug 2017 22:15:19 +0200
Message-ID: <20170823201554.90551-14-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37090 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932443AbdHWUQ0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id v186so630590wmf.4
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:26 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This give us:
- a clearer name (than alloc_phi())
- more flexibility when we need the instruction and not the pseudo.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 26 ++++++++++++++++----------
 linearize.h |  1 +
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/linearize.c b/linearize.c
index 4f4102af7..6cf97a42e 100644
--- a/linearize.c
+++ b/linearize.c
@@ -830,26 +830,32 @@ pseudo_t undef_pseudo(void)
 	return pseudo;
 }
 
-pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, struct symbol *type)
+struct instruction *alloc_phisrc(pseudo_t pseudo, struct symbol *type)
 {
-	struct instruction *insn;
-	pseudo_t phi;
+	struct instruction *insn = alloc_typed_instruction(OP_PHISOURCE, type);
+	pseudo_t phi = __alloc_pseudo(0);
 	static int nr = 0;
 
-	if (!source)
-		return VOID;
-
-	insn = alloc_typed_instruction(OP_PHISOURCE, type);
-	phi = __alloc_pseudo(0);
 	phi->type = PSEUDO_PHI;
 	phi->nr = ++nr;
 	phi->def = insn;
 
 	use_pseudo(insn, pseudo, &insn->phi_src);
-	insn->bb = source;
 	insn->target = phi;
+	return insn;
+}
+
+pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, struct symbol *type)
+{
+	struct instruction *insn;
+
+	if (!source)
+		return VOID;
+
+	insn = alloc_phisrc(pseudo, type);
+	insn->bb = source;
 	add_instruction(&source->insns, insn);
-	return phi;
+	return insn->target;
 }
 
 pseudo_t insert_phi_node(struct basic_block *bb, struct symbol *type)
diff --git a/linearize.h b/linearize.h
index a67f5b3e7..a550035d3 100644
--- a/linearize.h
+++ b/linearize.h
@@ -332,6 +332,7 @@ struct entrypoint {
 extern void insert_select(struct basic_block *bb, struct instruction *br, struct instruction *phi, pseudo_t if_true, pseudo_t if_false);
 extern void insert_branch(struct basic_block *bb, struct instruction *br, struct basic_block *target);
 
+struct instruction *alloc_phisrc(pseudo_t pseudo, struct symbol *type);
 pseudo_t insert_phi_node(struct basic_block *bb, struct symbol *type);
 pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, struct symbol *type);
 pseudo_t alloc_pseudo(struct instruction *def);
-- 
2.14.0

