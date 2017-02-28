From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 6/7] make process_decl() aware of the presence of an initializer
Date: Tue, 28 Feb 2017 11:04:02 +0100
Message-ID: <20170228100403.33184-7-luc.vanoostenryck@gmail.com>
References: <20170228094635.qbod5dwqwrw6etvt@macbook.local>
 <20170228100403.33184-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36063 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdB1KGk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Feb 2017 05:06:40 -0500
Received: by mail-wm0-f66.google.com with SMTP id r18so1500195wmd.3
        for <linux-sparse@vger.kernel.org>; Tue, 28 Feb 2017 02:06:16 -0800 (PST)
In-Reply-To: <20170228100403.33184-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The call to the method external_decl::process_decl() is
preceded by some processing and validation if there is also
an initializer.

Make the process_decl() method aware of the presence of such
an initializer in order to be able to make appropriate
validations.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/parse.c b/parse.c
index 693bb497f..c3c877b10 100644
--- a/parse.c
+++ b/parse.c
@@ -48,7 +48,7 @@ static struct symbol_list **function_symbol_list;
 struct symbol_list *function_computed_target_list;
 struct statement_list *function_computed_goto_list;
 
-typedef void (*process_decl_t)(struct symbol_list **list, struct symbol *decl);
+typedef void (*process_decl_t)(struct symbol_list **list, struct symbol *decl, int has_init);
 static struct token *external_decl(struct token *, process_decl_t, struct symbol_list **);
 
 static struct token *statement(struct token *token, struct statement **tree);
@@ -2232,7 +2232,7 @@ static struct token *parse_return_statement(struct token *token, struct statemen
 	return expression_statement(token->next, &stmt->ret_value);
 }
 
-static void process_for_loop_decl(struct symbol_list **list, struct symbol *sym)
+static void process_for_loop_decl(struct symbol_list **list, struct symbol *sym, int has_init)
 {
 	unsigned long storage;
 
@@ -2896,7 +2896,9 @@ static struct token *external_decl(struct token *token, process_decl_t process_d
 	}
 
 	for (;;) {
+		int has_init = 0;
 		if (!is_typedef && match_op(token, '=')) {
+			has_init = 1;
 			if (decl->ctype.modifiers & MOD_EXTERN) {
 				warning(decl->pos, "symbol with external linkage has initializer");
 				decl->ctype.modifiers &= ~MOD_EXTERN;
@@ -2904,7 +2906,7 @@ static struct token *external_decl(struct token *token, process_decl_t process_d
 			token = initializer(&decl->initializer, token->next);
 		}
 		if (!is_typedef)
-			process_decl(list, decl);
+			process_decl(list, decl, has_init);
 		check_declaration(decl);
 		if (decl->same_symbol) {
 			decl->definition = decl->same_symbol->definition;
@@ -2945,7 +2947,7 @@ static struct token *external_decl(struct token *token, process_decl_t process_d
 	return expect(token, ';', "at end of declaration");
 }
 
-static void default_process_decl(struct symbol_list **list, struct symbol *decl)
+static void default_process_decl(struct symbol_list **list, struct symbol *decl, int has_init)
 {
 	if (!(decl->ctype.modifiers & (MOD_EXTERN | MOD_INLINE))) {
 		add_symbol(list, decl);
-- 
2.11.1

