From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 6/18] Propagate decl_state to declaration_specifiers()
Date: Mon, 09 Mar 2009 07:11:08 +0000
Message-ID: <E1LgZdk-0000tX-0u@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43747 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbZCIHLK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:11:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZdk-0000tX-0u
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:11:08 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c |   74 +++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/parse.c b/parse.c
index 8c402f3..a2048a2 100644
--- a/parse.c
+++ b/parse.c
@@ -1079,7 +1079,7 @@ static void check_modifiers(struct position *pos, struct symbol *s, unsigned lon
 		     modifier_string (wrong));
 }
 
-static struct token *declaration_specifiers(struct token *next, struct ctype *ctype, int qual)
+static struct token *declaration_specifiers(struct token *next, struct decl_state *ctx, int qual)
 {
 	struct token *token;
 
@@ -1113,21 +1113,21 @@ static struct token *declaration_specifiers(struct token *next, struct ctype *ct
 		if (type) {
 			if (qual)
 				break;
-			if (ctype->base_type)
+			if (ctx->ctype.base_type)
 				break;
 			/* User types only mix with qualifiers */
 			if (mod & MOD_USERTYPE) {
-				if (ctype->modifiers & MOD_SPECIFIER)
+				if (ctx->ctype.modifiers & MOD_SPECIFIER)
 					break;
 			}
-			ctype->base_type = type;
+			ctx->ctype.base_type = type;
 		}
 
-		check_modifiers(&token->pos, s, ctype->modifiers);
-		apply_ctype(token->pos, &thistype, ctype);
+		check_modifiers(&token->pos, s, ctx->ctype.modifiers);
+		apply_ctype(token->pos, &thistype, &ctx->ctype);
 	}
 
-	if (!ctype->base_type) {
+	if (!ctx->ctype.base_type) {
 		struct symbol *base = &incomplete_ctype;
 
 		/*
@@ -1135,9 +1135,9 @@ static struct token *declaration_specifiers(struct token *next, struct ctype *ct
 		 * type, and "ctype_integer()" will turn this into
 		 * a specific one.
 		 */
-		if (ctype->modifiers & MOD_SPECIFIER)
+		if (ctx->ctype.modifiers & MOD_SPECIFIER)
 			base = &int_type;
-		ctype->base_type = base;
+		ctx->ctype.base_type = base;
 	}
 	return token;
 }
@@ -1339,39 +1339,39 @@ static struct token *direct_declarator(struct token *token, struct decl_state *c
 	return token;
 }
 
-static struct token *pointer(struct token *token, struct ctype *ctype)
+static struct token *pointer(struct token *token, struct decl_state *ctx)
 {
 	unsigned long modifiers;
 	struct symbol *base_type;
 
-	modifiers = ctype->modifiers & ~MOD_TYPEDEF;
-	base_type = ctype->base_type;
-	ctype->modifiers = modifiers;
+	modifiers = ctx->ctype.modifiers & ~MOD_TYPEDEF;
+	base_type = ctx->ctype.base_type;
+	ctx->ctype.modifiers = modifiers;
 
 	while (match_op(token,'*')) {
 		struct symbol *ptr = alloc_symbol(token->pos, SYM_PTR);
 		ptr->ctype.modifiers = modifiers & ~MOD_STORAGE;
-		ptr->ctype.as = ctype->as;
-		concat_ptr_list((struct ptr_list *)ctype->contexts,
+		ptr->ctype.as = ctx->ctype.as;
+		concat_ptr_list((struct ptr_list *)ctx->ctype.contexts,
 				(struct ptr_list **)&ptr->ctype.contexts);
 		ptr->ctype.base_type = base_type;
 
 		base_type = ptr;
-		ctype->modifiers = modifiers & MOD_STORAGE;
-		ctype->base_type = base_type;
-		ctype->as = 0;
-		free_ptr_list(&ctype->contexts);
+		ctx->ctype.modifiers = modifiers & MOD_STORAGE;
+		ctx->ctype.base_type = base_type;
+		ctx->ctype.as = 0;
+		free_ptr_list(&ctx->ctype.contexts);
 
-		token = declaration_specifiers(token->next, ctype, 1);
-		modifiers = ctype->modifiers;
-		ctype->base_type->endpos = token->pos;
+		token = declaration_specifiers(token->next, ctx, 1);
+		modifiers = ctx->ctype.modifiers;
+		ctx->ctype.base_type->endpos = token->pos;
 	}
 	return token;
 }
 
 static struct token *declarator(struct token *token, struct decl_state *ctx)
 {
-	token = pointer(token, &ctx->ctype);
+	token = pointer(token, ctx);
 	return direct_declarator(token, ctx);
 }
 
@@ -1425,14 +1425,13 @@ static struct token *handle_bitfield(struct token *token, struct decl_state *ctx
 
 static struct token *declaration_list(struct token *token, struct symbol_list **list)
 {
-	struct ctype ctype = {0, };
+	struct decl_state ctx = {.prefer_abstract = 0};
+	struct ctype saved;
 
-	token = declaration_specifiers(token, &ctype, 0);
+	token = declaration_specifiers(token, &ctx, 0);
+	saved = ctx.ctype;
 	for (;;) {
-		struct decl_state ctx;
 		struct symbol *decl = alloc_symbol(token->pos, SYM_NODE);
-		ctx.ctype = ctype;
-		ctx.prefer_abstract = 0;
 		ctx.ident = &decl->ident;
 
 		token = declarator(token, &ctx);
@@ -1448,6 +1447,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 		if (!match_op(token, ','))
 			break;
 		token = token->next;
+		ctx.ctype = saved;
 	}
 	return token;
 }
@@ -1470,7 +1470,7 @@ static struct token *parameter_declaration(struct token *token, struct symbol *s
 {
 	struct decl_state ctx = {.prefer_abstract = 1};
 
-	token = declaration_specifiers(token, &ctx.ctype, 0);
+	token = declaration_specifiers(token, &ctx, 0);
 	ctx.ident = &sym->ident;
 	token = declarator(token, &ctx);
 	token = handle_attributes(token, &ctx.ctype, KW_ATTRIBUTE);
@@ -1485,7 +1485,7 @@ struct token *typename(struct token *token, struct symbol **p, int mod)
 	struct decl_state ctx = {.prefer_abstract = 1};
 	struct symbol *sym = alloc_symbol(token->pos, SYM_NODE);
 	*p = sym;
-	token = declaration_specifiers(token, &ctx.ctype, 0);
+	token = declaration_specifiers(token, &ctx, 0);
 	token = declarator(token, &ctx);
 	apply_modifiers(token->pos, &ctx.ctype);
 	if (ctx.ctype.modifiers & MOD_STORAGE & ~mod)
@@ -2249,8 +2249,8 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 {
 	struct ident *ident = NULL;
 	struct symbol *decl;
-	struct ctype ctype = { 0, };
 	struct decl_state ctx = { .ident = &ident };
+	struct ctype saved;
 	struct symbol *base_type;
 	int is_typedef;
 
@@ -2262,15 +2262,15 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	}
 
 	/* Parse declaration-specifiers, if any */
-	token = declaration_specifiers(token, &ctype, 0);
+	token = declaration_specifiers(token, &ctx, 0);
 	decl = alloc_symbol(token->pos, SYM_NODE);
 	/* Just a type declaration? */
 	if (match_op(token, ';')) {
-		apply_modifiers(token->pos, &ctype);
+		apply_modifiers(token->pos, &ctx.ctype);
 		return token->next;
 	}
 
-	ctx.ctype = ctype;
+	saved = ctx.ctype;
 	token = declarator(token, &ctx);
 	token = handle_attributes(token, &ctx.ctype, KW_ATTRIBUTE | KW_ASM);
 	apply_modifiers(token->pos, &ctx.ctype);
@@ -2285,11 +2285,11 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	}
 
 	/* type define declaration? */
-	is_typedef = (ctype.modifiers & MOD_TYPEDEF) != 0;
+	is_typedef = (saved.modifiers & MOD_TYPEDEF) != 0;
 
 	/* Typedefs don't have meaningful storage */
 	if (is_typedef) {
-		ctype.modifiers &= ~MOD_STORAGE;
+		saved.modifiers &= ~MOD_STORAGE;
 		decl->ctype.modifiers &= ~MOD_STORAGE;
 		decl->ctype.modifiers |= MOD_USERTYPE;
 	}
@@ -2345,7 +2345,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		token = token->next;
 		ident = NULL;
 		decl = alloc_symbol(token->pos, SYM_NODE);
-		ctx.ctype = ctype;
+		ctx.ctype = saved;
 		token = handle_attributes(token, &ctx.ctype, KW_ATTRIBUTE);
 		token = declarator(token, &ctx);
 		token = handle_attributes(token, &ctx.ctype, KW_ATTRIBUTE | KW_ASM);
-- 
1.5.6.5


