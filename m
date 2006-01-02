From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH 4/7] fix 'weak' attribute loss
Date: Mon, 02 Jan 2006 22:20:12 +0300
Message-ID: <43B97CEC.6E90F4B3@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.tv-sign.ru ([213.234.233.51]:29143 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750920AbWABSEM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Jan 2006 13:04:12 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

When NS_MACRO symbol is used, sparse clears it's 'weak' flag.
This is bad for multifile parsing, and wrong:

	#weak_define FOO 1
	FOO
	#weak_define FOO 2	// silently ignored

After this patch sparse never writes to NS_MACRO symbols from
another scope (except ->used_in).

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- git-snapshot-20060101/symbol.h~4_USED	2006-01-02 20:10:26.000000000 +0300
+++ git-snapshot-20060101/symbol.h	2006-01-02 22:51:09.000000000 +0300
@@ -87,6 +87,7 @@ struct symbol {
 		struct /* NS_MACRO */ {
 			struct token *expansion;
 			struct token *arglist;
+			struct scope *used_in;
 		};
 		struct /* NS_PREPROCESSOR */ {
 			int (*handler)(struct stream *, struct token **, struct token *);
--- git-snapshot-20060101/pre-process.c~4_USED	2006-01-02 22:48:30.000000000 +0300
+++ git-snapshot-20060101/pre-process.c	2006-01-02 23:15:07.000000000 +0300
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
