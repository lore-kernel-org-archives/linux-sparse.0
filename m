From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 22/29] sssa: add seal_gotos() needed to seal BBs targeted by gotos
Date: Wed, 16 Aug 2017 17:34:48 +0200
Message-ID: <20170816153455.97693-23-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37140 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbdHPPfr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:47 -0400
Received: by mail-wr0-f195.google.com with SMTP id z91so651499wrc.4
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:47 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The paper for the new SSA construction nicely leave the question
of GOTOs as en exercice for the student.

This patch is such an exercice.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h |  1 +
 ssa.c       | 20 +++++++++++++++++++-
 ssa.h       |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/linearize.h b/linearize.h
index 30f34aa8f..eba0323d0 100644
--- a/linearize.h
+++ b/linearize.h
@@ -237,6 +237,7 @@ struct basic_block {
 	union {
 		struct {		// SSA construction
 			unsigned int sealed:1;
+			unsigned int unsealable:1;
 		};
 		struct {		// liveness
 			struct pseudo_list *needs, *defines;
diff --git a/ssa.c b/ssa.c
index 32e440669..d8fa32d93 100644
--- a/ssa.c
+++ b/ssa.c
@@ -81,7 +81,7 @@ void store_var(struct basic_block *bb, struct symbol *var, pseudo_t val)
 void seal_bb(struct basic_block *bb)
 {
 	struct instruction *insn;
-	if (bb->sealed)
+	if (bb->sealed || bb->unsealable)
 		return;
 	FOR_EACH_PTR(bb->insns, insn) {
 		struct symbol *var;
@@ -96,3 +96,21 @@ void seal_bb(struct basic_block *bb)
 	} END_FOR_EACH_PTR(insn);
 	bb->sealed = 1;
 }
+
+void seal_gotos(struct entrypoint *ep)
+{
+	struct basic_block *bb;
+
+	FOR_EACH_PTR(ep->bbs, bb) {
+		if (bb->sealed)
+			continue;
+		if (bb->unsealable)
+			bb->unsealable = 0;
+		seal_bb(bb);
+	} END_FOR_EACH_PTR(bb);
+
+	// cleanup these fields as they are aliased to ::needs & ::defines
+	FOR_EACH_PTR(ep->bbs, bb) {
+		bb->sealed = bb->unsealable = 0;
+	} END_FOR_EACH_PTR(bb);
+}
diff --git a/ssa.h b/ssa.h
index 484c2b418..e88b857b5 100644
--- a/ssa.h
+++ b/ssa.h
@@ -7,5 +7,6 @@
 pseudo_t load_var(struct basic_block *bb, struct symbol *var);
 void store_var(struct basic_block *bb, struct symbol *var, pseudo_t val);
 void seal_bb(struct basic_block *bb);
+void seal_gotos(struct entrypoint *ep);
 
 #endif
-- 
2.14.0

