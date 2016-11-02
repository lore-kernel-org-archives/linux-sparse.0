From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 1/3] Warn on unknown attributes instead of throwing errors
Date: Thu,  3 Nov 2016 00:07:37 +0100
Message-ID: <20161102230739.64519-2-luc.vanoostenryck@gmail.com>
References: <20161102230739.64519-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35980 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756920AbcKBXJs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 19:09:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id c17so5229605wmc.3
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 16:09:47 -0700 (PDT)
In-Reply-To: <20161102230739.64519-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

GCC creates new attributes quite often, generaly for specific
usages irrelevant to what sparse is used for.
Throwing errors on these create needless noise and annoyance
and seriously reduce sparse's usefulness, especially on big projects.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index 205e1264..d1aa83b4 100644
--- a/parse.c
+++ b/parse.c
@@ -1230,7 +1230,7 @@ static struct token *recover_unknown_attribute(struct token *token)
 {
 	struct expression *expr = NULL;
 
-	sparse_error(token->pos, "attribute '%s': unknown attribute", show_ident(token->ident));
+	warning(token->pos, "attribute '%s': unknown attribute", show_ident(token->ident));
 	token = token->next;
 	if (match_op(token, '('))
 		token = parens_expression(token, &expr, "in attribute");
-- 
2.10.1

