From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 3/5] unssa: try to avoid some OP_PHI copies
Date: Mon, 12 Dec 2016 16:28:59 +0100
Message-ID: <20161212152901.24948-4-luc.vanoostenryck@gmail.com>
References: <20161212152901.24948-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35911 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932244AbcLLP3L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Dec 2016 10:29:11 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so11935242wma.3
        for <linux-sparse@vger.kernel.org>; Mon, 12 Dec 2016 07:29:10 -0800 (PST)
In-Reply-To: <20161212152901.24948-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

OP_PHI's target can interfer with it's own source swhen defined
in the same basic block. Such interference can create problem
like the 'swap problem' (which only exist if the phi-node are
'processed' sequentially if they're processed in parallel such
problems don't exist) when phi-nodes are destructed. To avoid
such problems OP_PHI are rewritten as OP_COPY.

if an OP_PHI and it's OP_PHISOURCE are in different basic blocks
no such interference is possible and the copy is not needed.

This patch detect such situation and eliminate these unneeded copies.

Note: during unSSA we're removing the OP_PHI & OP_PHISOURCE
  but we need to use the def-use chains between them. We must
  thus not use kill_instruction() in OP_PHI (this would break
  def-use chains and leave stray OP_PHISOURCE), it's enough
  to set their bb to NULL.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 unssa.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/unssa.c b/unssa.c
index 2660e94c..50782352 100644
--- a/unssa.c
+++ b/unssa.c
@@ -30,6 +30,32 @@
 #include <assert.h>
 
 
+static int simplify_phi_node(struct instruction *phi, pseudo_t tmp)
+{
+	pseudo_t target = phi->target;
+	struct pseudo_user *pu;
+	pseudo_t src;
+
+	// verify if this phi can be simplified
+	FOR_EACH_PTR(phi->phi_list, src) {
+		struct instruction *def = src->def;
+
+		if (!def)
+			continue;
+		if (def->bb == phi->bb)
+			return 0;
+	} END_FOR_EACH_PTR(src);
+
+	// no need to make a copy of this one
+	// -> replace the target pseudo by the tmp
+	FOR_EACH_PTR(target->users, pu) {
+		use_pseudo(pu->insn, tmp, pu->userp);
+	} END_FOR_EACH_PTR(pu);
+
+	phi->bb = NULL;
+	return 1;
+}
+
 static void replace_phi_node(struct instruction *phi)
 {
 	pseudo_t tmp;
@@ -40,6 +66,9 @@ static void replace_phi_node(struct instruction *phi)
 	tmp->ident = phi->target->ident;
 	tmp->def = NULL;		// defined by all the phisrc
 
+	// can we avoid to make of copy?
+	simplify_phi_node(phi, tmp);
+
 	// rewrite all it's phi_src to copy to a new tmp
 	FOR_EACH_PTR(phi->phi_list, p) {
 		struct instruction *def = p->def;
@@ -53,6 +82,9 @@ static void replace_phi_node(struct instruction *phi)
 		def->target = tmp;
 	} END_FOR_EACH_PTR(p);
 
+	if (!phi->bb)
+		return;
+
 	// rewrite the phi node:
 	//	phi	%rt, ...
 	// to:
-- 
2.10.2

