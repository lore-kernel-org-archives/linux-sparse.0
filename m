From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 5/6] check the storage of C99 for-loop initializers
Date: Sun,  5 Mar 2017 20:21:51 +0100
Message-ID: <20170305192152.67931-6-luc.vanoostenryck@gmail.com>
References: <CANeU7Qk34VzZ6Q2oxEcFrreK=NOwmpSGbiVgvyckpp154xWJaQ@mail.gmail.com>
 <20170305192152.67931-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36526 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbdCETWl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 14:22:41 -0500
Received: by mail-wm0-f67.google.com with SMTP id v190so10657041wme.3
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 11:22:04 -0800 (PST)
In-Reply-To: <20170305192152.67931-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In C99, it is valid to declare a variable inside a
for-loop initializer but only when the storage is local
(automatic or register). Until now this was not enforced.

Fix this, when parsing declarations in a for-loop context,
by calling external_decl() with a validate method doing the
appropriate check of the storage.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                        | 13 ++++++++++++-
 validation/c99-for-loop-decl.c |  1 -
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/parse.c b/parse.c
index d91a4bced..6ec1bab97 100644
--- a/parse.c
+++ b/parse.c
@@ -2229,6 +2229,17 @@ static struct token *parse_return_statement(struct token *token, struct statemen
 	return expression_statement(token->next, &stmt->ret_value);
 }
 
+static void validate_for_loop_decl(struct symbol *sym)
+{
+	unsigned long storage = sym->ctype.modifiers & MOD_STORAGE;
+
+	if (storage & ~(MOD_AUTO | MOD_REGISTER)) {
+		const char *name = show_ident(sym->ident);
+		sparse_error(sym->pos, "non-local var '%s' in for-loop initializer", name);
+		sym->ctype.modifiers &= ~MOD_STORAGE;
+	}
+}
+
 static struct token *parse_for_statement(struct token *token, struct statement *stmt)
 {
 	struct symbol_list *syms;
@@ -2242,7 +2253,7 @@ static struct token *parse_for_statement(struct token *token, struct statement *
 	e1 = NULL;
 	/* C99 variable declaration? */
 	if (lookup_type(token)) {
-		token = external_declaration(token, &syms, NULL);
+		token = external_declaration(token, &syms, validate_for_loop_decl);
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

