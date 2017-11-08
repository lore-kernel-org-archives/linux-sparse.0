From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/9] dump-ir: saner use of fdump_linearize
Date: Wed,  8 Nov 2017 11:27:59 +0100
Message-ID: <20171108102802.43987-7-luc.vanoostenryck@gmail.com>
References: <20171108102802.43987-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:48082 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbdKHK2S (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 05:28:18 -0500
Received: by mail-wm0-f68.google.com with SMTP id r196so9387244wmf.2
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 02:28:18 -0800 (PST)
In-Reply-To: <20171108102802.43987-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c      | 5 +----
 test-linearize.c | 2 ++
 test-unssa.c     | 2 ++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/linearize.c b/linearize.c
index 65a4baf96..4970771bc 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2220,11 +2220,8 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 		add_one_insn(ep, insn);
 	}
 
-	if (fdump_linearize) {
-		if (fdump_linearize == 2)
-			return ep;
+	if (fdump_linearize)
 		show_entry(ep);
-	}
 
 	/*
 	 * Do trivial flow simplification - branches to
diff --git a/test-linearize.c b/test-linearize.c
index fe0673bef..284526781 100644
--- a/test-linearize.c
+++ b/test-linearize.c
@@ -47,6 +47,8 @@ static void clean_up_symbols(struct symbol_list *list)
 
 		expand_symbol(sym);
 		ep = linearize_symbol(sym);
+		if (fdump_linearize == 2)
+			continue;
 		if (ep)
 			show_entry(ep);
 	} END_FOR_EACH_PTR(sym);
diff --git a/test-unssa.c b/test-unssa.c
index 240d99601..ec5c93015 100644
--- a/test-unssa.c
+++ b/test-unssa.c
@@ -62,6 +62,8 @@ static int compile(struct symbol_list *list)
 		struct entrypoint *ep;
 		expand_symbol(sym);
 		ep = linearize_symbol(sym);
+		if (fdump_linearize == 2)
+			continue;
 		if (ep)
 			output_fn(ep);
 		else
-- 
2.14.0

