From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH 3/3] implement #strong_undef
Date: Mon, 4 Sep 2006 20:16:32 +0400
Message-ID: <20060904161632.GA7695@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from taganka54-host.corbina.net ([213.234.233.54]:27546 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S964832AbWIDMQa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Sep 2006 08:16:30 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josht@us.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>

Example

	// pre-buffer
	#strong_undef CONFIG_SMP

	// include/linux/autoconf.h
	#define CONFIG_SMP 1		// silently ignored

	#ifdef CONFIG_SMP
		...			// not taken
	#endif

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- git-snapshot-20060904/pre-process.c~7UNDEF	2006-09-04 19:48:23.000000000 +0400
+++ git-snapshot-20060904/pre-process.c	2006-09-04 19:58:21.000000000 +0400
@@ -1084,14 +1084,14 @@ static int do_handle_define(struct strea
 		return 1;
 
 	ret = 1;
-	sym = lookup_macro(name);
+	sym = lookup_symbol(name, NS_MACRO | NS_UNDEF);
 	if (sym) {
 		int clean;
 
 		if (attr < sym->attr)
 			goto out;
 
-		clean = (attr == sym->attr);
+		clean = (attr == sym->attr && sym->namespace == NS_MACRO);
 
 		if (token_list_different(sym->expansion, expansion) ||
 		    token_list_different(sym->arglist, arglist)) {
@@ -1118,6 +1118,7 @@ static int do_handle_define(struct strea
 		__free_token(token);	/* Free the "define" token, but not the rest of the line */
 	}
 
+	sym->namespace = NS_MACRO;
 	sym->used_in = NULL;
 	sym->attr = attr;
 out:
@@ -1139,7 +1140,7 @@ static int handle_strong_define(struct s
 	return do_handle_define(stream, line, token, SYM_ATTR_STRONG);
 }
 
-static int handle_undef(struct stream *stream, struct token **line, struct token *token)
+static int do_handle_undef(struct stream *stream, struct token **line, struct token *token, int attr)
 {
 	struct token *left = token->next;
 	struct symbol *sym;
@@ -1149,21 +1150,37 @@ static int handle_undef(struct stream *s
 		return 1;
 	}
 
-	sym = lookup_macro(left->ident);
-	if (!sym || sym->attr > SYM_ATTR_NORMAL)
+	sym = lookup_symbol(left->ident, NS_MACRO | NS_UNDEF);
+	if (sym) {
+		if (attr < sym->attr)
+			return 1;
+		if (attr == sym->attr && sym->namespace == NS_UNDEF)
+			return 1;
+	} else if (attr <= SYM_ATTR_NORMAL)
 		return 1;
 
-	if (sym->scope != file_scope) {
+	if (!sym || sym->scope != file_scope) {
 		sym = alloc_symbol(left->pos, SYM_NODE);
 		bind_symbol(sym, left->ident, NS_MACRO);
 	}
 
 	sym->namespace = NS_UNDEF;
 	sym->used_in = NULL;
+	sym->attr = attr;
 
 	return 1;
 }
 
+static int handle_undef(struct stream *stream, struct token **line, struct token *token)
+{
+	return do_handle_undef(stream, line, token, SYM_ATTR_NORMAL);
+}
+
+static int handle_strong_undef(struct stream *stream, struct token **line, struct token *token)
+{
+	return do_handle_undef(stream, line, token, SYM_ATTR_STRONG);
+}
+
 static int preprocessor_if(struct stream *stream, struct token *token, int true)
 {
 	token_type(token) = false_nesting ? TOKEN_SKIP_GROUPS : TOKEN_IF;
@@ -1574,6 +1591,7 @@ static void init_preprocessor(void)
 		{ "weak_define",	handle_weak_define },
 		{ "strong_define",	handle_strong_define },
 		{ "undef",		handle_undef },
+		{ "strong_undef",	handle_strong_undef },
 		{ "warning",		handle_warning },
 		{ "error",		handle_error },
 		{ "include",		handle_include },


-- 
VGER BF report: H 0
