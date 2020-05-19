From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 02/28] misc: s/fntype/rettype/
Date: Tue, 19 May 2020 02:57:02 +0200
Message-ID: <20200519005728.84594-3-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgESA5f (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:35 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9F7C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:35 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d24so2277077eds.11
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:35 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In evaluate_return_expression(), it's checked if the type of
the return statement match the function return type.

But, the variable used to hold this type is named 'fntype'
which is slightly confusing.

So, rename the variable holding the return type to 'rettype'
and only use 'fntype' for the one hoding the full function type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index b7bb1f52aa91..54cd5fa136e6 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3450,13 +3450,14 @@ void evaluate_symbol_list(struct symbol_list *list)
 static struct symbol *evaluate_return_expression(struct statement *stmt)
 {
 	struct expression *expr = stmt->expression;
-	struct symbol *fntype;
+	struct symbol *fntype, *rettype;
 
 	evaluate_expression(expr);
-	fntype = current_fn->ctype.base_type;
-	if (!fntype || fntype == &void_ctype) {
+	fntype = current_fn;
+	rettype = fntype->ctype.base_type;
+	if (!rettype || rettype == &void_ctype) {
 		if (expr && expr->ctype != &void_ctype)
-			expression_error(expr, "return expression in %s function", fntype?"void":"typeless");
+			expression_error(expr, "return expression in %s function", rettype?"void":"typeless");
 		if (expr && Wreturn_void)
 			warning(stmt->pos, "returning void-valued expression");
 		return NULL;
@@ -3468,7 +3469,7 @@ static struct symbol *evaluate_return_expression(struct statement *stmt)
 	}
 	if (!expr->ctype)
 		return NULL;
-	compatible_assignment_types(expr, fntype, &stmt->expression, "return expression");
+	compatible_assignment_types(expr, rettype, &stmt->expression, "return expression");
 	return NULL;
 }
 
-- 
2.26.2
