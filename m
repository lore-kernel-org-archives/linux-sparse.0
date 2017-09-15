From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/15] add test case for memory to register problem
Date: Fri, 15 Sep 2017 10:46:52 +0200
Message-ID: <20170915084704.39196-4-luc.vanoostenryck@gmail.com>
References: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34525 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbdIOIrN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:47:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id i131so2168630wma.1
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:47:13 -0700 (PDT)
In-Reply-To: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/linear/stray-phisrc.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 validation/linear/stray-phisrc.c

diff --git a/validation/linear/stray-phisrc.c b/validation/linear/stray-phisrc.c
new file mode 100644
index 000000000..e9f35c89c
--- /dev/null
+++ b/validation/linear/stray-phisrc.c
@@ -0,0 +1,25 @@
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
+	p += 1;			// will point to a[1] = &i
+	if (!g)
+		**p = 0;
+	return i;
+}
+
+/*
+ * check-name: stray phisrc
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: phisrc\\.
+ */
-- 
2.14.0

