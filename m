From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH RFC 10/13] symbol: flag builtins constant_p, safe_p and warning as constexprs
Date: Thu, 23 Jul 2015 01:22:09 +0200
Message-ID: <87oaj3ixr2.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37315 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbGVXWM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2015 19:22:12 -0400
Received: by wibud3 with SMTP id ud3so194226899wib.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2015 16:22:11 -0700 (PDT)
Received: from localhost.localdomain (x55b1cac6.dyn.telefonica.de. [85.177.202.198])
        by smtp.gmail.com with ESMTPSA id e7sm5597916wib.22.2015.07.22.16.22.10
        for <linux-sparse@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 16:22:11 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Unconditionally flag the expressions
  __builtin_constant_p(),
  __builtin_safe_p(),
  __builtin_warning()
as being integer constant expressions.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 symbol.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/symbol.c b/symbol.c
index 0ceff62..cbc846b 100644
--- a/symbol.c
+++ b/symbol.c
@@ -642,9 +642,10 @@ struct symbol *create_symbol(int stream, const char *name, int type, int namespa
 	return sym;
 }
 
-static int evaluate_to_integer(struct expression *expr)
+static int evaluate_to_int_const_expr(struct expression *expr)
 {
 	expr->ctype = &int_ctype;
+	expr->flags |= expr_set_flag_mask(EXPR_FLAG_INT_CONST_EXPR);
 	return 1;
 }
 
@@ -749,17 +750,17 @@ out:
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
2.4.5

