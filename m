From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 12/48] add insert_phi_node()
Date: Wed, 23 Aug 2017 22:15:18 +0200
Message-ID: <20170823201554.90551-13-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37082 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932443AbdHWUQY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id v186so630532wmf.4
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:24 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This helper is used later during the SSA construction and is,
as its name suggest, used to insert phi-nodes in the
instruction stream.

More exactly, the phi-node will be put at the begining of the
specified BB, just after the others phi-nodes but before
any other instructions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 22 ++++++++++++++++++++++
 linearize.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/linearize.c b/linearize.c
index 3ef65d585..4f4102af7 100644
--- a/linearize.c
+++ b/linearize.c
@@ -852,6 +852,28 @@ pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, struct symbol *t
 	return phi;
 }
 
+pseudo_t insert_phi_node(struct basic_block *bb, struct symbol *type)
+{
+	struct instruction *phi_node = alloc_typed_instruction(OP_PHI, type);
+	struct instruction *insn;
+	pseudo_t phi;
+
+	phi = alloc_pseudo(phi_node);
+	phi_node->target = phi;
+	phi_node->bb = bb;
+
+	FOR_EACH_PTR(bb->insns, insn) {
+		enum opcode op = insn->opcode;
+		if (op == OP_ENTRY || op == OP_PHI)
+			continue;
+		INSERT_CURRENT(phi_node, insn);
+		return phi;
+	} END_FOR_EACH_PTR(insn);
+
+	add_instruction(&bb->insns, phi_node);
+	return phi;
+}
+
 /*
  * We carry the "access_data" structure around for any accesses,
  * which simplifies things a lot. It contains all the access
diff --git a/linearize.h b/linearize.h
index 060d5f327..a67f5b3e7 100644
--- a/linearize.h
+++ b/linearize.h
@@ -332,6 +332,7 @@ struct entrypoint {
 extern void insert_select(struct basic_block *bb, struct instruction *br, struct instruction *phi, pseudo_t if_true, pseudo_t if_false);
 extern void insert_branch(struct basic_block *bb, struct instruction *br, struct basic_block *target);
 
+pseudo_t insert_phi_node(struct basic_block *bb, struct symbol *type);
 pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, struct symbol *type);
 pseudo_t alloc_pseudo(struct instruction *def);
 pseudo_t value_pseudo(long long val);
-- 
2.14.0

