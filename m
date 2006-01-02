From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH 5/7] prepare for #strong_{define,undef}
Date: Mon, 02 Jan 2006 22:20:17 +0300
Message-ID: <43B97CF1.8A073C26@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.tv-sign.ru ([213.234.233.51]:30679 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750923AbWABSER (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Jan 2006 13:04:17 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

This patch renames symbol->weak to symbol->attr and adds
symbolic names for it's values.

I don't like the new name, and will be happy to rename if
you suggest me something different.

Probably it is also better to move ->attr into the NS_MACRO
part of the union and make it integer.

No changes in pre-process.o

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- git-snapshot-20060101/symbol.h~5_PREP	2006-01-02 22:51:09.000000000 +0300
+++ git-snapshot-20060101/symbol.h	2006-01-02 23:36:40.000000000 +0300
@@ -70,10 +70,13 @@ struct symbol_op {
 extern int expand_safe_p(struct expression *expr, int cost);
 extern int expand_constant_p(struct expression *expr, int cost);
 
+#define SYM_ATTR_WEAK		1
+#define SYM_ATTR_NORMAL		0
+
 struct symbol {
 	enum namespace namespace:8;
 	enum type type:8;
-	unsigned char used:1, weak:1;
+	unsigned char used:1, attr:1;
 	struct position pos;		/* Where this symbol was declared */
 	struct ident *ident;		/* What identifier this symbol is associated with */
 	struct symbol *next_id;		/* Next semantic symbol that shares this identifier */
--- git-snapshot-20060101/pre-process.c~5_PREP	2006-01-02 23:15:07.000000000 +0300
+++ git-snapshot-20060101/pre-process.c	2006-01-02 23:45:32.000000000 +0300
@@ -1055,7 +1055,7 @@ Earg:
 	return NULL;
 }
 
-static int do_handle_define(struct stream *stream, struct token **line, struct token *token, int weak)
+static int do_handle_define(struct stream *stream, struct token **line, struct token *token, int attr)
 {
 	struct token *arglist, *expansion;
 	struct token *left = token->next;
@@ -1088,15 +1088,16 @@ static int do_handle_define(struct strea
 	if (sym) {
 		int clean;
 
-		if (weak > sym->weak)
+		if (attr > sym->attr)
 			goto out;
 
-		clean = (weak == sym->weak);
+		clean = (attr == sym->attr);
 
 		if (token_list_different(sym->expansion, expansion) ||
 		    token_list_different(sym->arglist, arglist)) {
 			ret = 0;
-			if ((clean && !weak) || sym->used_in == file_scope) {
+			if ((clean && attr == SYM_ATTR_NORMAL)
+					|| sym->used_in == file_scope) {
 				warning(left->pos, "preprocessor token %.*s redefined",
 						name->len, name->name);
 				info(sym->pos, "this was the original definition");
@@ -1118,19 +1119,19 @@ static int do_handle_define(struct strea
 	}
 
 	sym->used_in = NULL;
-	sym->weak = weak;
+	sym->attr = attr;
 out:
 	return ret;
 }
 
 static int handle_define(struct stream *stream, struct token **line, struct token *token)
 {
-	return do_handle_define(stream, line, token, 0);
+	return do_handle_define(stream, line, token, SYM_ATTR_NORMAL);
 }
 
 static int handle_weak_define(struct stream *stream, struct token **line, struct token *token)
 {
-	return do_handle_define(stream, line, token, 1);
+	return do_handle_define(stream, line, token, SYM_ATTR_WEAK);
 }
 
 static int handle_undef(struct stream *stream, struct token **line, struct token *token)
