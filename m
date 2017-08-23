From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 22/48] mem2reg: rename to use 'promote' instead of 'simplify'
Date: Wed, 23 Aug 2017 22:15:28 +0200
Message-ID: <20170823201554.90551-23-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37175 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932565AbdHWUQn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id v186so631571wmf.4
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:43 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 flow.h      | 2 +-
 linearize.c | 2 +-
 mem2reg.c   | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/flow.h b/flow.h
index 3133245e5..b9fc13723 100644
--- a/flow.h
+++ b/flow.h
@@ -14,7 +14,7 @@ struct instruction;
 
 extern int simplify_flow(struct entrypoint *ep);
 
-extern void simplify_symbol_usage(struct entrypoint *ep);
+extern void promote_symbols_usage(struct entrypoint *ep);
 extern void simplify_memops(struct entrypoint *ep);
 extern void pack_basic_blocks(struct entrypoint *ep);
 
diff --git a/linearize.c b/linearize.c
index d5606b708..2c49d29d9 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2277,7 +2277,7 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 	/*
 	 * Turn symbols into pseudos
 	 */
-	simplify_symbol_usage(ep);
+	promote_symbols_usage(ep);
 
 repeat:
 	/*
diff --git a/mem2reg.c b/mem2reg.c
index 41ba54442..0567e98fe 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -240,7 +240,7 @@ static void kill_dominated_stores(pseudo_t pseudo, struct instruction *insn,
 	} END_FOR_EACH_PTR(parent);
 }
 
-static void simplify_one_symbol(struct entrypoint *ep, struct symbol *sym)
+static void promote_symbol(struct entrypoint *ep, struct symbol *sym)
 {
 	pseudo_t pseudo;
 	struct pseudo_user *pu;
@@ -323,11 +323,11 @@ external_visibility:
 	return;
 }
 
-void simplify_symbol_usage(struct entrypoint *ep)
+void promote_symbols_usage(struct entrypoint *ep)
 {
 	pseudo_t pseudo;
 
 	FOR_EACH_PTR(ep->accesses, pseudo) {
-		simplify_one_symbol(ep, pseudo->sym);
+		promote_symbol(ep, pseudo->sym);
 	} END_FOR_EACH_PTR(pseudo);
 }
-- 
2.14.0

