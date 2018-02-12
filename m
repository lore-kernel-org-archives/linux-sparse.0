From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 8/9] add testcase for bad killing of dominated stores
Date: Mon, 12 Feb 2018 23:02:45 +0100
Message-ID: <20180212220246.17750-9-luc.vanoostenryck@gmail.com>
References: <20180212220246.17750-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51418 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932730AbeBLWDD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Feb 2018 17:03:03 -0500
Received: by mail-wm0-f65.google.com with SMTP id r71so12351033wmd.1
        for <linux-sparse@vger.kernel.org>; Mon, 12 Feb 2018 14:03:02 -0800 (PST)
In-Reply-To: <20180212220246.17750-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/store-dominated.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 validation/optim/store-dominated.c

diff --git a/validation/optim/store-dominated.c b/validation/optim/store-dominated.c
new file mode 100644
index 000000000..f1e2e6f29
--- /dev/null
+++ b/validation/optim/store-dominated.c
@@ -0,0 +1,16 @@
+static int a[];
+
+static void foo(void)
+{
+	int *c = &a[1];
+	*c = *c = 0;
+}
+
+/*
+ * check-name: store-dominated
+ * check-command: test-linearize $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: add\.
+ */
-- 
2.16.0

