From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] dissect: use show_ident() to print dctx->ident
Date: Wed, 12 Feb 2020 10:21:40 +0100
Message-ID: <20200212092140.GA21571@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21582 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728595AbgBLJVr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Feb 2020 04:21:47 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

I didn't know show_ident() uses 4 buffers for the string it returns and
thus it is safe to call it twice in a row.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/dissect.c b/dissect.c
index 499e0a0..6706690 100644
--- a/dissect.c
+++ b/dissect.c
@@ -617,16 +617,13 @@ static inline struct symbol *do_symbol(struct symbol *sym)
 
 	break; case SYM_FN:
 		stmt = sym->ctype.modifiers & MOD_INLINE
-			? type->inline_stmt
-			: type->stmt;
+			? type->inline_stmt : type->stmt;
 		if (!stmt)
 			break;
 
 		if (dctx)
-			sparse_error(dctx->pos,
-				"dissect_ctx change %.*s -> %s",
-				dctx->ident->len, dctx->ident->name,
-				show_ident(sym->ident));
+			sparse_error(dctx->pos, "dissect_ctx change %s -> %s",
+				show_ident(dctx->ident), show_ident(sym->ident));
 
 		dissect_ctx = sym;
 		do_sym_list(type->arguments);
-- 
2.5.0
