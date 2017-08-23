From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 35/48] mem2reg: be clear that we're using a symbol/var
Date: Wed, 23 Aug 2017 22:15:41 +0200
Message-ID: <20170823201554.90551-36-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34631 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWURK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69so654604wmh.1
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:10 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mem2reg.c b/mem2reg.c
index dca409f5d..641a1f65d 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -107,16 +107,17 @@ found_dominator:
 }
 
 /*
- * pseudo: pseudo for a symbol
- * insn: is a load of the symbol 'pseudo'.
+ * sym: a symbol/variable
+ * insn: is a load of the symbol 'sym'.
  * local: is the symbol local or externally visible?
  */
-static int find_dominating_stores(pseudo_t pseudo, struct instruction *insn,
+static int find_dominating_stores(struct symbol *sym, struct instruction *insn,
 	unsigned long generation, int local)
 {
 	struct basic_block *bb = insn->bb;
 	struct instruction *one, *dom = NULL;
 	struct pseudo_list *dominators;
+	pseudo_t pseudo = sym->pseudo;
 	int partial;
 
 	/* Unreachable load? Undo it */
@@ -376,7 +377,7 @@ static void promote_symbol(struct entrypoint *ep, struct symbol *sym)
 	FOR_EACH_PTR_REVERSE(pseudo->users, pu) {
 		struct instruction *insn = pu->insn;
 		if (insn->opcode == OP_LOAD)
-			all &= find_dominating_stores(pseudo, insn, ++bb_generation, !mod);
+			all &= find_dominating_stores(sym, insn, ++bb_generation, !mod);
 	} END_FOR_EACH_PTR_REVERSE(pu);
 
 	/* If we converted all the loads, remove the stores. They are dead */
-- 
2.14.0

