From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/7] diet: remove unused struct symbol::value
Date: Thu, 29 Jun 2017 07:16:44 +0200
Message-ID: <20170629051646.35988-6-luc.vanoostenryck@gmail.com>
References: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34378 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbdF2FTD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Jun 2017 01:19:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id p204so346116wmg.1
        for <linux-sparse@vger.kernel.org>; Wed, 28 Jun 2017 22:19:03 -0700 (PDT)
In-Reply-To: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This member seemed to be used for:
- current value of an enum during parsing
- index into the virtual frame
but is currently not used and never set, it's only
displayed in compile-i386 & show_parse (as zero since never
initialized).

Remove it to make struct symbol a bit more light.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 compile-i386.c | 2 +-
 show-parse.c   | 2 +-
 symbol.h       | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/compile-i386.c b/compile-i386.c
index 44b72ec39..633d9a476 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -2238,7 +2238,7 @@ static struct storage *x86_symbol_expr(struct symbol *sym)
 		return new;
 	}
 	if (sym->ctype.modifiers & MOD_ADDRESSABLE) {
-		printf("\taddi.%d\t\tv%d,vFP,$%lld\n", bits_in_pointer, new->pseudo, sym->value);
+		printf("\taddi.%d\t\tv%d,vFP,$%lld\n", bits_in_pointer, new->pseudo, 0ULL);
 		return new;
 	}
 	printf("\taddi.%d\t\tv%d,vFP,$offsetof(%s:%p)\n", bits_in_pointer, new->pseudo, show_ident(sym->ident), sym);
diff --git a/show-parse.c b/show-parse.c
index d365d737f..dd7e76fc4 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -927,7 +927,7 @@ static int show_symbol_expr(struct symbol *sym)
 		return new;
 	}
 	if (sym->ctype.modifiers & MOD_ADDRESSABLE) {
-		printf("\taddi.%d\t\tv%d,vFP,$%lld\n", bits_in_pointer, new, sym->value);
+		printf("\taddi.%d\t\tv%d,vFP,$%lld\n", bits_in_pointer, new, 0ULL);
 		return new;
 	}
 	printf("\taddi.%d\t\tv%d,vFP,$offsetof(%s:%p)\n", bits_in_pointer, new, show_ident(sym->ident), sym);
diff --git a/symbol.h b/symbol.h
index ac3fd8bf0..1bedc75c3 100644
--- a/symbol.h
+++ b/symbol.h
@@ -182,7 +182,6 @@ struct symbol {
 			struct symbol_list *inline_symbol_list;
 			struct expression *initializer;
 			struct entrypoint *ep;
-			long long value;		/* Initial value */
 			struct symbol *definition;
 		};
 	};
-- 
2.13.0

