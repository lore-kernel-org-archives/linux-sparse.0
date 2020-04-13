From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 17/17] bad-goto: cleanup evaluate_goto()
Date: Mon, 13 Apr 2020 18:16:05 +0200
Message-ID: <20200413161605.95900-18-luc.vanoostenryck@gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731409AbgDMQQ3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED341C0A3BDC
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:28 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d27so1511487wra.1
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:28 -0700 (PDT)
In-Reply-To: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reorganize the code to not repeat the test of the
label's namespace.

Also, make all namespaces other than NS_LABEL & NS_ITERATOR
as bogus and add some comments.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 2b845a301d6b..663540ff6445 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3748,20 +3748,22 @@ static void evaluate_goto_statement(struct statement *stmt)
 		return;
 	}
 
-	if (label->namespace == NS_LABEL && !label->stmt) {
-		sparse_error(stmt->pos, "label '%s' was not declared", show_ident(label->ident));
-		current_fn->bogus_linear = 1;
-	}
-	if (label->namespace == NS_LABEL && label->stmt) {
-		if (is_in_scope(label->label_scope, stmt->goto_scope))
-			return;
-		sparse_error(stmt->pos, "goto into statement expression");
-		info(label->stmt->pos,"   label '%s' is defined here",
-					show_ident(label->ident));
+	switch (label->namespace) {
+	case NS_ITERATOR:	// break / continue
+		break;
+	case NS_LABEL:		// goto + ident
+		if (!label->stmt) {
+			sparse_error(stmt->pos, "label '%s' was not declared",
+						show_ident(label->ident));
+		} else if (!is_in_scope(label->label_scope, stmt->goto_scope)) {
+			sparse_error(stmt->pos, "goto into statement expression");
+			info(label->stmt->pos,"   label '%s' is defined here",
+						show_ident(label->ident));
+		} else
+			break;
+	default:
 		current_fn->bogus_linear = 1;
 	}
-	if (label->namespace == NS_NONE)
-		current_fn->bogus_linear = 1;
 }
 
 struct symbol *evaluate_statement(struct statement *stmt)
-- 
2.26.0
