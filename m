From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/7] warn if testing the address of an array
Date: Wed, 22 Mar 2017 18:32:55 +0100
Message-ID: <20170322173257.63019-6-luc.vanoostenryck@gmail.com>
References: <20170322173257.63019-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34610 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759680AbdCVRdP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 13:33:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id u132so11598551wmg.1
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 10:33:13 -0700 (PDT)
In-Reply-To: <20170322173257.63019-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>

Testing the address of an array is quite suspicious:
it's most probably the sign of an error somewhere.
Furthermore, such uses always evaluate to true.

So, add a warning about such use (but only if -Waddress was given).
---
 evaluate.c                      |  3 +++
 validation/cond-address-array.c | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 validation/cond-address-array.c

diff --git a/evaluate.c b/evaluate.c
index d8ec1c2e3..f2d95c79d 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -872,6 +872,9 @@ static struct symbol *evaluate_conditional(struct expression *expr, int iterator
 		if (is_func_type(ctype)) {
 			if (Waddress)
 				warning(expr->pos, "the address of %s will always evaluate as true", "a function");
+		} else if (is_array_type(ctype)) {
+			if (Waddress)
+				warning(expr->pos, "the address of %s will always evaluate as true", "an array");
 		} else if (!is_scalar_type(ctype)) {
 			sparse_error(expr->pos, "incorrect type in conditional");
 			info(expr->pos, "   got %s", show_typename(ctype));
diff --git a/validation/cond-address-array.c b/validation/cond-address-array.c
new file mode 100644
index 000000000..e1d2f87f8
--- /dev/null
+++ b/validation/cond-address-array.c
@@ -0,0 +1,26 @@
+int foo(void) {
+	extern int a[];
+
+	if (a)
+		return 1;
+	return 0;
+}
+
+int bar(void) {
+	int a[2];
+
+	if (a)
+		return 1;
+	return 0;
+}
+
+/*
+ * check-name: cond-address-array.c
+ * check-command: test-linearize -Wno-decl -Waddress $file
+ * check-output-ignore
+ *
+ * check-error-start
+cond-address-array.c:4:13: warning: the address of an array will always evaluate as true
+cond-address-array.c:12:13: warning: the address of an array will always evaluate as true
+ * check-error-end
+ */
-- 
2.12.0

