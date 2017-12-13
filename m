From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/6] add testcase for 'sparse -D M...'
Date: Wed, 13 Dec 2017 18:15:26 +0100
Message-ID: <20171213171531.43707-2-luc.vanoostenryck@gmail.com>
References: <20171213171531.43707-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35062 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753806AbdLMRPo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 13 Dec 2017 12:15:44 -0500
Received: by mail-wm0-f54.google.com with SMTP id f9so6639685wmh.0
        for <linux-sparse@vger.kernel.org>; Wed, 13 Dec 2017 09:15:43 -0800 (PST)
In-Reply-To: <20171213171531.43707-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/preprocessor/cli-D-arg.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 validation/preprocessor/cli-D-arg.c

diff --git a/validation/preprocessor/cli-D-arg.c b/validation/preprocessor/cli-D-arg.c
new file mode 100644
index 000000000..b098e98bd
--- /dev/null
+++ b/validation/preprocessor/cli-D-arg.c
@@ -0,0 +1,13 @@
+A
+B
+/*
+ * check-name: cli: -D MACRO
+ * check-command: sparse -E -D A -D B=abc $file
+ * check-known-to-fail
+ *
+ * check-output-start
+
+1
+abc
+ * check-output-end
+ */
-- 
2.15.0

