From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 15/15] add test case for missing conversion to select
Date: Fri, 15 Sep 2017 10:47:04 +0200
Message-ID: <20170915084704.39196-16-luc.vanoostenryck@gmail.com>
References: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32928 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbdIOIrZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:47:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id 187so2169632wmn.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:47:25 -0700 (PDT)
In-Reply-To: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This may seems as an missing optimization problem but in truth,
the root cause is a problem with SSA conversion.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/missing-select.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 validation/optim/missing-select.c

diff --git a/validation/optim/missing-select.c b/validation/optim/missing-select.c
new file mode 100644
index 000000000..4796e0586
--- /dev/null
+++ b/validation/optim/missing-select.c
@@ -0,0 +1,24 @@
+static int foo(int **g)
+{
+	int i = 1;
+	int *a[2];
+	int **p;
+
+	a[1] = &i;
+	if (g)
+		p = g;
+	else
+		p = &a[0];
+	if (!g)
+		**p = 0;
+	return i;
+}
+
+/*
+ * check-name: missing-select
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: select\\.
+ */
-- 
2.14.0

