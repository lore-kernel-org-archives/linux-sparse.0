From: Al Viro <viro@ftp.linux.org.uk>
Subject: Sanitize pointer()
Date: Wed, 11 Mar 2009 07:08:35 +0000
Message-ID: <E1LhIYN-00042T-DM@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:41433 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbZCKHIh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 11 Mar 2009 03:08:37 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LhIYN-00042T-DM
	for linux-sparse@vger.kernel.org; Wed, 11 Mar 2009 07:08:35 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


There's no need to concat the context list into (empty) one of new node,
only to free the original one.  Moving the pointer to list instead works
fine...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c |   20 +++++---------------
 1 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/parse.c b/parse.c
index 28bc0c9..f16d321 100644
--- a/parse.c
+++ b/parse.c
@@ -1592,28 +1592,18 @@ static struct token *direct_declarator(struct token *token, struct decl_state *c
 
 static struct token *pointer(struct token *token, struct decl_state *ctx)
 {
-	unsigned long modifiers;
-	struct symbol *base_type;
-
-	modifiers = ctx->ctype.modifiers;
-	base_type = ctx->ctype.base_type;
-
 	while (match_op(token,'*')) {
 		struct symbol *ptr = alloc_symbol(token->pos, SYM_PTR);
-		ptr->ctype.modifiers = modifiers;
+		ptr->ctype.modifiers = ctx->ctype.modifiers;
+		ptr->ctype.base_type = ctx->ctype.base_type;
 		ptr->ctype.as = ctx->ctype.as;
-		concat_ptr_list((struct ptr_list *)ctx->ctype.contexts,
-				(struct ptr_list **)&ptr->ctype.contexts);
-		ptr->ctype.base_type = base_type;
