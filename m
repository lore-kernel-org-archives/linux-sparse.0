From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] remove unused arg in uses/defs functions
Date: Thu,  8 Dec 2016 04:46:18 +0100
Message-ID: <20161208034618.7910-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33621 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932872AbcLHEA5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 23:00:57 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so814048wmu.0
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 20:00:56 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In the liveness analysis, the use/def methods have a
'struct instruction *' argument.
This arg is never used and it's not clear for what it
could be used, what it would represent.

This patch remove this argument from all the concerned
functions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 liveness.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/liveness.c b/liveness.c
index fb696720..2e513943 100644
--- a/liveness.c
+++ b/liveness.c
@@ -13,7 +13,7 @@
 #include "flow.h"
 
 static void phi_defines(struct instruction * phi_node, pseudo_t target,
-	void (*defines)(struct basic_block *, struct instruction *, pseudo_t))
+	void (*defines)(struct basic_block *, pseudo_t))
 {
 	pseudo_t phi;
 	FOR_EACH_PTR(phi_node->phi_list, phi) {
@@ -23,33 +23,33 @@ static void phi_defines(struct instruction * phi_node, pseudo_t target,
 		def = phi->def;
 		if (!def || !def->bb)
 			continue;
-		defines(def->bb, phi->def, target);
+		defines(def->bb, target);
 	} END_FOR_EACH_PTR(phi);
 }
 
 static void asm_liveness(struct basic_block *bb, struct instruction *insn,
-	void (*def)(struct basic_block *, struct instruction *, pseudo_t),
-	void (*use)(struct basic_block *, struct instruction *, pseudo_t))
+	void (*def)(struct basic_block *, pseudo_t),
+	void (*use)(struct basic_block *, pseudo_t))
 {
 	struct asm_constraint *entry;
 
 	FOR_EACH_PTR(insn->asm_rules->inputs, entry) {
-		use(bb, insn, entry->pseudo);
+		use(bb, entry->pseudo);
 	} END_FOR_EACH_PTR(entry);
 		
 	FOR_EACH_PTR(insn->asm_rules->outputs, entry) {
-		def(bb, insn, entry->pseudo);
+		def(bb, entry->pseudo);
 	} END_FOR_EACH_PTR(entry);
 }
 
 static void track_instruction_usage(struct basic_block *bb, struct instruction *insn,
-	void (*def)(struct basic_block *, struct instruction *, pseudo_t),
-	void (*use)(struct basic_block *, struct instruction *, pseudo_t))
+	void (*def)(struct basic_block *, pseudo_t),
+	void (*use)(struct basic_block *, pseudo_t))
 {
 	pseudo_t pseudo;
 
-	#define USES(x)		use(bb, insn, insn->x)
-	#define DEFINES(x)	def(bb, insn, insn->x)
+	#define USES(x)		use(bb, insn->x)
+	#define DEFINES(x)	def(bb, insn->x)
 
 	switch (insn->opcode) {
 	case OP_RET:
@@ -122,7 +122,7 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 		if (insn->target != VOID)
 			DEFINES(target);
 		FOR_EACH_PTR(insn->arguments, pseudo) {
-			use(bb, insn, pseudo);
+			use(bb, pseudo);
 		} END_FOR_EACH_PTR(pseudo);
 		break;
 
@@ -180,7 +180,7 @@ static inline int trackable_pseudo(pseudo_t pseudo)
 	return pseudo && (pseudo->type == PSEUDO_REG || pseudo->type == PSEUDO_ARG);
 }
 
-static void insn_uses(struct basic_block *bb, struct instruction *insn, pseudo_t pseudo)
+static void insn_uses(struct basic_block *bb, pseudo_t pseudo)
 {
 	if (trackable_pseudo(pseudo)) {
 		struct instruction *def = pseudo->def;
@@ -189,7 +189,7 @@ static void insn_uses(struct basic_block *bb, struct instruction *insn, pseudo_t
 	}
 }
 
-static void insn_defines(struct basic_block *bb, struct instruction *insn, pseudo_t pseudo)
+static void insn_defines(struct basic_block *bb, pseudo_t pseudo)
 {
 	assert(trackable_pseudo(pseudo));
 	add_pseudo(&bb->defines, pseudo);
@@ -300,11 +300,11 @@ static void track_bb_phi_uses(struct basic_block *bb)
 static struct pseudo_list **live_list;
 static struct pseudo_list *dead_list;
 
-static void death_def(struct basic_block *bb, struct instruction *insn, pseudo_t pseudo)
+static void death_def(struct basic_block *bb, pseudo_t pseudo)
 {
 }
 
-static void death_use(struct basic_block *bb, struct instruction *insn, pseudo_t pseudo)
+static void death_use(struct basic_block *bb, pseudo_t pseudo)
 {
 	if (trackable_pseudo(pseudo) && !pseudo_in_list(*live_list, pseudo)) {
 		add_pseudo(&dead_list, pseudo);
-- 
2.10.2

