From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] add helper: valid_expr_subtype()
Date: Tue, 19 Sep 2017 04:13:33 +0200
Message-ID: <20170919021335.5881-4-luc.vanoostenryck@gmail.com>
References: <20170919021335.5881-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36992 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbdISCNo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 22:13:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id f4so2476961wmh.4
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 19:13:43 -0700 (PDT)
In-Reply-To: <20170919021335.5881-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/evaluate.c b/evaluate.c
index 649e132b8..0394dcbb9 100644
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
+static inline int valid_expr_subtype(struct expression *expr)
+{
+	return valid_expr_type(expr->left)
+	    && valid_expr_type(expr->right);
+}
+
 static struct symbol *evaluate_symbol_expression(struct expression *expr)
 {
 	struct expression *addr;
-- 
2.14.0

