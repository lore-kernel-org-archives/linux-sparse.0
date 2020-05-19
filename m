From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 15/28] scope: __func__ is special
Date: Tue, 19 May 2020 02:57:15 +0200
Message-ID: <20200519005728.84594-16-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgESA5u (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:50 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40099C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:49 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id se13so10370906ejb.9
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:49 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

__func__ needs to be in the namepsace for symbols: NS_SYMBOL
but doesn't follow the usual scope rules of them: it always
needs to be declared in the function scope.

So, use bind_symbol_scoped() instead of first using bind_symbol()
and then changing the namespace.
Also change the comment to better express that it's the scope
that is the unusual thing.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expression.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/expression.c b/expression.c
index 78e577cf10a1..ffb3c2dce4d5 100644
--- a/expression.c
+++ b/expression.c
@@ -122,9 +122,8 @@ static struct symbol *handle_func(struct token *token)
 	decl->ctype.modifiers = MOD_STATIC;
 	decl->endpos = token->pos;
 
-	/* function-scope, but in NS_SYMBOL */
-	bind_symbol(decl, ident, NS_LABEL);
-	decl->namespace = NS_SYMBOL;
+	/* NS_SYMBOL but in function-scope */
+	bind_symbol_with_scope(decl, ident, NS_SYMBOL, function_scope);
 
 	len = current_fn->ident->len;
 	string = __alloc_string(len + 1);
-- 
2.26.2
