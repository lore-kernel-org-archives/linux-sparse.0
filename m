From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 42/48] mem2reg: rename one->target to dom
Date: Wed, 23 Aug 2017 22:15:48 +0200
Message-ID: <20170823201554.90551-43-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34705 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWUR0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69so655184wmh.1
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:25 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mem2reg.c b/mem2reg.c
index bb5fadbf2..e27739701 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -86,6 +86,7 @@ static int find_dominating_parents(struct symbol *sym, struct instruction *insn,
 {
 	pseudo_t pseudo = sym->pseudo;
 	struct basic_block *parent;
+	pseudo_t dom;
 
 	if (!bb->parents)
 		return !!local;
@@ -105,6 +106,7 @@ static int find_dominating_parents(struct symbol *sym, struct instruction *insn,
 			}
 			if (!dominance)
 				continue;
+			dom = one->target;
 			goto found_dominator;
 		} END_FOR_EACH_PTR_REVERSE(one);
 no_dominance:
@@ -117,7 +119,7 @@ no_dominance:
 		continue;
 
 found_dominator:
-		add_pseudo(dominators, one->target);
+		add_pseudo(dominators, dom);
 	} END_FOR_EACH_PTR(parent);
 	return 1;
 }
-- 
2.14.0

