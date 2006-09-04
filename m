From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH 1/4] use lookup_macro() in handle_undef()
Date: Mon, 4 Sep 2006 19:41:35 +0400
Message-ID: <20060904154135.GA6424@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from taganka54-host.corbina.net ([213.234.233.54]:7387 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S964806AbWIDLle (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Sep 2006 07:41:34 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josht@us.ibm.com>, Al Viro <viro@zeniv.linux.org.uk>

The current code looks strange, I think it used to remove the symbol
from ->symbols list some time ago.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- git-snapshot-20060904/pre-process.c~1HUCL	2006-09-03 23:32:31.000000000 +0400
+++ git-snapshot-20060904/pre-process.c	2006-09-04 17:19:51.000000000 +0400
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
 


-- 
VGER BF report: H 0.0167159
