From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 04/28] bad-goto: add testcase for 'jump inside discarded expression statement'
Date: Tue, 19 May 2020 02:57:04 +0200
Message-ID: <20200519005728.84594-5-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgESA5i (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:38 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51C4C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:37 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id j21so5695984ejy.1
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:37 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A goto done into an piece of code discarded at expand or
linearize time will produce an invalid IR.

Add a testcase for it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/label-stmt-expr1.c           | 29 +++++++++++++++++++++++++
 validation/linear/goto-and-expr-stmt0.c | 28 ++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 validation/label-stmt-expr1.c
 create mode 100644 validation/linear/goto-and-expr-stmt0.c

diff --git a/validation/label-stmt-expr1.c b/validation/label-stmt-expr1.c
new file mode 100644
index 000000000000..339217dcb999
--- /dev/null
+++ b/validation/label-stmt-expr1.c
@@ -0,0 +1,29 @@
+static int foo(void)
+{
+	goto l;
+	({
+l:
+		0;
+	});
+}
+
+static void bar(void)
+{
+	({
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
+label-stmt-expr1.c:3:9: error: label 'l' used outside statement expression
+label-stmt-expr1.c:5:1:    label 'l' defined here
+label-stmt-expr1.c:16:9: error: label 'l' used outside statement expression
+label-stmt-expr1.c:13:1:    label 'l' defined here
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
2.26.2
