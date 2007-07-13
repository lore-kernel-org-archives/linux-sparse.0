From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 2/8] clean up evaluate_sign()
Date: Fri, 13 Jul 2007 18:44:37 +0100
Message-ID: <E1I9PC1-0000E0-4q@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49718 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbXGMRoh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 13:44:37 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I9PC1-0000E0-4q
	for linux-sparse@vger.kernel.org; Fri, 13 Jul 2007 18:44:37 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 9f543fe..7669c9a 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1671,17 +1671,19 @@ static struct symbol *evaluate_postop(struct expression *expr)
 static struct symbol *evaluate_sign(struct expression *expr)
 {
 	struct symbol *ctype = expr->unop->ctype;
+	int class = classify_type(ctype, &ctype);
 	if (expr->flags && !(expr->unop->flags & Int_const_expr))
 		expr->flags = 0;
-	if (is_int_type(ctype)) {
-		struct symbol *rtype = rtype = integer_promotion(ctype);
+	/* should be an arithmetic type */
+	if (!(class & TYPE_NUM))
+		return bad_expr_type(expr);
+	if (!(class & (TYPE_FLOAT|TYPE_RESTRICT))) {
+		struct symbol *rtype = integer_promotion(ctype);
 		expr->unop = cast_to(expr->unop, rtype);
 		ctype = rtype;
-	} else if (is_float_type(ctype) && expr->op != '~') {
-		/* no conversions needed */
-	} else if (is_restricted_type(ctype) && !restricted_unop(expr->op, &ctype)) {
+	} else if ((class & TYPE_FLOAT) && expr->op != '~') {
 		/* no conversions needed */
-	} else if (is_fouled_type(ctype) && !restricted_unop(expr->op, &ctype)) {
+	} else if ((class & TYPE_RESTRICT) && !restricted_unop(expr->op, &ctype)) {
 		/* no conversions needed */
 	} else {
 		return bad_expr_type(expr);
-- 
1.5.0-rc2.GIT
