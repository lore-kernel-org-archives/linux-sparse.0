From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/8] add testcases for duplicated warning about invalid types
Date: Fri,  2 Feb 2018 13:17:28 +0100
Message-ID: <20180202121735.39621-2-luc.vanoostenryck@gmail.com>
References: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37717 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeBBMTt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Feb 2018 07:19:49 -0500
Received: by mail-wm0-f67.google.com with SMTP id v71so11984299wmv.2
        for <linux-sparse@vger.kernel.org>; Fri, 02 Feb 2018 04:19:48 -0800 (PST)
In-Reply-To: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Once a invalid type is present in some sub-expression,
every upper level of the expression has an invalid type
but we should only warn about the innermost/root error.

However, this is not currently the case and invalid types
can create duplicated warnings, sometimes even a succession
of such warning.

Add some testcases to catch such situations.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/bad-type-twice0.c | 14 ++++++++++++++
 validation/bad-type-twice1.c | 17 +++++++++++++++++
 validation/bad-type-twice2.c | 19 +++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 validation/bad-type-twice0.c
 create mode 100644 validation/bad-type-twice1.c
 create mode 100644 validation/bad-type-twice2.c

diff --git a/validation/bad-type-twice0.c b/validation/bad-type-twice0.c
new file mode 100644
index 000000000..2dbc91b03
--- /dev/null
+++ b/validation/bad-type-twice0.c
@@ -0,0 +1,14 @@
+static int foo(a)
+{
+	return a ? : 1;
+}
+
+/*
+ * check-name: bad-type-twice0
+ * check-known-to-fail
+ *
+ * check-error-start
+bad-type-twice0.c:3:16: error: incorrect type in conditional
+bad-type-twice0.c:3:16:    got incomplete type a
+ * check-error-end
+ */
diff --git a/validation/bad-type-twice1.c b/validation/bad-type-twice1.c
new file mode 100644
index 000000000..2f4e2838f
--- /dev/null
+++ b/validation/bad-type-twice1.c
@@ -0,0 +1,17 @@
+static unsigned long foo(unsigned long val, void *ref)
+{
+	if (val >= ref)
+		val = 0;
+	return val;
+}
+
+/*
+ * check-name: bad-type-twice1
+ * check-known-to-fail
+ *
+ * check-error-start
+bad-type-twice1.c:3:17: error: incompatible types for operation (>=)
+bad-type-twice1.c:3:17:    left side has type unsigned long [unsigned] val
+bad-type-twice1.c:3:17:    right side has type void *ref
+ * check-error-end
+ */
diff --git a/validation/bad-type-twice2.c b/validation/bad-type-twice2.c
new file mode 100644
index 000000000..916e82028
--- /dev/null
+++ b/validation/bad-type-twice2.c
@@ -0,0 +1,19 @@
+extern type_t fun(int);
+
+int foo(int x, int y)
+{
+	return ((int)fun(y)) + x;
+}
+
+/*
+ * check-name: bad-type-twice2
+ * check-known-to-fail
+ *
+ * check-error-start
+bad-type-twice2.c:1:8: warning: 'type_t' has implicit type
+bad-type-twice2.c:1:15: error: Expected ; at end of declaration
+bad-type-twice2.c:1:15: error: got fun
+bad-type-twice2.c:5:22: error: undefined identifier 'fun'
+bad-type-twice2.c:5:18: error: cast from unknown type
+ * check-error-end
+ */
-- 
2.16.0

