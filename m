From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 24/28] bad-goto: extract check_label_declaration()
Date: Tue, 19 May 2020 02:57:24 +0200
Message-ID: <20200519005728.84594-25-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgESA56 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:58 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE20C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:57 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id se13so10371086ejb.9
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:57 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Extract this helper from evaluate_goto_statement().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 21d5d761627f..b272e3f642b2 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3257,6 +3257,21 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
 	return size_t_ctype;
 }
 
+static void check_label_declaration(struct position pos, struct symbol *label)
+{
+	switch (label->namespace) {
+	case NS_LABEL:
+		if (label->stmt)
+			break;
+		sparse_error(pos, "label '%s' was not declared", show_ident(label->ident));
+		/* fallthrough */
+	case NS_NONE:
+		current_fn->bogus_linear = 1;
+	default:
+		break;
+	}
+}
+
 struct symbol *evaluate_expression(struct expression *expr)
 {
 	if (!expr)
@@ -3748,12 +3763,7 @@ static void evaluate_goto_statement(struct statement *stmt)
 		return;
 	}
 
-	if (label->namespace == NS_LABEL && !label->stmt) {
-		sparse_error(stmt->pos, "label '%s' was not declared", show_ident(label->ident));
-		current_fn->bogus_linear = 1;
-	}
-	if (label->namespace == NS_NONE)
-		current_fn->bogus_linear = 1;
+	check_label_declaration(stmt->pos, label);
 }
 
 struct symbol *evaluate_statement(struct statement *stmt)
-- 
2.26.2
