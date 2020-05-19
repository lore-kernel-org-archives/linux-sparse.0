From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 16/28] scope: __label__ is special
Date: Tue, 19 May 2020 02:57:16 +0200
Message-ID: <20200519005728.84594-17-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgESA5u (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:50 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31079C05BD0A
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:50 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e10so10222082edq.0
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:50 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Labels declared wth __label__ are special because they must follow
the block scope normally used for variables instad of using the
scope used for labels.

So, use bind_symbol_scoped() instead of first using bind_symbol()
and then changing the namespace.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/parse.c b/parse.c
index e23c5b64e8be..29e3f939166d 100644
--- a/parse.c
+++ b/parse.c
@@ -2569,8 +2569,7 @@ static struct token *label_statement(struct token *token)
 	while (token_type(token) == TOKEN_IDENT) {
 		struct symbol *sym = alloc_symbol(token->pos, SYM_LABEL);
 		/* it's block-scope, but we want label namespace */
-		bind_symbol(sym, token->ident, NS_SYMBOL);
-		sym->namespace = NS_LABEL;
+		bind_symbol_with_scope(sym, token->ident, NS_LABEL, block_scope);
 		fn_local_symbol(sym);
 		token = token->next;
 		if (!match_op(token, ','))
-- 
2.26.2
