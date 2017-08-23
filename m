From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 43/48] mem2reg: get recursion right
Date: Wed, 23 Aug 2017 22:15:49 +0200
Message-ID: <20170823201554.90551-44-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35005 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWUR1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id x79so650368wma.2
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:26 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c                       | 71 ++++++++++++++++++++++++-----------------
 validation/loop-linearization.c |  4 +--
 2 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/mem2reg.c b/mem2reg.c
index e27739701..5f1c968a0 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -70,6 +70,10 @@ complex_phi:
 	return new;
 }
 
+
+static pseudo_t find_dominating_value(struct symbol *sym, struct instruction *insn,
+	struct basic_block *bb, unsigned long generation, int local);
+
 /*
  * sym - the symbol/var we're looking the value for
  * insn - a load of 'sym'
@@ -110,13 +114,9 @@ static int find_dominating_parents(struct symbol *sym, struct instruction *insn,
 			goto found_dominator;
 		} END_FOR_EACH_PTR_REVERSE(one);
 no_dominance:
-		if (parent->generation == generation)
-			continue;
-		parent->generation = generation;
-
-		if (!find_dominating_parents(sym, insn, parent, generation, dominators, local))
+		dom = find_dominating_value(sym, insn, parent, generation, local);
+		if (!dom)
 			return 0;
-		continue;
 
 found_dominator:
 		add_pseudo(dominators, dom);
@@ -124,6 +124,39 @@ found_dominator:
 	return 1;
 }
 
+static pseudo_t find_dominating_value(struct symbol *sym, struct instruction *insn,
+	struct basic_block *bb, unsigned long generation, int local)
+{
+	struct pseudo_list *dominators = NULL;
+
+	if (bb->generation == generation) {
+		return insn->target;
+		// FIXME: is that exact ?
+	}
+
+	bb->generation = generation;
+	if (!find_dominating_parents(sym, insn, bb, generation, &dominators, local))
+		return NULL;
+
+	/* This happens with initial assignments to structures etc.. */
+	if (!dominators) {
+		if (!local)
+			return NULL;
+		check_access(insn);
+
+		// FIXME: should be UNDEF
+		return value_pseudo(0);
+	}
+
+	/*
+	 * If we find just one dominating instruction, we
+	 * can turn it into a direct thing. Otherwise we'll
+	 * have to turn the load into a phi-node of the
+	 * dominators.
+	 */
+	return dominating_value(sym, bb, dominators);
+}
+
 /*
  * sym: a symbol/variable
  * insn: is a load of the symbol 'sym'.
@@ -134,7 +167,6 @@ static int find_dominating_stores(struct symbol *sym, struct instruction *insn,
 {
 	struct basic_block *bb = insn->bb;
 	struct instruction *one, *dom = NULL;
-	struct pseudo_list *dominators;
 	pseudo_t pseudo = sym->pseudo;
 	pseudo_t val;
 	int partial;
@@ -177,31 +209,10 @@ found:
 	}
 
 	/* OK, go find the parents */
-	bb->generation = generation;
-
-	dominators = NULL;
-	if (!find_dominating_parents(sym, insn, bb, generation, &dominators, local))
+	val = find_dominating_value(sym, insn, bb, generation, local);
+	if (!val)
 		return 0;
 
-	/* This happens with initial assignments to structures etc.. */
-	if (!dominators) {
-		if (!local)
-			return 0;
-		check_access(insn);
-
-		// FIXME: should be UNDEF
-		val = value_pseudo(0);
-		goto convert;
-	}
-
-	/*
-	 * If we find just one dominating instruction, we
-	 * can turn it into a direct thing. Otherwise we'll
-	 * have to turn the load into a phi-node of the
-	 * dominators.
-	 */
-	val = dominating_value(sym, bb, dominators);
