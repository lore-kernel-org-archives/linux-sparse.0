From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 4/7] Fix attribute/asm handling
Date: Sat, 14 Feb 2009 12:25:35 +0000
Message-ID: <E1LYJaR-0001oC-Kt@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37434 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbZBNMZh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 14 Feb 2009 07:25:37 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LYJaR-0001oC-Kt
	for linux-sparse@vger.kernel.org; Sat, 14 Feb 2009 12:25:35 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


a) asm aliases are accepted by gcc *only* directly after the top-level
declarator within external declaration (and they make no sense whatsoever
elsewhere - field names, function parameter names, casts, etc. simply
do not reach the assembler).  Anyway, gcc parser will reject those
anywhere else.

b) post-declarator attributes are *not* accepted in nested declarators.
In bitfield declarations they must follow the entire thing, _including_
:<width>.  They are not accepted in typenames either.  Basically, gcc
has distinction between the attributes of type and attributes of
declaration; "after the entire declaration" is for the latter and they
get applied to type only as a fallback.  So that's deliberate on part
of gcc...

c) no attributes in direct-declarator in front of [.....] or (.....).
Again, gcc behaviour.

d) in external declarations only attributes are accepted after commas.
IOW, you can't write int x, const *y, z; and get away with that.
Replacing const with __attribute__((...)) will get it accepted by
gcc, so we need to accept that variant.  However, any qualifiers
in that position will get rejected by anything, including gcc.

Note that there's a damn good reason why such syntax is a bad idea and
that reason applies to attributes as well.  Think what happens if later
we remove 'x' from the example above; 'z' will suddenly become const int.
So I think we want eventually to warn about the use of attributes in
that position as well.  For now I've got it in sync with gcc behaviour.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/parse.c b/parse.c
index 1678d80..62a005c 100644
--- a/parse.c
+++ b/parse.c
@@ -505,7 +505,7 @@ static struct token *struct_union_enum_specifier(enum type type,
 	struct position *repos;
 
 	ctype->modifiers = 0;
-	token = handle_attributes(token, ctype, KW_ATTRIBUTE | KW_ASM);
+	token = handle_attributes(token, ctype, KW_ATTRIBUTE);
 	if (token_type(token) == TOKEN_IDENT) {
 		sym = lookup_symbol(token->ident, NS_STRUCT);
 		if (!sym ||
@@ -1243,6 +1243,7 @@ static struct token *handle_attributes(struct token *token, struct ctype *ctype,
 			break;
 		token = keyword->op->declarator(token->next, &thistype);
 		apply_ctype(token->pos, &thistype, ctype);
+		keywords &= KW_ATTRIBUTE;
 	}
 	return token;
 }
@@ -1259,8 +1260,6 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
 	}
 
 	for (;;) {
-		token = handle_attributes(token, ctype, KW_ATTRIBUTE | KW_ASM);
-
 		if (token_type(token) != TOKEN_SPECIAL)
 			return token;
 
@@ -1406,11 +1405,12 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 		struct symbol *decl = alloc_symbol(token->pos, SYM_NODE);
 		decl->ctype = ctype;
 		token = declarator(token, decl, &ident, 0);
+
 		decl->ident = ident;
-		if (match_op(token, ':')) {
+		if (match_op(token, ':'))
 			token = handle_bitfield(token, decl);
-			token = handle_attributes(token, &decl->ctype, KW_ATTRIBUTE | KW_ASM);
-		}
+
+		token = handle_attributes(token, &decl->ctype, KW_ATTRIBUTE);
 		apply_modifiers(token->pos, &decl->ctype);
 		add_symbol(list, decl);
 		decl->endpos = token->pos;
@@ -1446,6 +1446,7 @@ static struct token *parameter_declaration(struct token *token, struct symbol **
 	sym->ctype = ctype;
 	*tree = sym;
 	token = declarator(token, sym, &ident, 1);
+	token = handle_attributes(token, &sym->ctype, KW_ATTRIBUTE);
 	sym->ident = ident;
 	apply_modifiers(token->pos, &sym->ctype);
 	sym->endpos = token->pos;
@@ -2298,6 +2299,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	}
 
 	token = declarator(token, decl, &ident, 0);
+	token = handle_attributes(token, &decl->ctype, KW_ATTRIBUTE | KW_ASM);
 	apply_modifiers(token->pos, &decl->ctype);
 
 	decl->endpos = token->pos;
@@ -2370,8 +2372,9 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		ident = NULL;
 		decl = alloc_symbol(token->pos, SYM_NODE);
 		decl->ctype = ctype;
-		token = declaration_specifiers(token, &decl->ctype, 1);
+		token = handle_attributes(token, &decl->ctype, KW_ATTRIBUTE);
 		token = declarator(token, decl, &ident, 0);
+		token = handle_attributes(token, &decl->ctype, KW_ATTRIBUTE | KW_ASM);
 		apply_modifiers(token->pos, &decl->ctype);
 		decl->endpos = token->pos;
 		if (!ident) {
-- 
1.5.6.6


