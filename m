From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 14/25] constexpr: recognize address constants created through pointer arithmetic
Date: Fri, 31 Mar 2017 03:44:48 +0200
Message-ID: <20170331014459.9351-15-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36047 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934889AbdCaBqn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:43 -0400
Received: by mail-wr0-f196.google.com with SMTP id k6so15310014wre.3
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:42 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

An address constant +/- an integer constant expression qualifies as an
address constant again.
Furthermore, the array-subscript operator "[]" may be used in the creation
of address constant.

Handle both cases by making evaluate_ptr_add() check whether an integer
constant expression is added to an address constant and tag the result as
being an address constant again if so.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                           |  7 +++++++
 validation/constexpr-pointer-arith.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 validation/constexpr-pointer-arith.c

diff --git a/evaluate.c b/evaluate.c
index ce2e52e15..e58d9c373 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -571,6 +571,13 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *i
 	classify_type(degenerate(expr->left), &ctype);
 	base = examine_pointer_target(ctype);
 
+	/*
+	 * An address constant +/- an integer constant expression
+	 * yields an address constant again [6.6(7)].
+	 */
+	if ((expr->left->flags & CEF_ADDR) && (expr->right->flags & CEF_ICE))
+		expr->flags = CEF_ADDR;
+
 	if (!base) {
 		expression_error(expr, "missing type information");
 		return NULL;
diff --git a/validation/constexpr-pointer-arith.c b/validation/constexpr-pointer-arith.c
new file mode 100644
index 000000000..a92202800
--- /dev/null
+++ b/validation/constexpr-pointer-arith.c
@@ -0,0 +1,28 @@
+static int a = 1;
+static int b[2] = {1, 1};
+
+static int *c = &b[1];					// OK
+static int *d = (int*)0 + 1;				// OK
+static int *e = &b[1] + 1;				// OK
+static int *f = b + 1;					// OK
+static int *g = d + 1;					// KO
+static int *h = &a + 1;				// OK
+static int *i = &b[1] + 1;				// OK
+static int *j = b + 1;					// OK
+static int *k = d + 1;					// KO
+static int *l = &*&b[1];				// OK
+static int *m = &*(&a + 1);				// OK
+static int *n = &*(&b[1] + 1);				// OK
+static int *o = &*(b + 1);				// OK
+static int *p = &*(d + 1);				// KO
+
+/*
+ * check-name: pointer arithmetic constness verification.
+ * check-command: sparse -Wconstexpr-not-const $file
+ *
+ * check-error-start
+constexpr-pointer-arith.c:8:19: warning: non-constant initializer for static object
+constexpr-pointer-arith.c:12:19: warning: non-constant initializer for static object
+constexpr-pointer-arith.c:17:22: warning: non-constant initializer for static object
+ * check-error-end
+ */
-- 
2.12.0

