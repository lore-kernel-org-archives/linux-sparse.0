From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 30/48] mem2reg: remove one indent level
Date: Wed, 23 Aug 2017 22:15:36 +0200
Message-ID: <20170823201554.90551-31-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34572 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWUQ6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69so654140wmh.1
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:58 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/mem2reg.c b/mem2reg.c
index 2a976e826..b7dc3cb4b 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -337,21 +337,17 @@ static void promote_symbol(struct entrypoint *ep, struct symbol *sym)
 	} END_FOR_EACH_PTR_REVERSE(pu);
 
 	/* If we converted all the loads, remove the stores. They are dead */
-	if (all && !mod) {
+	if (all && !mod)
 		return kill_pseudo_stores(pseudo);
-	} else {
-		/*
-		 * If we couldn't take the shortcut, see if we can at least kill some
-		 * of them..
-		 */
-		kill_pseudo_dominated_stores(pseudo, !mod);
