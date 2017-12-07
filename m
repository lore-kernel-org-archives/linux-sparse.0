From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] add testcases linearization of degenerated arrays/functions
Date: Thu,  7 Dec 2017 18:16:12 +0100
Message-ID: <20171207171613.34989-3-luc.vanoostenryck@gmail.com>
References: <20171207171613.34989-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40637 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756310AbdLGRU5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 7 Dec 2017 12:20:57 -0500
Received: by mail-wm0-f67.google.com with SMTP id f206so14146868wmf.5
        for <linux-sparse@vger.kernel.org>; Thu, 07 Dec 2017 09:20:57 -0800 (PST)
In-Reply-To: <20171207171613.34989-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/linear/degen-array.c    | 31 ++++++++++++++++++++++++++++
 validation/linear/degen-function.c | 38 +++++++++++++++++++++++++++++++++++
 validation/linear/degen-log-not.c  | 41 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 validation/linear/degen-array.c
 create mode 100644 validation/linear/degen-function.c
 create mode 100644 validation/linear/degen-log-not.c

diff --git a/validation/linear/degen-array.c b/validation/linear/degen-array.c
new file mode 100644
index 000000000..b8a6f4f66
--- /dev/null
+++ b/validation/linear/degen-array.c
@@ -0,0 +1,31 @@
+extern int a[3];
+
+int (*fa(int i))[] { return &a; }
+int *f0(int i) { return &a[0]; }
+int *fd(int i) { return  a; }
+
+/*
+ * check-name: degen-array
+ * check-command: test-linearize -m64 -Wno-decl $file
+ *
+ * check-output-start
+fa:
+.L0:
+	<entry-point>
+	ret.64      a
+
+
+f0:
+.L2:
+	<entry-point>
+	ret.64      a
+
+
+fd:
+.L4:
+	<entry-point>
+	ret.64      a
+
+
+ * check-output-end
+ */
diff --git a/validation/linear/degen-function.c b/validation/linear/degen-function.c
new file mode 100644
index 000000000..6dd3123b8
--- /dev/null
+++ b/validation/linear/degen-function.c
@@ -0,0 +1,38 @@
+extern int fun(int);
+
+typedef int (*fun_t)(int);
+
+fun_t fa(void) { return &fun; }
+fun_t f0(void) { return  fun; }
+
+/*
+ * check-name: degen-function
+ * check-command: test-linearize -m64 -Wno-decl -fdump-ir=linearize $file
+ *
+ * check-output-start
+fa:
+.L0:
+	<entry-point>
+	symaddr.64  %r1 <- fun
+	phisrc.64   %phi1(return) <- %r1
+	br          .L1
+
+.L1:
+	phi.64      %r2 <- %phi1(return)
+	ret.64      %r1
+
+
+f0:
+.L2:
+	<entry-point>
+	symaddr.64  %r3 <- fun
+	phisrc.64   %phi2(return) <- %r3
+	br          .L3
+
+.L3:
+	phi.64      %r4 <- %phi2(return)
+	ret.64      %r3
+
+
+ * check-output-end
+ */
diff --git a/validation/linear/degen-log-not.c b/validation/linear/degen-log-not.c
new file mode 100644
index 000000000..baa7d5366
--- /dev/null
+++ b/validation/linear/degen-log-not.c
@@ -0,0 +1,41 @@
+extern int arr[];
+int test_arr_addr(int i)
+{
+	if (!&arr) return 1;
+	return 0;
+}
+
+int test_arr_addr0(int i)
+{
+	if (!&arr[0]) return 1;
+	return 0;
+}
+
+int test_arr_degen(int i)
+{
+	if (!arr) return 1;
+	return 0;
+}
+
+extern int fun(void);
+int test_fun_addr(int i)
+{
+	if (!&fun) return 1;
+	return 0;
+}
+
+int test_fun_degen(int i)
+{
+	if (!fun) return 1;
+	return 0;
+}
+
+/*
+ * check-name: degenerate logical-not
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: load
+ * check-output-excludes: VOID
+ */
-- 
2.15.0

