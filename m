From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 34/48] mem2reg: move rewrite_load_instruction() here
Date: Wed, 23 Aug 2017 22:15:40 +0200
Message-ID: <20170823201554.90551-35-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32812 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWURI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id b79so663706wmf.0
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:08 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 flow.c    | 38 --------------------------------------
 flow.h    |  1 -
 mem2reg.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/flow.c b/flow.c
index 58ff24d23..78445713c 100644
--- a/flow.c
+++ b/flow.c
@@ -362,44 +362,6 @@ int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom
 	return 1;
 }
 
-/*
- * We should probably sort the phi list just to make it easier to compare
- * later for equality. 
- */
-void rewrite_load_instruction(struct instruction *insn, struct pseudo_list *dominators)
-{
-	pseudo_t new, phi;
-
-	/*
-	 * Check for somewhat common case of duplicate
-	 * phi nodes.
-	 */
-	new = first_pseudo(dominators)->def->src1;
-	FOR_EACH_PTR(dominators, phi) {
-		if (new != phi->def->src1)
-			goto complex_phi;
-		new->ident = new->ident ? : phi->ident;
-	} END_FOR_EACH_PTR(phi);
-
-	/*
-	 * All the same pseudo - mark the phi-nodes unused
-	 * and convert the load into a LNOP and replace the
-	 * pseudo.
-	 */
-	FOR_EACH_PTR(dominators, phi) {
-		kill_instruction(phi->def);
-	} END_FOR_EACH_PTR(phi);
-	convert_load_instruction(insn, new);
-	return;
-
-complex_phi:
-	/* We leave symbol pseudos with a bogus usage list here */
-	if (insn->src->type != PSEUDO_SYM)
-		kill_use(&insn->src);
-	insn->opcode = OP_PHI;
-	insn->phi_list = dominators;
-}
-
 void check_access(struct instruction *insn)
 {
 	pseudo_t pseudo = insn->src;
diff --git a/flow.h b/flow.h
index b9fc13723..d14987027 100644
--- a/flow.h
+++ b/flow.h
@@ -39,7 +39,6 @@ static inline void kill_instruction_force(struct instruction *insn)
 
 void check_access(struct instruction *insn);
 void convert_load_instruction(struct instruction *, pseudo_t);
-void rewrite_load_instruction(struct instruction *, struct pseudo_list *);
 int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom, int local);
 
 extern void clear_liveness(struct entrypoint *ep);
diff --git a/mem2reg.c b/mem2reg.c
index c2f77ffbe..dca409f5d 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -8,6 +8,44 @@
 #include "flow.h"
 
 
+/*
+ * We should probably sort the phi list just to make it easier to compare
+ * later for equality.
+ */
+static void rewrite_load_instruction(struct instruction *insn, struct pseudo_list *dominators)
+{
+	pseudo_t new, phi;
+
+	/*
+	 * Check for somewhat common case of duplicate
+	 * phi nodes.
+	 */
+	new = first_pseudo(dominators)->def->src1;
+	FOR_EACH_PTR(dominators, phi) {
+		if (new != phi->def->src1)
+			goto complex_phi;
+		new->ident = new->ident ? : phi->ident;
+	} END_FOR_EACH_PTR(phi);
+
+	/*
+	 * All the same pseudo - mark the phi-nodes unused
+	 * and convert the load into a LNOP and replace the
+	 * pseudo.
+	 */
+	FOR_EACH_PTR(dominators, phi) {
+		kill_instruction(phi->def);
+	} END_FOR_EACH_PTR(phi);
+	convert_load_instruction(insn, new);
+	return;
+
+complex_phi:
+	/* We leave symbol pseudos with a bogus usage list here */
+	if (insn->src->type != PSEUDO_SYM)
+		kill_use(&insn->src);
+	insn->opcode = OP_PHI;
+	insn->phi_list = dominators;
+}
+
 static int phisrc_in_bb(struct pseudo_list *list, struct basic_block *bb)
 {
 	pseudo_t p;
-- 
2.14.0

