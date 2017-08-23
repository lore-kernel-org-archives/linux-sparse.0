From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 24/48] mem2reg: extract externaly_visible()
Date: Wed, 23 Aug 2017 22:15:30 +0200
Message-ID: <20170823201554.90551-25-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37200 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932565AbdHWUQs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id v186so631831wmf.4
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:48 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/mem2reg.c b/mem2reg.c
index 2309d11c1..6fe864df0 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -240,26 +240,12 @@ static void kill_dominated_stores(pseudo_t pseudo, struct instruction *insn,
 	} END_FOR_EACH_PTR(parent);
 }
 
-static void promote_symbol(struct entrypoint *ep, struct symbol *sym)
+
+static unsigned long externaly_visible(struct symbol *sym, unsigned long mod)
 {
-	pseudo_t pseudo;
+	pseudo_t pseudo = sym->pseudo;
 	struct pseudo_user *pu;
-	unsigned long mod;
-	int all;
 
-	/* Never used as a symbol? */
-	pseudo = sym->pseudo;
-	if (!pseudo)
-		return;
-
-	mod = sym->ctype.modifiers;
-
-	/* We don't do coverage analysis of volatiles.. */
-	if (mod & MOD_VOLATILE)
-		return;
-
-	/* ..and symbols with external visibility need more care */
-	mod = mod & (MOD_NONLOCAL|MOD_STATIC|MOD_ADDRESSABLE);
 	if (mod)
 		goto external_visibility;
 
@@ -288,6 +274,31 @@ static void promote_symbol(struct entrypoint *ep, struct symbol *sym)
 	} END_FOR_EACH_PTR(pu);
 
 external_visibility:
+	return mod;
+}
+
+static void promote_symbol(struct entrypoint *ep, struct symbol *sym)
+{
+	pseudo_t pseudo;
+	struct pseudo_user *pu;
+	unsigned long mod;
+	int all;
+
+	/* Never used as a symbol? */
+	pseudo = sym->pseudo;
+	if (!pseudo)
+		return;
+
+	mod = sym->ctype.modifiers;
+
+	/* We don't do coverage analysis of volatiles.. */
+	if (mod & MOD_VOLATILE)
+		return;
+
+	/* ..and symbols with external visibility need more care */
+	mod = mod & (MOD_NONLOCAL|MOD_STATIC|MOD_ADDRESSABLE);
+	mod = externaly_visible(sym, mod);
+
 	all = 1;
 	FOR_EACH_PTR_REVERSE(pseudo->users, pu) {
 		struct instruction *insn = pu->insn;
-- 
2.14.0

