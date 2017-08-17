From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 2/4] fold is_simple_var() into simple_access()
Date: Fri, 18 Aug 2017 00:35:56 +0200
Message-ID: <20170817223558.21258-3-luc.vanoostenryck@gmail.com>
References: <20170817223558.21258-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33198 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753324AbdHQWgM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 18:36:12 -0400
Received: by mail-wr0-f195.google.com with SMTP id n88so10664371wrb.0
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 15:36:11 -0700 (PDT)
In-Reply-To: <20170817223558.21258-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 linearize.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/linearize.c b/linearize.c
index 9a7a71d3a..63c896fc7 100644
--- a/linearize.c
+++ b/linearize.c
@@ -978,16 +978,7 @@ static inline int is_simple_type(struct symbol *type)
 	return 0;
 }
 
-static inline int is_simple_var(struct symbol *var)
-{
-	if (!is_simple_type(var))
-		return 0;
 #define	MOD_NONREG	(MOD_STATIC|MOD_NONLOCAL|MOD_ADDRESSABLE|MOD_VOLATILE)
-	if (var->ctype.modifiers & MOD_NONREG)
-		return 0;
-	return 1;
-}
