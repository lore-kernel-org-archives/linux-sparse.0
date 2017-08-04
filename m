From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix: give a type to bad conditionnal expressions
Date: Fri,  4 Aug 2017 02:16:39 +0200
Message-ID: <20170804001639.4823-1-luc.vanoostenryck@gmail.com>
References: <20170804001122.4ivc2sktypvg2w3i@ltop.local>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36026 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbdHDASs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 3 Aug 2017 20:18:48 -0400
Received: by mail-wr0-f195.google.com with SMTP id y67so1983811wrb.3
        for <linux-sparse@vger.kernel.org>; Thu, 03 Aug 2017 17:18:48 -0700 (PDT)
In-Reply-To: <20170804001122.4ivc2sktypvg2w3i@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Bad conditional expressions used to have no type (NULL)
this in turn makes that some further processing are
not done. In particular, here, the expansion of the
operands are not done.

Fix this by giving to such expression a type 'bad_type'.

Note: nor gcc, not clang seems to emit a warning for the
      the testcase here which is not conform to the standard.
      OTOH, sparse complains and this was the cause of the
      non-expansion of the builtin.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                   |  1 +
 validation/cond-err-expand.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 validation/cond-err-expand.c

diff --git a/evaluate.c b/evaluate.c
index cf3cf244d..5b4abdb6a 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1220,6 +1220,7 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 
 Err:
 	expression_error(expr, "incompatible types in conditional expression (%s)", typediff);
+	expr->ctype = &bad_ctype;
 	return NULL;
 
 out:
diff --git a/validation/cond-err-expand.c b/validation/cond-err-expand.c
new file mode 100644
index 000000000..72af8d4b1
--- /dev/null
+++ b/validation/cond-err-expand.c
@@ -0,0 +1,27 @@
+static inline void f(void)
+{
+	__builtin_constant_p(0);
+}
+
+int foo(int a)
+{
+	return 0 ? 0 : f();
+}
+
+int bar(int a)
+{
+	return 1 ? f() : 0;
+}
+
+/*
+ * check-name: cond-err-expand.c
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-error-start
+cond-err-expand.c:8:18: error: incompatible types in conditional expression (different base types)
+cond-err-expand.c:13:18: error: incompatible types in conditional expression (different base types)
+ * check-error-end
+ *
+ * check-output-ignore
+ * check-excludes: call.* __builtin_constant_p
+ */
-- 
2.13.2

