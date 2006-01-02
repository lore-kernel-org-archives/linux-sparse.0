From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH 3/7] fix redefine of #weak_define
Date: Mon, 02 Jan 2006 22:19:56 +0300
Message-ID: <43B97CDC.4BA569C0@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.tv-sign.ru ([213.234.233.51]:27095 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750845AbWABSD5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Jan 2006 13:03:57 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

This patch fixes 2 bugs in do_handle_define()

1.	if (sym->weak)
		goto replace_it;

	This is wrong, we should allocate a new symbol if
	sym->scope != file_scope, example:

	inc.h:
		#weak_define FOO default

	redefine.c:
		#define FOO redefine
		FOO

	default.c:
		FOO

	$ ./test-lexing -include inc.h redefine.c default.c
	redefine
	Segmentation fault

2.	if (token_list_different(...)) {
		...
	}
	return 1;

	This is wrong too:

		#weak_define	FOO	1
		#define		FOO	1	// has no effect
		#define		FOO	2	// redefined without warning


Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- git-snapshot-20060101/pre-process.c~3_WEAK	2006-01-02 20:34:38.000000000 +0300
+++ git-snapshot-20060101/pre-process.c	2006-01-02 22:45:36.000000000 +0300
@@ -1061,6 +1061,7 @@ static int do_handle_define(struct strea
 	struct token *left = token->next;
 	struct symbol *sym;
 	struct ident *name;
+	int ret;
 
 	if (token_type(left) != TOKEN_IDENT) {
 		sparse_error(token->pos, "expected identifier to 'define'");
@@ -1082,35 +1083,43 @@ static int do_handle_define(struct strea
 	if (!expansion)
 		return 1;
 
+	ret = 1;
 	sym = lookup_macro(name);
-	if (sym) {
-		if (token_list_different(sym->expansion, expansion) || 
-		    token_list_different(sym->arglist, arglist)) {
-			if (sym->weak)
-				goto replace_it;
-			if (weak)
-				return 1;
-			warning(left->pos, "preprocessor token %.*s redefined",
-					name->len, name->name);
-			info(sym->pos, "this was the original definition");
-
-			/* Don't overwrite global defs */
-			if (sym->scope != file_scope)
-				goto allocate_new;
-			goto replace_it;
-		}
-		return 1;
-	}
-allocate_new:
-	sym = alloc_symbol(left->pos, SYM_NODE);
-	bind_symbol(sym, name, NS_MACRO);
-
-replace_it:
-	sym->expansion = expansion;
-	sym->arglist = arglist;
-	sym->weak = weak;
-	__free_token(token);		/* Free the "define" token, but not the rest of the line */
-	return 0;
+	if (sym) {
+		int clean;
+
+		if (weak > sym->weak)
+			goto out;
+
+		clean = (weak == sym->weak);
+
+		if (token_list_different(sym->expansion, expansion) ||
+		    token_list_different(sym->arglist, arglist)) {
+			ret = 0;
+			if (clean && !weak) {
+				warning(left->pos, "preprocessor token %.*s redefined",
+						name->len, name->name);
+				info(sym->pos, "this was the original definition");
+			}
+		} else if (clean)
+			goto out;
+	}
+
+	if (!sym || sym->scope != file_scope) {
+		sym = alloc_symbol(left->pos, SYM_NODE);
+		bind_symbol(sym, name, NS_MACRO);
+		ret = 0;
+	}
+
+	if (!ret) {
+		sym->expansion = expansion;
+		sym->arglist = arglist;
+		__free_token(token);	/* Free the "define" token, but not the rest of the line */
+	}
+
+	sym->weak = weak;
+out:
+	return ret;
 }
 
 static int handle_define(struct stream *stream, struct token **line, struct token *token)
