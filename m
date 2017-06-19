From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] dissect: use built_in_ident() instead of MK_IDENT()
Date: Mon, 19 Jun 2017 23:14:54 +0200
Message-ID: <20170619211454.45244-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34516 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdFSVO7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Jun 2017 17:14:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id f134so1485203wme.1
        for <linux-sparse@vger.kernel.org>; Mon, 19 Jun 2017 14:14:59 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Oleg Nesterov <oleg@redhat.com>

The motivation for this patch was to allow sparse to be
compiled with clang which doesn't like what is done
on VLAs in the MK_IDENT() macro.

But also, I can't see any justification for not using the
real thing to create identifiers: built_in_ident().

CC: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 dissect.h      | 13 -------------
 test-dissect.c |  6 +++---
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/dissect.h b/dissect.h
index 3b72b8988..5ac1f4d40 100644
--- a/dissect.h
+++ b/dissect.h
@@ -25,16 +25,3 @@ struct reporter
 };
 
 extern void dissect(struct symbol_list *, struct reporter *);
-
-#define	MK_IDENT(s)	({				\
-	static struct {					\
-		struct ident ident;			\
-		char __[sizeof(s)];			\
-	} ident = {{					\
-		.len  = sizeof(s)-1,			\
-		.name = s,				\
-	}};						\
-	&ident.ident;					\
-})
-
-#endif
diff --git a/test-dissect.c b/test-dissect.c
index a2548b7f2..862318f81 100644
--- a/test-dissect.c
+++ b/test-dissect.c
@@ -47,7 +47,7 @@ static void r_symbol(unsigned mode, struct position *pos, struct symbol *sym)
 	print_usage(pos, sym, mode);
 
 	if (!sym->ident)
-		sym->ident = MK_IDENT("__asm__");
+		sym->ident = built_in_ident("__asm__");
 
 	printf("%-32.*s %s\n",
 		sym->ident->len, sym->ident->name,
@@ -60,10 +60,10 @@ static void r_member(unsigned mode, struct position *pos, struct symbol *sym, st
 
 	print_usage(pos, sym, mode);
 
-	ni = MK_IDENT("?");
+	ni = built_in_ident("?");
 	si = sym->ident ?: ni;
 	/* mem == NULL means entire struct accessed */
-	mi = mem ? (mem->ident ?: ni) : MK_IDENT("*");
+	mi = mem ? (mem->ident ?: ni) : built_in_ident("*");
 
 	printf("%.*s.%-*.*s %s\n",
 		si->len, si->name,
-- 
2.13.0

