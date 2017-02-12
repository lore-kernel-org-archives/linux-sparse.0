From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 04/14] testsuite: add a simple test for -Wenum-mismatch
Date: Mon, 13 Feb 2017 00:28:54 +0100
Message-ID: <20170212232904.49647-5-luc.vanoostenryck@gmail.com>
References: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
 <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34479 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbdBLX3O (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 18:29:14 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so16482136wmi.1
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 15:29:14 -0800 (PST)
In-Reply-To: <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A nice feature
No tests existed for it
Create one now.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/enum-mismatch.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 validation/enum-mismatch.c

diff --git a/validation/enum-mismatch.c b/validation/enum-mismatch.c
new file mode 100644
index 000000000..9a929d24c
--- /dev/null
+++ b/validation/enum-mismatch.c
@@ -0,0 +1,19 @@
+enum ea { A = 0, };
+enum eb { B = 1, };
+
+
+static enum eb foo(enum ea a)
+{
+	return a;
+}
+
+/*
+ * check-name: enum-mismatch
+ * check-command: sparse -Wenum-mismatch $file
+ *
+ * check-error-start
+enum-mismatch.c:7:16: warning: mixing different enum types
+enum-mismatch.c:7:16:     int enum ea  versus
+enum-mismatch.c:7:16:     int enum eb 
+ * check-error-end
+ */
-- 
2.11.0

