From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 11/15] add test case for compound literals
Date: Fri, 15 Sep 2017 10:47:00 +0200
Message-ID: <20170915084704.39196-12-luc.vanoostenryck@gmail.com>
References: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35720 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdIOIrV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:47:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id e64so2165204wmi.2
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:47:21 -0700 (PDT)
In-Reply-To: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/compound-literal00.c | 18 ++++++++++++++++++
 validation/compound-literal01.c | 27 +++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 validation/compound-literal00.c
 create mode 100644 validation/compound-literal01.c

diff --git a/validation/compound-literal00.c b/validation/compound-literal00.c
new file mode 100644
index 000000000..f3069d2ca
--- /dev/null
+++ b/validation/compound-literal00.c
@@ -0,0 +1,18 @@
+struct bfs {
+        int a: 2;
+        int b: 30;
+};
+
+int foo(void)
+{
+        return (struct bfs){ .a = 1, .b = 2}.b;
+}
+
+/*
+ * check-name: compound-literal00.c
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$2
+ * check-error-end
+ */
diff --git a/validation/compound-literal01.c b/validation/compound-literal01.c
new file mode 100644
index 000000000..8a4935ea7
--- /dev/null
+++ b/validation/compound-literal01.c
@@ -0,0 +1,27 @@
+struct bfs {
+        int a: 2;
+        int b: 30;
+};
+
+int foo(void)
+{
+        struct bfs bf = { .a = 1, .b = 2 };
+        return (struct bfs[]){bf}[0].b;
+}
+
+int bar(void)
+{
+        struct bfs bf = { .a = 1, .b = 4 };
+        return (struct bfs[]){bf, { .a = 3, .b = 6}}[1].b;
+}
+
+/*
+ * check-name: compound-literal01.c
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-known-to-fail
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$2
+ * check-output-contains: ret\\..*\\$6
+ * check-error-end
+ */
-- 
2.14.0

