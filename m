From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 17/21] symbol: flag builtins constant_p, safe_p and warning as constexprs
Date: Mon, 01 Feb 2016 03:43:53 +0100
Message-ID: <87k2mpgnfa.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34777 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbcBACnz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:43:55 -0500
Received: by mail-wm0-f66.google.com with SMTP id p63so7040444wmp.1
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:43:55 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

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
index 0ceff62..42e6a8f 100644
--- a/symbol.c
+++ b/symbol.c
@@ -642,9 +642,10 @@ struct symbol *create_symbol(int stream, const char *name, int type, int namespa
 	return sym;
 }
 
-static int evaluate_to_integer(struct expression *expr)
+static int evaluate_to_int_const_expr(struct expression *expr)
 {
 	expr->ctype = &int_ctype;
+	expr->constexpr_flags |= CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
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

