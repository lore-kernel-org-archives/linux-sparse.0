From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 28/48] mem2reg: extract kill_pseudo_dominated_stores()
Date: Wed, 23 Aug 2017 22:15:34 +0200
Message-ID: <20170823201554.90551-29-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34858 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWUQz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id x79so649187wma.2
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:54 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mem2reg.c b/mem2reg.c
index 4671d4710..d13af1dd2 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -251,6 +251,17 @@ static void kill_dominated_stores(pseudo_t pseudo, struct instruction *insn,
 	} END_FOR_EACH_PTR(parent);
 }
 
+static void kill_pseudo_dominated_stores(pseudo_t pseudo, int local)
+{
+	struct pseudo_user *pu;
+
+	FOR_EACH_PTR(pseudo->users, pu) {
+		struct instruction *insn = pu->insn;
+		if (insn->opcode == OP_STORE)
+			kill_dominated_stores(pseudo, insn, ++bb_generation, insn->bb, local, 0);
+	} END_FOR_EACH_PTR(pu);
+}
+
 
 static unsigned long externaly_visible(struct symbol *sym, unsigned long mod)
 {
@@ -324,11 +335,7 @@ static void promote_symbol(struct entrypoint *ep, struct symbol *sym)
 		 * If we couldn't take the shortcut, see if we can at least kill some
 		 * of them..
 		 */
-		FOR_EACH_PTR(pseudo->users, pu) {
-			struct instruction *insn = pu->insn;
-			if (insn->opcode == OP_STORE)
-				kill_dominated_stores(pseudo, insn, ++bb_generation, insn->bb, !mod, 0);
-		} END_FOR_EACH_PTR(pu);
+		kill_pseudo_dominated_stores(pseudo, !mod);
 
 		if (!(mod & (MOD_NONLOCAL | MOD_STATIC))) {
 			struct basic_block *bb;
-- 
2.14.0

