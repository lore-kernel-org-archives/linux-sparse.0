From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 3/4] rename 'simple_{var,access}' by promatable_...'
Date: Fri, 18 Aug 2017 00:35:57 +0200
Message-ID: <20170817223558.21258-4-luc.vanoostenryck@gmail.com>
References: <20170817223558.21258-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34464 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753324AbdHQWgN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 18:36:13 -0400
Received: by mail-wr0-f195.google.com with SMTP id p14so2036329wrg.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 15:36:13 -0700 (PDT)
In-Reply-To: <20170817223558.21258-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 linearize.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/linearize.c b/linearize.c
index 63c896fc7..485d8eeec 100644
--- a/linearize.c
+++ b/linearize.c
@@ -955,7 +955,7 @@ static int linearize_address_gen(struct entrypoint *ep,
 /*
  * Is it possible and desirable for this to be promoted to a pseudo?
  */
-static inline int is_simple_type(struct symbol *type)
+static inline int is_promotable(struct symbol *type)
 {
 	if (type->type == SYM_NODE)
 		type = type->ctype.base_type;
@@ -979,7 +979,7 @@ static inline int is_simple_type(struct symbol *type)
 }
 
 #define	MOD_NONREG	(MOD_STATIC|MOD_NONLOCAL|MOD_ADDRESSABLE|MOD_VOLATILE)
-static inline struct symbol *simple_access(struct access_data *ad)
+static inline struct symbol *promotable_access(struct access_data *ad)
 {
 	pseudo_t addr = ad->address;
 	struct symbol *sym;
@@ -989,7 +989,7 @@ static inline struct symbol *simple_access(struct access_data *ad)
 	sym = addr->sym;
 	if (sym->ctype.modifiers & MOD_NONREG)
 		return NULL;
-	if (!is_simple_type(sym))
+	if (!is_promotable(sym))
 		return NULL;
 	return sym;
 }
@@ -1003,7 +1003,7 @@ static pseudo_t add_load(struct entrypoint *ep, struct access_data *ad)
 
 	if (!bb)
 		return VOID;
-	if ((var = simple_access(ad))) {
+	if ((var = promotable_access(ad))) {
 		new = load_var(bb, var);
 		return new;
 	}
@@ -1027,7 +1027,7 @@ static void add_store(struct entrypoint *ep, struct access_data *ad, pseudo_t va
 	if (!bb)
 		return;
 
-	if ((var = simple_access(ad))) {
+	if ((var = promotable_access(ad))) {
 		store_var(bb, var, value);
 		return;
 	}
-- 
2.14.0

