From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/15] add test case for missed overflow detection
Date: Fri, 15 Sep 2017 10:46:59 +0200
Message-ID: <20170915084704.39196-11-luc.vanoostenryck@gmail.com>
References: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38777 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbdIOIrU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:47:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id x17so2140674wmd.5
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:47:20 -0700 (PDT)
In-Reply-To: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/overflow.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 validation/overflow.c

diff --git a/validation/overflow.c b/validation/overflow.c
new file mode 100644
index 000000000..c2655e329
--- /dev/null
+++ b/validation/overflow.c
@@ -0,0 +1,19 @@
+extern int a;
+
+int a = __INT_MAX__ * 2;
+
+int foo(void)
+{
+	return __INT_MAX__ * 2;
+}
+
+/*
+ * check-name: overflow
+ * check-command: sparse -Wno-decl $file
+ *
+ * check-known-to-fail
+ * check-error-start
+bug-overflow.c:3:21: warning: integer overflow in expression
+bug-overflow.c:7:28: warning: integer overflow in expression
+ * check-error-end
+ */
-- 
2.14.0

