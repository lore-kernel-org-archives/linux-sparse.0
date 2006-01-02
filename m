From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH 6/7] implement #strong_define
Date: Mon, 02 Jan 2006 22:20:21 +0300
Message-ID: <43B97CF5.B57A133A@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.tv-sign.ru ([213.234.233.51]:32727 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750926AbWABSEW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Jan 2006 13:04:22 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

Example

	#strong_define FOO 1

	#undef	FOO	// silently ignored
	#define	FOO 2	// silently ignored

This allows (for example) to override CONFIG_XXX values without
editing include/linux/autoconf.h

I think this is useful. If you think differently, I will appreciate
your comments on this patch correctness.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- git-snapshot-20060101/symbol.h~6_DEF	2006-01-02 23:36:40.000000000 +0300
+++ git-snapshot-20060101/symbol.h	2006-01-02 23:51:36.000000000 +0300
@@ -70,13 +70,14 @@ struct symbol_op {
 extern int expand_safe_p(struct expression *expr, int cost);
 extern int expand_constant_p(struct expression *expr, int cost);
 
-#define SYM_ATTR_WEAK		1
-#define SYM_ATTR_NORMAL		0
+#define SYM_ATTR_WEAK		0
+#define SYM_ATTR_NORMAL		1
+#define SYM_ATTR_STRONG		2
 
 struct symbol {
 	enum namespace namespace:8;
 	enum type type:8;
-	unsigned char used:1, attr:1;
+	unsigned char used:1, attr:2;
 	struct position pos;		/* Where this symbol was declared */
 	struct ident *ident;		/* What identifier this symbol is associated with */
 	struct symbol *next_id;		/* Next semantic symbol that shares this identifier */
--- git-snapshot-20060101/pre-process.c~6_DEF	2006-01-02 23:45:31.000000000 +0300
+++ git-snapshot-20060101/pre-process.c	2006-01-03 00:28:36.000000000 +0300
@@ -1088,7 +1088,7 @@ static int do_handle_define(struct strea
 	if (sym) {
 		int clean;
 
-		if (attr > sym->attr)
+		if (attr < sym->attr)
 			goto out;
 
 		clean = (attr == sym->attr);
@@ -1134,6 +1134,11 @@ static int handle_weak_define(struct str
 	return do_handle_define(stream, line, token, SYM_ATTR_WEAK);
 }
 
+static int handle_strong_define(struct stream *stream, struct token **line, struct token *token)
+{
+	return do_handle_define(stream, line, token, SYM_ATTR_STRONG);
+}
+
 static int handle_undef(struct stream *stream, struct token **line, struct token *token)
 {
 	struct token *left = token->next;
@@ -1145,7 +1150,7 @@ static int handle_undef(struct stream *s
 	}
 
 	sym = lookup_macro(left->ident);
-	if (!sym)
+	if (!sym || sym->attr > SYM_ATTR_NORMAL)
 		return 1;
 
 	if (sym->scope != file_scope) {
@@ -1565,15 +1570,16 @@ static void init_preprocessor(void)
 		const char *name;
 		int (*handler)(struct stream *, struct token **, struct token *);
 	} normal[] = {
-		{ "define",	handle_define },
-		{ "weak_define",handle_weak_define },
-		{ "undef",	handle_undef },
-		{ "warning",	handle_warning },
-		{ "error",	handle_error },
-		{ "include",	handle_include },
-		{ "include_next",handle_include_next },
-		{ "pragma",	handle_pragma },
-		{ "line",	handle_line },
+		{ "define",		handle_define },
+		{ "weak_define",	handle_weak_define },
+		{ "strong_define",	handle_strong_define },
+		{ "undef",		handle_undef },
+		{ "warning",		handle_warning },
+		{ "error",		handle_error },
+		{ "include",		handle_include },
+		{ "include_next",	handle_include_next },
+		{ "pragma",		handle_pragma },
+		{ "line",		handle_line },
 
 		// our internal preprocessor tokens
 		{ "nostdinc",	   handle_nostdinc },
