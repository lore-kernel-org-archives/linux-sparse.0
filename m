From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] returns the correct type when evaluating NULL
Date: Mon,  6 Mar 2017 05:43:49 +0100
Message-ID: <20170306044349.16869-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36834 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbdCFEn6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 23:43:58 -0500
Received: by mail-wr0-f196.google.com with SMTP id l37so20151980wrc.3
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 20:43:57 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In evaluate_cast(), the expression '(void*)<some zero constant>',
aka 'NULL', is detected and given the type 'null_ctype',
a special kind of pointer type.
However the returned type is the original one: 'void *'.

This doesn't seem to be intented as in all other cases, the
evaluate_...() functions and ultimately evaluate_expression()
always return the type of the expression.

Fix this by returning the type given to the expression: null_ctype.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 47eeaef2e..440d05da6 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2844,7 +2844,7 @@ static struct symbol *evaluate_cast(struct expression *expr)
 				expr->type = EXPR_VALUE;
 				expr->ctype = &null_ctype;
 				expr->value = 0;
-				return ctype;
+				return expr->ctype;
 			}
 		}
 	}
-- 
2.11.1

