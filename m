From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 23/48] mem2reg: simplify check of modifiers for external visibility
Date: Wed, 23 Aug 2017 22:15:29 +0200
Message-ID: <20170823201554.90551-24-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34524 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932565AbdHWUQq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69so653627wmh.1
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:46 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mem2reg.c b/mem2reg.c
index 0567e98fe..2309d11c1 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -252,12 +252,14 @@ static void promote_symbol(struct entrypoint *ep, struct symbol *sym)
 	if (!pseudo)
 		return;
 
+	mod = sym->ctype.modifiers;
+
 	/* We don't do coverage analysis of volatiles.. */
-	if (sym->ctype.modifiers & MOD_VOLATILE)
+	if (mod & MOD_VOLATILE)
 		return;
 
 	/* ..and symbols with external visibility need more care */
-	mod = sym->ctype.modifiers & (MOD_NONLOCAL | MOD_STATIC | MOD_ADDRESSABLE);
+	mod = mod & (MOD_NONLOCAL|MOD_STATIC|MOD_ADDRESSABLE);
 	if (mod)
 		goto external_visibility;
 
-- 
2.14.0

