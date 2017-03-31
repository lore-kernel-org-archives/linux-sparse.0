From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 19/25] constexpr: flag builtins constant_p, safe_p and warning as constexprs
Date: Fri, 31 Mar 2017 03:44:53 +0200
Message-ID: <20170331014459.9351-20-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35232 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934699AbdCaBqr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:47 -0400
Received: by mail-wr0-f196.google.com with SMTP id p52so16621792wrc.2
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:46 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

Unconditionally flag the expressions
  __builtin_constant_p(),
  __builtin_safe_p(),
  __builtin_warning()
as being integer constant expressions.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin.c b/builtin.c
index dbb81032b..a427b45ee 100644
--- a/builtin.c
+++ b/builtin.c
@@ -27,9 +27,10 @@
 #include "expand.h"
 #include "symbol.h"
 
-static int evaluate_to_integer(struct expression *expr)
+static int evaluate_to_int_const_expr(struct expression *expr)
 {
 	expr->ctype = &int_ctype;
+	expr->flags |= CEF_SET_ICE;
 	return 1;
 }
 
@@ -152,17 +153,17 @@ static int expand_safe_p(struct expression *expr, int cost)
 }
 
 static struct symbol_op constant_p_op = {
-	.evaluate = evaluate_to_integer,
+	.evaluate = evaluate_to_int_const_expr,
 	.expand = expand_constant_p
 };
 
 static struct symbol_op safe_p_op = {
-	.evaluate = evaluate_to_integer,
+	.evaluate = evaluate_to_int_const_expr,
 	.expand = expand_safe_p
 };
 
 static struct symbol_op warning_op = {
-	.evaluate = evaluate_to_integer,
+	.evaluate = evaluate_to_int_const_expr,
 	.expand = expand_warning
 };
 
-- 
2.12.0

