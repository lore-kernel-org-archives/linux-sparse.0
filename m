From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 23/28] bad-goto: label expression inside a statement expression is UB
Date: Tue, 19 May 2020 02:57:23 +0200
Message-ID: <20200519005728.84594-24-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgESA55 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:57 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20BEC061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:56 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a2so744302ejb.10
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:56 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

More exactly, what is undefined is to jump inside the statement
expression with a computed goto.

Of course, once the address of such a label is taken, it's generaly
impossible to track if it will be used or not to jump inside the
statement expression.

So, for now, handle taking the address of such a label from outside
the statement expression, exactly as if a computed goto is effectively
done from there and so issue an error message and also mark the function
as useless for linearization.

Note: this is only partially correct since:
      1) the address could be taken from outside the statement
         and never used for a computed goto.
      2) the address could be taken from outside the statement
         but the corresponding computed goto only done from
         inside, which is perfectly fine.
      3) the address could be taken from inside but a computed
         goto done from outside.

Note: the real problem, like for the regular goto, is that the
      statement expression can be eliminated before linearization,
      the correspondng gotos corresponding then to branches to
      unexistent BBs.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expression.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/expression.c b/expression.c
index f8a8f03e7402..bbbc24e6b561 100644
--- a/expression.c
+++ b/expression.c
@@ -691,6 +691,7 @@ static struct token *unary_expression(struct token *token, struct expression **t
 				sym->ctype.modifiers |= MOD_ADDRESSABLE;
 				add_symbol(&function_computed_target_list, sym);
 			}
+			check_label_usage(sym, token->pos);
 			label->flags = CEF_ADDR;
 			label->label_symbol = sym;
 			*tree = label;
-- 
2.26.2
