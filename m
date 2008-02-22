From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 3/3] catch !x & y brainos
Date: Fri, 22 Feb 2008 23:05:35 +0000
Message-ID: <E1JSgxT-0003mf-2B@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:54765 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbYBVXFg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 22 Feb 2008 18:05:36 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: josh@freedesktop.org
Cc: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 2901c1b..4928584 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -917,6 +917,9 @@ static struct symbol *evaluate_binop(struct expression *expr)
 			rtype = integer_promotion(rtype);
 		} else {
 			// The rest do usual conversions
+			if (op == '&' && expr->left->type == EXPR_PREOP &&
+			    expr->left->op == '!')
+				warning(expr->pos, "dubious: !x & y");
 			ltype = usual_conversions(op, expr->left, expr->right,
 						  lclass, rclass, ltype, rtype);
 			ctype = rtype = ltype;
-- 
1.5.3.GIT
