From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 14/29] extract alloc_phisrc() from alloc_phi()
Date: Wed, 16 Aug 2017 17:34:40 +0200
Message-ID: <20170816153455.97693-15-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32856 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751642AbdHPPfe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:34 -0400
Received: by mail-wr0-f196.google.com with SMTP id n88so3697638wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:33 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This give us:
- a clearer name (than alloc_phi())
- more flexibility when we need the instruction and not the pseudo.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 26 ++++++++++++++++----------
 linearize.h |  1 +
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/linearize.c b/linearize.c
index 0af92a08e..1630810d4 100644
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

