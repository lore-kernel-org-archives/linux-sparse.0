From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] add test cases for canonicalization of boolean expressions
Date: Fri, 15 Sep 2017 10:55:11 +0200
Message-ID: <20170915085511.43429-5-luc.vanoostenryck@gmail.com>
References: <20170915085511.43429-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34538 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdIOIzV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:55:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id i131so2185964wma.1
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:55:21 -0700 (PDT)
In-Reply-To: <20170915085511.43429-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/bool-neq0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 validation/optim/bool-neq0.c

diff --git a/validation/optim/bool-neq0.c b/validation/optim/bool-neq0.c
new file mode 100644
index 000000000..d6ad7aec3
--- /dev/null
+++ b/validation/optim/bool-neq0.c
@@ -0,0 +1,12 @@
+int bneq0(int a) { return a != 0; }
+int bnoteq0(int a) { return !(a == 0); }
+int bnotnot(int a) { return !(!a); }
+
+/*
+ * check-name: bool-neq0
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-excludes: seteq\\.
+ * check-output-contains: setne\\.
+ */
-- 
2.14.0

