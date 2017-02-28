From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 4/7] add a method to external_declaration()
Date: Tue, 28 Feb 2017 11:04:00 +0100
Message-ID: <20170228100403.33184-5-luc.vanoostenryck@gmail.com>
References: <20170228094635.qbod5dwqwrw6etvt@macbook.local>
 <20170228100403.33184-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35255 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbdB1KGk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Feb 2017 05:06:40 -0500
Received: by mail-wr0-f193.google.com with SMTP id q39so962750wrb.2
        for <linux-sparse@vger.kernel.org>; Tue, 28 Feb 2017 02:06:14 -0800 (PST)
In-Reply-To: <20170228100403.33184-1-luc.vanoostenryck@gmail.com>
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

The changes are made up of:
- extract the part 'add local symbols to the list' to a separate
  function: default_process_decl() as preparatory step to make
- replace the part 'add local symbols to the list' by a call
  to a new function pointer given in argument,

Also, to make the change non-invasive for others files:
- rename 'external_declaration()' into 'external_decl()'
- make 'external_declaration()' a small helper calling
  'external_decl()' with 'default_process_decl()' as the method.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/parse.c b/parse.c
index d07b27a21..b9b8d1ae0 100644
--- a/parse.c
+++ b/parse.c
@@ -48,6 +48,9 @@ static struct symbol_list **function_symbol_list;
 struct symbol_list *function_computed_target_list;
 struct statement_list *function_computed_goto_list;
 
+typedef void (*process_decl_t)(struct symbol_list **list, struct symbol *decl);
+static struct token *external_decl(struct token *, process_decl_t, struct symbol_list **);
+
 static struct token *statement(struct token *token, struct statement **tree);
 static struct token *handle_attributes(struct token *token, struct decl_state *ctx, unsigned int keywords);
 
@@ -2797,7 +2800,8 @@ static struct token *toplevel_asm_declaration(struct token *token, struct symbol
 	return token;
 }
 
-struct token *external_declaration(struct token *token, struct symbol_list **list)
+static struct token *external_decl(struct token *token, process_decl_t process_decl,
+		struct symbol_list **list)
 {
 	struct ident *ident = NULL;
 	struct symbol *decl;
@@ -2884,12 +2888,8 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 			}
 			token = initializer(&decl->initializer, token->next);
 		}
-		if (!is_typedef) {
-			if (!(decl->ctype.modifiers & (MOD_EXTERN | MOD_INLINE))) {
-				add_symbol(list, decl);
-				fn_local_symbol(decl);
-			}
-		}
+		if (!is_typedef)
+			process_decl(list, decl);
 		check_declaration(decl);
 		if (decl->same_symbol) {
 			decl->definition = decl->same_symbol->definition;
@@ -2929,3 +2929,16 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	}
 	return expect(token, ';', "at end of declaration");
 }
+
+static void default_process_decl(struct symbol_list **list, struct symbol *decl)
+{
+	if (!(decl->ctype.modifiers & (MOD_EXTERN | MOD_INLINE))) {
+		add_symbol(list, decl);
+		fn_local_symbol(decl);
+	}
+}
+
+struct token *external_declaration(struct token *token, struct symbol_list **list)
+{
+	return external_decl(token, default_process_decl, list);
+}
-- 
2.11.1

