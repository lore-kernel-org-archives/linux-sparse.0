From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 5/7] check the storage of C99 for-loop initializers
Date: Tue, 28 Feb 2017 11:04:01 +0100
Message-ID: <20170228100403.33184-6-luc.vanoostenryck@gmail.com>
References: <20170228094635.qbod5dwqwrw6etvt@macbook.local>
 <20170228100403.33184-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34513 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbdB1KGk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Feb 2017 05:06:40 -0500
Received: by mail-wm0-f67.google.com with SMTP id m70so1507386wma.1
        for <linux-sparse@vger.kernel.org>; Tue, 28 Feb 2017 02:06:15 -0800 (PST)
In-Reply-To: <20170228100403.33184-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In C99, it is valid to declare a variable inside a
for-loop initializer but only when the storage is local
(automatic or register).
Until now this was not enforced.

Fix this by replacing, when parsing declarations in a for-loop
context, the method external_decl::default_process_decl()
by a new one containing the appropriate checks.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                        | 17 ++++++++++++++++-
 validation/c99-for-loop-decl.c |  1 -
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/parse.c b/parse.c
index b9b8d1ae0..693bb497f 100644
--- a/parse.c
+++ b/parse.c
@@ -2232,6 +2232,21 @@ static struct token *parse_return_statement(struct token *token, struct statemen
 	return expression_statement(token->next, &stmt->ret_value);
 }
 
+static void process_for_loop_decl(struct symbol_list **list, struct symbol *sym)
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
@@ -2245,7 +2260,7 @@ static struct token *parse_for_statement(struct token *token, struct statement *
 	e1 = NULL;
 	/* C99 variable declaration? */
 	if (lookup_type(token)) {
-		token = external_declaration(token, &syms);
+		token = external_decl(token, process_for_loop_decl, &syms);
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
2.11.1

