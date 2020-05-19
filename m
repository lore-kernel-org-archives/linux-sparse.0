From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 09/28] bad-goto: simplify testing of undeclared labels
Date: Tue, 19 May 2020 02:57:09 +0200
Message-ID: <20200519005728.84594-10-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgESA5n (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:43 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B21C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:43 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id h16so10185526eds.5
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:43 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

There is no need to do a lookup: checking if the label's
symbol is in the NS_LABEL namespace and is lacking an
associated statement is enough and much simpler.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 4bdd5ed05842..d4b462274add 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3747,7 +3747,8 @@ static void evaluate_goto_statement(struct statement *stmt)
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
2.26.2
