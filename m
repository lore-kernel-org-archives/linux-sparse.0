From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 2/2] fix: give a type to bad cond expr with known condition
Date: Fri,  4 Aug 2017 18:06:22 +0200
Message-ID: <20170804160622.18260-3-luc.vanoostenryck@gmail.com>
References: <20170804160622.18260-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36198 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbdHDQGe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 12:06:34 -0400
Received: by mail-wr0-f194.google.com with SMTP id y67so3286676wrb.3
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 09:06:34 -0700 (PDT)
In-Reply-To: <20170804160622.18260-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Conditional expressions whose second & third operands
have non-compatible types are not conform to the C standard
and sparse emit a warning for them and return the expression
as being erroneous. In consequence, such expressions are not
given a type. This, in turn, makes that some further processing
cannot be done (correctly).

It seems that neither GCC nor clang emit a warning when
there is a type mismatch but the condition is a constant.

In the case we're interested here (the slow compilation of a file)
the operation that cannot be done is the expansion its operands.
This, in turn and among other things, makes that builtins like
__builtin_constant_p() are not evaluated with disatrous consequence
for the amount of work done in the next phases.

Fix this by giving to conditional expressions with constant
condition the same type as the operand selected by the conditional
(but keeping the warning) as GCC & clang seems to do.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                   | 12 ++++++++++++
 validation/cond-err-expand.c | 27 +++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 validation/cond-err-expand.c

diff --git a/evaluate.c b/evaluate.c
index cf3cf244d..649e132b8 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1220,6 +1220,18 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 
 Err:
 	expression_error(expr, "incompatible types in conditional expression (%s)", typediff);
+	/*
+	 * if the condition is constant, the type is in fact known
+	 * so use it, as gcc & clang do.
+	 */
+	switch (expr_truth_value(expr->conditional)) {
+	case 1:	expr->ctype = ltype;
+		break;
+	case 0: expr->ctype = rtype;
+		break;
+	default:
+		break;
+	}
 	return NULL;
 
 out:
diff --git a/validation/cond-err-expand.c b/validation/cond-err-expand.c
new file mode 100644
index 000000000..93bbac153
--- /dev/null
+++ b/validation/cond-err-expand.c
@@ -0,0 +1,27 @@
+static inline void f(void)
+{
+	__builtin_constant_p(0);
+}
+
+void foo(void)
+{
+	0 ? 0 : f();
+}
+
+void bar(void)
+{
+	1 ? f() : 0;
+}
+
+/*
+ * check-name: cond-err-expand.c
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-error-start
+cond-err-expand.c:8:11: error: incompatible types in conditional expression (different base types)
+cond-err-expand.c:13:11: error: incompatible types in conditional expression (different base types)
+ * check-error-end
+ *
+ * check-output-ignore
+ * check-excludes: call.* __builtin_constant_p
+ */
-- 
2.13.2

