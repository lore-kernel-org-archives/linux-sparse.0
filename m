From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [SPARSE PATCH 1/5] add testcase for 'jump inside discarded expression statement'
Date: Fri, 10 Apr 2020 20:49:14 +0200
Message-ID: <20200410184918.64692-2-luc.vanoostenryck@gmail.com>
References: <20200410184918.64692-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32832 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgDJSta (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 10 Apr 2020 14:49:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so3302795wrd.0
        for <linux-sparse@vger.kernel.org>; Fri, 10 Apr 2020 11:49:29 -0700 (PDT)
In-Reply-To: <20200410184918.64692-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A goto done into an piece of code discarded at expand or
linearize time will produce an invalid IR.

Add a testcase for it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/linear/goto-and-expr-stmt0.c | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 validation/linear/goto-and-expr-stmt0.c

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
