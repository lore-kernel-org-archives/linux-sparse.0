From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 23/25] return an error if too few args
Date: Fri, 31 Mar 2017 03:44:57 +0200
Message-ID: <20170331014459.9351-24-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35265 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935038AbdCaBqv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:51 -0400
Received: by mail-wr0-f196.google.com with SMTP id p52so16621998wrc.2
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:50 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In evaluate_call(), argumenst are evaluated an a diagnostic
is emitted if the number of args is not what is expected.

Good.
However, the processing continues nevertheless.
If too much args were given, this doesn't matter much
but if too few are given we need to check a bit everywhere
for possible NULL args.

Avoid this by returning early an error if there was too few
arguments.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 46ea10ed8..0cec215ba 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3019,10 +3019,12 @@ static struct symbol *evaluate_call(struct expression *expr)
 			return NULL;
 		args = expression_list_size(expr->args);
 		fnargs = symbol_list_size(ctype->arguments);
-		if (args < fnargs)
+		if (args < fnargs) {
 			expression_error(expr,
 				     "not enough arguments for function %s",
 				     show_ident(sym->ident));
+			return NULL;
+		}
 		if (args > fnargs && !ctype->variadic)
 			expression_error(expr,
 				     "too many arguments for function %s",
-- 
2.12.0

