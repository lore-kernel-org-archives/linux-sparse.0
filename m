From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 2/5] Introducing statement keywords
Date: Wed, 7 Mar 2007 02:07:50 -0800
Message-ID: <20070307100750.GD10577@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc15.comcast.net ([63.240.77.85]:64668 "EHLO
	sccrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965025AbXCGKm1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 7 Mar 2007 05:42:27 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>

This change using keyword lookup for statement parsing
instead of a order compare.

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/parse.h
===================================================================
Index: sparse/symbol.c
===================================================================
Index: sparse/parse.c
===================================================================
--- sparse.orig/parse.c	2007-03-05 00:33:21.000000000 -0800
+++ sparse/parse.c	2007-03-05 00:55:46.000000000 -0800
@@ -43,6 +43,20 @@ static struct token *enum_specifier(stru
 static struct token *attribute_specifier(struct token *token, struct ctype *ctype);
 static struct token *typeof_specifier(struct token *token, struct ctype *ctype);
 
+static struct token *parse_if_statement(struct token *token, struct statement *stmt);
+static struct token *parse_return_statement(struct token *token, struct statement *stmt);
+static struct token *parse_loop_iterator(struct token *token, struct statement *stmt);
+static struct token *parse_default_statement(struct token *token, struct statement *stmt);
+static struct token *parse_case_statement(struct token *token, struct statement *stmt);
+static struct token *parse_switch_statement(struct token *token, struct statement *stmt);
+static struct token *parse_for_statement(struct token *token, struct statement *stmt);
+static struct token *parse_while_statement(struct token *token, struct statement *stmt);
+static struct token *parse_do_statement(struct token *token, struct statement *stmt);
+static struct token *parse_goto_statement(struct token *token, struct statement *stmt);
+static struct token *parse_context_statement(struct token *token, struct statement *stmt);
+static struct token *parse_range_statement(struct token *token, struct statement *stmt);
+static struct token *parse_asm(struct token *token, struct statement *stmt);
+
 
 static struct symbol_op modifier_op = {
 	.type = KW_MODIFIER,
@@ -77,6 +91,60 @@ static struct symbol_op enum_op = {
 	.declarator = enum_specifier,
 };
 
+
+
+static struct symbol_op if_op = {
+	.statement = parse_if_statement,
+};
+
+static struct symbol_op return_op = {
+	.statement = parse_return_statement,
+};
+
+static struct symbol_op loop_iter_op = {
+	.statement = parse_loop_iterator,
+};
+
+static struct symbol_op default_op = {
+	.statement = parse_default_statement,
+};
+
+static struct symbol_op case_op = {
+	.statement = parse_case_statement,
+};
+
+static struct symbol_op switch_op = {
+	.statement = parse_switch_statement,
+};
+
+static struct symbol_op for_op = {
+	.statement = parse_for_statement,
+};
+
+static struct symbol_op while_op = {
+	.statement = parse_while_statement,
+};
+
+static struct symbol_op do_op = {
+	.statement = parse_do_statement,
+};
+
+static struct symbol_op goto_op = {
+	.statement = parse_goto_statement,
+};
+
+static struct symbol_op context_op = {
+	.statement = parse_context_statement,
+};
+
+static struct symbol_op range_op = {
+	.statement = parse_range_statement,
+};
+
+static struct symbol_op asm_op = {
+	.statement = parse_asm,
+};
+
 static struct init_keyword {
 	const char *name;
 	enum namespace ns;
@@ -113,6 +181,25 @@ static struct init_keyword {
 	/* Ignored for now.. */
 	{ "restrict",	NS_TYPEDEF, .op = &qualifier_op},
 	{ "__restrict",	NS_TYPEDEF, .op = &qualifier_op},
+
+	/* Statement */
+	{ "if",		NS_KEYWORD, .op = &if_op },
+	{ "return",	NS_KEYWORD, .op = &return_op },
+	{ "break",	NS_KEYWORD, .op = &loop_iter_op },
+	{ "continue",	NS_KEYWORD, .op = &loop_iter_op },
+	{ "default",	NS_KEYWORD, .op = &default_op },
+	{ "case",	NS_KEYWORD, .op = &case_op },
+	{ "switch",	NS_KEYWORD, .op = &switch_op },
+	{ "for",	NS_KEYWORD, .op = &for_op },
+	{ "while",	NS_KEYWORD, .op = &while_op },
+	{ "do",		NS_KEYWORD, .op = &do_op },
+	{ "goto",	NS_KEYWORD, .op = &goto_op },
+	{ "__context__",NS_KEYWORD, .op = &context_op },
+	{ "__range__",	NS_KEYWORD, .op = &range_op },
+	{ "asm",	NS_KEYWORD, .op = &asm_op },
+	{ "__asm",	NS_KEYWORD, .op = &asm_op },
+	{ "__asm__",	NS_KEYWORD, .op = &asm_op },
+
 };
 
 void init_parser(int stream)
@@ -1536,44 +1623,9 @@ static struct token *statement(struct to
 
 	*tree = stmt;
 	if (token_type(token) == TOKEN_IDENT) {
-		if (token->ident == &if_ident)
-			return parse_if_statement(token, stmt);
-
-		if (token->ident == &return_ident)
-			return parse_return_statement(token, stmt);
-
-		if (token->ident == &break_ident || token->ident == &continue_ident)
-			return parse_loop_iterator(token, stmt);
-
-		if (token->ident == &default_ident)
-			return parse_default_statement(token, stmt);
-
-		if (token->ident == &case_ident)
-			return parse_case_statement(token, stmt);
-
-		if (token->ident == &switch_ident)
-			return parse_switch_statement(token, stmt);
-
-		if (token->ident == &for_ident)
-			return parse_for_statement(token, stmt);
-
-		if (token->ident == &while_ident)
-			return parse_while_statement(token, stmt);
-
-		if (token->ident == &do_ident)
-			return parse_do_statement(token, stmt);
-
-		if (token->ident == &goto_ident)
-			return parse_goto_statement(token, stmt);
-
-		if (match_idents(token, &asm_ident, &__asm___ident, &__asm_ident, NULL))
-			return parse_asm(token, stmt);
-
-		if (token->ident == &__context___ident)
-			return parse_context_statement(token, stmt);
-
-		if (token->ident == &__range___ident)
-			return parse_range_statement(token, stmt);
+		struct symbol *s = lookup_keyword(token->ident, NS_KEYWORD);
+		if (s && s->op->statement)
+			return s->op->statement(token, stmt);
 
 		if (match_op(token->next, ':')) {
 			stmt->type = STMT_LABEL;
Index: sparse/symbol.h
===================================================================
--- sparse.orig/symbol.h	2007-03-05 00:33:21.000000000 -0800
+++ sparse/symbol.h	2007-03-05 00:54:11.000000000 -0800
@@ -64,6 +64,7 @@ enum keyword {
 	KW_QUALIFIER	= 1 << 2,
 	KW_ATTRIBUTE	= 1 << 3,
 	KW_TYPEOF	= 1 << 4,
+	KW_STATEMENT	= 1 << 5,
 };
 
 struct context {
@@ -91,6 +92,7 @@ struct symbol_op {
 
 	/* keywrods */
 	struct token *(*declarator)(struct token *token, struct ctype *ctype);
+	struct token *(*statement)(struct token *token, struct statement *stmt);
 };	
 
 extern int expand_safe_p(struct expression *expr, int cost);
@@ -291,6 +293,13 @@ static inline int get_sym_type(struct sy
 	return type->type;
 }
 
+static inline struct symbol *lookup_keyword(struct ident *ident, enum namespace ns)
+{
+	if (!ident->keyword)
+		return NULL;
+	return lookup_symbol(ident, ns);
+}
+
 #define is_restricted_type(type) (get_sym_type(type) == SYM_RESTRICT)
 #define is_fouled_type(type) (get_sym_type(type) == SYM_FOULED)
 #define is_bitfield_type(type)   (get_sym_type(type) == SYM_BITFIELD)
Index: sparse/lib.c
===================================================================
Index: sparse/ident-list.h
===================================================================
