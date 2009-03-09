From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 17/18] Pass decl_state down to ->attribute()
Date: Mon, 09 Mar 2009 07:12:58 +0000
Message-ID: <E1LgZfW-0000zR-37@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43817 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbZCIHNA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:13:00 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZfW-0000zR-37
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:12:58 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c  |   37 +++++++++++++++++++------------------
 symbol.h |    2 +-
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/parse.c b/parse.c
index 6976070..8fa9ac1 100644
--- a/parse.c
+++ b/parse.c
@@ -58,7 +58,8 @@ static struct token *parse_range_statement(struct token *token, struct statement
 static struct token *parse_asm_statement(struct token *token, struct statement *stmt);
 static struct token *toplevel_asm_declaration(struct token *token, struct symbol_list **list);
 
-typedef struct token *attr_t(struct token *, struct symbol *, struct ctype *);
+typedef struct token *attr_t(struct token *, struct symbol *,
+			     struct decl_state *);
 
 static attr_t
 	attribute_packed, attribute_aligned, attribute_modifier,
@@ -912,7 +913,7 @@ static struct token *typeof_specifier(struct token *token, struct decl_state *ct
 	return expect(token, ')', "after typeof");
 }
 
-static struct token *ignore_attribute(struct token *token, struct symbol *attr, struct ctype *ctype)
+static struct token *ignore_attribute(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
 	struct expression *expr = NULL;
 	if (match_op(token, '('))
@@ -920,14 +921,14 @@ static struct token *ignore_attribute(struct token *token, struct symbol *attr,
 	return token;
 }
 
-static struct token *attribute_packed(struct token *token, struct symbol *attr, struct ctype *ctype)
+static struct token *attribute_packed(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
-	if (!ctype->alignment)
-		ctype->alignment = 1;
+	if (!&ctx->ctype.alignment)
+		ctx->ctype.alignment = 1;
 	return token;
 }
 
-static struct token *attribute_aligned(struct token *token, struct symbol *attr, struct ctype *ctype)
+static struct token *attribute_aligned(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
 	int alignment = max_alignment;
 	struct expression *expr = NULL;
@@ -940,8 +941,8 @@ static struct token *attribute_aligned(struct token *token, struct symbol *attr,
 	if (alignment & (alignment-1)) {
 		warning(token->pos, "I don't like non-power-of-2 alignments");
 		return token;
-	} else if (alignment > ctype->alignment)
-		ctype->alignment = alignment;
+	} else if (alignment > ctx->ctype.alignment)
+		ctx->ctype.alignment = alignment;
 	return token;
 }
 
@@ -952,13 +953,13 @@ static void apply_qualifier(struct position *pos, struct ctype *ctx, unsigned lo
 	ctx->modifiers |= qual;
 }
 
-static struct token *attribute_modifier(struct token *token, struct symbol *attr, struct ctype *ctype)
+static struct token *attribute_modifier(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
-	apply_qualifier(&token->pos, ctype, attr->ctype.modifiers);
+	apply_qualifier(&token->pos, &ctx->ctype, attr->ctype.modifiers);
 	return token;
 }
 
-static struct token *attribute_address_space(struct token *token, struct symbol *attr, struct ctype *ctype)
+static struct token *attribute_address_space(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
 	struct expression *expr = NULL;
 	int as;
@@ -967,19 +968,19 @@ static struct token *attribute_address_space(struct token *token, struct symbol
 	if (expr) {
 		as = const_expression_value(expr);
 		if (as)
-			ctype->as = as;
+			ctx->ctype.as = as;
 	}
 	token = expect(token, ')', "after address_space attribute");
 	return token;
 }
 
-static struct token *attribute_mode(struct token *token, struct symbol *attr, struct ctype *ctype)
+static struct token *attribute_mode(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
 	token = expect(token, '(', "after mode attribute");
 	if (token_type(token) == TOKEN_IDENT) {
 		struct symbol *mode = lookup_keyword(token->ident, NS_KEYWORD);
 		if (mode && mode->op->type == KW_MODE)
-			ctype->modifiers |= mode->ctype.modifiers;
+			ctx->ctype.modifiers |= mode->ctype.modifiers;
 		else
 			sparse_error(token->pos, "unknown mode attribute %s\n", show_ident(token->ident));
 		token = token->next;
@@ -989,7 +990,7 @@ static struct token *attribute_mode(struct token *token, struct symbol *attr, st
 	return token;
 }
 
-static struct token *attribute_context(struct token *token, struct symbol *attr, struct ctype *ctype)
+static struct token *attribute_context(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
 	struct context *context = alloc_context();
 	struct expression *args[3];
@@ -1027,13 +1028,13 @@ static struct token *attribute_context(struct token *token, struct symbol *attr,
 	}
 
 	if (argc)
-		add_ptr_list(&ctype->contexts, context);
+		add_ptr_list(&ctx->ctype.contexts, context);
 
 	token = expect(token, ')', "after context attribute");
 	return token;
 }
 
-static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct ctype *ctype)
+static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
 	if (Wtransparent_union)
 		warning(token->pos, "ignoring attribute __transparent_union__");
@@ -1069,7 +1070,7 @@ static struct token *attribute_specifier(struct token *token, struct decl_state
 		attribute_name = token->ident;
 		attr = lookup_keyword(attribute_name, NS_KEYWORD);
 		if (attr && attr->op->attribute)
-			token = attr->op->attribute(token->next, attr, &ctx->ctype);
+			token = attr->op->attribute(token->next, attr, ctx);
 		else
 			token = recover_unknown_attribute(token);
 
diff --git a/symbol.h b/symbol.h
index fd75631..b74ab0c 100644
--- a/symbol.h
+++ b/symbol.h
@@ -105,7 +105,7 @@ struct symbol_op {
 	struct token *(*declarator)(struct token *token, struct decl_state *ctx);
 	struct token *(*statement)(struct token *token, struct statement *stmt);
 	struct token *(*toplevel)(struct token *token, struct symbol_list **list);
-	struct token *(*attribute)(struct token *token, struct symbol *attr, struct ctype *ctype);
+	struct token *(*attribute)(struct token *token, struct symbol *attr, struct decl_state *ctx);
 
 	int test, set, class;
 };
-- 
1.5.6.5


