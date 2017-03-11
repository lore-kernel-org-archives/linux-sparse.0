From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 04/27] give a type to PSEUDO_ARGs
Date: Sat, 11 Mar 2017 10:06:43 +0100
Message-ID: <20170311090706.17171-5-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34948 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753724AbdCKJH0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:26 -0500
Received: by mail-wr0-f193.google.com with SMTP id u108so14120104wrb.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:24 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, PSEUDO_ARGs are created as if being produce/defined
by the OP_ENTRY instruction.

While there is certainly some logics behind it, it's also not
much useful. Worse, the others pseudo which define the 'def'
member (PSEUDO_REG) often use it to get the type corresponding
to the pseudo with 'pseudo->def->type'. Of course, the OP_ENTRY
can't be used so.

Furthermore, when the type (or the size) of an argument we need
to retrieve this information from the function prototype while
this info could already be given to the pseudo at its creation.

Fix this by using the 'sym' field of PSEUDO_ARG to store the
argument's type (and now the 'def' field become meaningless).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 6 +++---
 linearize.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/linearize.c b/linearize.c
index ea4616f80..255231c60 100644
--- a/linearize.c
+++ b/linearize.c
@@ -801,14 +801,14 @@ pseudo_t value_pseudo(long long val)
 	return pseudo;
 }
 
-static pseudo_t argument_pseudo(struct entrypoint *ep, int nr)
+static pseudo_t argument_pseudo(struct entrypoint *ep, int nr, struct symbol *arg)
 {
 	pseudo_t pseudo = __alloc_pseudo(0);
 	struct instruction *entry = ep->entry;
 
 	pseudo->type = PSEUDO_ARG;
 	pseudo->nr = nr;
-	pseudo->def = entry;
+	pseudo->sym = arg;
 	add_pseudo(&entry->arg_list, pseudo);
 
 	/* Argument pseudos have neither usage nor def */
@@ -1540,7 +1540,7 @@ static void linearize_argument(struct entrypoint *ep, struct symbol *arg, int nr
 	ad.source_type = arg;
 	ad.result_type = arg;
 	ad.address = symbol_pseudo(ep, arg);
-	linearize_store_gen(ep, argument_pseudo(ep, nr), &ad);
+	linearize_store_gen(ep, argument_pseudo(ep, nr, arg), &ad);
 	finish_address_gen(ep, &ad);
 }
 
diff --git a/linearize.h b/linearize.h
index c03940eea..9d192f7aa 100644
--- a/linearize.h
+++ b/linearize.h
@@ -34,9 +34,9 @@ struct pseudo {
 	struct pseudo_user_list *users;
 	struct ident *ident;
 	union {
-		struct symbol *sym;
-		struct instruction *def;
-		long long value;
+		struct symbol *sym;	// PSEUDO_SYM & ARG
+		struct instruction *def;// PSEUDO_REG & PHI
+		long long value;	// PSEUDO_VAL
 	};
 	void *priv;
 };
-- 
2.11.1

