From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] fix: missing evaluate with '-include' : add testcase
Date: Sun, 17 Sep 2017 12:05:51 +0200
Message-ID: <20170917100552.72288-2-luc.vanoostenryck@gmail.com>
References: <CAHmME9o02YNvfqV3RFofJE8FXwRaUACzq03TBADSYc74E02iBg@mail.gmail.com>
 <20170917100552.72288-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38903 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbdIQKGB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 Sep 2017 06:06:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id x17so6241393wmd.5
        for <linux-sparse@vger.kernel.org>; Sun, 17 Sep 2017 03:06:00 -0700 (PDT)
In-Reply-To: <20170917100552.72288-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/include-eval.c   |  7 +++++++
 validation/include-eval.inc | 12 ++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 validation/include-eval.c
 create mode 100644 validation/include-eval.inc

diff --git a/validation/include-eval.c b/validation/include-eval.c
new file mode 100644
index 000000000..bf9bf63fe
--- /dev/null
+++ b/validation/include-eval.c
@@ -0,0 +1,7 @@
+/* nothing */
+
+/*
+ * check-name: include-eval.c
+ * check-command: sparse -include ./include-eval.inc $file
+ * check-known-to-fail
+ */
diff --git a/validation/include-eval.inc b/validation/include-eval.inc
new file mode 100644
index 000000000..e2561ca41
--- /dev/null
+++ b/validation/include-eval.inc
@@ -0,0 +1,12 @@
+typedef unsigned long long_t;
+
+inline
+static unsigned int ok(void)
+{
+	return sizeof(long_t);
+}
+
+static unsigned int ko(void)
+{
+	return sizeof(long_t);
+}
-- 
2.14.0

