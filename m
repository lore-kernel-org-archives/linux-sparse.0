From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/15] add test case for incomplete type
Date: Fri, 15 Sep 2017 10:46:54 +0200
Message-ID: <20170915084704.39196-6-luc.vanoostenryck@gmail.com>
References: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36945 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbdIOIrP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:47:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id f4so2151777wmh.4
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:47:15 -0700 (PDT)
In-Reply-To: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/bad-return-type.c   | 19 +++++++++++++++++++
 validation/incomplete-struct.c | 23 +++++++++++++++++++++++
 validation/missing-return.c    | 20 ++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 validation/bad-return-type.c
 create mode 100644 validation/incomplete-struct.c
 create mode 100644 validation/missing-return.c

diff --git a/validation/bad-return-type.c b/validation/bad-return-type.c
new file mode 100644
index 000000000..0f3b3f516
--- /dev/null
+++ b/validation/bad-return-type.c
@@ -0,0 +1,19 @@
+void foo(int a)
+{
+	return a;
+}
+
+int bar(void)
+{
+	return;
+}
+
+/*
+ * check-name: bad return type
+ * check-command: sparse -Wno-decl $file
+ *
+ * check-error-start
+bad-return-type.c:3:16: error: return expression in void function
+bad-return-type.c:8:9: error: return with no return value
+ * check-error-end
+ */
diff --git a/validation/incomplete-struct.c b/validation/incomplete-struct.c
new file mode 100644
index 000000000..f9429f33a
--- /dev/null
+++ b/validation/incomplete-struct.c
@@ -0,0 +1,23 @@
+struct s;
+
+void foo(struct s s)
+{
+}
+
+struct s bar(void)
+{
+	struct s s;
+	return s;
+}
+
+/*
+ * check-name: incomplete struct
+ * check-command: sparse -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-error-start
+incomplete-struct.c:3:19: error: parameter 's' has incomplete type
+incomplete-struct.c:7:10: error: return type is incomplete
+incomplete-struct.c:9:11: error: 's' has incompelete type
+ * check-error-end
+ */
diff --git a/validation/missing-return.c b/validation/missing-return.c
new file mode 100644
index 000000000..b6ee75efd
--- /dev/null
+++ b/validation/missing-return.c
@@ -0,0 +1,20 @@
+int foo(int a)
+{
+}
+
+int bar(int a)
+{
+	if (a)
+		return 0;
+}
+
+/*
+ * check-name: missing return
+ * check-command: sparse -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-error-start
+missing-return.c:3:1: warning: control reaches end of non-void function
+missing-return.c:9:1: warning: control reaches end of non-void function
+ * check-error-end
+ */
-- 
2.14.0

