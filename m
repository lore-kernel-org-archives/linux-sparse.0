From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH] fix "wrong" NS_STRUCT symbol->pos
Date: Mon, 19 Dec 2005 21:35:58 +0300
Message-ID: <43A6FD8E.19FAAC85@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.tv-sign.ru ([213.234.233.51]:41401 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932231AbVLSRUh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 19 Dec 2005 12:20:37 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org

NS_STRUCT symbol gets it's ->pos from alloc_symbol(), it
could be called when sparse sees struct's forward declaration.

This patch ensures that ->pos identifies position where this
struct/union is actually defined.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- git-snapshot-20051210/parse.c~	2005-12-18 20:01:25.000000000 +0300
+++ git-snapshot-20051210/parse.c	2005-12-18 20:08:13.000000000 +0300
@@ -109,6 +109,7 @@ static struct token *struct_union_enum_s
 	struct token *(*parse)(struct token *, struct symbol *))
 {
 	struct symbol *sym;
+	struct position *repos;
 
 	ctype->modifiers = 0;
 	if (token_type(token) == TOKEN_IDENT) {
@@ -123,14 +124,16 @@ static struct token *struct_union_enum_s
 		}
 		if (sym->type != type)
 			error_die(token->pos, "invalid tag applied to %s", show_typename (sym));
-		token = token->next;
 		ctype->base_type = sym;
+		repos = &token->pos;
+		token = token->next;
 		if (match_op(token, '{')) {
 			// The following test is actually wrong for empty
 			// structs, but (1) they are not C99, (2) gcc does
 			// the same thing, and (3) it's easier.
 			if (sym->symbol_list)
 				error_die(token->pos, "redefinition of %s", show_typename (sym));
+			sym->pos = *repos;
 			token = parse(token->next, sym);
 			token = expect(token, '}', "at end of struct-union-enum-specifier");
