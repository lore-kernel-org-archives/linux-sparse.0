From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 4/16] null pointer constants have no special meaning for pointer subtraction
Date: Sun, 24 Jun 2007 09:03:51 +0100
Message-ID: <E1I2N4Z-0003cJ-5w@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34687 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbXFXIDv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 04:03:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I2N4Z-0003cJ-5w
	for linux-sparse@vger.kernel.org; Sun, 24 Jun 2007 09:03:51 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   19 ++-----------------
 1 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index febfad2..2510c2b 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -833,16 +833,6 @@ static int is_null_ptr(struct expression *expr)
 	return 1;
 }
 
-static struct symbol *common_ptr_type(struct expression *l, struct expression *r)
-{
-	/* NULL expression? Just return the type of the "other side" */
-	if (is_null_ptr(r))
-		return l->ctype;
-	if (is_null_ptr(l))
-		return r->ctype;
-	return NULL;
-}
-
 /*
  * Ignore differences in "volatile" and "const"ness when
  * subtracting pointers
@@ -868,13 +858,8 @@ static struct symbol *evaluate_ptr_sub(struct expression *expr, struct expressio
 
 	ctype = ltype;
 	typediff = type_difference(ltype, rtype, ~MOD_SIZE, ~MOD_SIZE);
-	if (typediff) {
-		ctype = common_ptr_type(l, r);
-		if (!ctype) {
-			expression_error(expr, "subtraction of different types can't work (%s)", typediff);
-			return NULL;
-		}
-	}
+	if (typediff)
+		expression_error(expr, "subtraction of different types can't work (%s)", typediff);
 	examine_symbol_type(ctype);
 
 	/* Figure out the base type we point to */
-- 
1.5.0-rc2.GIT
