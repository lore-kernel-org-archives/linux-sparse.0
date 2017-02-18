From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] check the storage of C99 for-loop initializers
Date: Sat, 18 Feb 2017 21:30:48 +0100
Message-ID: <20170218203048.22276-6-luc.vanoostenryck@gmail.com>
References: <20170218203048.22276-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32926 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753555AbdBRUbA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Feb 2017 15:31:00 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so8040780wmv.0
        for <linux-sparse@vger.kernel.org>; Sat, 18 Feb 2017 12:30:59 -0800 (PST)
In-Reply-To: <20170218203048.22276-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In C99, it is valid to declarare a variable inside
a for-loop initializer but only when the storage is local
(automatic or register).

Until now this was not enforced.

Fix that by adding the appropriate checks called by
external_declaration() via the new function pointer when
parsing this declaration in a for-loop context.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                        | 17 ++++++++++++++++-
 validation/c99-for-loop-decl.c |  1 -
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/parse.c b/parse.c
index 866186fd2..5b029ccdc 100644
--- a/parse.c
+++ b/parse.c
@@ -2217,6 +2217,21 @@ static struct token *parse_return_statement(struct token *token, struct statemen
 	return expression_statement(token->next, &stmt->ret_value);
 }
 
+static void add_for_loop_decl(struct symbol_list **list, struct symbol *sym)
+{
+	unsigned long storage;
+
+	storage = sym->ctype.modifiers & MOD_STORAGE;
+	if (storage & ~(MOD_AUTO | MOD_REGISTER)) {
+		const char *name = show_ident(sym->ident);
+		sparse_error(sym->pos, "non-local var '%s' in for-loop initializer", name);
+		sym->ctype.modifiers &= ~MOD_STORAGE;
+	}
+
+	add_symbol(list, sym);
+	fn_local_symbol(sym);
+}
+
 static struct token *parse_for_statement(struct token *token, struct statement *stmt)
 {
 	struct symbol_list *syms;
@@ -2230,7 +2245,7 @@ static struct token *parse_for_statement(struct token *token, struct statement *
 	e1 = NULL;
 	/* C99 variable declaration? */
 	if (lookup_type(token)) {
-		token = external_declaration(token, NULL, &syms);
+		token = external_declaration(token, add_for_loop_decl, &syms);
 	} else {
 		token = parse_expression(token, &e1);
 		token = expect(token, ';', "in 'for'");
diff --git a/validation/c99-for-loop-decl.c b/validation/c99-for-loop-decl.c
index b9db8c9c6..e813b0ae3 100644
--- a/validation/c99-for-loop-decl.c
+++ b/validation/c99-for-loop-decl.c
@@ -30,7 +30,6 @@ static int c99(void)
 
 /*
  * check-name: C99 for-loop declarations
- * check-known-to-fail
  *
  * check-error-start
 c99-for-loop-decl.c:22:27: warning: symbol with external linkage has initializer
-- 
2.11.0

