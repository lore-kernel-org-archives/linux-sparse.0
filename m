From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/6] testsuite: test modifiers preserved by 'typeof()'
Date: Thu, 24 Nov 2016 18:09:46 +0100
Message-ID: <20161124170947.14379-6-luc.vanoostenryck@gmail.com>
References: <20161124170947.14379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:34887 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757261AbcKXRKF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 24 Nov 2016 12:10:05 -0500
Received: by mail-wj0-f194.google.com with SMTP id f8so3667319wje.2
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2016 09:10:05 -0800 (PST)
In-Reply-To: <20161124170947.14379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Note: address space, 'safe' & 'noderef' have their own test file
because they have others issues or need to be handled differently.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/typeof-addresspace.c |  20 ++++++++
 validation/typeof-mods.c        | 109 ++++++++++++++++++++++++++++++++++++++++
 validation/typeof-noderef.c     |  19 +++++++
 validation/typeof-safe.c        |  23 +++++++++
 4 files changed, 171 insertions(+)
 create mode 100644 validation/typeof-addresspace.c
 create mode 100644 validation/typeof-mods.c
 create mode 100644 validation/typeof-noderef.c
 create mode 100644 validation/typeof-safe.c

diff --git a/validation/typeof-addresspace.c b/validation/typeof-addresspace.c
new file mode 100644
index 00000000..a94f77a3
--- /dev/null
+++ b/validation/typeof-addresspace.c
@@ -0,0 +1,20 @@
+#define	__as		__attribute__((address_space(1)))
+
+static void test_as(void)
+{
+	int __as obj, *ptr;
+	typeof(obj) var = obj;
+	typeof(ptr) ptr2 = ptr;
+	typeof(*ptr) var2 = obj;
+	typeof(*ptr) *ptr3 = ptr;	/* check-should-pass */
+	typeof(obj) *ptr4 = ptr;	/* check-should-pass */
+	obj = obj;
+	ptr = ptr;
+	ptr = &obj;
+	obj = *ptr;
+}
+
+/*
+ * check-name: typeof-addresspace.c
+ * check-known-to-fail
+ */
diff --git a/validation/typeof-mods.c b/validation/typeof-mods.c
new file mode 100644
index 00000000..8c98ab8c
--- /dev/null
+++ b/validation/typeof-mods.c
@@ -0,0 +1,109 @@
+#define	__noderef	__attribute__((noderef))
+#define	__bitwise	__attribute__((bitwise))
+#define	__nocast	__attribute__((nocast))
+#define	__safe		__attribute__((safe))
+
+static void test_spec(void)
+{
+	unsigned int obj, *ptr;
+	typeof(obj) var = obj;
+	typeof(ptr) ptr2 = ptr;
+	typeof(*ptr) var2 = obj;
+	typeof(*ptr) *ptr3 = ptr;
+	typeof(obj) *ptr4 = ptr;
+	obj = obj;
+	ptr = ptr;
+	ptr = &obj;
+	obj = *ptr;
+}
+
+static void test_const(void)
+{
+	const int obj, *ptr;
+	typeof(obj) var = obj;
+	typeof(ptr) ptr2 = ptr;
+	typeof(*ptr) var2 = obj;
+	typeof(*ptr) *ptr3 = ptr;
+	typeof(obj) *ptr4 = ptr;
+	ptr = ptr;
+	ptr = &obj;
+}
+
+static void test_volatile(void)
+{
+	volatile int obj, *ptr;
+	typeof(obj) var = obj;
+	typeof(ptr) ptr2 = ptr;
+	typeof(*ptr) var2 = obj;
+	typeof(*ptr) *ptr3 = ptr;
+	typeof(obj) *ptr4 = ptr;
+	obj = obj;
+	ptr = ptr;
+	ptr = &obj;
+	obj = *ptr;
+}
+
+static void test_bitwise(void)
+{
+	typedef int __bitwise type_t;
+	type_t obj, *ptr;
+	typeof(obj) var = obj;
+	typeof(ptr) ptr2 = ptr;
+	typeof(*ptr) var2 = obj;
+	typeof(*ptr) *ptr3 = ptr;
+	typeof(obj) *ptr4 = ptr;
+	obj = obj;
+	ptr = ptr;
+	ptr = &obj;
+	obj = *ptr;
+}
+
+static void test_static(void)
+{
+	static int obj, *ptr;
+	typeof(obj) var = obj;
+	typeof(ptr) ptr2 = ptr;
+	typeof(*ptr) var2 = obj;
+	typeof(*ptr) *ptr3 = ptr;
+	typeof(obj) *ptr4 = ptr;
+	obj = obj;
+	ptr = ptr;
+	ptr = &obj;
+	obj = *ptr;
+}
+
+static void test_tls(void)
+{
+	__thread int obj, *ptr;
+	typeof(obj) var = obj;
+	typeof(ptr) ptr2 = ptr;
+	typeof(*ptr) var2 = obj;
+	typeof(*ptr) *ptr3 = ptr;
+	typeof(obj) *ptr4 = ptr;
+	obj = obj;
+	ptr = ptr;
+	ptr = &obj;
+	obj = *ptr;
+}
+
+static void test_nocast(void)
+{
+	int __nocast obj, *ptr;
+	typeof(obj) var = obj;
+	typeof(ptr) ptr2 = ptr;
+	typeof(*ptr) var2 = obj;
+	typeof(*ptr) *ptr3 = ptr;
+	typeof(obj) *ptr4 = ptr;
+	obj = obj;
+	ptr = ptr;
+	ptr = &obj;
+	obj = *ptr;
+}
+
+/*
+ * check-name: typeof-mods
+ * check-known-to-fail
+ *
+ * check-error-start
+ * check-error-end
+ */
diff --git a/validation/typeof-noderef.c b/validation/typeof-noderef.c
new file mode 100644
index 00000000..e95a53ad
--- /dev/null
+++ b/validation/typeof-noderef.c
@@ -0,0 +1,19 @@
+#define	__noderef	__attribute__((noderef))
+
+static void test_noderef(void)
+{
+	int __noderef obj, *ptr;
+	typeof(ptr) ptr2 = ptr;
+	typeof(*ptr) *ptr3 = ptr;
+	typeof(obj) *ptr4 = ptr;
+	ptr = ptr;
+	ptr = &obj;
+}
+
+/*
+ * check-name: typeof-noderef
+ * check-known-to-fail
+ *
+ * check-error-start
+ * check-error-end
+ */
diff --git a/validation/typeof-safe.c b/validation/typeof-safe.c
new file mode 100644
index 00000000..614863fb
--- /dev/null
+++ b/validation/typeof-safe.c
@@ -0,0 +1,23 @@
+#define	__safe		__attribute__((safe))
+
+static void test_safe(void)
+{
+	int __safe obj, *ptr;
+	typeof(obj) var = obj;
+	typeof(ptr) ptr2 = ptr;
+	typeof(*ptr) var2 = obj;
+	typeof(*ptr) *ptr3 = ptr;
+	typeof(obj) *ptr4 = ptr;
+	obj = obj;
+	ptr = ptr;
+	ptr = &obj;
+	obj = *ptr;
+}
+
+/*
+ * check-name: typeof-safe
+ * check-known-to-fail
+ *
+ * check-error-start
+ * check-error-end
+ */
-- 
2.10.2

