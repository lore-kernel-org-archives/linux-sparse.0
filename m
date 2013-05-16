From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH] fix casting to bool
Date: Thu, 16 May 2013 16:56:06 -0400
Message-ID: <1368737766-6517-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ye0-f180.google.com ([209.85.213.180]:44305 "EHLO
	mail-ye0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab3EPVFA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 May 2013 17:05:00 -0400
Received: by mail-ye0-f180.google.com with SMTP id r11so708655yen.39
        for <linux-sparse@vger.kernel.org>; Thu, 16 May 2013 14:05:00 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org, Xi Wang <xi.wang@gmail.com>

Consider the following function.

	static _Bool foo(int x) { return x; }

Currently sparse emits:

	scast.1     %r2 <- (32) %arg1
	ret.1       %r2

This is incorrect since bool requires a zero test.

	setne.32    %r2 <- %arg1, $0
	ret.1       %r2

This patch adds zero testing for bool in cast_to().

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 evaluate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/evaluate.c b/evaluate.c
index d9c767f..a090028 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -272,6 +272,18 @@ static struct expression * cast_to(struct expression *old, struct symbol *type)
 	if (old->ctype != &null_ctype && is_same_type(old, type))
 		return old;
 
+	/* bool requires a zero test */
+	if (is_bool_type(type)) {
+		expr = alloc_expression(old->pos, EXPR_COMPARE);
+		expr->op = SPECIAL_NOTEQUAL;
+		expr->ctype = type;
+		expr->left = old;
+		expr->right = alloc_expression(old->pos, EXPR_VALUE);
+		expr->right->ctype = old->ctype;
+		expr->right->value = 0;
+		return expr;
+	}
+
 	/*
 	 * See if we can simplify the op. Move the cast down.
 	 */
-- 
1.8.1.2

