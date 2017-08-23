From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 36/48] mem2reg: be clear that we're using a symbol/var here too
Date: Wed, 23 Aug 2017 22:15:42 +0200
Message-ID: <20170823201554.90551-37-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34637 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWURL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69so654653wmh.1
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:11 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mem2reg.c b/mem2reg.c
index 641a1f65d..793a1d730 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -57,10 +57,11 @@ static int phisrc_in_bb(struct pseudo_list *list, struct basic_block *bb)
 	return 0;
 }
 
-static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
+static int find_dominating_parents(struct symbol *sym, struct instruction *insn,
 	struct basic_block *bb, unsigned long generation, struct pseudo_list **dominators,
 	int local)
 {
+	pseudo_t pseudo = sym->pseudo;
 	struct basic_block *parent;
 
 	if (!bb->parents)
@@ -90,7 +91,7 @@ no_dominance:
 			continue;
 		parent->generation = generation;
 
-		if (!find_dominating_parents(pseudo, insn, parent, generation, dominators, local))
+		if (!find_dominating_parents(sym, insn, parent, generation, dominators, local))
 			return 0;
 		continue;
 
@@ -161,7 +162,7 @@ found:
 	bb->generation = generation;
 
 	dominators = NULL;
-	if (!find_dominating_parents(pseudo, insn, bb, generation, &dominators, local))
+	if (!find_dominating_parents(sym, insn, bb, generation, &dominators, local))
 		return 0;
 
 	/* This happens with initial assignments to structures etc.. */
-- 
2.14.0

