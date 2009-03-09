From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 16/18] Pass decl_state down to ->declarator() and handle_attributes()
Date: Mon, 09 Mar 2009 07:12:48 +0000
Message-ID: <E1LgZfM-0000z3-2t@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43810 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbZCIHMu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:12:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZfM-0000z3-2t
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:12:48 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Other than for attributes of labels (completely ignored, and we can
simply use skip_attributes() there), all callers of handle_attributes
actually get ctype == &ctx->ctype for some ctx.  Ditto for ->declarator().
Switch both to passing ctx instead (has to be done at the same time,
since we have handle_attributes() called from ->declarator() for struct).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c  |   96 +++++++++++++++++++++++++++++++-------------------------------
 symbol.h |    2 +-
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/parse.c b/parse.c
index 9adba58..6976070 100644
--- a/parse.c
+++ b/parse.c
@@ -33,9 +33,9 @@ struct symbol_list *function_computed_target_list;
 struct statement_list *function_computed_goto_list;
 
 static struct token *statement(struct token *token, struct statement **tree);
-static struct token *handle_attributes(struct token *token, struct ctype *ctype, unsigned int keywords);
+static struct token *handle_attributes(struct token *token, struct decl_state *ctx, unsigned int keywords);
 
-typedef struct token *declarator_t(struct token *, struct ctype *);
+typedef struct token *declarator_t(struct token *, struct decl_state *);
 static declarator_t
 	struct_specifier, union_specifier, enum_specifier,
 	attribute_specifier, typeof_specifier, parse_asm_declarator,
@@ -595,13 +595,13 @@ struct symbol *label_symbol(struct token *token)
 }
 
 static struct token *struct_union_enum_specifier(enum type type,
-	struct token *token, struct ctype *ctype,
+	struct token *token, struct decl_state *ctx,
 	struct token *(*parse)(struct token *, struct symbol *))
 {
 	struct symbol *sym;
 	struct position *repos;
 
-	token = handle_attributes(token, ctype, KW_ATTRIBUTE);
+	token = handle_attributes(token, ctx, KW_ATTRIBUTE);
 	if (token_type(token) == TOKEN_IDENT) {
 		sym = lookup_symbol(token->ident, NS_STRUCT);
 		if (!sym ||
@@ -614,7 +614,7 @@ static struct token *struct_union_enum_specifier(enum type type,
 		}
 		if (sym->type != type)
 			error_die(token->pos, "invalid tag applied to %s", show_typename (sym));
-		ctype->base_type = sym;
+		ctx->ctype.base_type = sym;
 		repos = &token->pos;
 		token = token->next;
 		if (match_op(token, '{')) {
@@ -637,13 +637,13 @@ static struct token *struct_union_enum_specifier(enum type type,
 	// private struct/union/enum type
 	if (!match_op(token, '{')) {
 		sparse_error(token->pos, "expected declaration");
-		ctype->base_type = &bad_ctype;
+		ctx->ctype.base_type = &bad_ctype;
 		return token;
 	}
 
 	sym = alloc_symbol(token->pos, type);
 	token = parse(token->next, sym);
-	ctype->base_type = sym;
+	ctx->ctype.base_type = sym;
 	token =  expect(token, '}', "at end of specifier");
 	sym->endpos = token->pos;
 
@@ -673,14 +673,14 @@ static struct token *parse_union_declaration(struct token *token, struct symbol
 	return struct_declaration_list(token, &sym->symbol_list);
 }
 
-static struct token *struct_specifier(struct token *token, struct ctype *ctype)
+static struct token *struct_specifier(struct token *token, struct decl_state *ctx)
 {
-	return struct_union_enum_specifier(SYM_STRUCT, token, ctype, parse_struct_declaration);
+	return struct_union_enum_specifier(SYM_STRUCT, token, ctx, parse_struct_declaration);
 }
 
-static struct token *union_specifier(struct token *token, struct ctype *ctype)
+static struct token *union_specifier(struct token *token, struct decl_state *ctx)
 {
-	return struct_union_enum_specifier(SYM_UNION, token, ctype, parse_union_declaration);
+	return struct_union_enum_specifier(SYM_UNION, token, ctx, parse_union_declaration);
 }
 
 
@@ -877,11 +877,11 @@ static struct token *parse_enum_declaration(struct token *token, struct symbol *
 	return token;
 }
 
-static struct token *enum_specifier(struct token *token, struct ctype *ctype)
+static struct token *enum_specifier(struct token *token, struct decl_state *ctx)
 {
-	struct token *ret = struct_union_enum_specifier(SYM_ENUM, token, ctype, parse_enum_declaration);
+	struct token *ret = struct_union_enum_specifier(SYM_ENUM, token, ctx, parse_enum_declaration);
+	struct ctype *ctype = &ctx->ctype.base_type->ctype;
 
-	ctype = &ctype->base_type->ctype;
 	if (!ctype->base_type)
 		ctype->base_type = &incomplete_ctype;
 
@@ -890,7 +890,7 @@ static struct token *enum_specifier(struct token *token, struct ctype *ctype)
 
 static void apply_ctype(struct position pos, struct ctype *thistype, struct ctype *ctype);
 
-static struct token *typeof_specifier(struct token *token, struct ctype *ctype)
+static struct token *typeof_specifier(struct token *token, struct decl_state *ctx)
 {
 	struct symbol *sym;
 
@@ -900,14 +900,14 @@ static struct token *typeof_specifier(struct token *token, struct ctype *ctype)
 	}
 	if (lookup_type(token->next)) {
 		token = typename(token->next, &sym, 0);
-		ctype->base_type = sym->ctype.base_type;
-		apply_ctype(token->pos, &sym->ctype, ctype);
+		ctx->ctype.base_type = sym->ctype.base_type;
+		apply_ctype(token->pos, &sym->ctype, &ctx->ctype);
 	} else {
 		struct symbol *typeof_sym = alloc_symbol(token->pos, SYM_TYPEOF);
 		token = parse_expression(token->next, &typeof_sym->initializer);
 
 		typeof_sym->endpos = token->pos;
-		ctype->base_type = typeof_sym;
+		ctx->ctype.base_type = typeof_sym;
 	}		
 	return expect(token, ')', "after typeof");
 }
@@ -1051,7 +1051,7 @@ static struct token *recover_unknown_attribute(struct token *token)
 	return token;
 }
 
-static struct token *attribute_specifier(struct token *token, struct ctype *ctype)
+static struct token *attribute_specifier(struct token *token, struct decl_state *ctx)
 {
 	token = expect(token, '(', "after attribute");
 	token = expect(token, '(', "after attribute");
@@ -1069,7 +1069,7 @@ static struct token *attribute_specifier(struct token *token, struct ctype *ctyp
 		attribute_name = token->ident;
 		attr = lookup_keyword(attribute_name, NS_KEYWORD);
 		if (attr && attr->op->attribute)
-			token = attr->op->attribute(token->next, attr, ctype);
+			token = attr->op->attribute(token->next, attr, &ctx->ctype);
 		else
 			token = recover_unknown_attribute(token);
 
@@ -1095,51 +1095,51 @@ static void apply_modifier(struct position *pos, struct ctype *ctx, unsigned lon
 		sparse_error(*pos, "multiple storage classes");
 }
 
-static struct token *typedef_specifier(struct token *next, struct ctype *ctx)
+static struct token *typedef_specifier(struct token *next, struct decl_state *ctx)
 {
-	apply_modifier(&next->pos, ctx, MOD_TYPEDEF);
+	apply_modifier(&next->pos, &ctx->ctype, MOD_TYPEDEF);
 	return next;
 }
 
-static struct token *auto_specifier(struct token *next, struct ctype *ctx)
+static struct token *auto_specifier(struct token *next, struct decl_state *ctx)
 {
-	apply_modifier(&next->pos, ctx, MOD_AUTO);
+	apply_modifier(&next->pos, &ctx->ctype, MOD_AUTO);
 	return next;
 }
 
-static struct token *register_specifier(struct token *next, struct ctype *ctx)
+static struct token *register_specifier(struct token *next, struct decl_state *ctx)
 {
-	apply_modifier(&next->pos, ctx, MOD_REGISTER);
+	apply_modifier(&next->pos, &ctx->ctype, MOD_REGISTER);
 	return next;
 }
 
-static struct token *static_specifier(struct token *next, struct ctype *ctx)
+static struct token *static_specifier(struct token *next, struct decl_state *ctx)
 {
-	apply_modifier(&next->pos, ctx, MOD_STATIC);
+	apply_modifier(&next->pos, &ctx->ctype, MOD_STATIC);
 	return next;
 }
 
-static struct token *extern_specifier(struct token *next, struct ctype *ctx)
+static struct token *extern_specifier(struct token *next, struct decl_state *ctx)
 {
-	apply_modifier(&next->pos, ctx, MOD_EXTERN);
+	apply_modifier(&next->pos, &ctx->ctype, MOD_EXTERN);
 	return next;
 }
 
-static struct token *inline_specifier(struct token *next, struct ctype *ctx)
+static struct token *inline_specifier(struct token *next, struct decl_state *ctx)
 {
-	ctx->modifiers |= MOD_INLINE;
+	ctx->ctype.modifiers |= MOD_INLINE;
 	return next;
 }
 
-static struct token *const_qualifier(struct token *next, struct ctype *ctx)
+static struct token *const_qualifier(struct token *next, struct decl_state *ctx)
 {
-	apply_qualifier(&next->pos, ctx, MOD_CONST);
+	apply_qualifier(&next->pos, &ctx->ctype, MOD_CONST);
 	return next;
 }
 
-static struct token *volatile_qualifier(struct token *next, struct ctype *ctx)
+static struct token *volatile_qualifier(struct token *next, struct decl_state *ctx)
 {
-	apply_qualifier(&next->pos, ctx, MOD_VOLATILE);
+	apply_qualifier(&next->pos, &ctx->ctype, MOD_VOLATILE);
 	return next;
 }
 
@@ -1233,7 +1233,7 @@ static struct token *handle_qualifiers(struct token *t, struct decl_state *ctx)
 			break;
 		t = t->next;
 		if (s->op->declarator)
-			t = s->op->declarator(t, &ctx->ctype);
+			t = s->op->declarator(t, ctx);
 	}
 	return t;
 }
@@ -1280,7 +1280,7 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
 		}
 		token = token->next;
 		if (s->op->declarator)
-			token = s->op->declarator(token, &ctx->ctype);
+			token = s->op->declarator(token, ctx);
 		if (s->op->type & KW_EXACT) {
 			ctx->ctype.base_type = s->ctype.base_type;
 			ctx->ctype.modifiers |= s->ctype.modifiers;
@@ -1375,7 +1375,7 @@ static struct token *skip_attributes(struct token *token)
 	return token;
 }
 
-static struct token *handle_attributes(struct token *token, struct ctype *ctype, unsigned int keywords)
+static struct token *handle_attributes(struct token *token, struct decl_state *ctx, unsigned int keywords)
 {
 	struct symbol *keyword;
 	for (;;) {
@@ -1386,7 +1386,7 @@ static struct token *handle_attributes(struct token *token, struct ctype *ctype,
 			break;
 		if (!(keyword->op->type & keywords))
 			break;
-		token = keyword->op->declarator(token->next, ctype);
+		token = keyword->op->declarator(token->next, ctx);
 		keywords &= KW_ATTRIBUTE;
 	}
 	return token;
@@ -1473,7 +1473,7 @@ static struct token *direct_declarator(struct token *token, struct decl_state *c
 	    is_nested(token, &next, ctx->prefer_abstract)) {
 		struct symbol *base_type = ctype->base_type;
 		if (token->next != next)
-			next = handle_attributes(token->next, ctype,
+			next = handle_attributes(token->next, ctx,
 						  KW_ATTRIBUTE);
 		token = declarator(next, ctx);
 		token = expect(token, ')', "in nested declarator");
@@ -1606,7 +1606,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 		if (match_op(token, ':'))
 			token = handle_bitfield(token, &ctx);
 
-		token = handle_attributes(token, &ctx.ctype, KW_ATTRIBUTE);
+		token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
 		apply_modifiers(token->pos, &ctx.ctype);
 
 		decl->ctype = ctx.ctype;
@@ -1641,7 +1641,7 @@ static struct token *parameter_declaration(struct token *token, struct symbol *s
 	token = declaration_specifiers(token, &ctx);
 	ctx.ident = &sym->ident;
 	token = declarator(token, &ctx);
-	token = handle_attributes(token, &ctx.ctype, KW_ATTRIBUTE);
+	token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
 	apply_modifiers(token->pos, &ctx.ctype);
 	sym->ctype = ctx.ctype;
 	sym->endpos = token->pos;
@@ -1726,7 +1726,7 @@ static struct token *parse_asm_statement(struct token *token, struct statement *
 	return expect(token, ';', "at end of asm-statement");
 }
 
-static struct token *parse_asm_declarator(struct token *token, struct ctype *ctype)
+static struct token *parse_asm_declarator(struct token *token, struct decl_state *ctx)
 {
 	struct expression *expr;
 	token = expect(token, '(', "after asm");
@@ -2054,7 +2054,7 @@ static struct token *statement(struct token *token, struct statement **tree)
 		if (match_op(token->next, ':')) {
 			stmt->type = STMT_LABEL;
 			stmt->label_identifier = label_symbol(token);
-			token = handle_attributes(token->next->next, &stmt->label_identifier->ctype, KW_ATTRIBUTE);
+			token = skip_attributes(token->next->next);
 			return statement(token, &stmt->label_statement);
 		}
 	}
@@ -2440,7 +2440,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 
 	saved = ctx.ctype;
 	token = declarator(token, &ctx);
-	token = handle_attributes(token, &ctx.ctype, KW_ATTRIBUTE | KW_ASM);
+	token = handle_attributes(token, &ctx, KW_ATTRIBUTE | KW_ASM);
 	apply_modifiers(token->pos, &ctx.ctype);
 
 	decl->ctype = ctx.ctype;
@@ -2514,9 +2514,9 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		ident = NULL;
 		decl = alloc_symbol(token->pos, SYM_NODE);
 		ctx.ctype = saved;
-		token = handle_attributes(token, &ctx.ctype, KW_ATTRIBUTE);
+		token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
 		token = declarator(token, &ctx);
-		token = handle_attributes(token, &ctx.ctype, KW_ATTRIBUTE | KW_ASM);
+		token = handle_attributes(token, &ctx, KW_ATTRIBUTE | KW_ASM);
 		apply_modifiers(token->pos, &ctx.ctype);
 		decl->ctype = ctx.ctype;
 		decl->endpos = token->pos;
diff --git a/symbol.h b/symbol.h
index 07da99c..fd75631 100644
--- a/symbol.h
+++ b/symbol.h
@@ -102,7 +102,7 @@ struct symbol_op {
 	int (*args)(struct expression *);
 
 	/* keywords */
-	struct token *(*declarator)(struct token *token, struct ctype *ctype);
+	struct token *(*declarator)(struct token *token, struct decl_state *ctx);
 	struct token *(*statement)(struct token *token, struct statement *stmt);
 	struct token *(*toplevel)(struct token *token, struct symbol_list **list);
 	struct token *(*attribute)(struct token *token, struct symbol *attr, struct ctype *ctype);
-- 
1.5.6.5


