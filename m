From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 27/48] mem2reg: extract kill_pseudo_stores()
Date: Wed, 23 Aug 2017 22:15:33 +0200
Message-ID: <20170823201554.90551-28-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33764 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWUQx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id b79so663167wmf.0
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:52 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mem2reg.c b/mem2reg.c
index 7096a4bf2..4671d4710 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -148,6 +148,17 @@ static void kill_store(struct instruction *insn)
 	}
 }
 
+static void kill_pseudo_stores(pseudo_t pseudo)
+{
+	struct pseudo_user *pu;
+
+	FOR_EACH_PTR(pseudo->users, pu) {
+		struct instruction *insn = pu->insn;
+		if (insn->opcode == OP_STORE)
+			kill_store(insn);
+	} END_FOR_EACH_PTR(pu);
+}
+
 /* Kill a pseudo that is dead on exit from the bb */
 static void kill_dead_stores(pseudo_t pseudo, unsigned long generation, struct basic_block *bb, int local)
 {
@@ -307,11 +318,7 @@ static void promote_symbol(struct entrypoint *ep, struct symbol *sym)
 
 	/* If we converted all the loads, remove the stores. They are dead */
 	if (all && !mod) {
-		FOR_EACH_PTR(pseudo->users, pu) {
-			struct instruction *insn = pu->insn;
-			if (insn->opcode == OP_STORE)
-				kill_store(insn);
-		} END_FOR_EACH_PTR(pu);
+		return kill_pseudo_stores(pseudo);
 	} else {
 		/*
 		 * If we couldn't take the shortcut, see if we can at least kill some
-- 
2.14.0

