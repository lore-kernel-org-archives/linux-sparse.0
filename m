From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH 2/3] implement #strong_define
Date: Mon, 4 Sep 2006 20:16:18 +0400
Message-ID: <20060904161618.GA7692@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from taganka54-host.corbina.net ([213.234.233.54]:25242 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S964801AbWIDMQT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Sep 2006 08:16:19 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josht@us.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>

Example

	#strong_define FOO 1

	#undef	FOO	// silently ignored
	#define	FOO 2	// silently ignored

This allows (for example) to override CONFIG_XXX values without
editing include/linux/autoconf.h

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- git-snapshot-20060904/symbol.h~6DEF	2006-09-04 19:44:19.000000000 +0400
+++ git-snapshot-20060904/symbol.h	2006-09-04 19:48:23.000000000 +0400
@@ -80,13 +80,14 @@ struct symbol_op {
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
--- git-snapshot-20060904/pre-process.c~6DEF	2006-09-04 19:44:19.000000000 +0400
+++ git-snapshot-20060904/pre-process.c	2006-09-04 19:48:23.000000000 +0400
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


-- 
VGER BF report: H 5.71153e-14
