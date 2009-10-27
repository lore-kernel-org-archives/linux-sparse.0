From: Daniel De Graaf <danieldegraaf@gmail.com>
Subject: [PATCH] Fix incorrect linearization of "x && y && z"
Date: Tue, 27 Oct 2009 18:02:30 -0500
Message-ID: <4ae782bd.8602be0a.3a31.187a@mx.google.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:56109 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756842AbZJ0XbF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 27 Oct 2009 19:31:05 -0400
Received: by gxk4 with SMTP id 4so288526gxk.8
        for <linux-sparse@vger.kernel.org>; Tue, 27 Oct 2009 16:31:10 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

This fixes an incorrect assumption that results in && using shortcut
logic on the true branch instead of the false branch.

Signed-off-by: Daniel De Graaf <danieldegraaf@gmail.com>

---
 linearize.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/linearize.c b/linearize.c
index 238ee5d..9247409 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1389,7 +1389,10 @@ static pseudo_t linearize_logical(struct entrypoint *ep, struct expression *expr
 
 	shortcut = alloc_const_expression(expr->pos, expr->op == SPECIAL_LOGICAL_OR);
 	shortcut->ctype = expr->ctype;
-	return  linearize_conditional(ep, expr, expr->left, shortcut, expr->right);
+	if (expr->op == SPECIAL_LOGICAL_OR)
+		return linearize_conditional(ep, expr, expr->left, shortcut, expr->right);
+	else
+		return linearize_conditional(ep, expr, expr->left, expr->right, shortcut);
 }
 
 static pseudo_t linearize_compare(struct entrypoint *ep, struct expression *expr)
-- 
1.6.5


