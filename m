From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 23/29] sssa: set var's ident
Date: Wed, 16 Aug 2017 17:34:49 +0200
Message-ID: <20170816153455.97693-24-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37145 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbdHPPfs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:48 -0400
Received: by mail-wr0-f196.google.com with SMTP id z91so651557wrc.4
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:48 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

With this new method it's easier to assign an indent
to each phi-nodes.

THis patch has to simply assign the variable's ident to
the corresponding phi-node's pseudo.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ssa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ssa.c b/ssa.c
index d8fa32d93..e50fae0cc 100644
--- a/ssa.c
+++ b/ssa.c
@@ -33,6 +33,7 @@ static pseudo_t add_phi_operand(struct symbol *var, pseudo_t phi)
 		pseudo_t src = phisrc->target;
 		append_instruction(parent, phisrc);
 		use_pseudo(node, src, add_pseudo(&node->phi_list, src));
+		src->ident = var->ident;
 	} END_FOR_EACH_PTR(parent);
 	return phi;
 }
@@ -44,6 +45,7 @@ static pseudo_t load_var_parents(struct basic_block *bb, struct symbol *var)
 	if (!bb->sealed) {	// incomplete CFG
 		val = insert_phi_node(bb, var);
 		val->def->var = var;
+		val->ident = var->ident;
 		goto out;
 	}
 
@@ -56,6 +58,7 @@ static pseudo_t load_var_parents(struct basic_block *bb, struct symbol *var)
 		break;
 	default:
 		val = insert_phi_node(bb, var);
+		val->ident = var->ident;
 		store_var(bb, var, val);
 		val = add_phi_operand(var, val);
 	}
-- 
2.14.0

