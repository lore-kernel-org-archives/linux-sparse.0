From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 3/7] evaluate_compare() can just use evaluate_arith() for non-pointer cases
Date: Sun, 01 Oct 2006 14:57:31 +0100
Message-ID: <E1GU1ox-0006vS-RC@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33708 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932204AbWJAN53
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 09:57:29 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1GU1ox-0006vS-RC
	for linux-sparse@vger.kernel.org; Sun, 01 Oct 2006 14:57:31 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


---
 evaluate.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index b3a79e7..1d33c58 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -999,26 +999,11 @@ static struct symbol *evaluate_compare(s
 		goto OK;
 	}
 
-	ctype = compatible_integer_binop(&expr->left, &expr->right);
+	ctype = evaluate_arith(expr, 1);
 	if (ctype) {
 		if (ctype->ctype.modifiers & MOD_UNSIGNED)
 			expr->op = modify_for_unsigned(expr->op);
-		goto OK;
-	}
-
-	ctype = compatible_float_binop(&expr->left, &expr->right);
-	if (ctype)
-		goto OK;
-
-	ctype = compatible_restricted_binop(expr->op, &expr->left, &expr->right);
-	if (ctype) {
-		if (ctype->ctype.modifiers & MOD_UNSIGNED)
-			expr->op = modify_for_unsigned(expr->op);
-		goto OK;
 	}
-
-	bad_expr_type(expr);
-
 OK:
 	expr->ctype = &bool_ctype;
 	return &bool_ctype;
-- 
1.4.2.GIT
