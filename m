From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] add testcase of dead dominator
Date: Sat, 10 Feb 2018 14:29:44 +0100
Message-ID: <20180210132945.92758-2-luc.vanoostenryck@gmail.com>
References: <20180210132945.92758-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50651 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeBJNcC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Feb 2018 08:32:02 -0500
Received: by mail-wm0-f67.google.com with SMTP id f71so2188963wmf.0
        for <linux-sparse@vger.kernel.org>; Sat, 10 Feb 2018 05:32:01 -0800 (PST)
In-Reply-To: <20180210132945.92758-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/mem2reg/load-dead.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 validation/mem2reg/load-dead.c

diff --git a/validation/mem2reg/load-dead.c b/validation/mem2reg/load-dead.c
new file mode 100644
index 000000000..19ac4e5e4
--- /dev/null
+++ b/validation/mem2reg/load-dead.c
@@ -0,0 +1,19 @@
+int fun(int);
+
+static inline int fake(void)
+{
+}
+
+static void foo(int a)
+{
+	0 || fun((a, fake(), a));
+}
+
+/*
+ * check-name: load-dead
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: VOID
+ */
-- 
2.16.0

