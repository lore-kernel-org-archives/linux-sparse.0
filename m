From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/8] add helpers: valid_expr_type() & valid_subexpr_type()
Date: Fri,  2 Feb 2018 13:17:33 +0100
Message-ID: <20180202121735.39621-7-luc.vanoostenryck@gmail.com>
References: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50232 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeBBMTx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Feb 2018 07:19:53 -0500
Received: by mail-wm0-f67.google.com with SMTP id f71so12214019wmf.0
        for <linux-sparse@vger.kernel.org>; Fri, 02 Feb 2018 04:19:52 -0800 (PST)
In-Reply-To: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/evaluate.c b/evaluate.c
index 3c4a25325..14922017b 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -47,6 +47,17 @@ struct symbol *current_fn;
 static struct symbol *degenerate(struct expression *expr);
 static struct symbol *evaluate_symbol(struct symbol *sym);
 
+static inline int valid_expr_type(struct expression *expr)
+{
+	return expr && valid_type(expr->ctype);
+}
+
+static inline int valid_subexpr_type(struct expression *expr)
+{
+	return valid_expr_type(expr->left)
+	    && valid_expr_type(expr->right);
+}
+
 static struct symbol *evaluate_symbol_expression(struct expression *expr)
 {
 	struct expression *addr;
-- 
2.16.0

