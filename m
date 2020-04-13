From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/17] bad-goto: add more testcases
Date: Mon, 13 Apr 2020 18:15:51 +0200
Message-ID: <20200413161605.95900-4-luc.vanoostenryck@gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbgDMQQP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0F4C0A3BDC
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so10521576wma.4
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:14 -0700 (PDT)
In-Reply-To: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Add some testcases for gotos with undeclared labels & __label__.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/label-scope1.c | 42 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 validation/label-scope1.c

diff --git a/validation/label-scope1.c b/validation/label-scope1.c
new file mode 100644
index 000000000000..f2b1ae9b158a
--- /dev/null
+++ b/validation/label-scope1.c
@@ -0,0 +1,42 @@
+static void ok_top(void)
+{
+	__label__ l;
+l:
+	goto l;
+}
+
+static void ko_undecl(void)
+{
+	__label__ l;
+	goto l;				// KO: undeclared
+}
+
+static void ok_local(void)
+{
+l:
+	{
+		__label__ l;
+l:
+		goto l;
+	}
+goto l;
+}
+
+static void ko_scope(void)
+{
+	{
+		__label__ l;
+l:
+		goto l;
+	}
+goto l;					// KO: undeclared
+}
+
+/*
+ * check-name: label-scope1
+ *
+ * check-error-start
+label-scope1.c:11:9: error: label 'l' was not declared
+label-scope1.c:32:1: error: label 'l' was not declared
+ * check-error-end
+ */
-- 
2.26.0
