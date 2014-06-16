From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] sparse: fix bogus shift too big warning when rhs is a
 variable
Date: Mon, 16 Jun 2014 19:10:06 +0200
Message-ID: <20140616171006.GA20387@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from asavdk3.altibox.net ([109.247.116.14]:37563 "EHLO
	asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbaFPRKX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 16 Jun 2014 13:10:23 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse <linux-sparse@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, josh@joshtriplett.org

From 3e742071e931669108f55b4aae2fb074d1c029cc Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 16 Jun 2014 19:02:05 +0200
Subject: [PATCH] sparse: fix bogus shift too big warning when rhs is a
 variable

sparse warned about "shift too big" if the rhs was a variable.
As sparse usually cannot deduct the value of a variable
silence these warnings.

Before this patch following code snippet would generate a warning:

static int doshift(int foo)
{
	return 1 << foo;
}

sparse did not know the value of 'foo' so reported a warning.
Ignore the warning expect in the cases where the rhs of the shift
is a constant.

Include a few simple tests for left-shift and right-shift.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 expand.c                 |  2 +-
 validation/left-shift.c  | 31 +++++++++++++++++++++++++++++++
 validation/right-shift.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 validation/left-shift.c
 create mode 100644 validation/right-shift.c

diff --git a/expand.c b/expand.c
index 0f6720c..ce955d3 100644
--- a/expand.c
+++ b/expand.c
@@ -187,7 +187,7 @@ static int simplify_int_binop(struct expression *expr, struct symbol *ctype)
 		return 0;
 	r = right->value;
 	if (expr->op == SPECIAL_LEFTSHIFT || expr->op == SPECIAL_RIGHTSHIFT) {
-		if (r >= ctype->bit_size) {
+		if (right->flags & Int_const_expr && r >= ctype->bit_size) {
 			if (conservative)
 				return 0;
 			r = check_shift_count(expr, ctype, r);
diff --git a/validation/left-shift.c b/validation/left-shift.c
new file mode 100644
index 0000000..e8d929b
--- /dev/null
+++ b/validation/left-shift.c
@@ -0,0 +1,31 @@
+static unsigned int leftshift1(unsigned int value, unsigned int shift)
+{
+        return 1 << 1000;
+}
+
+static unsigned int leftshift2(unsigned int value, unsigned int shift)
+{
+        return value << 1000;
+}
+
+static unsigned int leftshift3(unsigned int value, unsigned int shift)
+{
+
+        return 1 << value;
+}
+
+static unsigned int leftshift4(unsigned int value, unsigned int shift)
+{
+
+        return value << shift;
+}
+
+/*
+ * check-name: Left shift - shift too big
+ *
+ * check-error-start
+left-shift.c:3:18: warning: shift too big (1000) for type int
+left-shift.c:8:22: warning: shift too big (1000) for type unsigned int
+ * check-error-end
+ */
+
diff --git a/validation/right-shift.c b/validation/right-shift.c
new file mode 100644
index 0000000..9be6006
--- /dev/null
+++ b/validation/right-shift.c
@@ -0,0 +1,31 @@
+static unsigned int rightshift1(unsigned int value, unsigned int shift)
+{
+        return 1 >> 1000;
+}
+
+static unsigned int rightshift2(unsigned int value, unsigned int shift)
+{
+        return value >> 1000;
+}
+
+static unsigned int rightshift3(unsigned int value, unsigned int shift)
+{
+
+        return 1 >> value;
+}
+
+static unsigned int rightshift4(unsigned int value, unsigned int shift)
+{
+
+        return value >> shift;
+}
+
+/*
+ * check-name: Right shift - shift too big
+ *
+ * check-error-start
+right-shift.c:3:18: warning: shift too big (1000) for type int
+right-shift.c:8:22: warning: shift too big (1000) for type unsigned int
+ * check-error-end
+ */
+
-- 
1.9.3

