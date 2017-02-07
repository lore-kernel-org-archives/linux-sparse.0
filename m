From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] add testcase for wrong early escape conversion
Date: Tue,  7 Feb 2017 18:45:05 +0100
Message-ID: <20170207174507.22722-2-luc.vanoostenryck@gmail.com>
References: <20170207174507.22722-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35939 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbdBGRwu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 12:52:50 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so29780401wmd.3
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 09:52:50 -0800 (PST)
In-Reply-To: <20170207174507.22722-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, Al Viro <viro@zeniv.linux.org.uk>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reported-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/preprocessor/early-escape.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 validation/preprocessor/early-escape.c

diff --git a/validation/preprocessor/early-escape.c b/validation/preprocessor/early-escape.c
new file mode 100644
index 000000000..c7beba5d8
--- /dev/null
+++ b/validation/preprocessor/early-escape.c
@@ -0,0 +1,23 @@
+#if 0
+"\l"
+#endif
+
+/*
+ * check-description:
+ *	Following the C standard, escape conversion must be
+ *	done in phase 5, just after preprocessing and just
+ *	before string concatenation. So we're not supposed
+ *	to receive a diagnostic for an unknown escape char
+ *	for a token which is excluded by the preprocessor.
+ * check-name: early-escape
+ * check-command: sparse -E $file
+ * check-known-to-fail
+ *
+ * check-output-start
+
+
+ * check-output-end
+ *
+ * check-error-start
+ * check-error-end
+ */
-- 
2.11.0

