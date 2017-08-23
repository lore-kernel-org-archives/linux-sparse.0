From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 47/48] mem2reg: add some small test cases
Date: Wed, 23 Aug 2017 22:15:53 +0200
Message-ID: <20170823201554.90551-48-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36218 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWURe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id f127so643133wmf.3
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:34 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 validation/mem2reg/global-direct00.c    | 24 ++++++++++++++++++++++++
 validation/mem2reg/local-addr-taken00.c | 21 +++++++++++++++++++++
 validation/mem2reg/local-direct00.c     | 20 ++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 validation/mem2reg/global-direct00.c
 create mode 100644 validation/mem2reg/local-addr-taken00.c
 create mode 100644 validation/mem2reg/local-direct00.c

diff --git a/validation/mem2reg/global-direct00.c b/validation/mem2reg/global-direct00.c
new file mode 100644
index 000000000..cd0f0d1a0
--- /dev/null
+++ b/validation/mem2reg/global-direct00.c
@@ -0,0 +1,24 @@
+int a, c, d;
+
+int foo(void)
+{
+	int b, e;
+	if (a)
+		b = c;
+	else
+		b = d;
+	if (c)
+		a = b;
+	if (b)
+		e = a;
+	return e;
+}
+
+/*
+ * check-name: mem2reg global direct 00
+ * check-command: test-linearize -fdump-ir=mem2reg,only -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-pattern-4-times: load\\.
+ * check-output-pattern-1-times: store\\.
+ */
diff --git a/validation/mem2reg/local-addr-taken00.c b/validation/mem2reg/local-addr-taken00.c
new file mode 100644
index 000000000..bcfa32257
--- /dev/null
+++ b/validation/mem2reg/local-addr-taken00.c
@@ -0,0 +1,21 @@
+int foo(int c, int a, int b)
+{
+	int l;
+	int *p = &l;
+
+	if (c)
+		l = a;
+	else
+		l = b;
+
+	return l;
+}
+
+/*
+ * check-name: mem2reg local address taken 00
+ * check-command: test-linearize -fdump-ir=mem2reg,only -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-excludes: load\\.
+ * check-output-excludes: store\\.
+ */
diff --git a/validation/mem2reg/local-direct00.c b/validation/mem2reg/local-direct00.c
new file mode 100644
index 000000000..fc55fa076
--- /dev/null
+++ b/validation/mem2reg/local-direct00.c
@@ -0,0 +1,20 @@
+int foo(int c, int a, int b)
+{
+	int l;
+
+	if (c)
+		l = a;
+	else
+		l = b;
+
+	return l;
+}
+
+/*
+ * check-name: mem2reg local direct 00
+ * check-command: test-linearize -fdump-ir=mem2reg,only -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-excludes: load\\.
+ * check-output-excludes: store\\.
+ */
-- 
2.14.0

