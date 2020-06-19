From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] gensel: use temporary variable in generic selection
Date: Fri, 19 Jun 2020 17:02:57 +0200
Message-ID: <20200619150300.63695-3-luc.vanoostenryck@gmail.com>
References: <20200619150300.63695-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391070AbgFSPEH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 19 Jun 2020 11:04:07 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89F0C06174E
        for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2020 08:04:06 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id s28so7825448edw.11
        for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2020 08:04:06 -0700 (PDT)
In-Reply-To: <20200619150300.63695-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Use a temporary variable for 'map->type' to make the expressions
in the following patches more readable.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 95aef4dc0758..cf40eed418b4 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3293,9 +3293,11 @@ static struct symbol *evaluate_generic_selection(struct expression *expr)
 		return NULL;
 
 	for (map = expr->map; map; map = map->next) {
-		if (!evaluate_symbol(map->type))
+		struct symbol *stype = map->type;
+
+		if (!evaluate_symbol(stype))
 			continue;
-		if (!type_selection(ctrl, map->type))
+		if (!type_selection(ctrl, stype))
 			continue;
 
 		res = map->expr;
-- 
2.27.0
