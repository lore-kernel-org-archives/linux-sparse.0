From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 28/28] bad-label: respect attribute((unused))
Date: Tue, 19 May 2020 02:57:28 +0200
Message-ID: <20200519005728.84594-29-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgESA6B (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:58:01 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416C2C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:58:01 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id yc10so10346425ejb.12
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:58:01 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, attributes on labels were simply ignored. This was fine
since nothing was done wth them anyway.

But now that Sparse can give a warning for unused labels it would
be nice to also support the attribute 'unused' not to issues the
warning when not desired.

So, add a small helper around handle_attributes() and use this
instead of skipping the attributes.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                   | 11 ++++++++++-
 scope.c                   |  2 ++
 symbol.h                  |  1 +
 validation/label-unused.c |  6 ++++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index a8e4a02e90e4..3cd84a3c7703 100644
--- a/parse.c
+++ b/parse.c
@@ -2554,6 +2554,15 @@ static struct token *parse_range_statement(struct token *token, struct statement
 	return expect(token, ';', "after range statement");
 }
 
+static struct token *handle_label_attributes(struct token *token, struct symbol *label)
+{
+	struct decl_state ctx = { };
+
+	token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
+	label->label_modifiers = ctx.ctype.modifiers;
+	return token;
+}
+
 static struct token *statement(struct token *token, struct statement **tree)
 {
 	struct statement *stmt = alloc_statement(token->pos, STMT_NONE);
@@ -2566,7 +2575,7 @@ static struct token *statement(struct token *token, struct statement **tree)
 
 		if (match_op(token->next, ':')) {
 			struct symbol *s = label_symbol(token, 0);
-			token = skip_attributes(token->next->next);
+			token = handle_label_attributes(token->next->next, s);
 			if (s->stmt) {
 				sparse_error(stmt->pos, "label '%s' redefined", show_ident(s->ident));
 				// skip the label to avoid multiple definitions
diff --git a/scope.c b/scope.c
index 03593d823d6d..4c1badb2c135 100644
--- a/scope.c
+++ b/scope.c
@@ -155,6 +155,8 @@ void end_label_scope(void)
 	FOR_EACH_PTR(label_scope->symbols, sym) {
 		if (!sym->stmt || sym->used)
 			continue;
+		if (sym->label_modifiers & MOD_UNUSED)
+			continue;
 		warning(sym->pos, "unused label '%s'", show_ident(sym->ident));
 	} END_FOR_EACH_PTR(sym);
 
diff --git a/symbol.h b/symbol.h
index 2293d06dd4fb..6f90479505cc 100644
--- a/symbol.h
+++ b/symbol.h
@@ -170,6 +170,7 @@ struct symbol {
 		struct /* NS_LABEL */ {
 			struct scope *label_scope;
 			struct position label_pos;
+			unsigned long label_modifiers;
 		};
 		struct /* NS_SYMBOL */ {
 			unsigned long	offset;
diff --git a/validation/label-unused.c b/validation/label-unused.c
index a654ef7742be..e3f255e1b5de 100644
--- a/validation/label-unused.c
+++ b/validation/label-unused.c
@@ -13,6 +13,12 @@ l:
 	});
 }
 
+static void baz(void)
+{
+l: __attribute__((unused));
+	return;
+}
+
 /*
  * check-name: label-unused
  *
-- 
2.26.2
