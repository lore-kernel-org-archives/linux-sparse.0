From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/17] bad-goto: reorg test in evaluate_goto_statement()
Date: Mon, 13 Apr 2020 18:15:53 +0200
Message-ID: <20200413161605.95900-6-luc.vanoostenryck@gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbgDMQQR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E925DC0A3BDC
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a201so10161970wme.1
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:16 -0700 (PDT)
In-Reply-To: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

No functional changes here, only changing the code structure
to prepare more incoming changes.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index b7bb1f52aa91..a432d243610e 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3741,10 +3741,14 @@ static void evaluate_goto_statement(struct statement *stmt)
 {
 	struct symbol *label = stmt->goto_label;
 
-	if (label && !label->stmt && label->ident && !lookup_keyword(label->ident, NS_KEYWORD))
+	if (!label) {
+		// no label associated, may be a computed goto
+		evaluate_expression(stmt->goto_expression);
+		return;
+	}
+	if (!label->stmt && label->ident && !lookup_keyword(label->ident, NS_KEYWORD)) {
 		sparse_error(stmt->pos, "label '%s' was not declared", show_ident(label->ident));
