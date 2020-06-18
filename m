From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] pre-process: add support for builtin macros
Date: Thu, 18 Jun 2020 22:47:14 +0200
Message-ID: <20200618204716.3896-4-luc.vanoostenryck@gmail.com>
References: <20200618204716.3896-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgFRUti (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 18 Jun 2020 16:49:38 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9DBC06174E
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jun 2020 13:49:38 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o15so7827440ejm.12
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jun 2020 13:49:37 -0700 (PDT)
In-Reply-To: <20200618204716.3896-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Sparse support the expansion of one-symbol-builtin macros like __FILE__.
It also support builtin macros with an argument, like 'defined()'
or '__has_attribute()'.

However, these last one are only expanded inside a pre-processor
conditional expression. This is correct for 'defined()' but macros
like '__has_attribute()' should be expanded in all contexts,
like user defined macros.

So, add support for the general expansion of such macros.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 pre-process.c | 34 ++++++++++++++++++++++++++++++++++
 symbol.h      |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/pre-process.c b/pre-process.c
index 059a7c1d9b7b..d2e13400711e 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -777,6 +777,9 @@ static int expand(struct token **list, struct symbol *sym)
 		expand_arguments(nargs, args);
 	}
 
+	if (sym->expand)
+		return sym->expand(token, args) ? 0 : 1;
+
 	expanding->tainted = 1;
 
 	last = token->next;
@@ -2000,6 +2003,34 @@ static int handle_nondirective(struct stream *stream, struct token **line, struc
 	return 1;
 }
 
+static void create_arglist(struct symbol *sym, int count)
+{
+	struct token *token;
+	struct token **next;
+
+	if (!count)
+		return;
+
+	token = __alloc_token(0);
+	token_type(token) = TOKEN_ARG_COUNT;
+	token->count.normal = count;
+	sym->arglist = token;
+	next = &token->next;
+
+	while (count--) {
+		struct token *id, *uses;
+		id = __alloc_token(0);
+		token_type(id) = TOKEN_IDENT;
+		uses = __alloc_token(0);
+		token_type(uses) = TOKEN_ARG_COUNT;
+		uses->count.normal = 1;
+
+		*next = id;
+		id->next = uses;
+		next = &uses->next;
+	}
+	*next = &eof_token_entry;
+}
 
 static void init_preprocessor(void)
 {
@@ -2041,6 +2072,7 @@ static void init_preprocessor(void)
 	static struct {
 		const char *name;
 		void (*expand_simple)(struct token *);
+		bool (*expand)(struct token *, struct arg *args);
 	} dynamic[] = {
 		{ "__LINE__",		expand_line },
 		{ "__FILE__",		expand_file },
@@ -2067,6 +2099,8 @@ static void init_preprocessor(void)
 		struct symbol *sym;
 		sym = create_symbol(stream, dynamic[i].name, SYM_NODE, NS_MACRO);
 		sym->expand_simple = dynamic[i].expand_simple;
+		if ((sym->expand = dynamic[i].expand) != NULL)
+			create_arglist(sym, 1);
 	}
 
 	counter_macro = 0;
diff --git a/symbol.h b/symbol.h
index 6b483101548a..e256322e83a2 100644
--- a/symbol.h
+++ b/symbol.h
@@ -114,6 +114,7 @@ struct decl_state {
 
 struct pseudo;
 struct entrypoint;
+struct arg;
 
 struct symbol_op {
 	enum keyword type;
@@ -161,6 +162,7 @@ struct symbol {
 			struct token *arglist;
 			struct scope *used_in;
 			void (*expand_simple)(struct token *);
+			bool (*expand)(struct token *, struct arg *args);
 		};
 		struct /* NS_PREPROCESSOR */ {
 			int (*handler)(struct stream *, struct token **, struct token *);
-- 
2.27.0
