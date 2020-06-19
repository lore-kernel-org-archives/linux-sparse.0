From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] gensel: validate the type of the associations
Date: Fri, 19 Jun 2020 17:03:00 +0200
Message-ID: <20200619150300.63695-6-luc.vanoostenryck@gmail.com>
References: <20200619150300.63695-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391108AbgFSPEK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 19 Jun 2020 11:04:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E483C0613F0
        for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2020 08:04:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p20so10485720ejd.13
        for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2020 08:04:10 -0700 (PDT)
In-Reply-To: <20200619150300.63695-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The type in a generic association must correspond to a complete
type and not a variably modified type.

Add validation for this.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/evaluate.c b/evaluate.c
index 491dfa3c6b89..aa0f208006bb 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3299,9 +3299,29 @@ static struct symbol *evaluate_generic_selection(struct expression *expr)
 	source.ctype.modifiers &= ~(MOD_QUALIFIER|MOD_ATOMIC);
 	for (map = expr->map; map; map = map->next) {
 		struct symbol *stype = map->type;
+		struct symbol *base;
 
 		if (!evaluate_symbol(stype))
 			continue;
+
+		if (stype->type == SYM_NODE)
+			base = stype->ctype.base_type;
+
+		if (base->type == SYM_ARRAY && base->array_size) {
+			get_expression_value_silent(base->array_size);
+			if (base->array_size->type == EXPR_VALUE)
+				continue;
+			sparse_error(stype->pos, "variable length array type in generic selection");
+			continue;
+		}
+		if (is_func_type(stype)) {
+			sparse_error(stype->pos, "function type in generic selection");
+			continue;
+		}
+		if (stype->bit_size <= 0 || is_void_type(stype)) {
+			sparse_error(stype->pos, "incomplete type in generic selection");
+			continue;
+		}
 		if (!type_selection(&source, stype))
 			continue;
 
-- 
2.27.0
