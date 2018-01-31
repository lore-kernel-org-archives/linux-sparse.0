From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] remove warning "call with no type"
Date: Wed, 31 Jan 2018 11:40:43 +0100
Message-ID: <20180131104043.3345-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40213 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbeAaKmy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 31 Jan 2018 05:42:54 -0500
Received: by mail-wm0-f65.google.com with SMTP id v123so6988661wmd.5
        for <linux-sparse@vger.kernel.org>; Wed, 31 Jan 2018 02:42:53 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This warning is issued when trying to linearize a call
expressions with a null expr->ctype but such null ctype
is a consequence of an error detected during evaluation
and this error must already have issued a warning or an
error message specific to the problem.

In short, this "call with no type" is non-informative
and redundant, so avoid usless noise and remove this
warning.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/linearize.c b/linearize.c
index 898acac88..739fc7c07 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1273,10 +1273,8 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 	struct symbol *fntype;
 	struct context *context;
 
-	if (!expr->ctype) {
-		warning(expr->pos, "call with no type!");
+	if (!expr->ctype)
 		return VOID;
-	}
 
 	fn = expr->fn;
 	fntype = fn->ctype;
-- 
2.16.0

