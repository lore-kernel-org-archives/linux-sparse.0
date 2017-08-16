From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 25/29] sssa: reorg load_var()
Date: Wed, 16 Aug 2017 17:34:51 +0200
Message-ID: <20170816153455.97693-26-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34199 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbdHPPfw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:52 -0400
Received: by mail-wr0-f195.google.com with SMTP id x43so3699116wrb.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:52 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

No functional changes here. Only shuffling some code
arround to make the next patch more readable.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ssa.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/ssa.c b/ssa.c
index 10279a602..7950ffeaf 100644
--- a/ssa.c
+++ b/ssa.c
@@ -13,6 +13,9 @@
 #include <assert.h>
 
 
+static pseudo_t load_var_(struct basic_block*, struct symbol*);
+
+
 // FIXME: -> common file
 static void append_instruction(struct basic_block *bb, struct instruction *insn)
 {
@@ -28,7 +31,7 @@ static pseudo_t add_phi_operand(struct symbol *var, pseudo_t phi)
 	struct basic_block *parent;
 
 	FOR_EACH_PTR(node->bb->parents, parent) {
-		pseudo_t val = load_var(parent, var);
+		pseudo_t val = load_var_(parent, var);
 		struct instruction *phisrc = alloc_phisrc(val, var);
 		pseudo_t src = phisrc->target;
 		append_instruction(parent, phisrc);
@@ -38,9 +41,15 @@ static pseudo_t add_phi_operand(struct symbol *var, pseudo_t phi)
 	return phi;
 }
 
-static pseudo_t load_var_parents(struct basic_block *bb, struct symbol *var)
+static pseudo_t load_var_(struct basic_block *bb, struct symbol *var)
 {
-	pseudo_t val;
+	pseudo_t val = phi_map_lookup(var->phi_map, bb);
+
+	if (val) {
+		while (val->type == PSEUDO_INDIR)
+			val = val->target;
+		return val;
+	}
 
 	if (!bb->sealed) {	// incomplete CFG
 		val = insert_phi_node(bb, var);
@@ -54,7 +63,7 @@ static pseudo_t load_var_parents(struct basic_block *bb, struct symbol *var)
 		val = undef_pseudo();
 		break;
 	case 1: // no phi needed
-		val = load_var(first_basic_block(bb->parents), var);
+		val = load_var_(first_basic_block(bb->parents), var);
 		break;
 	default:
 		val = insert_phi_node(bb, var);
@@ -64,18 +73,14 @@ static pseudo_t load_var_parents(struct basic_block *bb, struct symbol *var)
 	}
 
 out:
+	assert(val->type != PSEUDO_INDIR);
 	store_var(bb, var, val);
 	return val;
 }
 
 pseudo_t load_var(struct basic_block *bb, struct symbol *var)
 {
-	pseudo_t val = phi_map_lookup(var->phi_map, bb);
-	if (!val)
-		val = load_var_parents(bb, var);
-	while (val->type == PSEUDO_INDIR)
-		val = val->target;
-	return val;
+	return load_var_(bb, var);
 }
 
 void store_var(struct basic_block *bb, struct symbol *var, pseudo_t val)
-- 
2.14.0

