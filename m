From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/17] bad-goto: simplify testing of undeclared labels
Date: Mon, 13 Apr 2020 18:15:54 +0200
Message-ID: <20200413161605.95900-7-luc.vanoostenryck@gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbgDMQQS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0B2C0A3BDC
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x25so9832542wmc.0
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:17 -0700 (PDT)
In-Reply-To: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

There is no need to do a lookup: checking if the label's
symbol is in the NS_LABEL namespace and is lacking an
associated statement is enough and much simpler.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index a432d243610e..dc66b2e6ad9a 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3746,7 +3746,8 @@ static void evaluate_goto_statement(struct statement *stmt)
 		evaluate_expression(stmt->goto_expression);
 		return;
 	}
-	if (!label->stmt && label->ident && !lookup_keyword(label->ident, NS_KEYWORD)) {
+
+	if (label->namespace == NS_LABEL && !label->stmt) {
 		sparse_error(stmt->pos, "label '%s' was not declared", show_ident(label->ident));
 	}
 }
-- 
2.26.0
