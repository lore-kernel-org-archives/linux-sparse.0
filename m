From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH 2/4] fix handle_undef() on builtin macros
Date: Mon, 4 Sep 2006 19:41:48 +0400
Message-ID: <20060904154148.GA6431@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from taganka54-host.corbina.net ([213.234.233.54]:9947 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S964801AbWIDLlm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Sep 2006 07:41:42 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josht@us.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>

Example:

	inc.h:
		#define FOO bar
		#undef FOO

	file.c:
		FOO

	$ test-lexing -include inc.h file.c
	bar					<------ should be 'FOO'

This patch kills NS_INVISIBLEMACRO and introduces NS_UNDEF,
this is also used in the next patches.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- git-snapshot-20060904/symbol.h~2UNDEF	2006-09-03 23:32:31.000000000 +0400
+++ git-snapshot-20060904/symbol.h	2006-09-04 18:20:23.000000000 +0400
@@ -32,7 +32,7 @@ enum namespace {
 	NS_SYMBOL = 16,
 	NS_ITERATOR = 32,
 	NS_PREPROCESSOR = 64,
-	NS_INVISIBLEMACRO = 128,
+	NS_UNDEF = 128,
 };
 
 enum type {
--- git-snapshot-20060904/scope.c~2UNDEF	2006-09-03 23:32:31.000000000 +0400
+++ git-snapshot-20060904/scope.c	2006-09-04 18:20:23.000000000 +0400
@@ -41,7 +41,6 @@ static void start_scope(struct scope **s
 void start_file_scope(void)
 {
 	struct scope *scope = __alloc_scope(0);
-	struct symbol *sym;
 
 	memset(scope, 0, sizeof(*scope));
 	scope->next = &builtin_scope;
@@ -50,12 +49,6 @@ void start_file_scope(void)
 	/* top-level stuff defaults to file scopt, "extern" etc will choose global scope */
 	function_scope = scope;
 	block_scope = scope;
-
-	/* Make the builtin macros visible again */
-	FOR_EACH_PTR(builtin_scope.symbols, sym) {
-		if (sym->namespace == NS_INVISIBLEMACRO)
-			sym->namespace = NS_MACRO;
-	} END_FOR_EACH_PTR(sym);
 }
 
 void start_symbol_scope(void)
--- git-snapshot-20060904/pre-process.c~2UNDEF	2006-09-04 17:19:51.000000000 +0400
+++ git-snapshot-20060904/pre-process.c	2006-09-04 18:20:23.000000000 +0400
@@ -103,7 +103,7 @@ static void replace_with_integer(struct 
 
 static struct symbol *lookup_macro(struct ident *ident)
 {
-	struct symbol *sym = lookup_symbol(ident, NS_MACRO | NS_INVISIBLEMACRO);
+	struct symbol *sym = lookup_symbol(ident, NS_MACRO | NS_UNDEF);
 	if (sym && sym->namespace != NS_MACRO)
 		sym = NULL;
 	return sym;
@@ -1134,8 +1134,15 @@ static int handle_undef(struct stream *s
 	}
 
 	sym = lookup_macro(left->ident);
-	if (sym)
-		sym->namespace = NS_INVISIBLEMACRO;
+	if (!sym)
+		return 1;
+
+	if (sym->scope != file_scope) {
+		sym = alloc_symbol(left->pos, SYM_NODE);
+		bind_symbol(sym, left->ident, NS_MACRO);
+	}
+
+	sym->namespace = NS_UNDEF;
 
 	return 1;
 }


-- 
VGER BF report: U 0.500014
