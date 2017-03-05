From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 4/6] add an optional validation method to external_declaration()
Date: Sun,  5 Mar 2017 20:21:50 +0100
Message-ID: <20170305192152.67931-5-luc.vanoostenryck@gmail.com>
References: <CANeU7Qk34VzZ6Q2oxEcFrreK=NOwmpSGbiVgvyckpp154xWJaQ@mail.gmail.com>
 <20170305192152.67931-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34640 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752383AbdCETWl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 14:22:41 -0500
Received: by mail-wr0-f194.google.com with SMTP id u48so19321329wrc.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 11:22:03 -0800 (PST)
In-Reply-To: <20170305192152.67931-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

After parsing and validation, the symbols in the declaration
are added to the list given in argument, *if* they are not extern
symbols. The symbols that are extern are them not added to the list.

This is what is needed for usual declarations but ignoring extern
symbols make it impossible to emit a diagnostic in less usual
situation.

This is motivated by the validation of variable declaration inside
a for-loop initializer, which is valid in C99 but only for variable
with local storage.

The change consists in adding to external_declaration() an optional
callback 'validate_decl()' which, if present (non-null), is called
just before adding the declaration to the list.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c   |  2 +-
 parse.c | 10 +++++++---
 parse.h |  3 ++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib.c b/lib.c
index d76b8368e..272d2c88a 100644
--- a/lib.c
+++ b/lib.c
@@ -1085,7 +1085,7 @@ static struct symbol_list *sparse_tokenstream(struct token *token)
 
 	// Parse the resulting C code
 	while (!eof_token(token))
-		token = external_declaration(token, &translation_unit_used_list);
+		token = external_declaration(token, &translation_unit_used_list, NULL);
 	return translation_unit_used_list;
 }
 
diff --git a/parse.c b/parse.c
index d07b27a21..d91a4bced 100644
--- a/parse.c
+++ b/parse.c
@@ -2242,7 +2242,7 @@ static struct token *parse_for_statement(struct token *token, struct statement *
 	e1 = NULL;
 	/* C99 variable declaration? */
 	if (lookup_type(token)) {
-		token = external_declaration(token, &syms);
+		token = external_declaration(token, &syms, NULL);
 	} else {
 		token = parse_expression(token, &e1);
 		token = expect(token, ';', "in 'for'");
@@ -2469,7 +2469,7 @@ static struct token * statement_list(struct token *token, struct statement_list
 				seen_statement = 0;
 			}
 			stmt = alloc_statement(token->pos, STMT_DECLARATION);
-			token = external_declaration(token, &stmt->declaration);
+			token = external_declaration(token, &stmt->declaration, NULL);
 		} else {
 			seen_statement = Wdeclarationafterstatement;
 			token = statement(token, &stmt);
@@ -2797,7 +2797,8 @@ static struct token *toplevel_asm_declaration(struct token *token, struct symbol
 	return token;
 }
 
-struct token *external_declaration(struct token *token, struct symbol_list **list)
+struct token *external_declaration(struct token *token, struct symbol_list **list,
+		validate_decl_t validate_decl)
 {
 	struct ident *ident = NULL;
 	struct symbol *decl;
@@ -2885,6 +2886,9 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 			token = initializer(&decl->initializer, token->next);
 		}
 		if (!is_typedef) {
+			if (validate_decl)
+				validate_decl(decl);
+
 			if (!(decl->ctype.modifiers & (MOD_EXTERN | MOD_INLINE))) {
 				add_symbol(list, decl);
 				fn_local_symbol(decl);
diff --git a/parse.h b/parse.h
index a2b3e3889..26227a387 100644
--- a/parse.h
+++ b/parse.h
@@ -129,7 +129,8 @@ extern int show_statement(struct statement *);
 extern void show_statement_list(struct statement_list *, const char *);
 extern int show_expression(struct expression *);
 
-extern struct token *external_declaration(struct token *token, struct symbol_list **list);
+typedef void (*validate_decl_t)(struct symbol *decl);
+extern struct token *external_declaration(struct token *, struct symbol_list **, validate_decl_t);
 
 extern struct symbol *ctype_integer(int size, int want_unsigned);
 
-- 
2.11.1

