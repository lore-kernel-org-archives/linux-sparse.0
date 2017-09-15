From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 13/15] add test case for space within command line
Date: Fri, 15 Sep 2017 10:47:02 +0200
Message-ID: <20170915084704.39196-14-luc.vanoostenryck@gmail.com>
References: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:47284 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdIOIrX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:47:23 -0400
Received: by mail-wm0-f48.google.com with SMTP id 13so6409520wmq.2
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:47:23 -0700 (PDT)
In-Reply-To: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/preprocessor/arg-cli-ko.c | 16 ++++++++++++++++
 validation/preprocessor/arg-cli-ok.c | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 validation/preprocessor/arg-cli-ko.c
 create mode 100644 validation/preprocessor/arg-cli-ok.c

diff --git a/validation/preprocessor/arg-cli-ko.c b/validation/preprocessor/arg-cli-ko.c
new file mode 100644
index 000000000..d4e2803c0
--- /dev/null
+++ b/validation/preprocessor/arg-cli-ko.c
@@ -0,0 +1,16 @@
+M1(0)
+M2(0,1)
+
+/*
+ * check-name: arg on command line
+ * check-command: sparse -E '-DM1(X)=X' '-DM2(X, Y)=B Y S X T' $file
+ *
+ * check-description: this is a failure of the testsuite.
+ * check-known-to-fail
+ *
+ * check-output-start
+
+0
+B 1 S 0 T
+ * check-output-end
+ */
diff --git a/validation/preprocessor/arg-cli-ok.c b/validation/preprocessor/arg-cli-ok.c
new file mode 100644
index 000000000..6a7f2c7e2
--- /dev/null
+++ b/validation/preprocessor/arg-cli-ok.c
@@ -0,0 +1,16 @@
+M1(0)
+M2(0,1)
+
+/*
+ * check-name: arg on command line
+ * check-command: sparse -E '-DM1(X)=X' '-DM2(X,Y)=B Y S X T' $file
+ *
+ * check-description: this is a failure of the testsuite.
+ * check-known-to-fail
+ *
+ * check-output-start
+
+0
+B 1 S 0 T
+ * check-output-end
+ */
-- 
2.14.0

