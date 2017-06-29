From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/7] diet: squeeze struct symbol's members
Date: Thu, 29 Jun 2017 07:16:45 +0200
Message-ID: <20170629051646.35988-7-luc.vanoostenryck@gmail.com>
References: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35230 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbdF2FTF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Jun 2017 01:19:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id u23so342843wma.2
        for <linux-sparse@vger.kernel.org>; Wed, 28 Jun 2017 22:19:04 -0700 (PDT)
In-Reply-To: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

struct symbol::arguments is only used for functions, while
struct symbol::initializer is never used for functions.

Put both of them in an union in order to make the structure
a bit more lightweight.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/symbol.h b/symbol.h
index 1bedc75c3..d8733e99f 100644
--- a/symbol.h
+++ b/symbol.h
@@ -175,12 +175,14 @@ struct symbol {
 					transparent_union:1;
 			struct expression *array_size;
 			struct ctype ctype;
-			struct symbol_list *arguments;
 			struct statement *stmt;
+			union {
+				struct symbol_list *arguments;
+				struct expression *initializer;
+			};
 			struct symbol_list *symbol_list;
 			struct statement *inline_stmt;
 			struct symbol_list *inline_symbol_list;
-			struct expression *initializer;
 			struct entrypoint *ep;
 			struct symbol *definition;
 		};
-- 
2.13.0

