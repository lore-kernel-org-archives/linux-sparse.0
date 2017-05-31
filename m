From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] force to 0 expressions which are erroneously non-constant
Date: Wed, 31 May 2017 15:31:23 +0200
Message-ID: <20170531133123.3105-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36588 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbdEaNbc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 31 May 2017 09:31:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id k15so3662066wmh.3
        for <linux-sparse@vger.kernel.org>; Wed, 31 May 2017 06:31:32 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Wher some expression that need to be constant but in fact is not
constant, sparse throw an error and leave the expression as-is.

But some code may make the explicit or implicit assumption that
the expression is constant and use its value, resulting in some
random value, which is not desirable.

One situation where this happen is in code like:
	switch (x) {
	case <some non-const expression>: ...
In this case, the linearization of the switch/case statement
will unconditionally use the value of the case expression
but the expression has no value.

One way to avoid this would be to add defensive checks each time
a value is retrieved but this is a lot of work and time for no
benefit.

Change this by forcing the expression to be a constant value of 0
just after the error message has been issued.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/expand.c b/expand.c
index dacee7a76..8ee52cfd5 100644
--- a/expand.c
+++ b/expand.c
@@ -1054,8 +1054,11 @@ static void expand_const_expression(struct expression *expr, const char *where)
 {
 	if (expr) {
 		expand_expression(expr);
-		if (expr->type != EXPR_VALUE)
+		if (expr->type != EXPR_VALUE) {
 			expression_error(expr, "Expected constant expression in %s", where);
+			expr->type = EXPR_VALUE;
+			expr->value = 0;
+		}
 	}
 }
 
-- 
2.13.0

