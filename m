From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] add testcase converted loads
Date: Tue,  6 Feb 2018 20:41:42 +0100
Message-ID: <20180206194143.1285-2-luc.vanoostenryck@gmail.com>
References: <20180206194143.1285-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42669 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753066AbeBFTnx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 6 Feb 2018 14:43:53 -0500
Received: by mail-wr0-f193.google.com with SMTP id 41so3204191wrc.9
        for <linux-sparse@vger.kernel.org>; Tue, 06 Feb 2018 11:43:53 -0800 (PST)
In-Reply-To: <20180206194143.1285-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

More specifically, a testcase show the wrong usage
for the address of a converted load.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/load-converted.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 validation/optim/load-converted.c

diff --git a/validation/optim/load-converted.c b/validation/optim/load-converted.c
new file mode 100644
index 000000000..010c6bc7b
--- /dev/null
+++ b/validation/optim/load-converted.c
@@ -0,0 +1,15 @@
+static int foo(int *p, int i)
+{
+	int a = p[i];
+	int b = p[i];
+	return (a - b);
+}
+
+/*
+ * check-name: load-converted
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: add\.
+ */
-- 
2.16.0

