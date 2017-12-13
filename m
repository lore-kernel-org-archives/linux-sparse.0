From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/6] testsuite: add test case for quoting of command's arguments
Date: Wed, 13 Dec 2017 18:15:28 +0100
Message-ID: <20171213171531.43707-4-luc.vanoostenryck@gmail.com>
References: <20171213171531.43707-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39975 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753266AbdLMRPr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 13 Dec 2017 12:15:47 -0500
Received: by mail-wm0-f67.google.com with SMTP id f206so6519521wmf.5
        for <linux-sparse@vger.kernel.org>; Wed, 13 Dec 2017 09:15:46 -0800 (PST)
In-Reply-To: <20171213171531.43707-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/self-quote-args.c | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 validation/self-quote-args.c

diff --git a/validation/self-quote-args.c b/validation/self-quote-args.c
new file mode 100644
index 000000000..acac41d7d
--- /dev/null
+++ b/validation/self-quote-args.c
@@ -0,0 +1,8 @@
+/*
+ * check-name: self-quote-args
+ * check-description: This is testing that the test-suite
+ *	respect the quoting of the command's arguments.
+ * check-command: sparse '-foption with-spaces' empty-file
+ * check-known-to-fail
+ * check-output-ignore
+ */
-- 
2.15.0

