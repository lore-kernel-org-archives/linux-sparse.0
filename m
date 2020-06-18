From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] pre-process: add testcases for __has_feature() & __has_extension()
Date: Thu, 18 Jun 2020 22:47:12 +0200
Message-ID: <20200618204716.3896-2-luc.vanoostenryck@gmail.com>
References: <20200618204716.3896-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgFRUtg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 18 Jun 2020 16:49:36 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9B0C06174E
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jun 2020 13:49:36 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w16so7866522ejj.5
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jun 2020 13:49:35 -0700 (PDT)
In-Reply-To: <20200618204716.3896-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The support for these builtin macros is incoming.
So, add some testcases for them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/preprocessor/has-feature.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 validation/preprocessor/has-feature.c

diff --git a/validation/preprocessor/has-feature.c b/validation/preprocessor/has-feature.c
new file mode 100644
index 000000000000..3ab7c3e039fa
--- /dev/null
+++ b/validation/preprocessor/has-feature.c
@@ -0,0 +1,21 @@
+#ifndef __has_feature
+__has_feature()??? Quesako?
+#define __has_feature(x) 0
+#else
+"has __has_feature(), yeah!"
+#endif
+
+#if __has_feature(not_a_feature)
+#error "not a feature!"
+#endif
+
+/*
+ * check-name: has-feature
+ * check-command: sparse -E $file
+ * check-known-to-fail
+ *
+ * check-output-start
+
+"has __has_feature(), yeah!"
+ * check-output-end
+ */
-- 
2.27.0
