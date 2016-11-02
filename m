From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] Warn on unknown attributes instead of throwing errors
Date: Wed,  2 Nov 2016 22:59:37 +0100
Message-ID: <20161102215939.36765-2-luc.vanoostenryck@gmail.com>
References: <20161102215939.36765-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34782 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757114AbcKBWBy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 18:01:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id p190so5077738wmp.1
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 15:01:53 -0700 (PDT)
In-Reply-To: <20161102215939.36765-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

GCC creates new attributes quite often, generaly for specific
usages irrelevant to what sparse is used for.
Throwing errors on these create needless noise and annoyance
which is better to avoid.


Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index 205e1264..212fae3a 100644
--- a/parse.c
+++ b/parse.c
@@ -1230,7 +1230,8 @@ static struct token *recover_unknown_attribute(struct token *token)
 {
 	struct expression *expr = NULL;
 
-	sparse_error(token->pos, "attribute '%s': unknown attribute", show_ident(token->ident));
+	if (Wunknown_attribute)
+		warning(token->pos, "attribute '%s': unknown attribute", show_ident(token->ident));
 	token = token->next;
 	if (match_op(token, '('))
 		token = parens_expression(token, &expr, "in attribute");
-- 
2.10.1

