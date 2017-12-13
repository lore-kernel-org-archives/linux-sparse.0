From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/6] add test case for space within command line
Date: Wed, 13 Dec 2017 18:15:30 +0100
Message-ID: <20171213171531.43707-6-luc.vanoostenryck@gmail.com>
References: <20171213171531.43707-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34399 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753679AbdLMRQB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 13 Dec 2017 12:16:01 -0500
Received: by mail-wm0-f52.google.com with SMTP id y82so22692247wmg.1
        for <linux-sparse@vger.kernel.org>; Wed, 13 Dec 2017 09:16:00 -0800 (PST)
In-Reply-To: <20171213171531.43707-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/preprocessor/cli-D-space.c | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 validation/preprocessor/cli-D-space.c

diff --git a/validation/preprocessor/cli-D-space.c b/validation/preprocessor/cli-D-space.c
new file mode 100644
index 000000000..d104d66da
--- /dev/null
+++ b/validation/preprocessor/cli-D-space.c
@@ -0,0 +1,11 @@
+M(0,1)
+/*
+ * check-name: cli: allow spaces in macros
+ * check-command: sparse -E '-DM(X, Y)=a' $file
+ * check-known-to-fail
+ *
+ * check-output-start
+
+a
+ * check-output-end
+ */
-- 
2.15.0

