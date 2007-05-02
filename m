From: Christopher Li <sparse@chrisli.org>
Subject: Re: barrier macro
Date: Wed, 2 May 2007 00:20:56 -0700
Message-ID: <20070502072056.GA9889@chrisli.org>
References: <20070501153448.a65c81c2.rdunlap@xenotime.net> <463802E1.4030303@freedesktop.org> <46381269.9090305@freedesktop.org> <46382387.4010903@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc12.comcast.net ([204.127.200.82]:39569 "EHLO
	sccrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbXEBIG4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 May 2007 04:06:56 -0400
Content-Disposition: inline
In-Reply-To: <46382387.4010903@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

On Tue, May 01, 2007 at 10:37:11PM -0700, Josh Triplett wrote:
> 
> Fixed in current Git.
> 

May I purpose a slightly different fix?

The reason I use bit mask in the keyword so that it can allow
select a sub set of keywords. If we want, We can fine tune exactly
what keyword is allowed. It also makes the caller of handle_attributes
show exactly what kind of attribute it takes.

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/parse.c
===================================================================
--- sparse.orig/parse.c	2007-05-02 00:41:30.000000000 -0700
+++ sparse/parse.c	2007-05-02 00:53:09.000000000 -0700
@@ -35,7 +35,7 @@ struct symbol_list *function_computed_ta
 struct statement_list *function_computed_goto_list;
 
 static struct token *statement(struct token *token, struct statement **tree);
-static struct token *handle_attributes(struct token *token, struct ctype *ctype, int allow_asm);
+static struct token *handle_attributes(struct token *token, struct ctype *ctype, enum keyword keywords);
 
 static struct token *struct_specifier(struct token *token, struct ctype *ctype);
 static struct token *union_specifier(struct token *token, struct ctype *ctype);
@@ -458,7 +458,7 @@ static struct token *struct_union_enum_s
 	struct position *repos;
 
 	ctype->modifiers = 0;
-	token = handle_attributes(token, ctype, 1);
+	token = handle_attributes(token, ctype, KW_ATTRIBUTE | KW_ASM);
 	if (token_type(token) == TOKEN_IDENT) {
 		sym = lookup_symbol(token->ident, NS_STRUCT);
 		if (!sym ||
@@ -1094,7 +1094,7 @@ static struct token *abstract_array_decl
 static struct token *parameter_type_list(struct token *, struct symbol *, struct ident **p);
 static struct token *declarator(struct token *token, struct symbol *sym, struct ident **p);
 
-static struct token *handle_attributes(struct token *token, struct ctype *ctype, int allow_asm)
+static struct token *handle_attributes(struct token *token, struct ctype *ctype, enum keyword keywords)
 {
 	struct symbol *keyword;
 	for (;;) {
@@ -1104,7 +1104,7 @@ static struct token *handle_attributes(s
 		keyword = lookup_keyword(token->ident, NS_KEYWORD | NS_TYPEDEF);
 		if (!keyword || keyword->type != SYM_KEYWORD)
 			break;
-		if (!(keyword->op->type & (KW_ATTRIBUTE | (allow_asm ? KW_ASM : 0))))
+		if (!(keyword->op->type & keywords))
 			break;
 		token = keyword->op->declarator(token->next, &thistype);
 		apply_ctype(token->pos, &thistype, ctype);
@@ -1122,7 +1122,7 @@ static struct token *direct_declarator(s
 	}
 
 	for (;;) {
-		token = handle_attributes(token, ctype, 1);
+		token = handle_attributes(token, ctype, KW_ATTRIBUTE | KW_ASM);
 
 		if (token_type(token) != TOKEN_SPECIAL)
 			return token;
@@ -1261,7 +1261,7 @@ static struct token *declaration_list(st
 		decl->ident = ident;
 		if (match_op(token, ':')) {
 			token = handle_bitfield(token, decl);
-			token = handle_attributes(token, &decl->ctype, 1);
+			token = handle_attributes(token, &decl->ctype, KW_ATTRIBUTE | KW_ASM);
 		}
 		apply_modifiers(token->pos, &decl->ctype);
 		add_symbol(list, decl);
@@ -1702,7 +1702,7 @@ static struct token *statement(struct to
 		if (match_op(token->next, ':')) {
 			stmt->type = STMT_LABEL;
 			stmt->label_identifier = label_symbol(token);
-			token = handle_attributes(token->next->next, &stmt->label_identifier->ctype, 0);
+			token = handle_attributes(token->next->next, &stmt->label_identifier->ctype, KW_ATTRIBUTE);
 			return statement(token, &stmt->label_statement);
 		}
 	}
