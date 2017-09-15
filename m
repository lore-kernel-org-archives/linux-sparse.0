From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 14/15] add test case for superfluous cast with volatiles
Date: Fri, 15 Sep 2017 10:47:03 +0200
Message-ID: <20170915084704.39196-15-luc.vanoostenryck@gmail.com>
References: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38793 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdIOIrY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:47:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id x17so2140812wmd.5
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:47:24 -0700 (PDT)
In-Reply-To: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/linear/cast-volatile.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 validation/linear/cast-volatile.c

diff --git a/validation/linear/cast-volatile.c b/validation/linear/cast-volatile.c
new file mode 100644
index 000000000..f8a649372
--- /dev/null
+++ b/validation/linear/cast-volatile.c
@@ -0,0 +1,14 @@
+static int foo(volatile int *a, int v)
+{
+	*a = v;
+	return *a;
+}
+
+/*
+ * check-name: cast-volatile
+ * check-command: test-linearize -fdump-ir=linearize $file
+ *
+ * check-known-to-fail
+ * check-output-ignore
+ * check-output-excludes: scast\\.
+ */
-- 
2.14.0

