From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 4/5] add a method to external_declaration()
Date: Mon, 20 Feb 2017 08:20:51 +0100
Message-ID: <20170220072052.2429-5-luc.vanoostenryck@gmail.com>
References: <1ebf742e-5680-4160-6dc5-808fcfb5cc44@ramsayjones.plus.com>
 <20170220072052.2429-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35069 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbdBTHYD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Feb 2017 02:24:03 -0500
Received: by mail-wr0-f196.google.com with SMTP id q39so10917828wrb.2
        for <linux-sparse@vger.kernel.org>; Sun, 19 Feb 2017 23:23:03 -0800 (PST)
In-Reply-To: <20170220072052.2429-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

After parsing and validation, the symbols in the declaration
are added to the list given in argument, *if* they are not extern
symbols. The symbols that are extern are them not added to the list.

This is what is needed for usual declarations but ignoring extern
symbols make it impossible to emit a diagnostic in less usual
situation.

This is motivated by the validation of variable declaration inside
a for-loop initializer, which valid in C99 but only for variable
with local storage.

The changes consist in moving the part 'add the symbol to the list if
the symbol is not extern' to a separate function which will be called
by default.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c   |  2 +-
 parse.c | 22 +++++++++++++++-------
 parse.h |  3 ++-
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/lib.c b/lib.c
index d47325243..9badc09b3 100644
--- a/lib.c
+++ b/lib.c
@@ -1080,7 +1080,7 @@ static struct symbol_list *sparse_tokenstream(struct token *token)
 
 	// Parse the resulting C code
 	while (!eof_token(token))
-		token = external_declaration(token, &translation_unit_used_list);
+		token = external_declaration(token, NULL, &translation_unit_used_list);
 	return translation_unit_used_list;
 }
 
diff --git a/parse.c b/parse.c
index a4a126720..866186fd2 100644
--- a/parse.c
+++ b/parse.c
@@ -2230,7 +2230,7 @@ static struct token *parse_for_statement(struct token *token, struct statement *
 	e1 = NULL;
 	/* C99 variable declaration? */
 	if (lookup_type(token)) {
-		token = external_declaration(token, &syms);
+		token = external_declaration(token, NULL, &syms);
 	} else {
 		token = parse_expression(token, &e1);
 		token = expect(token, ';', "in 'for'");
@@ -2457,7 +2457,7 @@ static struct token * statement_list(struct token *token, struct statement_list
 				seen_statement = 0;
 			}
 			stmt = alloc_statement(token->pos, STMT_DECLARATION);
-			token = external_declaration(token, &stmt->declaration);
+			token = external_declaration(token, NULL, &stmt->declaration);
 		} else {
 			seen_statement = Wdeclarationafterstatement;
 			token = statement(token, &stmt);
@@ -2785,7 +2785,15 @@ static struct token *toplevel_asm_declaration(struct token *token, struct symbol
 	return token;
 }
 
-struct token *external_declaration(struct token *token, struct symbol_list **list)
+static void add_stmt_decl(struct symbol_list **list, struct symbol *decl)
+{
+	if (!(decl->ctype.modifiers & (MOD_EXTERN | MOD_INLINE))) {
+		add_symbol(list, decl);
+		fn_local_symbol(decl);
+	}
+}
+
+struct token *external_declaration(struct token *token, add_decl_t add_decl, struct symbol_list **list)
 {
 	struct ident *ident = NULL;
 	struct symbol *decl;
@@ -2864,6 +2872,9 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		sparse_error(token->pos, "void declaration");
 	}
 
+	if (!add_decl)
+		add_decl = add_stmt_decl;
+
 	for (;;) {
 		if (!is_typedef && match_op(token, '=')) {
 			if (decl->ctype.modifiers & MOD_EXTERN) {
@@ -2873,10 +2884,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 			token = initializer(&decl->initializer, token->next);
 		}
 		if (!is_typedef) {
-			if (!(decl->ctype.modifiers & (MOD_EXTERN | MOD_INLINE))) {
-				add_symbol(list, decl);
-				fn_local_symbol(decl);
-			}
+			add_decl(list, decl);
 		}
 		check_declaration(decl);
 		if (decl->same_symbol) {
diff --git a/parse.h b/parse.h
index a2b3e3889..d3199727e 100644
--- a/parse.h
+++ b/parse.h
@@ -129,7 +129,8 @@ extern int show_statement(struct statement *);
 extern void show_statement_list(struct statement_list *, const char *);
 extern int show_expression(struct expression *);
 
-extern struct token *external_declaration(struct token *token, struct symbol_list **list);
+typedef void (*add_decl_t)(struct symbol_list **list, struct symbol *decl);
+extern struct token *external_declaration(struct token *token, add_decl_t add_decl, struct symbol_list **list);
 
 extern struct symbol *ctype_integer(int size, int want_unsigned);
 
-- 
2.11.0

