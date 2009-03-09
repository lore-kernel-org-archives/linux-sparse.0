From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 14/18] Have ->declarator() act directly on ctype being affected
Date: Mon, 09 Mar 2009 07:12:28 +0000
Message-ID: <E1LgZf2-0000yB-2W@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43806 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbZCIHMa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:12:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZf2-0000yB-2W
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:12:28 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


... and don't do full-blown apply_ctype() every damn time.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c  |  234 ++++++++++++++++++++++++++++++++++++++++++-------------------
 symbol.h |    1 +
 2 files changed, 162 insertions(+), 73 deletions(-)

diff --git a/parse.c b/parse.c
index 73b4cac..076e149 100644
--- a/parse.c
+++ b/parse.c
@@ -35,11 +35,13 @@ struct statement_list *function_computed_goto_list;
 static struct token *statement(struct token *token, struct statement **tree);
 static struct token *handle_attributes(struct token *token, struct ctype *ctype, unsigned int keywords);
 
-static struct token *struct_specifier(struct token *token, struct ctype *ctype);
-static struct token *union_specifier(struct token *token, struct ctype *ctype);
-static struct token *enum_specifier(struct token *token, struct ctype *ctype);
-static struct token *attribute_specifier(struct token *token, struct ctype *ctype);
-static struct token *typeof_specifier(struct token *token, struct ctype *ctype);
+typedef struct token *declarator_t(struct token *, struct ctype *);
+static declarator_t
+	struct_specifier, union_specifier, enum_specifier,
+	attribute_specifier, typeof_specifier, parse_asm_declarator,
+	typedef_specifier, inline_specifier, auto_specifier,
+	register_specifier, static_specifier, extern_specifier,
+	const_qualifier, volatile_qualifier;
 
 static struct token *parse_if_statement(struct token *token, struct statement *stmt);
 static struct token *parse_return_statement(struct token *token, struct statement *stmt);
@@ -55,17 +57,14 @@ static struct token *parse_context_statement(struct token *token, struct stateme
 static struct token *parse_range_statement(struct token *token, struct statement *stmt);
 static struct token *parse_asm_statement(struct token *token, struct statement *stmt);
 static struct token *toplevel_asm_declaration(struct token *token, struct symbol_list **list);
-static struct token *parse_asm_declarator(struct token *token, struct ctype *ctype);
 
+typedef struct token *attr_t(struct token *, struct symbol *, struct ctype *);
 
-static struct token *attribute_packed(struct token *token, struct symbol *attr, struct ctype *ctype);
-static struct token *attribute_modifier(struct token *token, struct symbol *attr, struct ctype *ctype);
-static struct token *attribute_address_space(struct token *token, struct symbol *attr, struct ctype *ctype);
-static struct token *attribute_aligned(struct token *token, struct symbol *attr, struct ctype *ctype);
-static struct token *attribute_mode(struct token *token, struct symbol *attr, struct ctype *ctype);
-static struct token *attribute_context(struct token *token, struct symbol *attr, struct ctype *ctype);
-static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct ctype *ctype);
-static struct token *ignore_attribute(struct token *token, struct symbol *attr, struct ctype *ctype);
+static attr_t
+	attribute_packed, attribute_aligned, attribute_modifier,
+	attribute_address_space, attribute_context,
+	attribute_transparent_union, ignore_attribute,
+	attribute_mode;
 
 enum {
 	Set_T = 1,
@@ -86,11 +85,47 @@ enum {
 	CInt = 0, CSInt, CUInt, CReal, CChar, CSChar, CUChar
 };
 
-static struct symbol_op modifier_op = {
+static struct symbol_op typedef_op = {
 	.type = KW_MODIFIER,
+	.declarator = typedef_specifier,
 };
 
-static struct symbol_op qualifier_op = {
+static struct symbol_op inline_op = {
+	.type = KW_MODIFIER,
+	.declarator = inline_specifier,
+};
+
+static struct symbol_op auto_op = {
+	.type = KW_MODIFIER,
+	.declarator = auto_specifier,
+};
+
+static struct symbol_op register_op = {
+	.type = KW_MODIFIER,
+	.declarator = register_specifier,
+};
+
+static struct symbol_op static_op = {
+	.type = KW_MODIFIER,
+	.declarator = static_specifier,
+};
+
+static struct symbol_op extern_op = {
+	.type = KW_MODIFIER,
+	.declarator = extern_specifier,
+};
+
+static struct symbol_op const_op = {
+	.type = KW_QUALIFIER,
+	.declarator = const_qualifier,
+};
+
+static struct symbol_op volatile_op = {
+	.type = KW_QUALIFIER,
+	.declarator = volatile_qualifier,
+};
+
+static struct symbol_op restrict_op = {
 	.type = KW_QUALIFIER,
 };
 
@@ -128,7 +163,7 @@ static struct symbol_op enum_op = {
 };
 
 static struct symbol_op spec_op = {
-	.type = KW_SPECIFIER,
+	.type = KW_SPECIFIER | KW_EXACT,
 	.test = Set_Any,
 	.set = Set_S|Set_T,
 };
@@ -285,15 +320,15 @@ static struct init_keyword {
 	struct symbol *type;
 } keyword_table[] = {
 	/* Type qualifiers */
-	{ "const",	NS_TYPEDEF, MOD_CONST, .op = &qualifier_op },
-	{ "__const",	NS_TYPEDEF, MOD_CONST, .op = &qualifier_op },
-	{ "__const__",	NS_TYPEDEF, MOD_CONST, .op = &qualifier_op },
-	{ "volatile",	NS_TYPEDEF, MOD_VOLATILE, .op = &qualifier_op },
-	{ "__volatile",		NS_TYPEDEF, MOD_VOLATILE, .op = &qualifier_op },
-	{ "__volatile__", 	NS_TYPEDEF, MOD_VOLATILE, .op = &qualifier_op },
+	{ "const",	NS_TYPEDEF, .op = &const_op },
+	{ "__const",	NS_TYPEDEF, .op = &const_op },
+	{ "__const__",	NS_TYPEDEF, .op = &const_op },
+	{ "volatile",	NS_TYPEDEF, .op = &volatile_op },
+	{ "__volatile",		NS_TYPEDEF, .op = &volatile_op },
+	{ "__volatile__", 	NS_TYPEDEF, .op = &volatile_op },
 
 	/* Typedef.. */
-	{ "typedef",	NS_TYPEDEF, MOD_TYPEDEF, .op = &modifier_op },
+	{ "typedef",	NS_TYPEDEF, .op = &typedef_op },
 
 	/* Type specifiers */
 	{ "void",	NS_TYPEDEF, .type = &void_ctype, .op = &spec_op},
@@ -326,19 +361,19 @@ static struct init_keyword {
 	{ "union", 	NS_TYPEDEF, .op = &union_op },
 	{ "enum", 	NS_TYPEDEF, .op = &enum_op },
 
-	{ "inline",	NS_TYPEDEF, MOD_INLINE, .op = &modifier_op },
-	{ "__inline",	NS_TYPEDEF, MOD_INLINE, .op = &modifier_op },
-	{ "__inline__",	NS_TYPEDEF, MOD_INLINE, .op = &modifier_op },
+	{ "inline",	NS_TYPEDEF, .op = &inline_op },
+	{ "__inline",	NS_TYPEDEF, .op = &inline_op },
+	{ "__inline__",	NS_TYPEDEF, .op = &inline_op },
 
 	/* Ignored for now.. */
-	{ "restrict",	NS_TYPEDEF, .op = &qualifier_op},
-	{ "__restrict",	NS_TYPEDEF, .op = &qualifier_op},
+	{ "restrict",	NS_TYPEDEF, .op = &restrict_op},
+	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
 
 	/* Storage class */
-	{ "auto",	NS_TYPEDEF, MOD_AUTO, .op = &modifier_op },
-	{ "register",	NS_TYPEDEF, MOD_REGISTER, .op = &modifier_op },
-	{ "static",	NS_TYPEDEF, MOD_STATIC, .op = &modifier_op },
-	{ "extern",	NS_TYPEDEF, MOD_EXTERN, .op = &modifier_op },
+	{ "auto",	NS_TYPEDEF, .op = &auto_op },
+	{ "register",	NS_TYPEDEF, .op = &register_op },
+	{ "static",	NS_TYPEDEF, .op = &static_op },
+	{ "extern",	NS_TYPEDEF, .op = &extern_op },
 
 	/* Statement */
 	{ "if",		NS_KEYWORD, .op = &if_op },
@@ -566,7 +601,6 @@ static struct token *struct_union_enum_specifier(enum type type,
 	struct symbol *sym;
 	struct position *repos;
 
-	ctype->modifiers = 0;
 	token = handle_attributes(token, ctype, KW_ATTRIBUTE);
 	if (token_type(token) == TOKEN_IDENT) {
 		sym = lookup_symbol(token->ident, NS_STRUCT);
@@ -854,6 +888,8 @@ static struct token *enum_specifier(struct token *token, struct ctype *ctype)
 	return ret;
 }
 
+static void apply_ctype(struct position pos, struct ctype *thistype, struct ctype *ctype);
+
 static struct token *typeof_specifier(struct token *token, struct ctype *ctype)
 {
 	struct symbol *sym;
@@ -864,12 +900,12 @@ static struct token *typeof_specifier(struct token *token, struct ctype *ctype)
 	}
 	if (lookup_type(token->next)) {
 		token = typename(token->next, &sym, 0);
-		*ctype = sym->ctype;
+		ctype->base_type = sym->ctype.base_type;
+		apply_ctype(token->pos, &sym->ctype, ctype);
 	} else {
 		struct symbol *typeof_sym = alloc_symbol(token->pos, SYM_TYPEOF);
 		token = parse_expression(token->next, &typeof_sym->initializer);
 
-		ctype->modifiers = 0;
 		typeof_sym->endpos = token->pos;
 		ctype->base_type = typeof_sym;
 	}		
@@ -886,7 +922,8 @@ static struct token *ignore_attribute(struct token *token, struct symbol *attr,
 
 static struct token *attribute_packed(struct token *token, struct symbol *attr, struct ctype *ctype)
 {
-	ctype->alignment = 1;
+	if (!ctype->alignment)
+		ctype->alignment = 1;
 	return token;
 }
 
@@ -900,23 +937,38 @@ static struct token *attribute_aligned(struct token *token, struct symbol *attr,
 		if (expr)
 			alignment = const_expression_value(expr);
 	}
-	ctype->alignment = alignment;
+	if (alignment & (alignment-1)) {
+		warning(token->pos, "I don't like non-power-of-2 alignments");
+		return token;
+	} else if (alignment > ctype->alignment)
+		ctype->alignment = alignment;
 	return token;
 }
 
+static void apply_qualifier(struct position *pos, struct ctype *ctx, unsigned long qual)
+{
+	if (ctx->modifiers & qual)
+		warning(*pos, "duplicate %s", modifier_string(qual));
+	ctx->modifiers |= qual;
+}
+
 static struct token *attribute_modifier(struct token *token, struct symbol *attr, struct ctype *ctype)
 {
-	ctype->modifiers |= attr->ctype.modifiers;
+	apply_qualifier(&token->pos, ctype, attr->ctype.modifiers);
 	return token;
 }
 
 static struct token *attribute_address_space(struct token *token, struct symbol *attr, struct ctype *ctype)
 {
 	struct expression *expr = NULL;
+	int as;
 	token = expect(token, '(', "after address_space attribute");
 	token = conditional_expression(token, &expr);
-	if (expr)
-		ctype->as = const_expression_value(expr);
+	if (expr) {
+		as = const_expression_value(expr);
+		if (as)
+			ctype->as = as;
+	}
 	token = expect(token, ')', "after address_space attribute");
 	return token;
 }
@@ -1001,7 +1053,6 @@ static struct token *recover_unknown_attribute(struct token *token)
 
 static struct token *attribute_specifier(struct token *token, struct ctype *ctype)
 {
-	ctype->modifiers = 0;
 	token = expect(token, '(', "after attribute");
 	token = expect(token, '(', "after attribute");
 
@@ -1032,37 +1083,78 @@ static struct token *attribute_specifier(struct token *token, struct ctype *ctyp
 	return token;
 }
 
-static void apply_ctype(struct position pos, struct ctype *thistype, struct ctype *ctype)
+static void apply_modifier(struct position *pos, struct ctype *ctx, unsigned long modifier)
 {
-	unsigned long mod = thistype->modifiers;
+	if (!(ctx->modifiers & MOD_STORAGE & ~MOD_INLINE)) {
+		ctx->modifiers |= modifier;
+		return;
+	}
+	if (ctx->modifiers & modifier)
+		sparse_error(*pos, "duplicate %s", modifier_string(modifier));
+	else
+		sparse_error(*pos, "multiple storage classes");
+}
+
+static struct token *typedef_specifier(struct token *next, struct ctype *ctx)
+{
+	apply_modifier(&next->pos, ctx, MOD_TYPEDEF);
+	return next;
+}
 
-	if (mod) {
-		unsigned long old = ctype->modifiers;
-		unsigned long dup, conflict;
+static struct token *auto_specifier(struct token *next, struct ctype *ctx)
+{
+	apply_modifier(&next->pos, ctx, MOD_AUTO);
+	return next;
+}
 
-		dup = mod & old;
-		if (dup)
-			sparse_error(pos, "Just how %sdo you want this type to be?",
-				modifier_string(dup));
+static struct token *register_specifier(struct token *next, struct ctype *ctx)
+{
+	apply_modifier(&next->pos, ctx, MOD_REGISTER);
+	return next;
+}
 
-		// Only one storage modifier allowed, except that "inline" doesn't count.
-		conflict = (mod | old) & (MOD_STORAGE & ~MOD_INLINE);
-		conflict &= (conflict - 1);
-		if (conflict)
-			sparse_error(pos, "multiple storage classes");
+static struct token *static_specifier(struct token *next, struct ctype *ctx)
+{
+	apply_modifier(&next->pos, ctx, MOD_STATIC);
+	return next;
+}
 
-		ctype->modifiers = old | mod;
-	}
+static struct token *extern_specifier(struct token *next, struct ctype *ctx)
+{
+	apply_modifier(&next->pos, ctx, MOD_EXTERN);
+	return next;
+}
+
+static struct token *inline_specifier(struct token *next, struct ctype *ctx)
+{
+	ctx->modifiers |= MOD_INLINE;
+	return next;
+}
+
+static struct token *const_qualifier(struct token *next, struct ctype *ctx)
+{
+	apply_qualifier(&next->pos, ctx, MOD_CONST);
+	return next;
+}
+
+static struct token *volatile_qualifier(struct token *next, struct ctype *ctx)
+{
+	apply_qualifier(&next->pos, ctx, MOD_VOLATILE);
+	return next;
+}
+
+static void apply_ctype(struct position pos, struct ctype *thistype, struct ctype *ctype)
+{
+	unsigned long mod = thistype->modifiers;
+
+	if (mod)
+		apply_qualifier(&pos, ctype, mod);
 
 	/* Context */
 	concat_ptr_list((struct ptr_list *)thistype->contexts,
 	                (struct ptr_list **)&ctype->contexts);
 
 	/* Alignment */
-	if (thistype->alignment & (thistype->alignment-1)) {
-		warning(pos, "I don't like non-power-of-2 alignments");
-		thistype->alignment = 0;
-	}
 	if (thistype->alignment > ctype->alignment)
 		ctype->alignment = thistype->alignment;
 
@@ -1138,9 +1230,8 @@ static struct token *declaration_specifiers(struct token *next, struct decl_stat
 	int size = 0;
 
 	while ( (token = next) != NULL ) {
-		struct ctype thistype;
 		struct ident *ident;
-		struct symbol *s, *type;
+		struct symbol *s;
 
 		next = token->next;
 		if (token_type(token) != TOKEN_IDENT)
@@ -1187,13 +1278,12 @@ static struct token *declaration_specifiers(struct token *next, struct decl_stat
 				seen |= Set_Vlong;
 			}
 		}
-		thistype = s->ctype;
 		if (s->op->declarator)
-			next = s->op->declarator(next, &thistype);
-		type = thistype.base_type;
-		if (type)
-			ctx->ctype.base_type = type;
-		apply_ctype(token->pos, &thistype, &ctx->ctype);
+			next = s->op->declarator(next, &ctx->ctype);
+		if (s->op->type & KW_EXACT) {
+			ctx->ctype.base_type = s->ctype.base_type;
+			ctx->ctype.modifiers |= s->ctype.modifiers;
+		}
 	}
 	if (qual)
 		return token;
@@ -1290,7 +1380,6 @@ static struct token *handle_attributes(struct token *token, struct ctype *ctype,
 {
 	struct symbol *keyword;
 	for (;;) {
-		struct ctype thistype = { 0, };
 		if (token_type(token) != TOKEN_IDENT)
 			break;
 		keyword = lookup_keyword(token->ident, NS_KEYWORD | NS_TYPEDEF);
@@ -1298,8 +1387,7 @@ static struct token *handle_attributes(struct token *token, struct ctype *ctype,
 			break;
 		if (!(keyword->op->type & keywords))
 			break;
-		token = keyword->op->declarator(token->next, &thistype);
-		apply_ctype(token->pos, &thistype, ctype);
+		token = keyword->op->declarator(token->next, ctype);
 		keywords &= KW_ATTRIBUTE;
 	}
 	return token;
diff --git a/symbol.h b/symbol.h
index f82f51d..07da99c 100644
--- a/symbol.h
+++ b/symbol.h
@@ -69,6 +69,7 @@ enum keyword {
 	KW_MODE		= 1 << 6,
 	KW_SHORT	= 1 << 7,
 	KW_LONG		= 1 << 8,
+	KW_EXACT	= 1 << 9,
 };
 
 struct context {
-- 
1.5.6.5


