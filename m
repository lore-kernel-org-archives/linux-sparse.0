From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 12/21] evaluate: recognize address constants created through pointer arithmetic
Date: Mon, 01 Feb 2016 03:39:58 +0100
Message-ID: <8760y9i269.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34881 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbcBACkB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:40:01 -0500
Received: by mail-wm0-f65.google.com with SMTP id l66so7031299wml.2
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:40:01 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

An address constant +/- an integer constant expression qualifies as an
address constant again.
Furthermore, the array-subscript operator "[]" may be used in the creation
of address constant.

Handle both cases by making evaluate_ptr_add() check whether an integer
constant expression is added to an address constant and tag the result as
being an address constant again if so.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c                           |  8 ++++++++
 validation/constexpr-pointer-arith.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 validation/constexpr-pointer-arith.c

diff --git a/evaluate.c b/evaluate.c
index a740474..16b4ce0 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -565,6 +565,14 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *i
 	classify_type(degenerate(expr->left), &ctype);
 	base = examine_pointer_target(ctype);
 
+	/*
+	 * An address constant +/- an integer constant expression
+	 * yields an address constant again [6.6(7)].
+	 */
+	if ((expr->left->constexpr_flags & CONSTEXPR_FLAG_ADDR_CONST) &&
+		(expr->right->constexpr_flags & CONSTEXPR_FLAG_INT_CONST_EXPR))
+		expr->constexpr_flags = CONSTEXPR_FLAG_ADDR_CONST;
+
 	if (!base) {
 		expression_error(expr, "missing type information");
 		return NULL;
diff --git a/validation/constexpr-pointer-arith.c b/validation/constexpr-pointer-arith.c
new file mode 100644
index 0000000..a922028
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
2.7.0

