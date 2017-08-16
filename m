From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 27/29] sssa: remove trivial phi-nodes
Date: Wed, 16 Aug 2017 17:34:53 +0200
Message-ID: <20170816153455.97693-28-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36835 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbdHPPf4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:56 -0400
Received: by mail-wr0-f196.google.com with SMTP id y67so3695630wrb.3
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:55 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

These trivial phi-nodes have all their sources but one
which are defined by the phi-node itself . This typically
arise if a var is presetn in a loop and only set in the
loop header.

In this case, the only possible value for the phi-node and
these sources is the value of the other unique source.
These phi-nodes can this easily be replaced by this value
avoiding firther unwanted processing.

This patch remove these trivial phi-nodes in most, simple
cases.

More complex cases need more complex method to get rid of them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ssa.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/ssa.c b/ssa.c
index 9d532dbf6..1b7f7cda3 100644
--- a/ssa.c
+++ b/ssa.c
@@ -16,6 +16,92 @@
 static pseudo_t load_var_(struct basic_block*, struct symbol*, unsigned long);
 
 
+static inline void concat_user_list(struct pseudo_user_list *src, struct pseudo_user_list **dst)
+{
+	concat_ptr_list((struct ptr_list *)src, (struct ptr_list **)dst);
+}
+
+/*
+ * Go through the "insn->users" list and replace them all..
+ */
+static void convert_phi(struct instruction *insn, pseudo_t src)
+{
+	pseudo_t phi = insn->target;
+	struct pseudo_user *pu;
+
+	assert(phi != src);
+	if (phi == src)
+		return;
+	FOR_EACH_PTR(phi->users, pu) {
+		pseudo_t *pp = pu->userp;
+		pseudo_t p = *pp;
+
+		if (p == VOID)
+			continue;
+		assert(p == phi);
+		if (p->def->src == phi)
+			continue;
+		*pu->userp = src;
+	} END_FOR_EACH_PTR(pu);
+	if (has_use_list(src))
+		concat_user_list(phi->users, &src->users);
+	phi->users = NULL;
+}
+
+static void kill_phi_node(struct instruction *node)
+{
+	struct pseudo_list *phi_list = node->phi_list;
+	pseudo_t phi;
+
+	node->phi_list = NULL;
+	node->bb = NULL;
+	FOR_EACH_PTR(phi_list, phi) {
+		struct instruction *phisrc;
+		if (phi == VOID)
+			continue;
+		phisrc = phi->def;
+		remove_use(&phisrc->src);
+		phisrc->bb = NULL;
+	} END_FOR_EACH_PTR(phi);
+	free_ptr_list(&node->phi_list);
+}
+
+static pseudo_t try_remove_trivial_phi(pseudo_t phi)
+{
+	struct instruction *node = phi->def;
+	pseudo_t same = NULL;
+	pseudo_t p;
+
+	if (phi == VOID)
+		return phi;
+	if (phi->type != PSEUDO_REG)
+		return phi;
+	if (node->opcode != OP_PHI)
+		return phi;
+	FOR_EACH_PTR(node->phi_list, p) {
+		pseudo_t src;
+
+		if (p == VOID)
+			continue;
+		src = p->def->src;
+		if (src == same || src == phi)
+			continue;
+		if (same)
+			return phi;
+		same = src;
+	} END_FOR_EACH_PTR(p);
+
+	if (same == NULL)
+		same = undef_pseudo();
+
+	convert_phi(node, same);
+	phi->target = same;
+	phi->type = PSEUDO_INDIR;
+	kill_phi_node(node);
+
+	return same;
+}
+
 // FIXME: -> common file
 static void append_instruction(struct basic_block *bb, struct instruction *insn)
 {
@@ -38,6 +124,7 @@ static pseudo_t add_phi_operand(struct symbol *var, pseudo_t phi, unsigned long
 		use_pseudo(node, src, add_pseudo(&node->phi_list, src));
 		src->ident = var->ident;
 	} END_FOR_EACH_PTR(parent);
+	phi = try_remove_trivial_phi(phi);
 	return phi;
 }
 
-- 
2.14.0

