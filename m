From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 15/18] Clean up and split declaration_specifiers()
Date: Mon, 09 Mar 2009 07:12:38 +0000
Message-ID: <E1LgZfC-0000yR-2g@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43808 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbZCIHMk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:12:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZfC-0000yR-2g
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:12:38 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


At this point there's not much in common between qualifiers-only
and full cases; easier to split the sucker in two and lose the
qual argument.  Clean it up, while we are at it...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c |   59 +++++++++++++++++++++++++++++------------------------------
 1 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/parse.c b/parse.c
index 076e149..9adba58 100644
--- a/parse.c
+++ b/parse.c
@@ -1221,47 +1221,47 @@ struct symbol *ctype_integer(unsigned long spec)
 	return types[spec & MOD_UNSIGNED ? CUInt : CInt][size];
 }
 
-static struct token *declaration_specifiers(struct token *next, struct decl_state *ctx, int qual)
+static struct token *handle_qualifiers(struct token *t, struct decl_state *ctx)
 {
+	while (token_type(t) == TOKEN_IDENT) {
+		struct symbol *s = lookup_symbol(t->ident, NS_TYPEDEF);
+		if (!s)
+			break;
+		if (s->type != SYM_KEYWORD)
+			break;
+		if (!(s->op->type & (KW_ATTRIBUTE | KW_QUALIFIER)))
+			break;
+		t = t->next;
+		if (s->op->declarator)
+			t = s->op->declarator(t, &ctx->ctype);
+	}
+	return t;
+}
 
-	struct token *token;
+static struct token *declaration_specifiers(struct token *token, struct decl_state *ctx)
+{
 	int seen = 0;
 	int class = CInt;
 	int size = 0;
 
-	while ( (token = next) != NULL ) {
-		struct ident *ident;
-		struct symbol *s;
-
-		next = token->next;
-		if (token_type(token) != TOKEN_IDENT)
-			break;
-		ident = token->ident;
-
-		s = lookup_symbol(ident, NS_TYPEDEF);
+	while (token_type(token) == TOKEN_IDENT) {
+		struct symbol *s = lookup_symbol(token->ident, NS_TYPEDEF);
 		if (!s)
 			break;
-		if (qual) {
-			if (s->type != SYM_KEYWORD)
-				break;
-			if (!(s->op->type & (KW_ATTRIBUTE | KW_QUALIFIER)))
-				break;
-		}
-		if (s->ctype.modifiers & MOD_USERTYPE) {
+		if (s->type != SYM_KEYWORD) {
 			if (seen & Set_Any)
 				break;
 			seen |= Set_S | Set_T;
 			ctx->ctype.base_type = s->ctype.base_type;
 			apply_ctype(token->pos, &s->ctype, &ctx->ctype);
+			token = token->next;
 			continue;
 		}
-		if (s->type != SYM_KEYWORD)
-			break;
 		if (s->op->type & KW_SPECIFIER) {
 			if (seen & s->op->test) {
 				specifier_conflict(token->pos,
 						   seen & s->op->test,
-						   ident);
+						   token->ident);
 				break;
 			}
 			seen |= s->op->set;
@@ -1278,15 +1278,14 @@ static struct token *declaration_specifiers(struct token *next, struct decl_stat
 				seen |= Set_Vlong;
 			}
 		}
+		token = token->next;
 		if (s->op->declarator)
-			next = s->op->declarator(next, &ctx->ctype);
+			token = s->op->declarator(token, &ctx->ctype);
 		if (s->op->type & KW_EXACT) {
 			ctx->ctype.base_type = s->ctype.base_type;
 			ctx->ctype.modifiers |= s->ctype.modifiers;
 		}
 	}
-	if (qual)
-		return token;
 
 	if (!(seen & Set_S)) {	/* not set explicitly? */
 		struct symbol *base = &incomplete_ctype;
@@ -1531,7 +1530,7 @@ static struct token *pointer(struct token *token, struct decl_state *ctx)
 		ctx->ctype.as = 0;
 		free_ptr_list(&ctx->ctype.contexts);
 
-		token = declaration_specifiers(token->next, ctx, 1);
+		token = handle_qualifiers(token->next, ctx);
 		modifiers = ctx->ctype.modifiers;
 		ctx->ctype.base_type->endpos = token->pos;
 	}
@@ -1597,7 +1596,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 	struct decl_state ctx = {.prefer_abstract = 0};
 	struct ctype saved;
 
-	token = declaration_specifiers(token, &ctx, 0);
+	token = declaration_specifiers(token, &ctx);
 	saved = ctx.ctype;
 	for (;;) {
 		struct symbol *decl = alloc_symbol(token->pos, SYM_NODE);
@@ -1639,7 +1638,7 @@ static struct token *parameter_declaration(struct token *token, struct symbol *s
 {
 	struct decl_state ctx = {.prefer_abstract = 1};
 
-	token = declaration_specifiers(token, &ctx, 0);
+	token = declaration_specifiers(token, &ctx);
 	ctx.ident = &sym->ident;
 	token = declarator(token, &ctx);
 	token = handle_attributes(token, &ctx.ctype, KW_ATTRIBUTE);
@@ -1654,7 +1653,7 @@ struct token *typename(struct token *token, struct symbol **p, int mod)
 	struct decl_state ctx = {.prefer_abstract = 1};
 	struct symbol *sym = alloc_symbol(token->pos, SYM_NODE);
 	*p = sym;
-	token = declaration_specifiers(token, &ctx, 0);
+	token = declaration_specifiers(token, &ctx);
 	token = declarator(token, &ctx);
 	apply_modifiers(token->pos, &ctx.ctype);
 	if (ctx.ctype.modifiers & MOD_STORAGE & ~mod)
@@ -2431,7 +2430,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	}
 
 	/* Parse declaration-specifiers, if any */
-	token = declaration_specifiers(token, &ctx, 0);
+	token = declaration_specifiers(token, &ctx);
 	decl = alloc_symbol(token->pos, SYM_NODE);
 	/* Just a type declaration? */
 	if (match_op(token, ';')) {
-- 
1.5.6.5


