From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 5/18] Separating ctype and parser state, part 1
Date: Mon, 09 Mar 2009 07:10:58 +0000
Message-ID: <E1LgZda-0000tC-0i@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43737 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbZCIHLA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:11:00 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZda-0000tC-0i
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:10:58 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Introduce struct decl_state that will hold the declaration parser
state.  Pass it to declarator() and direct_declarator().  Note
that at this stage we are putting more stuff on stack *and* get
extra copying; that's temporary and we'll deal with that in subsequent
patches.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c  |   98 ++++++++++++++++++++++++++++++++++----------------------------
 symbol.h |    6 ++++
 2 files changed, 60 insertions(+), 44 deletions(-)

diff --git a/parse.c b/parse.c
index 4c31bbe..8c402f3 100644
--- a/parse.c
+++ b/parse.c
@@ -1153,7 +1153,7 @@ static struct token *abstract_array_declarator(struct token *token, struct symbo
 
 static struct token *parameter_type_list(struct token *, struct symbol *);
 static struct token *identifier_list(struct token *, struct symbol *);
-static struct token *declarator(struct token *token, struct ctype *ctx, struct ident **p, int);
+static struct token *declarator(struct token *token, struct decl_state *ctx);
 
 static struct token *skip_attribute(struct token *token)
 {
@@ -1292,21 +1292,22 @@ static enum kind which_func(struct token *token,
 	return Bad_Func;
 }
 
-static struct token *direct_declarator(struct token *token, struct ctype *ctx, struct ident **p, int prefer_abstract)
+static struct token *direct_declarator(struct token *token, struct decl_state *ctx)
 {
-	struct ctype *ctype = ctx;
+	struct ctype *ctype = &ctx->ctype;
 	struct token *next;
+	struct ident **p = ctx->ident;
 
-	if (p && token_type(token) == TOKEN_IDENT) {
-		*p = token->ident;
+	if (ctx->ident && token_type(token) == TOKEN_IDENT) {
+		*ctx->ident = token->ident;
 		token = token->next;
 	} else if (match_op(token, '(') &&
-	    is_nested(token, &next, prefer_abstract)) {
+	    is_nested(token, &next, ctx->prefer_abstract)) {
 		struct symbol *base_type = ctype->base_type;
 		if (token->next != next)
 			next = handle_attributes(token->next, ctype,
 						  KW_ATTRIBUTE);
-		token = declarator(next, ctx, p, prefer_abstract);
+		token = declarator(next, ctx);
 		token = expect(token, ')', "in nested declarator");
 		while (ctype->base_type != base_type)
 			ctype = &ctype->base_type->ctype;
@@ -1314,7 +1315,7 @@ static struct token *direct_declarator(struct token *token, struct ctype *ctx, s
 	}
 
 	if (match_op(token, '(')) {
-		enum kind kind = which_func(token, p, prefer_abstract);
+		enum kind kind = which_func(token, p, ctx->prefer_abstract);
 		struct symbol *fn;
 		fn = alloc_indirect_symbol(token->pos, ctype, SYM_FN);
 		token = token->next;
@@ -1368,15 +1369,15 @@ static struct token *pointer(struct token *token, struct ctype *ctype)
 	return token;
 }
 
-static struct token *declarator(struct token *token, struct ctype *ctx, struct ident **p, int prefer_abstract)
+static struct token *declarator(struct token *token, struct decl_state *ctx)
 {
-	token = pointer(token, ctx);
-	return direct_declarator(token, ctx, p, prefer_abstract);
+	token = pointer(token, &ctx->ctype);
+	return direct_declarator(token, ctx);
 }
 
-static struct token *handle_bitfield(struct token *token, struct symbol *decl)
+static struct token *handle_bitfield(struct token *token, struct decl_state *ctx)
 {
-	struct ctype *ctype = &decl->ctype;
+	struct ctype *ctype = &ctx->ctype;
 	struct expression *expr;
 	struct symbol *bitfield;
 	long long width;
@@ -1396,11 +1397,11 @@ static struct token *handle_bitfield(struct token *token, struct symbol *decl)
 	if (width < 0 || width > INT_MAX) {
 		sparse_error(token->pos, "invalid bitfield width, %lld.", width);
 		width = -1;
-	} else if (decl->ident && width == 0) {
+	} else if (*ctx->ident && width == 0) {
 		sparse_error(token->pos, "invalid named zero-width bitfield `%s'",
-		     show_ident(decl->ident));
+		     show_ident(*ctx->ident));
 		width = -1;
-	} else if (decl->ident) {
+	} else if (*ctx->ident) {
 		struct symbol *base_type = bitfield->ctype.base_type;
 		struct symbol *bitfield_type = base_type == &int_type ? bitfield : base_type;
 		int is_signed = !(bitfield_type->ctype.modifiers & MOD_UNSIGNED);
@@ -1428,19 +1429,22 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 
 	token = declaration_specifiers(token, &ctype, 0);
 	for (;;) {
-		struct ident *ident = NULL;
+		struct decl_state ctx;
 		struct symbol *decl = alloc_symbol(token->pos, SYM_NODE);
-		decl->ctype = ctype;
-		token = declarator(token, &decl->ctype, &ident, 0);
+		ctx.ctype = ctype;
+		ctx.prefer_abstract = 0;
+		ctx.ident = &decl->ident;
 
-		decl->ident = ident;
+		token = declarator(token, &ctx);
 		if (match_op(token, ':'))
-			token = handle_bitfield(token, decl);
+			token = handle_bitfield(token, &ctx);
 
-		token = handle_attributes(token, &decl->ctype, KW_ATTRIBUTE);
-		apply_modifiers(token->pos, &decl->ctype);
-		add_symbol(list, decl);
+		token = handle_attributes(token, &ctx.ctype, KW_ATTRIBUTE);
+		apply_modifiers(token->pos, &ctx.ctype);
+
+		decl->ctype = ctx.ctype;
 		decl->endpos = token->pos;
+		add_symbol(list, decl);
 		if (!match_op(token, ','))
 			break;
 		token = token->next;
@@ -1464,27 +1468,30 @@ static struct token *struct_declaration_list(struct token *token, struct symbol_
 
 static struct token *parameter_declaration(struct token *token, struct symbol *sym)
 {
-	struct ctype ctype = {0, };
+	struct decl_state ctx = {.prefer_abstract = 1};
 
-	token = declaration_specifiers(token, &ctype, 0);
-	token = declarator(token, &ctype, &sym->ident, 1);
-	token = handle_attributes(token, &ctype, KW_ATTRIBUTE);
-	apply_modifiers(token->pos, &ctype);
-	sym->ctype = ctype;
+	token = declaration_specifiers(token, &ctx.ctype, 0);
+	ctx.ident = &sym->ident;
+	token = declarator(token, &ctx);
+	token = handle_attributes(token, &ctx.ctype, KW_ATTRIBUTE);
+	apply_modifiers(token->pos, &ctx.ctype);
+	sym->ctype = ctx.ctype;
 	sym->endpos = token->pos;
 	return token;
 }
 
 struct token *typename(struct token *token, struct symbol **p, int mod)
 {
+	struct decl_state ctx = {.prefer_abstract = 1};
 	struct symbol *sym = alloc_symbol(token->pos, SYM_NODE);
 	*p = sym;
-	token = declaration_specifiers(token, &sym->ctype, 0);
-	token = declarator(token, &sym->ctype, NULL, 1);
-	apply_modifiers(token->pos, &sym->ctype);
-	if (sym->ctype.modifiers & MOD_STORAGE & ~mod)
+	token = declaration_specifiers(token, &ctx.ctype, 0);
+	token = declarator(token, &ctx);
+	apply_modifiers(token->pos, &ctx.ctype);
+	if (ctx.ctype.modifiers & MOD_STORAGE & ~mod)
 		warning(sym->pos, "storage class in typename (%s)",
 			show_typename(sym));
+	sym->ctype = ctx.ctype;
 	sym->endpos = token->pos;
 	return token;
 }
@@ -2243,6 +2250,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	struct ident *ident = NULL;
 	struct symbol *decl;
 	struct ctype ctype = { 0, };
+	struct decl_state ctx = { .ident = &ident };
 	struct symbol *base_type;
 	int is_typedef;
 
@@ -2256,17 +2264,18 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	/* Parse declaration-specifiers, if any */
 	token = declaration_specifiers(token, &ctype, 0);
 	decl = alloc_symbol(token->pos, SYM_NODE);
-	decl->ctype = ctype;
 	/* Just a type declaration? */
 	if (match_op(token, ';')) {
-		apply_modifiers(token->pos, &decl->ctype);
+		apply_modifiers(token->pos, &ctype);
 		return token->next;
 	}
 
-	token = declarator(token, &decl->ctype, &ident, 0);
-	token = handle_attributes(token, &decl->ctype, KW_ATTRIBUTE | KW_ASM);
-	apply_modifiers(token->pos, &decl->ctype);
+	ctx.ctype = ctype;
+	token = declarator(token, &ctx);
+	token = handle_attributes(token, &ctx.ctype, KW_ATTRIBUTE | KW_ASM);
+	apply_modifiers(token->pos, &ctx.ctype);
 
+	decl->ctype = ctx.ctype;
 	decl->endpos = token->pos;
 
 	/* Just a type declaration? */
@@ -2336,11 +2345,12 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		token = token->next;
 		ident = NULL;
 		decl = alloc_symbol(token->pos, SYM_NODE);
-		decl->ctype = ctype;
-		token = handle_attributes(token, &decl->ctype, KW_ATTRIBUTE);
-		token = declarator(token, &decl->ctype, &ident, 0);
-		token = handle_attributes(token, &decl->ctype, KW_ATTRIBUTE | KW_ASM);
-		apply_modifiers(token->pos, &decl->ctype);
+		ctx.ctype = ctype;
+		token = handle_attributes(token, &ctx.ctype, KW_ATTRIBUTE);
+		token = declarator(token, &ctx);
+		token = handle_attributes(token, &ctx.ctype, KW_ATTRIBUTE | KW_ASM);
+		apply_modifiers(token->pos, &ctx.ctype);
+		decl->ctype = ctx.ctype;
 		decl->endpos = token->pos;
 		if (!ident) {
 			sparse_error(token->pos, "expected identifier name in type definition");
diff --git a/symbol.h b/symbol.h
index a747128..1f66d55 100644
--- a/symbol.h
+++ b/symbol.h
@@ -87,6 +87,12 @@ struct ctype {
 	struct symbol *base_type;
 };
 
+struct decl_state {
+	struct ctype ctype;
+	int prefer_abstract;
+	struct ident **ident;
+};
+
 struct symbol_op {
 	enum keyword type;
 	int (*evaluate)(struct expression *);
-- 
1.5.6.5


