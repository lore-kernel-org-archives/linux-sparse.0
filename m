From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 08/28] bad-goto: reorg test in evaluate_goto_statement()
Date: Tue, 19 May 2020 02:57:08 +0200
Message-ID: <20200519005728.84594-9-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgESA5m (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61183C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:42 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id i16so5747232edv.1
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:42 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

No functional changes here, only changing the code structure
to prepare more incoming changes.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index c18ae81df5ad..4bdd5ed05842 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3742,10 +3742,14 @@ static void evaluate_goto_statement(struct statement *stmt)
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
