From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] gensel: controlling expression must be lvalue converted
Date: Fri, 19 Jun 2020 17:02:58 +0200
Message-ID: <20200619150300.63695-4-luc.vanoostenryck@gmail.com>
References: <20200619150300.63695-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391104AbgFSPEJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 19 Jun 2020 11:04:09 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08FFC0613EE
        for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2020 08:04:07 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w16so10536550ejj.5
        for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2020 08:04:07 -0700 (PDT)
In-Reply-To: <20200619150300.63695-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marco Elver <elver@google.com>

Following the resolution of DR481, the controlling expression
of a generic selection must be lvalue converted. In other words,
the qualifiers must be ignored.

Reported-by: Marco Elver <elver@google.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index cf40eed418b4..d8615a894c0d 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3287,17 +3287,20 @@ static struct symbol *evaluate_generic_selection(struct expression *expr)
 {
 	struct type_expression *map;
 	struct expression *res;
+	struct symbol source;
 	struct symbol *ctrl;
 
 	if (!(ctrl = evaluate_expression(expr->control)))
 		return NULL;
 
+	source = *ctrl;
+	source.ctype.modifiers &= ~(MOD_QUALIFIER|MOD_ATOMIC);
 	for (map = expr->map; map; map = map->next) {
 		struct symbol *stype = map->type;
 
 		if (!evaluate_symbol(stype))
 			continue;
-		if (!type_selection(ctrl, stype))
+		if (!type_selection(&source, stype))
 			continue;
 
 		res = map->expr;
-- 
2.27.0
