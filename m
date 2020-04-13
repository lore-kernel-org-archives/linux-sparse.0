From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/17] bad-goto: catch labels with reserved names
Date: Mon, 13 Apr 2020 18:15:56 +0200
Message-ID: <20200413161605.95900-9-luc.vanoostenryck@gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731402AbgDMQQU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59B9C008748
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h2so9802740wmb.4
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:19 -0700 (PDT)
In-Reply-To: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

If a reserved name is used as the destination of a goto,
its associated label won't be valid and at linearization
time no BB will can be created for it, resulting in an
invalid IR.

So, catch such gotos at evaluation time and mark the
function to not be linearized.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                          | 2 ++
 validation/linear/invalid-labels0.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 14953f195fcc..99a9ee72d11f 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3751,6 +3751,8 @@ static void evaluate_goto_statement(struct statement *stmt)
 		sparse_error(stmt->pos, "label '%s' was not declared", show_ident(label->ident));
 		current_fn->bogus_linear = 1;
 	}
+	if (label->namespace == NS_NONE)
+		current_fn->bogus_linear = 1;
 }
 
 struct symbol *evaluate_statement(struct statement *stmt)
diff --git a/validation/linear/invalid-labels0.c b/validation/linear/invalid-labels0.c
index ae3bf7283fb8..a15e9d434011 100644
--- a/validation/linear/invalid-labels0.c
+++ b/validation/linear/invalid-labels0.c
@@ -11,7 +11,6 @@ void bar(void)
 /*
  * check-name: invalid-labels0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: END
-- 
2.26.0
