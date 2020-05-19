From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 10/28] bad-goto: do not linearize function with undeclared labels
Date: Tue, 19 May 2020 02:57:10 +0200
Message-ID: <20200519005728.84594-11-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgESA5p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:45 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22A3C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:44 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id h16so10185557eds.5
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:44 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It's not possible to produce a valid & correct IR if
the function contains a goto to an undeclared label.

So, try to catch these situations and mark the function
as such, the linearization will then simply ignore it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/evaluate.c b/evaluate.c
index d4b462274add..c757fc82b204 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3750,6 +3750,7 @@ static void evaluate_goto_statement(struct statement *stmt)
 
 	if (label->namespace == NS_LABEL && !label->stmt) {
 		sparse_error(stmt->pos, "label '%s' was not declared", show_ident(label->ident));
+		current_fn->bogus_linear = 1;
 	}
 }
 
-- 
2.26.2
