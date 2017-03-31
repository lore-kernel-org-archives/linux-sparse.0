From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 10/25] constexpr: collect storage modifiers of initializers
Date: Fri, 31 Mar 2017 03:44:44 +0200
Message-ID: <20170331014459.9351-11-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36013 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934847AbdCaBqj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:39 -0400
Received: by mail-wr0-f195.google.com with SMTP id k6so15309803wre.3
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:38 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is a preparatory step for checking the constness
of initializers of static storage duration objects;

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 07edda41b..138ee1dd6 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2451,13 +2451,13 @@ static struct expression *next_designators(struct expression *old,
 }
 
 static int handle_initializer(struct expression **ep, int nested,
-				     int class, struct symbol *ctype);
+		int class, struct symbol *ctype, unsigned long mods);
 
 /*
  * deal with traversing subobjects [6.7.8(17,18,20)]
  */
 static void handle_list_initializer(struct expression *expr,
-				    int class, struct symbol *ctype)
+		int class, struct symbol *ctype, unsigned long mods)
 {
 	struct expression *e, *last = NULL, *top = NULL, *next;
 	int jumped = 0;
@@ -2515,7 +2515,8 @@ found:
 		else
 			v = &top->ident_expression;
 
-		if (handle_initializer(v, 1, lclass, top->ctype))
+		mods |= ctype->ctype.modifiers & MOD_STORAGE;
+		if (handle_initializer(v, 1, lclass, top->ctype, mods))
 			continue;
 
 		if (!(lclass & TYPE_COMPOUND)) {
@@ -2608,7 +2609,7 @@ static struct expression *handle_scalar(struct expression *e, int nested)
  * until we dig into the inner struct.
  */
 static int handle_initializer(struct expression **ep, int nested,
-				     int class, struct symbol *ctype)
+		int class, struct symbol *ctype, unsigned long mods)
 {
 	int is_string = is_string_type(ctype);
 	struct expression *e = *ep, *p;
@@ -2648,7 +2649,7 @@ static int handle_initializer(struct expression **ep, int nested,
 				goto String;
 			}
 		}
-		handle_list_initializer(e, class, ctype);
+		handle_list_initializer(e, class, ctype, mods);
 		return 1;
 	}
 
@@ -2696,7 +2697,7 @@ static void evaluate_initializer(struct symbol *ctype, struct expression **ep)
 {
 	struct symbol *type;
 	int class = classify_type(ctype, &type);
-	if (!handle_initializer(ep, 0, class, ctype))
+	if (!handle_initializer(ep, 0, class, ctype, 0))
 		expression_error(*ep, "invalid initializer");
 }
 
-- 
2.12.0

