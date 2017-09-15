From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/15] add test case for conditionally undefined var
Date: Fri, 15 Sep 2017 10:46:53 +0200
Message-ID: <20170915084704.39196-5-luc.vanoostenryck@gmail.com>
References: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32858 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdIOIrO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:47:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id 187so2169217wmn.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:47:14 -0700 (PDT)
In-Reply-To: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/var-undef-partial.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 validation/var-undef-partial.c

diff --git a/validation/var-undef-partial.c b/validation/var-undef-partial.c
new file mode 100644
index 000000000..2b6658342
--- /dev/null
+++ b/validation/var-undef-partial.c
@@ -0,0 +1,21 @@
+int foo(int a, int b)
+{
+	int var = 0;
+	int r;
+
+	if (a)
+		var = 1;
+	if (b)
+		r = var;
+
+	return r;		// undef if !b
+}
+
+/*
+ * check-name: variable partially undefined
+ * check-description: trigger a bug in symbol/memop simplification
+ * check-description: sparse-llvm is used here as semantic checker of sparse's IR
+ * check-command: sparse-llvm -Wno-decl $file
+ * check-known-to-fail
+ * check-output-ignore
+ */
-- 
2.14.0

