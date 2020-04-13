From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 07/17] bad-goto: do not linearize function with undeclared labels
Date: Mon, 13 Apr 2020 18:15:55 +0200
Message-ID: <20200413161605.95900-8-luc.vanoostenryck@gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731400AbgDMQQT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E37CC0A3BE2
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:19 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s8so10706610wrt.7
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:18 -0700 (PDT)
In-Reply-To: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It's not possible to produce a valid & correct IR if
the function contains a goto to an undeclared label.

So, try to catch these situations and mark the function
as such, the linearization will then simply ignore it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/evaluate.c b/evaluate.c
index dc66b2e6ad9a..14953f195fcc 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3749,6 +3749,7 @@ static void evaluate_goto_statement(struct statement *stmt)
 
 	if (label->namespace == NS_LABEL && !label->stmt) {
 		sparse_error(stmt->pos, "label '%s' was not declared", show_ident(label->ident));
+		current_fn->bogus_linear = 1;
 	}
 }
 
-- 
2.26.0
