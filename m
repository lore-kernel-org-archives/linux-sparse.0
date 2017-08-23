From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 38/48] mem2reg: let rewrite_load_instruction() take the symbol as arg
Date: Wed, 23 Aug 2017 22:15:44 +0200
Message-ID: <20170823201554.90551-39-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37337 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWURR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id v186so633016wmf.4
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:17 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mem2reg.c b/mem2reg.c
index 0078485da..4ba0f3408 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -12,7 +12,7 @@
  * We should probably sort the phi list just to make it easier to compare
  * later for equality.
  */
-static void rewrite_load_instruction(struct instruction *insn, struct pseudo_list *dominators)
+static void rewrite_load_instruction(struct symbol *sym, struct instruction *insn, struct pseudo_list *dominators)
 {
 	pseudo_t new, phi;
 
@@ -24,7 +24,7 @@ static void rewrite_load_instruction(struct instruction *insn, struct pseudo_lis
 	FOR_EACH_PTR(dominators, phi) {
 		if (new != phi->def->src1)
 			goto complex_phi;
-		new->ident = new->ident ? : phi->ident;
+		new->ident = new->ident ? : sym->ident;
 	} END_FOR_EACH_PTR(phi);
 
 	/*
@@ -190,7 +190,7 @@ found:
 	 * have to turn the load into a phi-node of the
 	 * dominators.
 	 */
-	rewrite_load_instruction(insn, dominators);
+	rewrite_load_instruction(sym, insn, dominators);
 	return 1;
 }
 
-- 
2.14.0

