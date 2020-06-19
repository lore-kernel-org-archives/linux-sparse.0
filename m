From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] gensel: controlling expression must be pointer-converted
Date: Fri, 19 Jun 2020 17:02:59 +0200
Message-ID: <20200619150300.63695-5-luc.vanoostenryck@gmail.com>
References: <20200619150300.63695-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391106AbgFSPEK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 19 Jun 2020 11:04:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298F2C0613EF
        for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2020 08:04:09 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gl26so10525852ejb.11
        for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2020 08:04:09 -0700 (PDT)
In-Reply-To: <20200619150300.63695-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marco Elver <elver@google.com>

Following the resolution of DR481, the controlling expression
of a generic selection must be array-to-pointer converted and
function-to-pointer converted.

Do this by adding a call to degenerate().

Reported-by: Marco Elver <elver@google.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index d8615a894c0d..491dfa3c6b89 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3290,7 +3290,9 @@ static struct symbol *evaluate_generic_selection(struct expression *expr)
 	struct symbol source;
 	struct symbol *ctrl;
 
-	if (!(ctrl = evaluate_expression(expr->control)))
+	if (!evaluate_expression(expr->control))
+		return NULL;
+	if (!(ctrl = degenerate(expr->control)))
 		return NULL;
 
 	source = *ctrl;
-- 
2.27.0
