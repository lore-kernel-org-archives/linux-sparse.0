From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 09/14] testsuite: add some selfchecking
Date: Mon, 13 Feb 2017 00:28:59 +0100
Message-ID: <20170212232904.49647-10-luc.vanoostenryck@gmail.com>
References: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
 <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34510 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdBLX3T (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 18:29:19 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so16482312wmi.1
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 15:29:19 -0800 (PST)
In-Reply-To: <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/testsuite-selfcheck1.c | 10 ++++++++++
 validation/testsuite-selfcheck2.c | 10 ++++++++++
 validation/testsuite-selfcheck3.c | 10 ++++++++++
 3 files changed, 30 insertions(+)
 create mode 100644 validation/testsuite-selfcheck1.c
 create mode 100644 validation/testsuite-selfcheck2.c
 create mode 100644 validation/testsuite-selfcheck3.c

diff --git a/validation/testsuite-selfcheck1.c b/validation/testsuite-selfcheck1.c
new file mode 100644
index 000000000..d927f9961
--- /dev/null
+++ b/validation/testsuite-selfcheck1.c
@@ -0,0 +1,10 @@
+good
+
+/*
+ * check-name: selfcheck1
+ * check-command: sparse -E $file
+ * check-output-ignore
+ *
+ * check-output-contains: good
+ * check-output-excludes: evil
+ */
diff --git a/validation/testsuite-selfcheck2.c b/validation/testsuite-selfcheck2.c
new file mode 100644
index 000000000..5309e32f3
--- /dev/null
+++ b/validation/testsuite-selfcheck2.c
@@ -0,0 +1,10 @@
+evil
+
+/*
+ * check-name: selfcheck2
+ * check-command: sparse -E $file
+ * check-output-ignore
+ * check-known-to-fail
+ *
+ * check-output-contains: good
+ */
diff --git a/validation/testsuite-selfcheck3.c b/validation/testsuite-selfcheck3.c
new file mode 100644
index 000000000..6d834e68d
--- /dev/null
+++ b/validation/testsuite-selfcheck3.c
@@ -0,0 +1,10 @@
+evil
+
+/*
+ * check-name: selfcheck3
+ * check-command: sparse -E $file
+ * check-output-ignore
+ * check-known-to-fail
+ *
+ * check-output-excludes: evil
+ */
-- 
2.11.0

