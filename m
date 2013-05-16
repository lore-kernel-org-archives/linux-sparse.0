From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH] fix logical operand type
Date: Thu, 16 May 2013 16:56:19 -0400
Message-ID: <1368737779-6601-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f179.google.com ([209.85.161.179]:51784 "EHLO
	mail-gg0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab3EPVEg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 May 2013 17:04:36 -0400
Received: by mail-gg0-f179.google.com with SMTP id c4so168400ggn.10
        for <linux-sparse@vger.kernel.org>; Thu, 16 May 2013 14:04:35 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org, Xi Wang <xi.wang@gmail.com>

The type of logical operands should be bool.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
simplify.c seems to assume so.

	case OP_AND_BOOL:
		if (value == 1)
			return replace_with_pseudo(insn, insn->src1);
---
 evaluate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/evaluate.c b/evaluate.c
index c345a50..8954ff2 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -873,6 +873,8 @@ static struct symbol *evaluate_logical(struct expression *expr)
 		return NULL;
 
 	expr->ctype = &bool_ctype;
+	expr->left = cast_to(expr->left, &bool_ctype);
+	expr->right = cast_to(expr->right, &bool_ctype);
 	if (expr->flags) {
 		if (!(expr->left->flags & expr->right->flags & Int_const_expr))
 			expr->flags = 0;
-- 
1.8.1.2

