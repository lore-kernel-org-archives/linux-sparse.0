From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] also report type & size when warning on non-power-of-2 pointer subtraction
Date: Sun, 21 Jan 2018 17:18:47 +0100
Message-ID: <20180121161847.94239-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:43195 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeAUQS6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Jan 2018 11:18:58 -0500
Received: by mail-wm0-f65.google.com with SMTP id g1so11870310wmg.2
        for <linux-sparse@vger.kernel.org>; Sun, 21 Jan 2018 08:18:58 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The option -Wptr-subtraction-blows warns when pointer subtraction
is done and the base size is not a power-of-2.
However, the current message doesn't give much context.

Change this by giving the base type and the size in the warning.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                 |  2 +-
 validation/ptr-sub-blows.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 validation/ptr-sub-blows.c

diff --git a/evaluate.c b/evaluate.c
index 4be4e8e5b..7818af48f 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -848,7 +848,7 @@ static struct symbol *evaluate_ptr_sub(struct expression *expr)
 
 		if (value & (value-1)) {
 			if (Wptr_subtraction_blows)
-				warning(expr->pos, "potentially expensive pointer subtraction");
+				warning(expr->pos, "potentially expensive pointer subtraction (size = %lu for %s)", value, show_typename(lbase));
 		}
 
 		sub->op = '-';
diff --git a/validation/ptr-sub-blows.c b/validation/ptr-sub-blows.c
new file mode 100644
index 000000000..433bd4e0c
--- /dev/null
+++ b/validation/ptr-sub-blows.c
@@ -0,0 +1,22 @@
+static int ok(int *a, int *b)
+{
+	return a - b;
+}
+
+struct s {
+	int a, b, c;
+};
+
+static int ko(struct s *a, struct s *b)
+{
+	return a - b;
+}
+
+/*
+ * check-name: ptr-sub-blows
+ * check-command: sparse -Wptr-subtraction-blows $file
+ *
+ * check-error-start
+ptr-sub-blows.c:12:18: warning: potentially expensive pointer subtraction (size = 12 for struct s)
+ * check-error-end
+ */
-- 
2.16.0

