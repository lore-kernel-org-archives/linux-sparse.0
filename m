From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH 3/4] fix (SIGSEGV) handle_define() on #weak_define
Date: Mon, 4 Sep 2006 19:41:57 +0400
Message-ID: <20060904154157.GA6434@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from taganka54-host.corbina.net ([213.234.233.54]:23020 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S964806AbWIDLlz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Sep 2006 07:41:55 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josht@us.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>

This patch fixes 2 bugs in do_handle_define()

1.
	do_handle_define:
		...
		if (sym->weak)
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


2.
	'#define' shouldn't inherit a weak attribute if the symbol
	was previously weak_define'd. Example:

		#weak_define	FOO	1
		#define		FOO	1	// has no effect
		#define		FOO	2	// redefined without warning

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- git-snapshot-20060904/pre-process.c~3WEAK	2006-09-04 18:20:23.000000000 +0400
+++ git-snapshot-20060904/pre-process.c	2006-09-04 19:16:45.000000000 +0400
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


-- 
VGER BF report: U 0.499562
