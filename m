From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 1/18] Leave applying attributes until we know whether it's a nested declarator
Date: Mon, 09 Mar 2009 07:10:17 +0000
Message-ID: <E1LgZcv-0000rB-WF@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43721 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbZCIHKU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:10:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZcv-0000rB-WF
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:10:18 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Don't mess with applying attributes in which_kind(); leave that until
we know whether that's function declarator or a nested one.  We'll need
that to deal with scopes properly.  Clean parameter_type_list() and
parameter_declaration(), get rid of a leak.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/parse.c b/parse.c
index 73280b4..d70166a 100644
--- a/parse.c
+++ b/parse.c
@@ -1151,10 +1151,60 @@ static struct token *abstract_array_declarator(struct token *token, struct symbo
 	return token;
 }
 
-static struct token *parameter_type_list(struct token *, struct symbol *, struct ctype *);
+static struct token *parameter_type_list(struct token *, struct symbol *);
 static struct token *identifier_list(struct token *, struct symbol *);
 static struct token *declarator(struct token *token, struct symbol *sym, struct ident **p, int);
 
+static struct token *skip_attribute(struct token *token)
+{
+	token = token->next;
+	if (match_op(token, '(')) {
+		int depth = 1;
+		token = token->next;
+		while (depth && !eof_token(token)) {
+			if (token_type(token) == TOKEN_SPECIAL) {
+				if (token->special == '(')
+					depth++;
+				else if (token->special == ')')
+					depth--;
+			}
+			token = token->next;
+		}
+	}
+	return token;
+}
+
+static struct token *skip_attributes(struct token *token)
+{
+	struct symbol *keyword;
+	for (;;) {
+		if (token_type(token) != TOKEN_IDENT)
+			break;
+		keyword = lookup_keyword(token->ident, NS_KEYWORD | NS_TYPEDEF);
+		if (!keyword || keyword->type != SYM_KEYWORD)
+			break;
+		if (!(keyword->op->type & KW_ATTRIBUTE))
+			break;
+		token = expect(token->next, '(', "after attribute");
+		token = expect(token, '(', "after attribute");
+		for (;;) {
+			if (eof_token(token))
+				break;
+			if (match_op(token, ';'))
+				break;
+			if (token_type(token) != TOKEN_IDENT)
+				break;
+			token = skip_attribute(token);
+			if (!match_op(token, ','))
+				break;
+			token = token->next;
+		}
+		token = expect(token, ')', "after attribute");
+		token = expect(token, ')', "after attribute");
+	}
+	return token;
+}
+
 static struct token *handle_attributes(struct token *token, struct ctype *ctype, unsigned int keywords)
 {
 	struct symbol *keyword;
@@ -1179,7 +1229,7 @@ enum kind {
 };
 
 static enum kind which_kind(struct token *token, struct token **p,
-			    struct ident **n, struct ctype *ctype,
+			    struct ident **n,
 			    int dont_nest, int prefer_abstract)
 {
 	/*
@@ -1191,7 +1241,7 @@ static enum kind which_kind(struct token *token, struct token **p,
 	 */
 	struct token *next = token->next;
 
-	*p = next = handle_attributes(next, ctype, KW_ATTRIBUTE);
+	*p = next = skip_attributes(next);
 
 	if (token_type(next) == TOKEN_IDENT) {
 		if (lookup_type(next))
@@ -1249,8 +1299,7 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
 		if (token->special == '(') {
 			struct symbol *sym;
 			struct token *next;
-			struct ctype thistype = {0, };
-			enum kind kind = which_kind(token, &next, p, &thistype,
+			enum kind kind = which_kind(token, &next, p,
 						dont_nest, prefer_abstract);
 
 			dont_nest = 1;
@@ -1258,7 +1307,8 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
 			if (kind == Nested) {
 				struct symbol *base_type = ctype->base_type;
 				if (token->next != next)
-					apply_ctype(token->pos, &thistype, ctype);
+					next = handle_attributes(token->next, ctype,
+								  KW_ATTRIBUTE);
 				token = declarator(next, decl, p, prefer_abstract);
 				token = expect(token, ')', "in nested declarator");
 				while (ctype->base_type != base_type)
@@ -1275,13 +1325,10 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
 
 			/* otherwise we have a function */
 			sym = alloc_indirect_symbol(token->pos, ctype, SYM_FN);
-			if (kind == K_R) {
-				next = identifier_list(next, sym);
-			} else if (kind == Proto) {
-				struct ctype *t;
-				t = (token->next == next ? NULL : &thistype);
-				next = parameter_type_list(next, sym, t);
-			}
+			if (kind == K_R)
+				next = identifier_list(token->next, sym);
+			else if (kind == Proto)
+				next = parameter_type_list(token->next, sym);
 			token = expect(next, ')', "in function declarator");
 			sym->endpos = token->pos;
 			continue;
@@ -1425,18 +1472,13 @@ static struct token *struct_declaration_list(struct token *token, struct symbol_
 	return token;
 }
 
-static struct token *parameter_declaration(struct token *token, struct symbol **tree, struct ctype *pending)
+static struct token *parameter_declaration(struct token *token, struct symbol *sym)
 {
 	struct ident *ident = NULL;
-	struct symbol *sym;
 	struct ctype ctype = {0, };
 
-	if (pending)
-		apply_ctype(token->pos, pending, &ctype);
 	token = declaration_specifiers(token, &ctype, 0);
-	sym = alloc_symbol(token->pos, SYM_NODE);
 	sym->ctype = ctype;
-	*tree = sym;
 	token = declarator(token, sym, &ident, 1);
 	token = handle_attributes(token, &sym->ctype, KW_ATTRIBUTE);
 	sym->ident = ident;
@@ -1910,7 +1952,7 @@ static struct token *identifier_list(struct token *token, struct symbol *fn)
 	return token;
 }
 
-static struct token *parameter_type_list(struct token *token, struct symbol *fn, struct ctype *pending)
+static struct token *parameter_type_list(struct token *token, struct symbol *fn)
 {
 	struct symbol_list **list = &fn->arguments;
 
@@ -1924,7 +1966,7 @@ static struct token *parameter_type_list(struct token *token, struct symbol *fn,
 		}
 
 		sym = alloc_symbol(token->pos, SYM_NODE);
-		token = parameter_declaration(token, &sym, pending);
+		token = parameter_declaration(token, sym);
 		if (sym->ctype.base_type == &void_ctype) {
 			/* Special case: (void) */
 			if (!*list && !sym->ident)
@@ -1932,11 +1974,9 @@ static struct token *parameter_type_list(struct token *token, struct symbol *fn,
 			warning(token->pos, "void parameter");
 		}
 		add_symbol(list, sym);
-		sym->endpos = token->pos;
 		if (!match_op(token, ','))
 			break;
 		token = token->next;
-		pending = NULL;
 	}
 	return token;
 }
-- 
1.5.6.5


