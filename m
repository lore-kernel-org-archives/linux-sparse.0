From: Al Viro <viro@ftp.linux.org.uk>
Subject: Don't mix storage class bits with ctype->modifiers while parsing type
Date: Wed, 11 Mar 2009 07:08:25 +0000
Message-ID: <E1LhIYD-00040j-D5@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:41394 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbZCKHI1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 11 Mar 2009 03:08:27 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LhIYD-00040j-D5
	for linux-sparse@vger.kernel.org; Wed, 11 Mar 2009 07:08:25 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Keep storage class (and "is it inline") explicitly in decl_state;
translate to modifiers only when we are done with parsing.  That
avoids the need to separate MOD_STORAGE bits while constructing
the type (e.g. in alloc_indirect_symbol(), etc.).  It also allows
to get rid of MOD_FORCE for good - instead of passing it to typename()
we pass an int * and let typename() tell whether we'd got a force-cast.
Indication of force-cast never makes it into the modifier bits at all.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 expression.c |   12 +++----
 expression.h |    2 +-
 gdbhelpers   |    3 --
 parse.c      |  107 ++++++++++++++++++++++++++++++++++++++++++----------------
 symbol.h     |    5 +--
 5 files changed, 86 insertions(+), 43 deletions(-)

diff --git a/expression.c b/expression.c
index 7c88a28..c9277da 100644
--- a/expression.c
+++ b/expression.c
@@ -118,7 +118,7 @@ static struct token *parse_type(struct token *token, struct expression **tree)
 	struct symbol *sym;
 	*tree = alloc_expression(token->pos, EXPR_TYPE);
 	(*tree)->flags = Int_const_expr; /* sic */
-	token = typename(token, &sym, 0);
+	token = typename(token, &sym, NULL);
 	if (sym->ident)
 		sparse_error(token->pos,
 			     "type expression should not include identifier "
@@ -167,7 +167,7 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		return expect(token, '(', "after __builtin_offset");
 
 	token = token->next;
-	token = typename(token, &sym, 0);
+	token = typename(token, &sym, NULL);
 	if (sym->ident)
 		sparse_error(token->pos,
 			     "type expression should not include identifier "
@@ -482,7 +482,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 		if (token->special == '[' && lookup_type(token->next)) {
 			expr = alloc_expression(token->pos, EXPR_TYPE);
 			expr->flags = Int_const_expr; /* sic */
-			token = typename(token->next, &expr->symbol, 0);
+			token = typename(token->next, &expr->symbol, NULL);
 			token = expect(token, ']', "in type expression");
 			break;
 		}
@@ -602,7 +602,7 @@ static struct token *type_info_expression(struct token *token,
 	if (!match_op(token, '(') || !lookup_type(token->next))
 		return unary_expression(token, &expr->cast_expression);
 	p = token;
-	token = typename(token->next, &expr->cast_type, 0);
+	token = typename(token->next, &expr->cast_type, NULL);
 
 	if (!match_op(token, ')')) {
 		static const char * error[] = {
@@ -727,10 +727,8 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 			struct symbol *sym;
 			int is_force;
 
-			token = typename(next, &sym, MOD_FORCE);
+			token = typename(next, &sym, &is_force);
 			cast->cast_type = sym;
-			is_force = sym->ctype.modifiers & MOD_FORCE;
-			sym->ctype.modifiers &= ~MOD_FORCE;
 			token = expect(token, ')', "at end of cast operator");
 			if (match_op(token, '{')) {
 				if (is_force)
diff --git a/expression.h b/expression.h
index 2e12b12..631224f 100644
--- a/expression.h
+++ b/expression.h
@@ -193,7 +193,7 @@ static inline struct expression *alloc_const_expression(struct position pos, int
 }
 
 /* Type name parsing */
-struct token *typename(struct token *, struct symbol **, int);
+struct token *typename(struct token *, struct symbol **, int *);
 
 static inline int lookup_type(struct token *token)
 {
diff --git a/gdbhelpers b/gdbhelpers
index e28417a..db78d6c 100644
--- a/gdbhelpers
+++ b/gdbhelpers
@@ -158,9 +158,6 @@ define gdb_show_ctype
 	if ($arg0->modifiers & MOD_USERTYPE)
 		printf "MOD_USERTYPE "
 	end
-	if ($arg0->modifiers & MOD_FORCE)
-		printf "MOD_FORCE "
-	end
 	if ($arg0->modifiers & MOD_EXPLICITLY_SIGNED)
 		printf "MOD_EXPLICITLY_SIGNED"
 	end
diff --git a/parse.c b/parse.c
index e99ca3d..28bc0c9 100644
--- a/parse.c
+++ b/parse.c
@@ -65,7 +65,7 @@ static attr_t
 	attribute_packed, attribute_aligned, attribute_modifier,
 	attribute_address_space, attribute_context,
 	attribute_transparent_union, ignore_attribute,
-	attribute_mode;
+	attribute_mode, attribute_force;
 
 typedef struct symbol *to_mode_t(struct symbol *);
 
@@ -91,6 +91,10 @@ enum {
 	CInt = 0, CSInt, CUInt, CReal, CChar, CSChar, CUChar
 };
 
+enum {
+	SNone = 0, STypedef, SAuto, SRegister, SExtern, SStatic, SForced
+};
+
 static struct symbol_op typedef_op = {
 	.type = KW_MODIFIER,
 	.declarator = typedef_specifier,
@@ -294,6 +298,10 @@ static struct symbol_op attr_mod_op = {
 	.attribute = attribute_modifier,
 };
 
+static struct symbol_op attr_force_op = {
+	.attribute = attribute_force,
+};
+
 static struct symbol_op address_space_op = {
 	.attribute = attribute_address_space,
 };
@@ -426,7 +434,7 @@ static struct init_keyword {
 	{ "nocast",	NS_KEYWORD,	MOD_NOCAST,	.op = &attr_mod_op },
 	{ "noderef",	NS_KEYWORD,	MOD_NODEREF,	.op = &attr_mod_op },
 	{ "safe",	NS_KEYWORD,	MOD_SAFE, 	.op = &attr_mod_op },
-	{ "force",	NS_KEYWORD,	MOD_FORCE,	.op = &attr_mod_op },
+	{ "force",	NS_KEYWORD,	.op = &attr_force_op },
 	{ "bitwise",	NS_KEYWORD,	MOD_BITWISE,	.op = &attr_mod_op },
 	{ "__bitwise__",NS_KEYWORD,	MOD_BITWISE,	.op = &attr_mod_op },
 	{ "address_space",NS_KEYWORD,	.op = &address_space_op },
@@ -585,10 +593,10 @@ static struct symbol * alloc_indirect_symbol(struct position pos, struct ctype *
 	struct symbol *sym = alloc_symbol(pos, type);
 
 	sym->ctype.base_type = ctype->base_type;
-	sym->ctype.modifiers = ctype->modifiers & ~MOD_STORAGE;
+	sym->ctype.modifiers = ctype->modifiers;
 
 	ctype->base_type = sym;
-	ctype->modifiers &= MOD_STORAGE;
+	ctype->modifiers = 0;
 	return sym;
 }
 
@@ -912,7 +920,7 @@ static struct token *typeof_specifier(struct token *token, struct decl_state *ct
 		return token;
 	}
 	if (lookup_type(token->next)) {
-		token = typename(token->next, &sym, 0);
+		token = typename(token->next, &sym, NULL);
 		ctx->ctype.base_type = sym->ctype.base_type;
 		apply_ctype(token->pos, &sym->ctype, &ctx->ctype);
 	} else {
@@ -1138,51 +1146,79 @@ static struct token *attribute_specifier(struct token *token, struct decl_state
 	return token;
 }
 
-static void apply_modifier(struct position *pos, struct ctype *ctx, unsigned long modifier)
+static const char *storage_class[] = 
 {
-	if (!(ctx->modifiers & MOD_STORAGE & ~MOD_INLINE)) {
-		ctx->modifiers |= modifier;
+	[STypedef] = "typedef",
+	[SAuto] = "auto",
+	[SExtern] = "extern",
+	[SStatic] = "static",
+	[SRegister] = "register",
+	[SForced] = "[force]"
+};
+
+static unsigned long storage_modifiers(struct decl_state *ctx)
+{
+	static unsigned long mod[] = 
+	{
+		[SAuto] = MOD_AUTO,
+		[SExtern] = MOD_EXTERN,
+		[SStatic] = MOD_STATIC,
+		[SRegister] = MOD_REGISTER
+	};
+	return mod[ctx->storage_class] | (ctx->is_inline ? MOD_INLINE : 0);
+}
+
+static void set_storage_class(struct position *pos, struct decl_state *ctx, int class)
+{
+	if (!ctx->storage_class) {
+		ctx->storage_class = class;
 		return;
 	}
-	if (ctx->modifiers & modifier)
-		sparse_error(*pos, "duplicate %s", modifier_string(modifier));
+	if (ctx->storage_class == class)
+		sparse_error(*pos, "duplicate %s", storage_class[class]);
 	else
 		sparse_error(*pos, "multiple storage classes");
 }
 
 static struct token *typedef_specifier(struct token *next, struct decl_state *ctx)
 {
-	apply_modifier(&next->pos, &ctx->ctype, MOD_TYPEDEF);
+	set_storage_class(&next->pos, ctx, STypedef);
 	return next;
 }
 
 static struct token *auto_specifier(struct token *next, struct decl_state *ctx)
 {
-	apply_modifier(&next->pos, &ctx->ctype, MOD_AUTO);
+	set_storage_class(&next->pos, ctx, SAuto);
 	return next;
 }
 
 static struct token *register_specifier(struct token *next, struct decl_state *ctx)
 {
-	apply_modifier(&next->pos, &ctx->ctype, MOD_REGISTER);
+	set_storage_class(&next->pos, ctx, SRegister);
 	return next;
 }
 
 static struct token *static_specifier(struct token *next, struct decl_state *ctx)
 {
-	apply_modifier(&next->pos, &ctx->ctype, MOD_STATIC);
+	set_storage_class(&next->pos, ctx, SStatic);
 	return next;
 }
 
 static struct token *extern_specifier(struct token *next, struct decl_state *ctx)
 {
-	apply_modifier(&next->pos, &ctx->ctype, MOD_EXTERN);
+	set_storage_class(&next->pos, ctx, SExtern);
 	return next;
 }
 
+static struct token *attribute_force(struct token *token, struct symbol *attr, struct decl_state *ctx)
+{
+	set_storage_class(&token->pos, ctx, SForced);
+	return token;
+}
+
 static struct token *inline_specifier(struct token *next, struct decl_state *ctx)
 {
-	ctx->ctype.modifiers |= MOD_INLINE;
+	ctx->is_inline = 1;
 	return next;
 }
 
@@ -1559,20 +1595,19 @@ static struct token *pointer(struct token *token, struct decl_state *ctx)
 	unsigned long modifiers;
 	struct symbol *base_type;
 
-	modifiers = ctx->ctype.modifiers & ~MOD_TYPEDEF;
+	modifiers = ctx->ctype.modifiers;
 	base_type = ctx->ctype.base_type;
-	ctx->ctype.modifiers = modifiers;
 
 	while (match_op(token,'*')) {
 		struct symbol *ptr = alloc_symbol(token->pos, SYM_PTR);
-		ptr->ctype.modifiers = modifiers & ~MOD_STORAGE;
+		ptr->ctype.modifiers = modifiers;
 		ptr->ctype.as = ctx->ctype.as;
 		concat_ptr_list((struct ptr_list *)ctx->ctype.contexts,
 				(struct ptr_list **)&ptr->ctype.contexts);
 		ptr->ctype.base_type = base_type;
 
 		base_type = ptr;
-		ctx->ctype.modifiers = modifiers & MOD_STORAGE;
+		ctx->ctype.modifiers = 0;
 		ctx->ctype.base_type = base_type;
 		ctx->ctype.as = 0;
 		free_ptr_list(&ctx->ctype.contexts);
@@ -1642,8 +1677,10 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 {
 	struct decl_state ctx = {.prefer_abstract = 0};
 	struct ctype saved;
+	unsigned long mod;
 
 	token = declaration_specifiers(token, &ctx);
+	mod = storage_modifiers(&ctx);
 	saved = ctx.ctype;
 	for (;;) {
 		struct symbol *decl = alloc_symbol(token->pos, SYM_NODE);
@@ -1657,6 +1694,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 		apply_modifiers(token->pos, &ctx);
 
 		decl->ctype = ctx.ctype;
+		decl->ctype.modifiers |= mod;
 		decl->endpos = token->pos;
 		add_symbol(list, decl);
 		if (!match_op(token, ','))
@@ -1691,23 +1729,33 @@ static struct token *parameter_declaration(struct token *token, struct symbol *s
 	token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
 	apply_modifiers(token->pos, &ctx);
 	sym->ctype = ctx.ctype;
+	sym->ctype.modifiers |= storage_modifiers(&ctx);
 	sym->endpos = token->pos;
 	return token;
 }
 
-struct token *typename(struct token *token, struct symbol **p, int mod)
+struct token *typename(struct token *token, struct symbol **p, int *forced)
 {
 	struct decl_state ctx = {.prefer_abstract = 1};
+	int class;
 	struct symbol *sym = alloc_symbol(token->pos, SYM_NODE);
 	*p = sym;
 	token = declaration_specifiers(token, &ctx);
 	token = declarator(token, &ctx);
 	apply_modifiers(token->pos, &ctx);
-	if (ctx.ctype.modifiers & MOD_STORAGE & ~mod)
-		warning(sym->pos, "storage class in typename (%s)",
-			show_typename(sym));
 	sym->ctype = ctx.ctype;
 	sym->endpos = token->pos;
+	class = ctx.storage_class;
+	if (forced) {
+		*forced = 0;
+		if (class == SForced) {
+			*forced = 1;
+			class = 0;
+		}
+	}
+	if (class)
+		warning(sym->pos, "storage class in typename (%s %s)",
+			storage_class[class], show_typename(sym));
 	return token;
 }
 
@@ -2487,6 +2535,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	struct decl_state ctx = { .ident = &ident };
 	struct ctype saved;
 	struct symbol *base_type;
+	unsigned long mod;
 	int is_typedef;
 
 	/* Top-level inline asm? */
@@ -2498,6 +2547,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 
 	/* Parse declaration-specifiers, if any */
 	token = declaration_specifiers(token, &ctx);
+	mod = storage_modifiers(&ctx);
 	decl = alloc_symbol(token->pos, SYM_NODE);
 	/* Just a type declaration? */
 	if (match_op(token, ';')) {
@@ -2511,6 +2561,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	apply_modifiers(token->pos, &ctx);
 
 	decl->ctype = ctx.ctype;
+	decl->ctype.modifiers |= mod;
 	decl->endpos = token->pos;
 
 	/* Just a type declaration? */
@@ -2520,14 +2571,11 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	}
 
 	/* type define declaration? */
-	is_typedef = (saved.modifiers & MOD_TYPEDEF) != 0;
+	is_typedef = ctx.storage_class == STypedef;
 
 	/* Typedefs don't have meaningful storage */
-	if (is_typedef) {
-		saved.modifiers &= ~MOD_STORAGE;
-		decl->ctype.modifiers &= ~MOD_STORAGE;
+	if (is_typedef)
 		decl->ctype.modifiers |= MOD_USERTYPE;
-	}
 
 	bind_symbol(decl, ident, is_typedef ? NS_TYPEDEF: NS_SYMBOL);
 
@@ -2586,6 +2634,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		token = handle_attributes(token, &ctx, KW_ATTRIBUTE | KW_ASM);
 		apply_modifiers(token->pos, &ctx);
 		decl->ctype = ctx.ctype;
+		decl->ctype.modifiers |= mod;
 		decl->endpos = token->pos;
 		if (!ident) {
 			sparse_error(token->pos, "expected identifier name in type definition");
diff --git a/symbol.h b/symbol.h
index f58c80a..da4d64a 100644
--- a/symbol.h
+++ b/symbol.h
@@ -92,8 +92,8 @@ struct ctype {
 struct decl_state {
 	struct ctype ctype;
 	struct ident **ident;
-	int prefer_abstract;
 	struct symbol_op *mode;
+	unsigned char prefer_abstract, is_inline, storage_class;
 };
 
 struct symbol_op {
@@ -212,12 +212,11 @@ struct symbol {
 #define MOD_SAFE	0x8000000	// non-null/non-trapping pointer
 
 #define MOD_USERTYPE	0x10000000
-#define MOD_FORCE	0x20000000
 #define MOD_EXPLICITLY_SIGNED	0x40000000
 #define MOD_BITWISE	0x80000000
 
 #define MOD_NONLOCAL	(MOD_EXTERN | MOD_TOPLEVEL)
-#define MOD_STORAGE	(MOD_AUTO | MOD_REGISTER | MOD_STATIC | MOD_EXTERN | MOD_INLINE | MOD_TOPLEVEL | MOD_FORCE)
+#define MOD_STORAGE	(MOD_AUTO | MOD_REGISTER | MOD_STATIC | MOD_EXTERN | MOD_INLINE | MOD_TOPLEVEL)
 #define MOD_SIGNEDNESS	(MOD_SIGNED | MOD_UNSIGNED | MOD_EXPLICITLY_SIGNED)
 #define MOD_SPECIFIER	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG | MOD_SIGNEDNESS)
 #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG)
-- 
1.5.6.5


