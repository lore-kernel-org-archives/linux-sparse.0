From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix: try_to_simplify_bb eargerness part 2
Date: Sun, 30 Jul 2017 01:58:50 +0200
Message-ID: <20170729235850.22180-1-luc.vanoostenryck@gmail.com>
References: <20170729233805.lvdhpk5bnyaj5zq6@ltop.local>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33714 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbdG2X65 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 19:58:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id q189so20415031wmd.0
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 16:58:56 -0700 (PDT)
In-Reply-To: <20170729233805.lvdhpk5bnyaj5zq6@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Michael Stefaniuc <mstefani@mykolab.com>, linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is a temptative patch for the wine infinitive loop.
---
 flow.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/flow.c b/flow.c
index d8198ce8d..fe16d78d4 100644
--- a/flow.c
+++ b/flow.c
@@ -79,6 +79,19 @@ static int bb_depends_on(struct basic_block *target, struct basic_block *src)
 	return 0;
 }
 
+/*
+ * This is only to be used by try_to_simplify_bb().
+ * It really should be handled by bb_depends_on(), only
+ * that there is no liveness done on OP_PHI/OP_PHISRC.
+ * bb_depends_on() should return true if a phi
+ * is defined by src and used by target but it doesn't.
+ * So for now we add the explicit check.
+ */
+static int bb_uses_phi(struct basic_block *target, pseudo_t phi)
+{
+	return pseudo_in_list(target->needs, phi);
+}
+
 /*
  * This is only to be used by try_to_simplify_bb().
  * It really should be handled by bb_depends_on(), only
@@ -152,6 +165,8 @@ static int try_to_simplify_bb(struct basic_block *bb, struct instruction *first,
 		target = true ? second->bb_true : second->bb_false;
 		if (bb_depends_on(target, bb))
 			continue;
+		if (bb_uses_phi(target, first->target))
+			continue;
 		if (bb_defines_phi(bb, first))
 			continue;
 		changed |= rewrite_branch(source, &br->bb_true, bb, target);
-- 
2.13.2

