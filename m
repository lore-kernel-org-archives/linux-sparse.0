From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] allow builtins to have prototype and evaluate/expand methods
Date: Mon, 23 Jan 2017 22:37:27 +0100
Message-ID: <20170123213728.89900-3-luc.vanoostenryck@gmail.com>
References: <20170123213728.89900-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35722 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdAWVhn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 23 Jan 2017 16:37:43 -0500
Received: by mail-wm0-f67.google.com with SMTP id d140so29658459wmd.2
        for <linux-sparse@vger.kernel.org>; Mon, 23 Jan 2017 13:37:42 -0800 (PST)
In-Reply-To: <20170123213728.89900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

So far, builtin functions which had some evaluate/expand method
couldn't also have a prototype because each would have its own symbol
and only the one for the prototype will be seen.
This also meant that the evaluate/expand functions had to take care
to set the correct types for they argumenst & results, which is fine
for some generic builtins like __builtin_constant_p() it's much less
practical for the ones like __builtin_bswap{16,32,64}().

Fix this by marking the idents for the builtins we declare some
evaluate/expand methods has being the ident of a builtin function
and later at evaluation time, to share the methods between all the symbols
corresponding to an identifier so marked.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c  | 1 +
 evaluate.c | 6 ++++++
 token.h    | 1 +
 3 files changed, 8 insertions(+)

diff --git a/builtin.c b/builtin.c
index c6c97ed85..ddc71f785 100644
--- a/builtin.c
+++ b/builtin.c
@@ -205,6 +205,7 @@ void init_builtins(int stream)
 		sym = create_symbol(stream, ptr->name, SYM_NODE, NS_SYMBOL);
 		sym->ctype.base_type = ptr->base_type;
 		sym->ctype.modifiers = ptr->modifiers;
+		sym->ident->builtin = 1;
 		sym->op = ptr->op;
 	}
 }
diff --git a/evaluate.c b/evaluate.c
index 6d44e0d9c..f89e44b75 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2829,6 +2829,12 @@ static int evaluate_symbol_call(struct expression *expr)
 	if (fn->type != EXPR_PREOP)
 		return 0;
 
+	if (ctype->ident->builtin) {
+		struct symbol *next = ctype->next_id;
+		if (!ctype->op && next)
+			ctype->op = next->op;
+	}
+
 	if (ctype->op && ctype->op->evaluate)
 		return ctype->op->evaluate(expr);
 
diff --git a/token.h b/token.h
index f7d88eb45..7b9c7ab74 100644
--- a/token.h
+++ b/token.h
@@ -73,6 +73,7 @@ struct ident {
 	unsigned char len;	/* Length of identifier name */
 	unsigned char tainted:1,
 	              reserved:1,
+	              builtin:1,
 		      keyword:1;
 	char name[];		/* Actual identifier */
 };
-- 
2.11.0

