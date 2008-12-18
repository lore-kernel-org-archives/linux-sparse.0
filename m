From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 02/16] Expand "dubious !x & y" handling to other combinations
	of !, &, and |.
Date: Fri, 19 Dec 2008 00:51:30 +0300
Message-ID: <20081218215130.28136.92813.stgit@zaytsev.su>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:19155 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbYLRVml (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 16:42:41 -0500
Received: by ey-out-2122.google.com with SMTP id 22so44093eye.37
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2008 13:42:36 -0800 (PST)
In-Reply-To: <20081218181935.28136.60256.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

From: Josh Triplett <josh@freedesktop.org>

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 evaluate.c                            |   13 ++++++++++---
 validation/dubious-bitwise-with-not.c |   19 +++++++++++++++++--
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index c501323..f976645 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -921,9 +921,16 @@ static struct symbol *evaluate_binop(struct expression *expr)
 			rtype = integer_promotion(rtype);
 		} else {
 			// The rest do usual conversions
-			if (op == '&' && expr->left->type == EXPR_PREOP &&
-			    expr->left->op == '!')
-				warning(expr->pos, "dubious: !x & y");
+			const unsigned left_not  = expr->left->type == EXPR_PREOP
+			                           && expr->left->op == '!';
+			const unsigned right_not = expr->right->type == EXPR_PREOP
+			                           && expr->right->op == '!';
+			if ((op == '&' || op == '|') && (left_not || right_not))
+				warning(expr->pos, "dubious: %sx %c %sy",
+				        left_not ? "!" : "",
+					op,
+					right_not ? "!" : "");
+
 			ltype = usual_conversions(op, expr->left, expr->right,
 						  lclass, rclass, ltype, rtype);
 			ctype = rtype = ltype;
diff --git a/validation/dubious-bitwise-with-not.c b/validation/dubious-bitwise-with-not.c
index e076899..c48bcae 100644
--- a/validation/dubious-bitwise-with-not.c
+++ b/validation/dubious-bitwise-with-not.c
@@ -1,9 +1,24 @@
-static unsigned int ok1 = !1 && 2;
-static unsigned int bad1 = !1 & 2;
+static unsigned int ok1  = !1 &&  2;
+static unsigned int bad1 = !1 &   2;
+static unsigned int ok2  = !1 ||  2;
+static unsigned int bad2 = !1 |   2;
+static unsigned int ok3  =  1 && !2;
+static unsigned int bad3 =  1 &  !2;
+static unsigned int ok4  =  1 || !2;
+static unsigned int bad4 =  1 |  !2;
+static unsigned int ok5  = !1 && !2;
+static unsigned int bad5 = !1 &  !2;
+static unsigned int ok6  = !1 || !2;
+static unsigned int bad6 = !1 |  !2;
 /*
  * check-name: Dubious bitwise operation on !x
  *
  * check-error-start
 dubious-bitwise-with-not.c:2:31: warning: dubious: !x & y
+dubious-bitwise-with-not.c:4:31: warning: dubious: !x | y
+dubious-bitwise-with-not.c:6:31: warning: dubious: x & !y
+dubious-bitwise-with-not.c:8:31: warning: dubious: x | !y
+dubious-bitwise-with-not.c:10:31: warning: dubious: !x & !y
+dubious-bitwise-with-not.c:12:31: warning: dubious: !x | !y
  * check-error-end
  */

