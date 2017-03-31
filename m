From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 09/25] constexpr: rename handle_simple_initializer() to handle_initializer()
Date: Fri, 31 Mar 2017 03:44:43 +0200
Message-ID: <20170331014459.9351-10-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35160 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934997AbdCaBqi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:38 -0400
Received: by mail-wr0-f194.google.com with SMTP id p52so16621355wrc.2
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:37 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This function, with a quite long name, not only handle
simple initializer but also complex ones.

So, rename it to the shorter and more correct form.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 68a2d5ebf..07edda41b 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2450,7 +2450,7 @@ static struct expression *next_designators(struct expression *old,
 	return new;
 }
 
-static int handle_simple_initializer(struct expression **ep, int nested,
+static int handle_initializer(struct expression **ep, int nested,
 				     int class, struct symbol *ctype);
 
 /*
@@ -2515,7 +2515,7 @@ found:
 		else
 			v = &top->ident_expression;
 
-		if (handle_simple_initializer(v, 1, lclass, top->ctype))
+		if (handle_initializer(v, 1, lclass, top->ctype))
 			continue;
 
 		if (!(lclass & TYPE_COMPOUND)) {
@@ -2607,7 +2607,7 @@ static struct expression *handle_scalar(struct expression *e, int nested)
  * { "string", ...} - we need to preserve that string literal recognizable
  * until we dig into the inner struct.
  */
-static int handle_simple_initializer(struct expression **ep, int nested,
+static int handle_initializer(struct expression **ep, int nested,
 				     int class, struct symbol *ctype)
 {
 	int is_string = is_string_type(ctype);
@@ -2696,7 +2696,7 @@ static void evaluate_initializer(struct symbol *ctype, struct expression **ep)
 {
 	struct symbol *type;
 	int class = classify_type(ctype, &type);
-	if (!handle_simple_initializer(ep, 0, class, ctype))
+	if (!handle_initializer(ep, 0, class, ctype))
 		expression_error(*ep, "invalid initializer");
 }
 
-- 
2.12.0

