From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] add testcase for __builtin_unreachable()
Date: Sat, 16 Sep 2017 11:01:45 +0200
Message-ID: <20170916090147.38083-2-luc.vanoostenryck@gmail.com>
References: <20170916090147.38083-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37608 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdIPJB4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 16 Sep 2017 05:01:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id f4so4580653wmh.4
        for <linux-sparse@vger.kernel.org>; Sat, 16 Sep 2017 02:01:55 -0700 (PDT)
In-Reply-To: <20170916090147.38083-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

__builtin_unreachable()'s semantic has consequences on the CFG
and this should be taken in account for:
* checking for undefined variables
* checking when control reaches end of non-void function
* context checking
* ...

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/linear/builtin_unreachable.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 validation/linear/builtin_unreachable.c

diff --git a/validation/linear/builtin_unreachable.c b/validation/linear/builtin_unreachable.c
new file mode 100644
index 000000000..4f13b892a
--- /dev/null
+++ b/validation/linear/builtin_unreachable.c
@@ -0,0 +1,31 @@
+void function_that_never_returns(void);
+
+int foo(int c)
+{
+	if (c)
+		return 1;
+	function_that_never_returns();
+	__builtin_unreachable();
+}
+
+/*
+ * check-name: __builtin_unreachable()
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-known-to-fail
+ * check-output-start
+foo:
+.L0:
+	<entry-point>
+	cbr         %arg1, .L3, .L2
+
+.L2:
+	call        function_that_never_returns
+	unreach
+
+.L3:
+	ret.32      $1
+
+
+ * check-output-end
+ */
-- 
2.14.0

