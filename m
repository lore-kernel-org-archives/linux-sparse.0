From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/17] bad-goto: add testcase for 'jump inside discarded expression statement'
Date: Mon, 13 Apr 2020 18:15:49 +0200
Message-ID: <20200413161605.95900-2-luc.vanoostenryck@gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731394AbgDMQQN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:13 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACF8C0A3BE2
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o81so4243688wmo.2
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:13 -0700 (PDT)
In-Reply-To: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A goto done into an piece of code discarded at expand or
linearize time will produce an invalid IR.

Add a testcase for it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/label-stmt-expr1.c           | 30 +++++++++++++++++++++++++
 validation/linear/goto-and-expr-stmt0.c | 28 +++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 validation/label-stmt-expr1.c
 create mode 100644 validation/linear/goto-and-expr-stmt0.c

diff --git a/validation/label-stmt-expr1.c b/validation/label-stmt-expr1.c
new file mode 100644
index 000000000000..47ba54ae7305
--- /dev/null
+++ b/validation/label-stmt-expr1.c
@@ -0,0 +1,30 @@
+static int foo(void)
+{
+	goto l;
+	return	({
+l:
+		0;
+	});
+}
+
+static void bar(void)
+{
+	int r;
+	r = ({
+l:
+		0;
+	});
+	goto l;
+}
+
+/*
+ * check-name: label-stmt-expr1
+ * check-known-to-fail
+ *
+ * check-error-start
+label-stmt-expr1.c:3:9: error: goto into statement expression
+label-stmt-expr1.c:5:1:    label 'l' is defined here
+label-stmt-expr1.c:17:9: error: goto into statement expression
+label-stmt-expr1.c:14:1:    label 'l' is defined here
+ * check-error-end
+ */
diff --git a/validation/linear/goto-and-expr-stmt0.c b/validation/linear/goto-and-expr-stmt0.c
new file mode 100644
index 000000000000..548813531779
--- /dev/null
+++ b/validation/linear/goto-and-expr-stmt0.c
@@ -0,0 +1,28 @@
+int t(void)
+{
+	goto inside;
+	return 1 ? 2 : ({
+inside:
+			return 3;
+			4;
+		    });
+}
+
+void f(int x, int y)
+{
+	1 ? x : ({
+a:
+		 y;
+	});
+	goto a;
+}
+
+/*
+ * check-name: goto-and-expr-stmt0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: END
+ * check-error-ignore
+ */
-- 
2.26.0
