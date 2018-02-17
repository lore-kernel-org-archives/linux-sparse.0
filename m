From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] builtin: add testcases for expansion of special FP constants
Date: Sat, 17 Feb 2018 15:56:33 +0100
Message-ID: <20180217145634.53616-4-luc.vanoostenryck@gmail.com>
References: <20180217145634.53616-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33462 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbeBQO4r (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Feb 2018 09:56:47 -0500
Received: by mail-wr0-f193.google.com with SMTP id s5so5541267wra.0
        for <linux-sparse@vger.kernel.org>; Sat, 17 Feb 2018 06:56:46 -0800 (PST)
In-Reply-To: <20180217145634.53616-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

More specifically: for __builtin_nan(), _huge_val() & _inf()

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/expand/builtin_huge_val.c | 39 ++++++++++++++++++++++++++++++++++++
 validation/expand/builtin_nan.c      | 23 +++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 validation/expand/builtin_huge_val.c
 create mode 100644 validation/expand/builtin_nan.c

diff --git a/validation/expand/builtin_huge_val.c b/validation/expand/builtin_huge_val.c
new file mode 100644
index 000000000..09ef2a6f3
--- /dev/null
+++ b/validation/expand/builtin_huge_val.c
@@ -0,0 +1,39 @@
+static float huge_valf(void)
+{
+	return __builtin_huge_valf();
+}
+
+static double huge_val(void)
+{
+	return __builtin_huge_val();
+}
+
+static long double huge_vall(void)
+{
+	return __builtin_huge_vall();
+}
+
+
+static float inff(void)
+{
+	return __builtin_inff();
+}
+
+static double inf(void)
+{
+	return __builtin_inf();
+}
+
+static long double infl(void)
+{
+	return __builtin_infl();
+}
+
+/*
+ * check-name: builtin_huge_val expand
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: call
+ */
diff --git a/validation/expand/builtin_nan.c b/validation/expand/builtin_nan.c
new file mode 100644
index 000000000..20e3ae925
--- /dev/null
+++ b/validation/expand/builtin_nan.c
@@ -0,0 +1,23 @@
+static float nanf(void)
+{
+	return __builtin_nanf("0");
+}
+
+static double nan(void)
+{
+	return __builtin_nan("0");
+}
+
+static long double nanl(void)
+{
+	return __builtin_nanl("0");
+}
+
+/*
+ * check-name: builtin_nan expand
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: call
+ */
-- 
2.16.0

