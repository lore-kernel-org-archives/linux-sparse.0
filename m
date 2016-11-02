From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] cleanup: remove evaluate_arguments()'s unused argument
Date: Wed,  2 Nov 2016 18:16:23 +0100
Message-ID: <20161102171623.17883-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34765 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933217AbcKBRQd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 13:16:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id p190so4055055wmp.1
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 10:16:27 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Was slightly confusing when reading some code.
Better to remove it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index e350c0c0..b45a3958 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2172,7 +2172,7 @@ static struct symbol *evaluate_alignof(struct expression *expr)
 	return size_t_ctype;
 }
 
-static int evaluate_arguments(struct symbol *f, struct symbol *fn, struct expression_list *head)
+static int evaluate_arguments(struct symbol *fn, struct expression_list *head)
 {
 	struct expression *expr;
 	struct symbol_list *argument_types = fn->arguments;
@@ -2885,7 +2885,7 @@ static struct symbol *evaluate_call(struct expression *expr)
 		if (!sym->op->args(expr))
 			return NULL;
 	} else {
-		if (!evaluate_arguments(sym, ctype, arglist))
+		if (!evaluate_arguments(ctype, arglist))
 			return NULL;
 		args = expression_list_size(expr->args);
 		fnargs = symbol_list_size(ctype->arguments);
-- 
2.10.1

