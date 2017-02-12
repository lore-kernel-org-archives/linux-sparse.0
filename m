From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 2/3] let identical symbols share their evaluate/expand methods
Date: Sun, 12 Feb 2017 16:10:59 +0100
Message-ID: <20170212151100.15868-3-luc.vanoostenryck@gmail.com>
References: <20170212150332.33xlxmzohgb7hrpp@macpro.local>
 <20170212151100.15868-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36334 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdBLPMW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 10:12:22 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so14671476wmd.3
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 07:12:21 -0800 (PST)
In-Reply-To: <20170212151100.15868-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Johannes Berg <johannes@sipsolutions.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

So far, builtin functions which had some evaluate/expand method
couldn't also have a prototype because the declaration of the
prototype and the definition of the builtin with its method would
each have their own symbol and only one of them will be seen, the
last one, the one for the prototype.
This also meant that the evaluate/expand methods had to take care
to set the correct types for they argumenst & results, which is fine
for some generic builtins like __builtin_constant_p() but much less
practical for the ones like __builtin_bswap{16,32,64}().

Fix this by letting symbols with same name share their methods.

Originally-by: Christopher Li <sparse@chrisli.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index b65a6ebce..a4a126720 100644
--- a/parse.c
+++ b/parse.c
@@ -2879,8 +2879,10 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 			}
 		}
 		check_declaration(decl);
-		if (decl->same_symbol)
+		if (decl->same_symbol) {
 			decl->definition = decl->same_symbol->definition;
+			decl->op = decl->same_symbol->op;
+		}
 
 		if (!match_op(token, ','))
 			break;
-- 
2.11.0

