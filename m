From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] add test cases for simplification of equivalent to 'x == 0' or 'x != 0'
Date: Fri, 15 Sep 2017 10:55:10 +0200
Message-ID: <20170915085511.43429-4-luc.vanoostenryck@gmail.com>
References: <20170915085511.43429-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36887 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdIOIzU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:55:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id f4so2168817wmh.4
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:55:20 -0700 (PDT)
In-Reply-To: <20170915085511.43429-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/bool-eq0.c | 12 ++++++++++++
 validation/optim/bool-ne0.c | 12 ++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 validation/optim/bool-eq0.c
 create mode 100644 validation/optim/bool-ne0.c

diff --git a/validation/optim/bool-eq0.c b/validation/optim/bool-eq0.c
new file mode 100644
index 000000000..dbc93d95c
--- /dev/null
+++ b/validation/optim/bool-eq0.c
@@ -0,0 +1,12 @@
+int beq0(int a) { return a == 0; }
+int bnotne0(int a) { return !(a != 0); }
+int bnot(int a) { return !a; }
+
+/*
+ * check-name: bool-eq0
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-excludes: setne\\.
+ * check-output-contains: seteq\\.
+ */
diff --git a/validation/optim/bool-ne0.c b/validation/optim/bool-ne0.c
new file mode 100644
index 000000000..b8206f6c7
--- /dev/null
+++ b/validation/optim/bool-ne0.c
@@ -0,0 +1,12 @@
+int bne0(int a) { return a != 0; }
+int bnoteq0(int a) { return !(a == 0); }
+int bnotnot(int a) { return !(!a); }
+
+/*
+ * check-name: bool-ne0
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-excludes: seteq\\.
+ * check-output-contains: setne\\.
+ */
-- 
2.14.0

