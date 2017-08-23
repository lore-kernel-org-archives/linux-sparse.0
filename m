From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 44/48] mem2reg: don't check dominance by removed instructions
Date: Wed, 23 Aug 2017 22:15:50 +0200
Message-ID: <20170823201554.90551-45-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37391 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWUR2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id v186so633430wmf.4
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:28 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mem2reg.c b/mem2reg.c
index 5f1c968a0..493274df5 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -100,6 +100,8 @@ static int find_dominating_parents(struct symbol *sym, struct instruction *insn,
 
 		FOR_EACH_PTR_REVERSE(parent->insns, one) {
 			int dominance;
+			if (!one->bb)
+				continue;
 			if (one == insn)
 				goto no_dominance;
 			dominance = dominates(pseudo, insn, one, local);
@@ -180,6 +182,8 @@ static int find_dominating_stores(struct symbol *sym, struct instruction *insn,
 	partial = 0;
 	FOR_EACH_PTR(bb->insns, one) {
 		int dominance;
+		if (!one->bb)
+			continue;
 		if (one == insn)
 			goto found;
 		dominance = dominates(pseudo, insn, one, local);
@@ -250,6 +254,8 @@ static void kill_dead_stores(pseudo_t pseudo, unsigned long generation, struct b
 	FOR_EACH_PTR_REVERSE(bb->insns, insn) {
 		int opcode = insn->opcode;
 
+		if (!insn->bb)
+			continue;
 		if (opcode != OP_LOAD && opcode != OP_STORE) {
 			if (local)
 				continue;
-- 
2.14.0

