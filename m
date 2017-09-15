From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/4] add test cases for canonicalization of add/sub chains
Date: Fri, 15 Sep 2017 10:55:08 +0200
Message-ID: <20170915085511.43429-2-luc.vanoostenryck@gmail.com>
References: <20170915085511.43429-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35659 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdIOIzS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:55:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id e64so2182419wmi.2
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:55:18 -0700 (PDT)
In-Reply-To: <20170915085511.43429-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/canonical-add.c | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 validation/optim/canonical-add.c

diff --git a/validation/optim/canonical-add.c b/validation/optim/canonical-add.c
new file mode 100644
index 000000000..b7035e4cd
--- /dev/null
+++ b/validation/optim/canonical-add.c
@@ -0,0 +1,55 @@
+int xpc_add_ypc(int x, int y)
+{
+	return (x + 1) + (y + 1);
+}
+
+int xmc_add_ypc(int x, int y)
+{
+	return (x - 1) + (y + 1);
+}
+
+int xpc_add_ymc(int x, int y)
+{
+	return (x + 1) + (y - 1);
+}
+
+int xmc_add_ymc(int x, int y)
+{
+	return (x - 1) + (y - 1);
+}
+
+int xpc_sub_ypc(int x, int y)
+{
+	return (x + 1) - (y + 1);
+}
+
+int xmc_sub_ypc(int x, int y)
+{
+	return (x - 1) - (y + 1);
+}
+
+int xpc_sub_ymc(int x, int y)
+{
+	return (x + 1) - (y - 1);
+}
+
+int xmc_sub_ymc(int x, int y)
+{
+	return (x - 1) - (y - 1);
+}
+
+/*
+ * check-name: canonical-add
+ * check-description:
+ *	1) verify that constants in add/sub chains are
+ *	   pushed at the right of the whole chain.
+ *	   For example '(a + 1) + b' must be canonicalized into '(a + b) + 1'
+ *	   This is needed for '(a + 1) + b - 1' to be simplified into '(a + b)'
+ *
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ * check-output-ignore
+
+ * check-output-excludes: \$1
+ * check-output-excludes: \$-1
+ */
-- 
2.14.0

