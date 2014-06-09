From: Phil Carmody <phil@dovecot.fi>
Subject: [PATCH 1/3] sparse: Just use simple ints for decision variables
Date: Mon,  9 Jun 2014 14:58:00 +0300
Message-ID: <1402315082-14102-2-git-send-email-phil@dovecot.fi>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wursti.dovecot.fi ([87.106.245.223]:41354 "EHLO
	wursti.dovecot.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbaFIMFj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Jun 2014 08:05:39 -0400
In-Reply-To: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org, phil@dovecot.fi

The expressions are just ints, and const is pointess.

Signed-off-by: Phil Carmody <phil@dovecot.fi>
---
 evaluate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 6655615..9052962 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -917,10 +917,10 @@ static struct symbol *evaluate_binop(struct expression *expr)
 			rtype = integer_promotion(rtype);
 		} else {
 			// The rest do usual conversions
-			const unsigned left_not  = expr->left->type == EXPR_PREOP
-			                           && expr->left->op == '!';
-			const unsigned right_not = expr->right->type == EXPR_PREOP
-			                           && expr->right->op == '!';
+			int left_not  = expr->left->type == EXPR_PREOP
+					&& expr->left->op == '!';
+			int right_not = expr->right->type == EXPR_PREOP
+			                && expr->right->op == '!';
 			if ((op == '&' || op == '|') && (left_not || right_not))
 				warning(expr->pos, "dubious: %sx %c %sy",
 				        left_not ? "!" : "",
-- 
2.0.0

