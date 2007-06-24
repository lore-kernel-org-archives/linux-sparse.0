From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 6/16] remove useless argument in evaluate_ptr_sub()
Date: Sun, 24 Jun 2007 09:04:11 +0100
Message-ID: <E1I2N4t-0003cz-6J@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34689 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbXFXIEL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 04:04:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I2N4t-0003cz-6J
	for linux-sparse@vger.kernel.org; Sun, 24 Jun 2007 09:04:11 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 5eba817..2203e67 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -836,12 +836,12 @@ static int is_null_ptr(struct expression *expr)
  */
 #define MOD_IGN (MOD_VOLATILE | MOD_CONST)
 
-static struct symbol *evaluate_ptr_sub(struct expression *expr, struct expression *l, struct expression **rp)
+static struct symbol *evaluate_ptr_sub(struct expression *expr, struct expression *l)
 {
 	const char *typediff;
 	struct symbol *ctype;
 	struct symbol *ltype, *rtype;
-	struct expression *r = *rp;
+	struct expression *r = expr->right;
 
 	ltype = degenerate(l);
 	rtype = degenerate(r);
@@ -851,7 +851,7 @@ static struct symbol *evaluate_ptr_sub(struct expression *expr, struct expressio
 	 * right thing.
 	 */
 	if (!is_ptr_type(rtype))
-		return evaluate_ptr_add(expr, degenerate(l), rp);
+		return evaluate_ptr_add(expr, degenerate(l), &expr->right);
 
 	ctype = ltype;
 	typediff = type_difference(ltype, rtype, ~MOD_SIZE, ~MOD_SIZE);
@@ -902,7 +902,7 @@ static struct symbol *evaluate_sub(struct expression *expr)
 	struct symbol *ltype = left->ctype;
 
 	if (is_ptr_type(ltype))
-		return evaluate_ptr_sub(expr, left, &expr->right);
+		return evaluate_ptr_sub(expr, left);
 
 	return evaluate_arith(expr, 1);
 }
-- 
1.5.0-rc2.GIT
