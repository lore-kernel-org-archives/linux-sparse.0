From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] add testcase for return & inline
Date: Sat, 16 Sep 2017 11:01:46 +0200
Message-ID: <20170916090147.38083-3-luc.vanoostenryck@gmail.com>
References: <20170916090147.38083-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37613 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdIPJB5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 16 Sep 2017 05:01:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id f4so4580687wmh.4
        for <linux-sparse@vger.kernel.org>; Sat, 16 Sep 2017 02:01:56 -0700 (PDT)
In-Reply-To: <20170916090147.38083-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The linearization of 'return' statements must correctly take
in account some implementation details of the inlining.

As such, it deserves its own testcase.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/linear/inline-return.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 validation/linear/inline-return.c

diff --git a/validation/linear/inline-return.c b/validation/linear/inline-return.c
new file mode 100644
index 000000000..b1e4d8446
--- /dev/null
+++ b/validation/linear/inline-return.c
@@ -0,0 +1,24 @@
+static inline int def(void)
+{
+	return 1;
+}
+
+int foo(void)
+{
+	return def();
+}
+
+int bar(void)
+{
+	return def();
+	return 0;
+}
+
+/*
+ * check-name: inline-return.c
+ * check-command: test-linearize -fdump-ir=linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$1
+ * check-output-excludes: ret\\..*\\$0
+ */
-- 
2.14.0

