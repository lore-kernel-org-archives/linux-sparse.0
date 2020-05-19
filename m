From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 11/28] bad-goto: catch labels with reserved names
Date: Tue, 19 May 2020 02:57:11 +0200
Message-ID: <20200519005728.84594-12-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgESA5q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6542C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:45 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id s3so10397922eji.6
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:45 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

If a reserved name is used as the destination of a goto,
its associated label won't be valid and at linearization
time no BB will can be created for it, resulting in an
invalid IR.

So, catch such gotos at evaluation time and mark the
function to not be linearized.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                       | 2 ++
 validation/linear/goto-invalid.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index c757fc82b204..21d5d761627f 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3752,6 +3752,8 @@ static void evaluate_goto_statement(struct statement *stmt)
 		sparse_error(stmt->pos, "label '%s' was not declared", show_ident(label->ident));
 		current_fn->bogus_linear = 1;
 	}
+	if (label->namespace == NS_NONE)
+		current_fn->bogus_linear = 1;
 }
 
 struct symbol *evaluate_statement(struct statement *stmt)
diff --git a/validation/linear/goto-invalid.c b/validation/linear/goto-invalid.c
index 569d0b0d2db1..860b32a41ef9 100644
--- a/validation/linear/goto-invalid.c
+++ b/validation/linear/goto-invalid.c
@@ -11,7 +11,6 @@ void bar(void)
 /*
  * check-name: goto-invalid
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-error-ignore
  * check-output-ignore
-- 
2.26.2
