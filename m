From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH] fix pointer casts in evaluate_compare()
Date: Thu, 16 May 2013 16:55:33 -0400
Message-ID: <1368737733-6475-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gh0-f181.google.com ([209.85.160.181]:54230 "EHLO
	mail-gh0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab3EPU5T (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 May 2013 16:57:19 -0400
Received: by mail-gh0-f181.google.com with SMTP id z12so725662ghb.26
        for <linux-sparse@vger.kernel.org>; Thu, 16 May 2013 13:57:18 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org, Xi Wang <xi.wang@gmail.com>

The results of cast_to() seem unused.  Assign them to expr->left and
expr->right.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 evaluate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 0dfa519..d9c767f 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1024,11 +1024,11 @@ static struct symbol *evaluate_compare(struct expression *expr)
 			goto OK;
 		}
 		if (is_null1 && (rclass & TYPE_PTR)) {
-			left = cast_to(left, rtype);
+			expr->left = cast_to(left, rtype);
 			goto OK;
 		}
 		if (is_null2 && (lclass & TYPE_PTR)) {
-			right = cast_to(right, ltype);
+			expr->right = cast_to(right, ltype);
 			goto OK;
 		}
 	}
@@ -1044,11 +1044,11 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	if (expr->op == SPECIAL_EQUAL || expr->op == SPECIAL_NOTEQUAL) {
 		if (ltype->ctype.as == rtype->ctype.as) {
 			if (lbase == &void_ctype) {
-				right = cast_to(right, ltype);
+				expr->right = cast_to(right, ltype);
 				goto OK;
 			}
 			if (rbase == &void_ctype) {
-				left = cast_to(left, rtype);
+				expr->left = cast_to(left, rtype);
 				goto OK;
 			}
 		}
-- 
1.8.1.2

