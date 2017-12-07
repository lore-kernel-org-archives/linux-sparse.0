From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] add more testcases for using addresses in conditionals
Date: Thu,  7 Dec 2017 18:16:11 +0100
Message-ID: <20171207171613.34989-2-luc.vanoostenryck@gmail.com>
References: <20171207171613.34989-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:46409 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756779AbdLGRU4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 7 Dec 2017 12:20:56 -0500
Received: by mail-wm0-f67.google.com with SMTP id r78so14444938wme.5
        for <linux-sparse@vger.kernel.org>; Thu, 07 Dec 2017 09:20:56 -0800 (PST)
In-Reply-To: <20171207171613.34989-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

and unify the existing ones.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 .../{cond-address-array.c => Waddress-array.c}     |   9 +-
 ...cond-address-function.c => Waddress-function.c} |   7 +-
 validation/Waddress-weak.c                         |  25 +++++
 validation/Waddress.c                              | 110 +++++++++++++++++++++
 4 files changed, 142 insertions(+), 9 deletions(-)
 rename validation/{cond-address-array.c => Waddress-array.c} (37%)
 rename validation/{cond-address-function.c => Waddress-function.c} (39%)
 create mode 100644 validation/Waddress-weak.c
 create mode 100644 validation/Waddress.c

diff --git a/validation/cond-address-array.c b/validation/Waddress-array.c
similarity index 37%
rename from validation/cond-address-array.c
rename to validation/Waddress-array.c
index e1d2f87f8..831784548 100644
--- a/validation/cond-address-array.c
+++ b/validation/Waddress-array.c
@@ -15,12 +15,11 @@ int bar(void) {
 }
 
 /*
- * check-name: cond-address-array.c
- * check-command: test-linearize -Wno-decl -Waddress $file
- * check-output-ignore
+ * check-name: Waddress-array
+ * check-command: sparse -Wno-decl -Waddress $file
  *
  * check-error-start
-cond-address-array.c:4:13: warning: the address of an array will always evaluate as true
-cond-address-array.c:12:13: warning: the address of an array will always evaluate as true
+Waddress-array.c:4:13: warning: the address of an array will always evaluate as true
+Waddress-array.c:12:13: warning: the address of an array will always evaluate as true
  * check-error-end
  */
diff --git a/validation/cond-address-function.c b/validation/Waddress-function.c
similarity index 39%
rename from validation/cond-address-function.c
rename to validation/Waddress-function.c
index 9a143a009..fccbe2d89 100644
--- a/validation/cond-address-function.c
+++ b/validation/Waddress-function.c
@@ -8,11 +8,10 @@ int global_function(void)
 }
 
 /*
- * check-name: cond-address-function
- * check-command: test-linearize -Wno-decl -Waddress $file
- * check-output-ignore
+ * check-name: Waddress-function
+ * check-command: sparse -Wno-decl -Waddress $file
  *
  * check-error-start
-cond-address-function.c:5:13: warning: the address of a function will always evaluate as true
+Waddress-function.c:5:13: warning: the address of a function will always evaluate as true
  * check-error-end
  */
diff --git a/validation/Waddress-weak.c b/validation/Waddress-weak.c
new file mode 100644
index 000000000..1fe8d33c8
--- /dev/null
+++ b/validation/Waddress-weak.c
@@ -0,0 +1,25 @@
+extern int var       __attribute__((weak));
+extern int arr[]     __attribute__((weak));
+extern int fun(void) __attribute__((weak));
+
+int test_addr_weak_fun(void)
+{
+	if ( &var) return 1;
+	if (  arr) return 1;
+	if ( &arr) return 1;
+	if (  fun) return 1;
+	if ( &fun) return 1;
+	if (!&var) return 0;
+	if (! arr) return 0;
+	if (!&arr) return 0;
+	if (! fun) return 0;
+	if (!&fun) return 0;
+	return -1;
+}
+
+/*
+ * check-name: Waddress-weak
+ * check-note: Undefined weak symbols (can) have a null address.
+ * check-command: sparse -Wno-decl -Waddress $file
+ * check-known-to-fail
+ */
diff --git a/validation/Waddress.c b/validation/Waddress.c
new file mode 100644
index 000000000..10556c3aa
--- /dev/null
+++ b/validation/Waddress.c
@@ -0,0 +1,110 @@
+extern int fun(void);
+extern int arr[];
+extern int var;
+
+int test_address(int arg, int ptr[])
+{
+
+	if (fun())	return -1;
+	if (var)	return -1;
+	if (arg)	return -1;
+	if (ptr)	return -1;
+
+lab:
+	if (arr)	return 1;
+	if (&arr)	return 1;
+	if (fun)	return 1;
+	if (&fun)	return 1;
+	if (&var)	return 1;
+	if (&arg)	return 1;
+	if (&&lab)	return 1;
+
+	return -1;
+}
+
+int test_address_not(int arg, int ptr[])
+{
+
+	if (!fun())	return -1;
+	if (!var)	return -1;
+	if (!arg)	return -1;
+	if (!ptr)	return -1;
+
+lab:
+	if (!arr)	return 0;
+	if (!&arr)	return 0;
+	if (!fun)	return 0;
+	if (!&fun)	return 0;
+	if (!&var)	return 0;
+	if (!&arg)	return 0;
+	if (!&&lab)	return 0;
+
+	return -1;
+}
+
+int test_address_cmp(int arg, int ptr[])
+{
+	if (fun() == 0)	return -1;
+	if (0 == fun())	return -1;
+	if (var == 0)	return -1;
+	if (0 == var)	return -1;
+	if (arg == 0)	return -1;
+	if (0 == arg)	return -1;
+	if (ptr == 0)	return -1;
+	if (0 == ptr)	return -1;
+
+lab:
+	if (arr == 0)	return 0;
+	if (0 == arr)	return 0;
+	if (&arr == 0)	return 0;
+	if (0 == &arr)	return 0;
+	if (fun == 0)	return 0;
+	if (0 == fun)	return 0;
+	if (&fun == 0)	return 0;
+	if (0 == &fun)	return 0;
+	if (&var == 0)	return 0;
+	if (0 == &var)	return 0;
+	if (&arg == 0)	return 0;
+	if (0 == &arg)	return 0;
+	if (&&lab == 0)	return 0;
+	if (0 == &&lab)	return 0;
+
+	return -1;
+}
+
+/*
+ * check-name: Waddress
+ * check-command: sparse -Wno-decl -Wno-non-pointer-null -Waddress $file
+ * check-known-to-fail
+ *
+ * check-error-start
+Waddress.c:14:13: warning: the address of an array will always evaluate as true
+Waddress.c:15:14: warning: the address of an array will always evaluate as true
+Waddress.c:16:13: warning: the address of a function will always evaluate as true
+Waddress.c:17:14: warning: the address of a function will always evaluate as true
+Waddress.c:18:13: warning: the address of a variable will always evaluate as true
+Waddress.c:19:13: warning: the address of a variable will always evaluate as true
+Waddress.c:20:13: warning: the address of a label will always evaluate as true
+Waddress.c:34:13: warning: the address of an array will always evaluate as true
+Waddress.c:35:13: warning: the address of an array will always evaluate as true
+Waddress.c:36:13: warning: the address of a function will always evaluate as true
+Waddress.c:37:13: warning: the address of a function will always evaluate as true
+Waddress.c:38:13: warning: the address of a variable will always evaluate as true
+Waddress.c:39:13: warning: the address of a variable will always evaluate as true
+Waddress.c:40:13: warning: the address of a label will always evaluate as true
+Waddress.c:57:13: warning: the address of an array will always evaluate as true
+Waddress.c:58:13: warning: the address of an array will always evaluate as true
+Waddress.c:59:13: warning: the address of an array will always evaluate as true
+Waddress.c:60:13: warning: the address of an array will always evaluate as true
+Waddress.c:61:13: warning: the address of a function will always evaluate as true
+Waddress.c:62:13: warning: the address of a function will always evaluate as true
+Waddress.c:63:13: warning: the address of a function will always evaluate as true
+Waddress.c:64:13: warning: the address of a function will always evaluate as true
+Waddress.c:65:13: warning: the address of a variable will always evaluate as true
+Waddress.c:66:13: warning: the address of a variable will always evaluate as true
+Waddress.c:67:13: warning: the address of a variable will always evaluate as true
+Waddress.c:68:13: warning: the address of a variable will always evaluate as true
+Waddress.c:69:13: warning: the address of a label will always evaluate as true
+Waddress.c:70:13: warning: the address of a label will always evaluate as true
+ * check-error-end
+ */
-- 
2.15.0

