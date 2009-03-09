From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 18/18] Restore __attribute__((mode)) handling
Date: Mon, 09 Mar 2009 07:13:08 +0000
Message-ID: <E1LgZfg-000100-3K@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43823 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbZCIHNK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:13:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZfg-000100-3K
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:13:08 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


... at least to the extent we used to do it.  It still does _not_
cover the perversions gcc can do with that, but at least it deals
with regressions.  Full solution will have to wait for full-blown
imitation of what gcc people call __attribute__ semantics, the
bastards...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c                         |  118 ++++++++++++++++++++++++++++++++-------
 symbol.h                        |    4 +-
 validation/nested-declarator2.c |    1 +
 3 files changed, 101 insertions(+), 22 deletions(-)

diff --git a/parse.c b/parse.c
index 8fa9ac1..bffb690 100644
--- a/parse.c
+++ b/parse.c
@@ -67,6 +67,11 @@ static attr_t
 	attribute_transparent_union, ignore_attribute,
 	attribute_mode;
 
+typedef struct symbol *to_mode_t(struct symbol *);
+
+static to_mode_t
+	to_QI_mode, to_HI_mode, to_SI_mode, to_DI_mode, to_word_mode;
+
 enum {
 	Set_T = 1,
 	Set_S = 2,
@@ -309,8 +314,29 @@ static struct symbol_op ignore_attr_op = {
 	.attribute = ignore_attribute,
 };
 
-static struct symbol_op mode_spec_op = {
+static struct symbol_op mode_QI_op = {
+	.type = KW_MODE,
+	.to_mode = to_QI_mode
+};
+
+static struct symbol_op mode_HI_op = {
 	.type = KW_MODE,
+	.to_mode = to_HI_mode
+};
+
+static struct symbol_op mode_SI_op = {
+	.type = KW_MODE,
+	.to_mode = to_SI_mode
+};
+
+static struct symbol_op mode_DI_op = {
+	.type = KW_MODE,
+	.to_mode = to_DI_mode
+};
+
+static struct symbol_op mode_word_op = {
+	.type = KW_MODE,
+	.to_mode = to_word_mode
 };
 
 static struct init_keyword {
@@ -411,16 +437,16 @@ static struct init_keyword {
 	{ "__transparent_union__",	NS_KEYWORD,	.op = &transparent_union_op },
 
 	{ "__mode__",	NS_KEYWORD,	.op = &mode_op },
-	{ "QI",		NS_KEYWORD,	MOD_CHAR,	.op = &mode_spec_op },
-	{ "__QI__",	NS_KEYWORD,	MOD_CHAR,	.op = &mode_spec_op },
-	{ "HI",		NS_KEYWORD,	MOD_SHORT,	.op = &mode_spec_op },
-	{ "__HI__",	NS_KEYWORD,	MOD_SHORT,	.op = &mode_spec_op },
-	{ "SI",		NS_KEYWORD,			.op = &mode_spec_op },
-	{ "__SI__",	NS_KEYWORD,			.op = &mode_spec_op },
-	{ "DI",		NS_KEYWORD,	MOD_LONGLONG,	.op = &mode_spec_op },
-	{ "__DI__",	NS_KEYWORD,	MOD_LONGLONG,	.op = &mode_spec_op },
-	{ "word",	NS_KEYWORD,	MOD_LONG,	.op = &mode_spec_op },
-	{ "__word__",	NS_KEYWORD,	MOD_LONG,	.op = &mode_spec_op },
+	{ "QI",		NS_KEYWORD,	MOD_CHAR,	.op = &mode_QI_op },
+	{ "__QI__",	NS_KEYWORD,	MOD_CHAR,	.op = &mode_QI_op },
+	{ "HI",		NS_KEYWORD,	MOD_SHORT,	.op = &mode_HI_op },
+	{ "__HI__",	NS_KEYWORD,	MOD_SHORT,	.op = &mode_HI_op },
+	{ "SI",		NS_KEYWORD,			.op = &mode_SI_op },
+	{ "__SI__",	NS_KEYWORD,			.op = &mode_SI_op },
+	{ "DI",		NS_KEYWORD,	MOD_LONGLONG,	.op = &mode_DI_op },
+	{ "__DI__",	NS_KEYWORD,	MOD_LONGLONG,	.op = &mode_DI_op },
+	{ "word",	NS_KEYWORD,	MOD_LONG,	.op = &mode_word_op },
+	{ "__word__",	NS_KEYWORD,	MOD_LONG,	.op = &mode_word_op },
 
 	/* Ignored attributes */
 	{ "nothrow",	NS_KEYWORD,	.op = &ignore_attr_op },
@@ -542,10 +568,18 @@ struct statement *alloc_statement(struct position pos, int type)
 
 static struct token *struct_declaration_list(struct token *token, struct symbol_list **list);
 
-static int apply_modifiers(struct position pos, struct ctype *ctype)
+static void apply_modifiers(struct position pos, struct decl_state *ctx)
 {
-	/* not removing it; application of delayed attributes will be here */
-	return 0;
+	struct symbol *ctype;
+	if (!ctx->mode)
+		return;
+	ctype = ctx->mode->to_mode(ctx->ctype.base_type);
+	if (!ctype)
+		sparse_error(pos, "don't know how to apply mode to %s",
+				show_typename(ctx->ctype.base_type));
+	else
+		ctx->ctype.base_type = ctype;
+	
 }
 
 static struct symbol * alloc_indirect_symbol(struct position pos, struct ctype *ctype, int type)
@@ -974,13 +1008,55 @@ static struct token *attribute_address_space(struct token *token, struct symbol
 	return token;
 }
 
+static struct symbol *to_QI_mode(struct symbol *ctype)
+{
+	if (ctype->ctype.base_type != &int_type)
+		return NULL;
+	if (ctype == &char_ctype)
+		return ctype;
+	return ctype->ctype.modifiers & MOD_UNSIGNED ? &uchar_ctype
+						     : &schar_ctype;
+}
+
+static struct symbol *to_HI_mode(struct symbol *ctype)
+{
+	if (ctype->ctype.base_type != &int_type)
+		return NULL;
+	return ctype->ctype.modifiers & MOD_UNSIGNED ? &ushort_ctype
+						     : &sshort_ctype;
+}
+
+static struct symbol *to_SI_mode(struct symbol *ctype)
+{
+	if (ctype->ctype.base_type != &int_type)
+		return NULL;
+	return ctype->ctype.modifiers & MOD_UNSIGNED ? &uint_ctype
+						     : &sint_ctype;
+}
+
+static struct symbol *to_DI_mode(struct symbol *ctype)
+{
+	if (ctype->ctype.base_type != &int_type)
+		return NULL;
+	return ctype->ctype.modifiers & MOD_UNSIGNED ? &ullong_ctype
+						     : &sllong_ctype;
+}
+
+static struct symbol *to_word_mode(struct symbol *ctype)
+{
+	if (ctype->ctype.base_type != &int_type)
+		return NULL;
+	return ctype->ctype.modifiers & MOD_UNSIGNED ? &ulong_ctype
+						     : &slong_ctype;
+}
+
 static struct token *attribute_mode(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
 	token = expect(token, '(', "after mode attribute");
 	if (token_type(token) == TOKEN_IDENT) {
 		struct symbol *mode = lookup_keyword(token->ident, NS_KEYWORD);
 		if (mode && mode->op->type == KW_MODE)
-			ctx->ctype.modifiers |= mode->ctype.modifiers;
+			ctx->mode = mode->op;
 		else
 			sparse_error(token->pos, "unknown mode attribute %s\n", show_ident(token->ident));
 		token = token->next;
@@ -1608,7 +1684,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 			token = handle_bitfield(token, &ctx);
 
 		token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
-		apply_modifiers(token->pos, &ctx.ctype);
+		apply_modifiers(token->pos, &ctx);
 
 		decl->ctype = ctx.ctype;
 		decl->endpos = token->pos;
@@ -1643,7 +1719,7 @@ static struct token *parameter_declaration(struct token *token, struct symbol *s
 	ctx.ident = &sym->ident;
 	token = declarator(token, &ctx);
 	token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
-	apply_modifiers(token->pos, &ctx.ctype);
+	apply_modifiers(token->pos, &ctx);
 	sym->ctype = ctx.ctype;
 	sym->endpos = token->pos;
 	return token;
@@ -1656,7 +1732,7 @@ struct token *typename(struct token *token, struct symbol **p, int mod)
 	*p = sym;
 	token = declaration_specifiers(token, &ctx);
 	token = declarator(token, &ctx);
-	apply_modifiers(token->pos, &ctx.ctype);
+	apply_modifiers(token->pos, &ctx);
 	if (ctx.ctype.modifiers & MOD_STORAGE & ~mod)
 		warning(sym->pos, "storage class in typename (%s)",
 			show_typename(sym));
@@ -2435,14 +2511,14 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	decl = alloc_symbol(token->pos, SYM_NODE);
 	/* Just a type declaration? */
 	if (match_op(token, ';')) {
-		apply_modifiers(token->pos, &ctx.ctype);
+		apply_modifiers(token->pos, &ctx);
 		return token->next;
 	}
 
 	saved = ctx.ctype;
 	token = declarator(token, &ctx);
 	token = handle_attributes(token, &ctx, KW_ATTRIBUTE | KW_ASM);
-	apply_modifiers(token->pos, &ctx.ctype);
+	apply_modifiers(token->pos, &ctx);
 
 	decl->ctype = ctx.ctype;
 	decl->endpos = token->pos;
@@ -2518,7 +2594,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
 		token = declarator(token, &ctx);
 		token = handle_attributes(token, &ctx, KW_ATTRIBUTE | KW_ASM);
-		apply_modifiers(token->pos, &ctx.ctype);
+		apply_modifiers(token->pos, &ctx);
 		decl->ctype = ctx.ctype;
 		decl->endpos = token->pos;
 		if (!ident) {
diff --git a/symbol.h b/symbol.h
index b74ab0c..f9944bf 100644
--- a/symbol.h
+++ b/symbol.h
@@ -91,8 +91,9 @@ struct ctype {
 
 struct decl_state {
 	struct ctype ctype;
-	int prefer_abstract;
 	struct ident **ident;
+	int prefer_abstract;
+	struct symbol_op *mode;
 };
 
 struct symbol_op {
@@ -106,6 +107,7 @@ struct symbol_op {
 	struct token *(*statement)(struct token *token, struct statement *stmt);
 	struct token *(*toplevel)(struct token *token, struct symbol_list **list);
 	struct token *(*attribute)(struct token *token, struct symbol *attr, struct decl_state *ctx);
+	struct symbol *(*to_mode)(struct symbol *);
 
 	int test, set, class;
 };
diff --git a/validation/nested-declarator2.c b/validation/nested-declarator2.c
index cd22853..345a04b 100644
--- a/validation/nested-declarator2.c
+++ b/validation/nested-declarator2.c
@@ -32,6 +32,7 @@ nested-declarator2.c:17:1: warning: non-ANSI definition of function 'w1'
 nested-declarator2.c:21:21: warning: non-ANSI function declaration of function '<noident>'
 nested-declarator2.c:22:16: warning: variadic functions must have one named argument
 nested-declarator2.c:24:21: warning: identifier list not in definition
+nested-declarator2.c:25:45: error: don't know how to apply mode to incomplete type
 nested-declarator2.c:26:13: error: Expected ) in nested declarator
 nested-declarator2.c:26:13: error: got -
 nested-declarator2.c:27:16: error: Expected ; at the end of type declaration
-- 
1.5.6.5

