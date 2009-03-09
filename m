From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 2/18] Don't mess with passing symbol to declarator/direct_declarator
Date: Mon, 09 Mar 2009 07:10:28 +0000
Message-ID: <E1LgZd6-0000rf-0B@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43723 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbZCIHKa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:10:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZd6-0000rf-0B
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:10:28 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


There's no reason to pass symbol to declarator/direct_declarator;
we only use &sym->ctype, so passing ctype * is fine.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/parse.c b/parse.c
index d70166a..74a8103 100644
--- a/parse.c
+++ b/parse.c
@@ -1153,7 +1153,7 @@ static struct token *abstract_array_declarator(struct token *token, struct symbo
 
 static struct token *parameter_type_list(struct token *, struct symbol *);
 static struct token *identifier_list(struct token *, struct symbol *);
-static struct token *declarator(struct token *token, struct symbol *sym, struct ident **p, int);
+static struct token *declarator(struct token *token, struct ctype *ctx, struct ident **p, int);
 
 static struct token *skip_attribute(struct token *token)
 {
@@ -1281,9 +1281,9 @@ static enum kind which_kind(struct token *token, struct token **p,
 	return dont_nest ? Bad_Func : Nested;
 }
 
-static struct token *direct_declarator(struct token *token, struct symbol *decl, struct ident **p, int prefer_abstract)
+static struct token *direct_declarator(struct token *token, struct ctype *ctx, struct ident **p, int prefer_abstract)
 {
-	struct ctype *ctype = &decl->ctype;
+	struct ctype *ctype = ctx;
 	int dont_nest = 0;
 
 	if (p && token_type(token) == TOKEN_IDENT) {
@@ -1309,7 +1309,7 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
 				if (token->next != next)
 					next = handle_attributes(token->next, ctype,
 								  KW_ATTRIBUTE);
-				token = declarator(next, decl, p, prefer_abstract);
+				token = declarator(next, ctx, p, prefer_abstract);
 				token = expect(token, ')', "in nested declarator");
 				while (ctype->base_type != base_type)
 					ctype = &ctype->base_type->ctype;
@@ -1378,10 +1378,10 @@ static struct token *pointer(struct token *token, struct ctype *ctype)
 	return token;
 }
 
-static struct token *declarator(struct token *token, struct symbol *sym, struct ident **p, int prefer_abstract)
+static struct token *declarator(struct token *token, struct ctype *ctx, struct ident **p, int prefer_abstract)
 {
-	token = pointer(token, &sym->ctype);
-	return direct_declarator(token, sym, p, prefer_abstract);
+	token = pointer(token, ctx);
+	return direct_declarator(token, ctx, p, prefer_abstract);
 }
 
 static struct token *handle_bitfield(struct token *token, struct symbol *decl)
@@ -1441,7 +1441,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 		struct ident *ident = NULL;
 		struct symbol *decl = alloc_symbol(token->pos, SYM_NODE);
 		decl->ctype = ctype;
-		token = declarator(token, decl, &ident, 0);
+		token = declarator(token, &decl->ctype, &ident, 0);
 
 		decl->ident = ident;
 		if (match_op(token, ':'))
@@ -1474,15 +1474,13 @@ static struct token *struct_declaration_list(struct token *token, struct symbol_
 
 static struct token *parameter_declaration(struct token *token, struct symbol *sym)
 {
-	struct ident *ident = NULL;
 	struct ctype ctype = {0, };
 
 	token = declaration_specifiers(token, &ctype, 0);
+	token = declarator(token, &ctype, &sym->ident, 1);
+	token = handle_attributes(token, &ctype, KW_ATTRIBUTE);
+	apply_modifiers(token->pos, &ctype);
 	sym->ctype = ctype;
-	token = declarator(token, sym, &ident, 1);
-	token = handle_attributes(token, &sym->ctype, KW_ATTRIBUTE);
-	sym->ident = ident;
-	apply_modifiers(token->pos, &sym->ctype);
 	sym->endpos = token->pos;
 	return token;
 }
@@ -1492,7 +1490,7 @@ struct token *typename(struct token *token, struct symbol **p, int mod)
 	struct symbol *sym = alloc_symbol(token->pos, SYM_NODE);
 	*p = sym;
 	token = declaration_specifiers(token, &sym->ctype, 0);
-	token = declarator(token, sym, NULL, 1);
+	token = declarator(token, &sym->ctype, NULL, 1);
 	apply_modifiers(token->pos, &sym->ctype);
 	if (sym->ctype.modifiers & MOD_STORAGE & ~mod)
 		warning(sym->pos, "storage class in typename (%s)",
@@ -2275,7 +2273,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		return token->next;
 	}
 
-	token = declarator(token, decl, &ident, 0);
+	token = declarator(token, &decl->ctype, &ident, 0);
 	token = handle_attributes(token, &decl->ctype, KW_ATTRIBUTE | KW_ASM);
 	apply_modifiers(token->pos, &decl->ctype);
 
@@ -2350,7 +2348,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		decl = alloc_symbol(token->pos, SYM_NODE);
 		decl->ctype = ctype;
 		token = handle_attributes(token, &decl->ctype, KW_ATTRIBUTE);
-		token = declarator(token, decl, &ident, 0);
+		token = declarator(token, &decl->ctype, &ident, 0);
 		token = handle_attributes(token, &decl->ctype, KW_ATTRIBUTE | KW_ASM);
 		apply_modifiers(token->pos, &decl->ctype);
 		decl->endpos = token->pos;
-- 
1.5.6.5


