From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH 1/7] use lookup_macro() in handle_undef()
Date: Mon, 02 Jan 2006 22:19:42 +0300
Message-ID: <43B97CCD.5BD4F335@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.tv-sign.ru ([213.234.233.51]:22231 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750878AbWABSD5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Jan 2006 13:03:57 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

Current code looks strange, I think it used to remove the symbol
from ->symbols list some time ago.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- git-snapshot-20060101/pre-process.c~1_HUCL	2006-01-01 00:13:52.000000000 +0300
+++ git-snapshot-20060101/pre-process.c	2006-01-02 20:04:22.000000000 +0300
@@ -1126,22 +1126,17 @@ static int handle_weak_define(struct str
 static int handle_undef(struct stream *stream, struct token **line, struct token *token)
 {
 	struct token *left = token->next;
-	struct symbol **sym;
+	struct symbol *sym;
 
 	if (token_type(left) != TOKEN_IDENT) {
 		sparse_error(token->pos, "expected identifier to 'undef'");
 		return 1;
 	}
 
-	sym = &left->ident->symbols;
-	while (*sym) {
-		struct symbol *t = *sym;
-		if (t->namespace & (NS_MACRO | NS_INVISIBLEMACRO)) {
-			t->namespace = NS_INVISIBLEMACRO;
-			return 1;
-		}
-		sym = &t->next_id;
-	}
+	sym = lookup_macro(left->ident);
+	if (sym)
+		sym->namespace = NS_INVISIBLEMACRO;
+
 	return 1;
 }
