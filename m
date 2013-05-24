From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH 2/2] fix expression type for floating point !
Date: Fri, 24 May 2013 09:30:36 -0400
Message-ID: <1369402236-16871-2-git-send-email-xi.wang@gmail.com>
References: <1369402236-16871-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:64457 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab3EXNcT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 24 May 2013 09:32:19 -0400
Received: by mail-vc0-f180.google.com with SMTP id gd11so3137794vcb.11
        for <linux-sparse@vger.kernel.org>; Fri, 24 May 2013 06:32:18 -0700 (PDT)
In-Reply-To: <1369402236-16871-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Xi Wang <xi.wang@gmail.com>

Run test-linearize against this program.

	static int foo(float x) { return !x; }

The output is:

	set.32      %r2 <- 0.000000
	bad_op.32
	ret.32      %r3

The expression type of zero testing should be EXPR_COMPARE, rather than
EXPR_BINOP, which causes bad_op.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 evaluate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 5d87444..19be637 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1797,7 +1797,7 @@ static struct symbol *evaluate_preop(struct expression *expr)
 			warning(expr->pos, "testing a 'safe expression'");
 		if (is_float_type(ctype)) {
 			struct expression *arg = expr->unop;
-			expr->type = EXPR_BINOP;
+			expr->type = EXPR_COMPARE;
 			expr->op = SPECIAL_EQUAL;
 			expr->left = arg;
 			expr->right = alloc_expression(expr->pos, EXPR_FVALUE);
-- 
1.8.1.2

