From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/9] add testcases for converted loads
Date: Mon, 12 Feb 2018 23:02:38 +0100
Message-ID: <20180212220246.17750-2-luc.vanoostenryck@gmail.com>
References: <20180212220246.17750-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38343 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932671AbeBLWC4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Feb 2018 17:02:56 -0500
Received: by mail-wr0-f194.google.com with SMTP id t94so16706929wrc.5
        for <linux-sparse@vger.kernel.org>; Mon, 12 Feb 2018 14:02:55 -0800 (PST)
In-Reply-To: <20180212220246.17750-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/load-converted.c     | 15 +++++++++++++++
 validation/optim/load-semi-volatile.c | 25 +++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 validation/optim/load-converted.c
 create mode 100644 validation/optim/load-semi-volatile.c

diff --git a/validation/optim/load-converted.c b/validation/optim/load-converted.c
new file mode 100644
index 000000000..010c6bc7b
--- /dev/null
+++ b/validation/optim/load-converted.c
@@ -0,0 +1,15 @@
+static int foo(int *p, int i)
+{
+	int a = p[i];
+	int b = p[i];
+	return (a - b);
+}
+
+/*
+ * check-name: load-converted
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: add\.
+ */
diff --git a/validation/optim/load-semi-volatile.c b/validation/optim/load-semi-volatile.c
new file mode 100644
index 000000000..0e266e171
--- /dev/null
+++ b/validation/optim/load-semi-volatile.c
@@ -0,0 +1,25 @@
+struct s {
+	volatile int a;
+};
+
+struct s s;
+
+void foo(void)
+{
+	s;
+	s.a;
+}
+
+/*
+ * check-name: load-semi-volatile
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-pattern(1): load
+ *
+ * check-description:
+ *	The load at line 9 must be removed.
+ *	The load at line 10 is volatile and thus
+ *	must not be removed.
+ */
-- 
2.16.0

