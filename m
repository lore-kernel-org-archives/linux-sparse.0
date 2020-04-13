From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 16/17] bad-goto: catch gotos inside expression statements
Date: Mon, 13 Apr 2020 18:16:04 +0200
Message-ID: <20200413161605.95900-17-luc.vanoostenryck@gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731408AbgDMQQ3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DB9C008749
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:27 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h9so10719090wrc.8
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:27 -0700 (PDT)
In-Reply-To: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It's not allowed to do a goto into an expression statement.
For exemple, it's not well defined what should happen if such
an expression is not evaluated because unnneded and optimized
away at expand time.

For such situations GCC issues an error, clang doesn't and
produces a valid IR. Spare produces an invalid IR with branches
to unexisting BBs.

Fix this by:
*) detecting this situation at evaluation time
*) issue an error
*) mark the function to not be linearized.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                              | 9 +++++++++
 validation/label-stmt-expr1.c           | 1 -
 validation/linear/goto-and-expr-stmt0.c | 9 +++++++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 99a9ee72d11f..2b845a301d6b 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -42,6 +42,7 @@
 #include "symbol.h"
 #include "target.h"
 #include "expression.h"
+#include "scope.h"
 
 struct symbol *current_fn;
 
@@ -3751,6 +3752,14 @@ static void evaluate_goto_statement(struct statement *stmt)
 		sparse_error(stmt->pos, "label '%s' was not declared", show_ident(label->ident));
 		current_fn->bogus_linear = 1;
 	}
+	if (label->namespace == NS_LABEL && label->stmt) {
+		if (is_in_scope(label->label_scope, stmt->goto_scope))
+			return;
+		sparse_error(stmt->pos, "goto into statement expression");
+		info(label->stmt->pos,"   label '%s' is defined here",
+					show_ident(label->ident));
+		current_fn->bogus_linear = 1;
+	}
 	if (label->namespace == NS_NONE)
 		current_fn->bogus_linear = 1;
 }
diff --git a/validation/label-stmt-expr1.c b/validation/label-stmt-expr1.c
index 47ba54ae7305..f4f178c9d951 100644
--- a/validation/label-stmt-expr1.c
+++ b/validation/label-stmt-expr1.c
@@ -19,7 +19,6 @@ l:
 
 /*
  * check-name: label-stmt-expr1
- * check-known-to-fail
  *
  * check-error-start
 label-stmt-expr1.c:3:9: error: goto into statement expression
diff --git a/validation/linear/goto-and-expr-stmt0.c b/validation/linear/goto-and-expr-stmt0.c
index 548813531779..c6b6621a6a81 100644
--- a/validation/linear/goto-and-expr-stmt0.c
+++ b/validation/linear/goto-and-expr-stmt0.c
@@ -20,9 +20,14 @@ a:
 /*
  * check-name: goto-and-expr-stmt0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: END
- * check-error-ignore
+ *
+ * check-error-start
+linear/goto-and-expr-stmt0.c:3:9: error: goto into statement expression
+linear/goto-and-expr-stmt0.c:5:1:    label 'inside' is defined here
+linear/goto-and-expr-stmt0.c:17:9: error: goto into statement expression
+linear/goto-and-expr-stmt0.c:14:1:    label 'a' is defined here
+ * check-error-end
  */
-- 
2.26.0
