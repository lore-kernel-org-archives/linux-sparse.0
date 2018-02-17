From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] builtin: add testcases for expansion of FP classification
Date: Sat, 17 Feb 2018 15:56:34 +0100
Message-ID: <20180217145634.53616-5-luc.vanoostenryck@gmail.com>
References: <20180217145634.53616-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33465 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbeBQO4s (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Feb 2018 09:56:48 -0500
Received: by mail-wr0-f195.google.com with SMTP id s5so5541288wra.0
        for <linux-sparse@vger.kernel.org>; Sat, 17 Feb 2018 06:56:47 -0800 (PST)
In-Reply-To: <20180217145634.53616-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

__builtin_isinf(), isnan() & isnormal() are all special cases
of __builtin_fpclassify().

Add a few cases testing if those are correctly expanded if
when the argument is a constant.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/expand/builtin_fpclassify.c | 26 ++++++++++++++++++++++++++
 validation/expand/builtin_isinf.c      | 20 ++++++++++++++++++++
 validation/expand/builtin_isnan.c      | 20 ++++++++++++++++++++
 validation/expand/builtin_isnormal.c   | 20 ++++++++++++++++++++
 4 files changed, 86 insertions(+)
 create mode 100644 validation/expand/builtin_fpclassify.c
 create mode 100644 validation/expand/builtin_isinf.c
 create mode 100644 validation/expand/builtin_isnan.c
 create mode 100644 validation/expand/builtin_isnormal.c

diff --git a/validation/expand/builtin_fpclassify.c b/validation/expand/builtin_fpclassify.c
new file mode 100644
index 000000000..506927dd3
--- /dev/null
+++ b/validation/expand/builtin_fpclassify.c
@@ -0,0 +1,26 @@
+enum { FP_NAN, FP_INF, FP_NOR, FP_SUB, FP_ZERO };
+
+#define	classify(X) __builtin_fpclassify(FP_NAN,FP_INF,FP_NOR,FP_SUB,FP_ZERO,X)
+
+int test(void)
+{
+	if (classify(__builtin_nan("0")) != FP_NAN)
+		return 0;
+	if (classify(__builtin_inf("0")) != FP_INF)
+		return 0;
+	if (classify(1.0) != FP_NOR)
+		return 0;
+	if (classify(0.0) != FP_ZERO)
+		return 0;
+
+	return 1;
+}
+
+/*
+ * check-name: builtin_fpclassify
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$1
+ */
diff --git a/validation/expand/builtin_isinf.c b/validation/expand/builtin_isinf.c
new file mode 100644
index 000000000..36b20a60e
--- /dev/null
+++ b/validation/expand/builtin_isinf.c
@@ -0,0 +1,20 @@
+int test(void)
+{
+	if (!__builtin_isinf(__builtin_inff()))
+		return 0;
+	if (!__builtin_isinf(__builtin_inf()))
+		return 0;
+	if (!__builtin_isinf(__builtin_infl()))
+		return 0;
+
+	return 1;
+}
+
+/*
+ * check-name: builtin_isinf expand
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$1
+ */
diff --git a/validation/expand/builtin_isnan.c b/validation/expand/builtin_isnan.c
new file mode 100644
index 000000000..07c7e5e54
--- /dev/null
+++ b/validation/expand/builtin_isnan.c
@@ -0,0 +1,20 @@
+int test(void)
+{
+	if (!__builtin_isnan(__builtin_nanf("0")))
+		return 0;
+	if (!__builtin_isnan(__builtin_nan("0")))
+		return 0;
+	if (!__builtin_isnan(__builtin_nanl("0")))
+		return 0;
+
+	return 1;
+}
+
+/*
+ * check-name: builtin_isnan expand
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$1
+ */
diff --git a/validation/expand/builtin_isnormal.c b/validation/expand/builtin_isnormal.c
new file mode 100644
index 000000000..0b69e2731
--- /dev/null
+++ b/validation/expand/builtin_isnormal.c
@@ -0,0 +1,20 @@
+int test(void)
+{
+	if (!__builtin_isnormal(1.0F))
+		return 0;
+	if (!__builtin_isnormal(1.0))
+		return 0;
+	if (!__builtin_isnormal(1.0L))
+		return 0;
+
+	return 1;
+}
+
+/*
+ * check-name: builtin_isnormal expand
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$1
+ */
-- 
2.16.0

