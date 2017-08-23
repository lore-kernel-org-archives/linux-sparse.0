From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 31/48] mem2reg: add comment to find_dominating_stores()
Date: Wed, 23 Aug 2017 22:15:37 +0200
Message-ID: <20170823201554.90551-32-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34589 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWURC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69so654263wmh.1
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:01 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mem2reg.c b/mem2reg.c
index b7dc3cb4b..26837935c 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -68,6 +68,11 @@ found_dominator:
 	return 1;
 }
 
+/*
+ * pseudo: pseudo for a symbol
+ * insn: is a load of the symbol 'pseudo'.
+ * local: is the symbol local or externally visible?
+ */
 static int find_dominating_stores(pseudo_t pseudo, struct instruction *insn,
 	unsigned long generation, int local)
 {
-- 
2.14.0

