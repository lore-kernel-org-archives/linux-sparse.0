From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH 2/7] kill NS_INVISIBLEMACRO, introduce NS_UNDEF
Date: Mon, 02 Jan 2006 22:19:49 +0300
Message-ID: <43B97CD5.493EF3C2@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.tv-sign.ru ([213.234.233.51]:24791 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750882AbWABSD6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Jan 2006 13:03:58 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

With this patch handle_undef() doesn't corrupt the builtin macros.

This (imho) cleanups the code and is used in the next patches.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- git-snapshot-20060101/symbol.h~2_UNDEF	2006-01-01 00:13:52.000000000 +0300
+++ git-snapshot-20060101/symbol.h	2006-01-02 20:10:26.000000000 +0300
@@ -32,7 +32,7 @@ enum namespace {
 	NS_SYMBOL = 16,
 	NS_ITERATOR = 32,
 	NS_PREPROCESSOR = 64,
-	NS_INVISIBLEMACRO = 128,
+	NS_UNDEF = 128,
 };
 
 enum type {
--- git-snapshot-20060101/scope.c~2_UNDEF	2006-01-01 00:13:52.000000000 +0300
+++ git-snapshot-20060101/scope.c	2006-01-02 20:28:40.000000000 +0300
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
--- git-snapshot-20060101/pre-process.c~2_UNDEF	2006-01-02 20:02:57.000000000 +0300
+++ git-snapshot-20060101/pre-process.c	2006-01-02 20:34:38.000000000 +0300
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
