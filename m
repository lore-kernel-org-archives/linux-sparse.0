From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] testsuite: add a simple test for -Wenum-mismatch
Date: Wed,  2 Nov 2016 22:45:09 +0100
Message-ID: <20161102214509.36571-6-luc.vanoostenryck@gmail.com>
References: <20161102214509.36571-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35132 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932325AbcKBVsZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 17:48:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id 68so5032620wmz.2
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 14:48:25 -0700 (PDT)
In-Reply-To: <20161102214509.36571-1-luc.vanoostenryck@gmail.com>
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
index 00000000..9a929d24
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
2.10.1

