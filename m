From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 12/15] add test case for pre-processor extra tokens warning
Date: Fri, 15 Sep 2017 10:47:01 +0200
Message-ID: <20170915084704.39196-13-luc.vanoostenryck@gmail.com>
References: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36985 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbdIOIrW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:47:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id f4so2152058wmh.4
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:47:22 -0700 (PDT)
In-Reply-To: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/preprocessor/extra-token.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 validation/preprocessor/extra-token.c

diff --git a/validation/preprocessor/extra-token.c b/validation/preprocessor/extra-token.c
new file mode 100644
index 000000000..50a853c5d
--- /dev/null
+++ b/validation/preprocessor/extra-token.c
@@ -0,0 +1,15 @@
+#define THIS 0
+#ifdef THIS == 1
+#endif
+
+/*
+ * check-name: preprocessor/extra-token.c
+ * check-command: sparse -E $file
+ * check-known-to-fail
+ *
+ * check-error-start
+preprocessor/extra-token.c:2:13: warning: extra tokens at end of #ifdef directive
+ * check-error-end
+ *
+ * check-output-ignore
+ */
-- 
2.14.0

