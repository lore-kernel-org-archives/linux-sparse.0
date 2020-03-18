From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] add testcases for OP_UNREACH
Date: Wed, 18 Mar 2020 18:31:16 +0100
Message-ID: <20200318173120.63939-2-luc.vanoostenryck@gmail.com>
References: <20200318173120.63939-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42999 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgCRRb0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Mar 2020 13:31:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so31527406wrm.9
        for <linux-sparse@vger.kernel.org>; Wed, 18 Mar 2020 10:31:25 -0700 (PDT)
In-Reply-To: <20200318173120.63939-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/context-unreachable.c              | 16 ++++++++++
 validation/linear/builtin_unreachable0.c      | 30 +++++++++++++++++++
 ...n_unreachable.c => builtin_unreachable1.c} | 14 ++++-----
 validation/linear/noreturn-unreachable0.c     | 23 ++++++++++++++
 4 files changed, 76 insertions(+), 7 deletions(-)
 create mode 100644 validation/context-unreachable.c
 create mode 100644 validation/linear/builtin_unreachable0.c
 rename validation/linear/{builtin_unreachable.c => builtin_unreachable1.c} (65%)
 create mode 100644 validation/linear/noreturn-unreachable0.c

diff --git a/validation/context-unreachable.c b/validation/context-unreachable.c
new file mode 100644
index 000000000000..3e330403ce01
--- /dev/null
+++ b/validation/context-unreachable.c
@@ -0,0 +1,16 @@
+int fun(void);
+
+static void foo(void)
+{
+	__context__(1);
+	if (!fun()) {
+		__builtin_unreachable();
+		return;
+	}
+	__context__(-1);
+}
+
+/*
+ * check-name: context-unreachable
+ * check-known-to-fail
+ */
diff --git a/validation/linear/builtin_unreachable0.c b/validation/linear/builtin_unreachable0.c
new file mode 100644
index 000000000000..5da9d074ae5f
--- /dev/null
+++ b/validation/linear/builtin_unreachable0.c
@@ -0,0 +1,30 @@
+extern void die(void) __attribute__((noreturn));
+
+int foo(int p)
+{
+	if (p == 3)
+		__builtin_unreachable();
+	return p;
+}
+
+/*
+ * check-name: builtin_unreachable0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-start
+foo:
+.L0:
+	<entry-point>
+	seteq.32    %r2 <- %arg1, $3
+	cbr         %r2, .L1, .L3
+
+.L1:
+	unreach
+
+.L3:
+	ret.32      %arg1
+
+
+ * check-output-end
+ */
diff --git a/validation/linear/builtin_unreachable.c b/validation/linear/builtin_unreachable1.c
similarity index 65%
rename from validation/linear/builtin_unreachable.c
rename to validation/linear/builtin_unreachable1.c
index 4f13b892af54..280f853d8a07 100644
--- a/validation/linear/builtin_unreachable.c
+++ b/validation/linear/builtin_unreachable1.c
@@ -1,15 +1,15 @@
-void function_that_never_returns(void);
+extern void die(void);
 
 int foo(int c)
 {
 	if (c)
 		return 1;
-	function_that_never_returns();
+	die();
 	__builtin_unreachable();
 }
 
 /*
- * check-name: __builtin_unreachable()
+ * check-name: builtin_unreachable1
  * check-command: test-linearize -Wno-decl $file
  *
  * check-known-to-fail
@@ -19,13 +19,13 @@ foo:
 	<entry-point>
 	cbr         %arg1, .L3, .L2
 
-.L2:
-	call        function_that_never_returns
-	unreach
-
 .L3:
 	ret.32      $1
 
+.L2:
+	call        die
+	unreach
+
 
  * check-output-end
  */
diff --git a/validation/linear/noreturn-unreachable0.c b/validation/linear/noreturn-unreachable0.c
new file mode 100644
index 000000000000..b76319458e96
--- /dev/null
+++ b/validation/linear/noreturn-unreachable0.c
@@ -0,0 +1,23 @@
+extern void die(void) __attribute__((noreturn));
+
+int foo(void)
+{
+	die();
+	return 0;
+}
+
+/*
+ * check-name: noreturn-unreachable0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-start
+foo:
+.L0:
+	<entry-point>
+	call        die
+	unreach
+
+
+ * check-output-end
+ */
-- 
2.25.1
