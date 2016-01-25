From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v2 10/13] symbol: flag builtins constant_p, safe_p and warning as constexprs
Date: Mon, 25 Jan 2016 16:02:06 +0100
Message-ID: <87mvrtem8h.fsf@gmail.com>
References: <87twm1g1go.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34470 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000AbcAYPCJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 10:02:09 -0500
Received: by mail-wm0-f65.google.com with SMTP id b14so11806226wmb.1
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 07:02:09 -0800 (PST)
In-Reply-To: <87twm1g1go.fsf@gmail.com> (Nicolai Stange's message of "Mon, 25
	Jan 2016 15:47:51 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Nicolai Stange <nicstange@gmail.com>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
index 0ceff62..0438dc4 100644
--- a/symbol.c
+++ b/symbol.c
@@ -642,9 +642,10 @@ struct symbol *create_symbol(int stream, const char *name, int type, int namespa
 	return sym;
 }
 
-static int evaluate_to_integer(struct expression *expr)
+static int evaluate_to_int_const_expr(struct expression *expr)
 {
 	expr->ctype = &int_ctype;
+	expr_set_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);
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
2.7.0

