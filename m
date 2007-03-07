From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 4/5] Introduce top level parsing for asm parsing.
Date: Wed, 7 Mar 2007 02:09:29 -0800
Message-ID: <20070307100929.GE10577@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc14.comcast.net ([204.127.225.94]:62912 "EHLO
	alnrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965030AbXCGKoG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 7 Mar 2007 05:44:06 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>


Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/parse.h
===================================================================
Index: sparse/symbol.c
===================================================================
Index: sparse/parse.c
===================================================================
--- sparse.orig/parse.c	2007-03-07 00:03:18.000000000 -0800
+++ sparse/parse.c	2007-03-07 00:03:50.000000000 -0800
@@ -56,6 +56,7 @@ static struct token *parse_goto_statemen
 static struct token *parse_context_statement(struct token *token, struct statement *stmt);
 static struct token *parse_range_statement(struct token *token, struct statement *stmt);
 static struct token *parse_asm(struct token *token, struct statement *stmt);
+static struct token *toplevel_asm_declaration(struct token *token, struct symbol_list **list);
 
 
 static struct symbol_op modifier_op = {
@@ -143,6 +144,7 @@ static struct symbol_op range_op = {
 
 static struct symbol_op asm_op = {
 	.statement = parse_asm,
+	.toplevel = toplevel_asm_declaration,
 };
 
 static struct init_keyword {
@@ -1977,8 +1979,11 @@ struct token *external_declaration(struc
 	int is_typedef;
 
 	/* Top-level inline asm? */
-	if (match_idents(token, &asm_ident, &__asm___ident, &__asm_ident, NULL))
-		return toplevel_asm_declaration(token, list);
+	if (token_type(token) == TOKEN_IDENT) {
+		struct symbol *s = lookup_keyword(token->ident, NS_KEYWORD);
+		if (s && s->op->toplevel)
+			return s->op->toplevel(token, list);
+	}
 
 	/* Parse declaration-specifiers, if any */
 	token = declaration_specifiers(token, &ctype, 0);
Index: sparse/symbol.h
===================================================================
--- sparse.orig/symbol.h	2007-03-07 00:03:18.000000000 -0800
+++ sparse/symbol.h	2007-03-07 00:03:20.000000000 -0800
@@ -93,6 +93,7 @@ struct symbol_op {
 	/* keywrods */
 	struct token *(*declarator)(struct token *token, struct ctype *ctype);
 	struct token *(*statement)(struct token *token, struct statement *stmt);
+	struct token *(*toplevel)(struct token *token, struct symbol_list **list);
 };	
 
 extern int expand_safe_p(struct expression *expr, int cost);
Index: sparse/lib.c
===================================================================
Index: sparse/ident-list.h
===================================================================
