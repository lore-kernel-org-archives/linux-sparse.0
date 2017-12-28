From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] add testcase for CSE of floating-point compares
Date: Thu, 28 Dec 2017 23:17:34 +0100
Message-ID: <20171228221735.38902-2-luc.vanoostenryck@gmail.com>
References: <20171228221735.38902-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:44842 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753369AbdL1WRv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 17:17:51 -0500
Received: by mail-wm0-f65.google.com with SMTP id t8so45868335wmc.3
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 14:17:50 -0800 (PST)
In-Reply-To: <20171228221735.38902-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/cse-fcmp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 validation/optim/cse-fcmp.c

diff --git a/validation/optim/cse-fcmp.c b/validation/optim/cse-fcmp.c
new file mode 100644
index 000000000..9e6872302
--- /dev/null
+++ b/validation/optim/cse-fcmp.c
@@ -0,0 +1,20 @@
+extern void fun(void);
+
+int foo(double a, double b)
+{
+	if (a < b)
+		fun();
+	if (a < b)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * check-name: cse-fcmp
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-pattern(1): fcmp
+ */
-- 
2.15.0

