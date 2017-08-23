From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 48/48] mem2reg: don't promote unused or already promoted vars
Date: Wed, 23 Aug 2017 22:15:54 +0200
Message-ID: <20170823201554.90551-49-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35059 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWURh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id x79so650812wma.2
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:36 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mem2reg.c b/mem2reg.c
index d31cd4121..490077d67 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -405,6 +405,10 @@ static void promote_symbol(struct entrypoint *ep, struct symbol *sym)
 	if (!pseudo)
 		return;
 
+	/* already converted ? */
+	if (!pseudo->users)
+		return;
+
 	mod = sym->ctype.modifiers;
 
 	/* We don't do coverage analysis of volatiles.. */
-- 
2.14.0

