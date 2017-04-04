From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/6] teach sparse how to dump macro definitions
Date: Tue,  4 Apr 2017 23:49:51 +0200
Message-ID: <20170404214955.47926-3-luc.vanoostenryck@gmail.com>
References: <20170404214955.47926-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36295 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753855AbdDDVuM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Apr 2017 17:50:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id x124so8042554wmf.3
        for <linux-sparse@vger.kernel.org>; Tue, 04 Apr 2017 14:50:11 -0700 (PDT)
In-Reply-To: <20170404214955.47926-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.h         |  1 +
 pre-process.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/lib.h b/lib.h
index 19b5cb0b3..f2df4aa1d 100644
--- a/lib.h
+++ b/lib.h
@@ -141,6 +141,7 @@ extern int arch_m64;
 
 extern void declare_builtin_functions(void);
 extern void create_builtin_stream(void);
+extern void dump_macro_definitions(void);
 extern struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list **files);
 extern struct symbol_list *__sparse(char *filename);
 extern struct symbol_list *sparse_keep_tokens(char *filename);
diff --git a/pre-process.c b/pre-process.c
index 7c57ba1cd..74414dfeb 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -44,6 +44,7 @@
 #include "expression.h"
 #include "scope.h"
 
+static struct ident_list *macros;	// only needed for -dD
 static int false_nesting = 0;
 static int counter_macro = 0;		// __COUNTER__ expansion
 
@@ -1351,6 +1352,7 @@ static int do_handle_define(struct stream *stream, struct token **line, struct t
 	if (!sym || sym->scope != file_scope) {
 		sym = alloc_symbol(left->pos, SYM_NODE);
 		bind_symbol(sym, name, NS_MACRO);
+		add_ident(&macros, name);
 		ret = 0;
 	}
 
@@ -2010,3 +2012,56 @@ struct token * preprocess(struct token *token)
 
 	return token;
 }
+
+static void dump_macro(struct symbol *sym)
+{
+	int nargs = sym->arglist ? sym->arglist->count.normal : 0;
+	struct token *args[nargs];
+	struct token *token;
+
+	printf("#define %s", show_ident(sym->ident));
+	token = sym->arglist;
+	if (token) {
+		const char *sep = "";
+		int narg = 0;
+		putchar('(');
+		for (; !eof_token(token); token = token->next) {
+			if (token_type(token) == TOKEN_ARG_COUNT)
+				continue;
+			printf("%s%s", sep, show_token(token));
+			args[narg++] = token;
+			sep = ", ";
+		}
+		putchar(')');
+	}
+	putchar(' ');
+
+	token = sym->expansion;
+	while (!eof_token(token)) {
+		struct token *next = token->next;
+		switch (token_type(token)) {
+		case TOKEN_UNTAINT:
+			break;
+		case TOKEN_MACRO_ARGUMENT:
+			token = args[token->argnum];
+			/* fall-through */
+		default:
+			printf("%s", show_token(token));
+			if (next->pos.whitespace)
+				putchar(' ');
+		}
+		token = next;
+	}
+	putchar('\n');
+}
+
+void dump_macro_definitions(void)
+{
+	struct ident *name;
+
+	FOR_EACH_PTR(macros, name) {
+		struct symbol *sym = lookup_macro(name);
+		if (sym)
+			dump_macro(sym);
+	} END_FOR_EACH_PTR(name);
+}
-- 
2.12.0

