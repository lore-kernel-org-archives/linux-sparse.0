From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/7] warn if testing the address of a function
Date: Wed, 22 Mar 2017 18:32:53 +0100
Message-ID: <20170322173257.63019-4-luc.vanoostenryck@gmail.com>
References: <20170322173257.63019-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35566 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759029AbdCVRdM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 13:33:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id z133so11691317wmb.2
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 10:33:11 -0700 (PDT)
In-Reply-To: <20170322173257.63019-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>

Testing the address of a function is quite suspicious:
it's most probably the sign of an error somewhere.
Furthermore, such uses always evaluate to true.

So, add a warning about such use (but only if -Waddress was given).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                         |  5 ++++-
 validation/cond-address-function.c | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 validation/cond-address-function.c

diff --git a/evaluate.c b/evaluate.c
index 47eeaef2e..d8ec1c2e3 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -869,7 +869,10 @@ static struct symbol *evaluate_conditional(struct expression *expr, int iterator
 	if (ctype) {
 		if (is_safe_type(ctype))
 			warning(expr->pos, "testing a 'safe expression'");
-		if (!is_scalar_type(ctype)) {
+		if (is_func_type(ctype)) {
+			if (Waddress)
+				warning(expr->pos, "the address of %s will always evaluate as true", "a function");
+		} else if (!is_scalar_type(ctype)) {
 			sparse_error(expr->pos, "incorrect type in conditional");
 			info(expr->pos, "   got %s", show_typename(ctype));
 			ctype = NULL;
diff --git a/validation/cond-address-function.c b/validation/cond-address-function.c
new file mode 100644
index 000000000..9a143a009
--- /dev/null
+++ b/validation/cond-address-function.c
@@ -0,0 +1,18 @@
+extern void func(void);
+
+int global_function(void)
+{
+	if (func)
+		return 1;
+	return 0;
+}
+
+/*
+ * check-name: cond-address-function
+ * check-command: test-linearize -Wno-decl -Waddress $file
+ * check-output-ignore
+ *
+ * check-error-start
+cond-address-function.c:5:13: warning: the address of a function will always evaluate as true
+ * check-error-end
+ */
-- 
2.12.0

