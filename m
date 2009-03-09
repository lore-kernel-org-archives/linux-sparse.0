From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 10/18] preparations to ->declarator() cleanup - separate typedef handling
Date: Mon, 09 Mar 2009 07:11:48 +0000
Message-ID: <E1LgZeO-0000vd-1Y@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43757 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbZCIHLt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:11:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZeO-0000vd-1Y
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:11:48 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Take typedef handling in declaration_specifiers() into separate
branch; kill useless check for qual in case the type we've got
has non-NULL base_type (we'd have already buggered off in that
situation before we get to the check in question).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/parse.c b/parse.c
index 1435fde..ba1a52d 100644
--- a/parse.c
+++ b/parse.c
@@ -1105,29 +1105,31 @@ static struct token *declaration_specifiers(struct token *next, struct decl_stat
 		s = lookup_symbol(ident, NS_TYPEDEF);
 		if (!s)
 			break;
-		thistype = s->ctype;
-		mod = thistype.modifiers;
 		if (qual) {
 			if (s->type != SYM_KEYWORD)
 				break;
 			if (!(s->op->type & (KW_ATTRIBUTE | KW_QUALIFIER)))
 				break;
 		}
+		if (s->ctype.modifiers & MOD_USERTYPE) {
+			if (ctx->ctype.base_type)
+				break;
+			if (ctx->ctype.modifiers & MOD_SPECIFIER)
+				break;
+			ctx->ctype.base_type = s->ctype.base_type;
+			apply_ctype(token->pos, &s->ctype, &ctx->ctype);
+			continue;
+		}
+		thistype = s->ctype;
+		mod = thistype.modifiers;
 		if (s->type == SYM_KEYWORD && s->op->declarator) {
 			next = s->op->declarator(next, &thistype);
 			mod = thistype.modifiers;
 		}
 		type = thistype.base_type;
 		if (type) {
-			if (qual)
-				break;
 			if (ctx->ctype.base_type)
 				break;
-			/* User types only mix with qualifiers */
-			if (mod & MOD_USERTYPE) {
-				if (ctx->ctype.modifiers & MOD_SPECIFIER)
-					break;
-			}
 			ctx->ctype.base_type = type;
 		}
 
-- 
1.5.6.5


