From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH 4/4] fix loss of 'weak' attribute on usage
Date: Mon, 4 Sep 2006 19:42:11 +0400
Message-ID: <20060904154211.GA6437@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from taganka54-host.corbina.net ([213.234.233.54]:26604 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S964812AbWIDLmK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Sep 2006 07:42:10 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josht@us.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>

When NS_MACRO symbol is used, sparse clears it's 'weak' flag.
This is bad for multifile parsing, and wrong:

	#weak_define FOO 1
	FOO
	#weak_define FOO 2	// silently ignored

After this patch sparse never writes to NS_MACRO symbols from
another scope.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- git-snapshot-20060904/symbol.h~4USED	2006-09-04 18:20:23.000000000 +0400
+++ git-snapshot-20060904/symbol.h	2006-09-04 19:22:36.000000000 +0400
@@ -97,6 +97,7 @@ struct symbol {
 		struct /* NS_MACRO */ {
 			struct token *expansion;
 			struct token *arglist;
+			struct scope *used_in;
 		};
 		struct /* NS_PREPROCESSOR */ {
 			int (*handler)(struct stream *, struct token **, struct token *);
--- git-snapshot-20060904/pre-process.c~4USED	2006-09-04 19:17:22.000000000 +0400
+++ git-snapshot-20060904/pre-process.c	2006-09-04 19:22:36.000000000 +0400
@@ -114,7 +114,7 @@ static int token_defined(struct token *t
 	if (token_type(token) == TOKEN_IDENT) {
 		struct symbol *sym = lookup_macro(token->ident);
 		if (sym) {
-			sym->weak = 0;
+			sym->used_in = file_scope;
 			return 1;
 		}
 		return 0;
@@ -143,7 +143,7 @@ static int expand_one_symbol(struct toke
 
 	sym = lookup_macro(token->ident);
 	if (sym) {
-		sym->weak = 0;
+		sym->used_in = file_scope;
 		return expand(list, sym);
 	}
 	if (token->ident == &__LINE___ident) {
@@ -1096,7 +1096,7 @@ static int do_handle_define(struct strea
 		if (token_list_different(sym->expansion, expansion) ||
 		    token_list_different(sym->arglist, arglist)) {
 			ret = 0;
-			if (clean && !weak) {
+			if ((clean && !weak) || sym->used_in == file_scope) {
 				warning(left->pos, "preprocessor token %.*s redefined",
 						name->len, name->name);
 				info(sym->pos, "this was the original definition");
@@ -1117,6 +1117,7 @@ static int do_handle_define(struct strea
 		__free_token(token);	/* Free the "define" token, but not the rest of the line */
 	}
 
+	sym->used_in = NULL;
 	sym->weak = weak;
 out:
 	return ret;
@@ -1152,6 +1153,7 @@ static int handle_undef(struct stream *s
 	}
 
 	sym->namespace = NS_UNDEF;
+	sym->used_in = NULL;
 
 	return 1;
 }


-- 
VGER BF report: U 0.500211
