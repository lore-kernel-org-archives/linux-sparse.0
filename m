From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/8] early return if null ctype in evaluate_conditional()
Date: Fri,  2 Feb 2018 13:17:30 +0100
Message-ID: <20180202121735.39621-4-luc.vanoostenryck@gmail.com>
References: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33026 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBBMTu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Feb 2018 07:19:50 -0500
Received: by mail-wr0-f195.google.com with SMTP id s5so22396728wra.0
        for <linux-sparse@vger.kernel.org>; Fri, 02 Feb 2018 04:19:50 -0800 (PST)
In-Reply-To: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This function contains a few tests which must only be done
if the type is valid, same for the final call to degenerate().

Currently this is done by an "if (ctype) { ... }" but this
cause multiple NULL tests, take screen real estate and is
somehow error prone.

Change this by returning as soon as we know the ctype is
invalid since nothing good can be done after it.
This also makes, IMO, the code clearer.

NB: no functional changes here.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 027993983..1fc6111e4 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -879,25 +879,23 @@ static struct symbol *evaluate_conditional(struct expression *expr, int iterator
 		warning(expr->pos, "assignment expression in conditional");
 
 	ctype = evaluate_expression(expr);
-	if (ctype) {
-		if (is_safe_type(ctype))
-			warning(expr->pos, "testing a 'safe expression'");
-		if (is_func_type(ctype)) {
-			if (Waddress)
-				warning(expr->pos, "the address of %s will always evaluate as true", "a function");
-		} else if (is_array_type(ctype)) {
-			if (Waddress)
-				warning(expr->pos, "the address of %s will always evaluate as true", "an array");
-		} else if (!is_scalar_type(ctype)) {
-			sparse_error(expr->pos, "incorrect type in conditional");
-			info(expr->pos, "   got %s", show_typename(ctype));
-			ctype = NULL;
-		}
+	if (!ctype)
+		return NULL;
+	if (is_safe_type(ctype))
+		warning(expr->pos, "testing a 'safe expression'");
+	if (is_func_type(ctype)) {
+		if (Waddress)
+			warning(expr->pos, "the address of %s will always evaluate as true", "a function");
+	} else if (is_array_type(ctype)) {
+		if (Waddress)
+			warning(expr->pos, "the address of %s will always evaluate as true", "an array");
+	} else if (!is_scalar_type(ctype)) {
+		sparse_error(expr->pos, "incorrect type in conditional");
+		info(expr->pos, "   got %s", show_typename(ctype));
+		return NULL;
 	}
 
-	if (ctype)
-		ctype = degenerate(expr);
