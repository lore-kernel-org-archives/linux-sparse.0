From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/6] testsuite: test modifiers preserved by '&' operator
Date: Thu, 24 Nov 2016 18:09:45 +0100
Message-ID: <20161124170947.14379-5-luc.vanoostenryck@gmail.com>
References: <20161124170947.14379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34561 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756864AbcKXRKE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 24 Nov 2016 12:10:04 -0500
Received: by mail-wm0-f66.google.com with SMTP id g23so5512389wme.1
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2016 09:10:04 -0800 (PST)
In-Reply-To: <20161124170947.14379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/ptr-inherit.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 validation/ptr-inherit.c

diff --git a/validation/ptr-inherit.c b/validation/ptr-inherit.c
new file mode 100644
index 00000000..58524a71
--- /dev/null
+++ b/validation/ptr-inherit.c
@@ -0,0 +1,80 @@
+#define	__user		__attribute__((address_space(1)))
+#define	__noderef	__attribute__((noderef))
+#define	__bitwise	__attribute__((bitwise))
+#define	__nocast	__attribute__((nocast))
+#define	__safe		__attribute__((safe))
+
+
+/* Should be inherited? */
+static void test_const(void)
+{
+	const int o;
+	int *p = &o;			/* check-should-fail */
+}
+
+static void test_volatile(void)
+{
+	volatile int o;
+	int *p = &o;			/* check-should-fail */
+}
+
+static void test_noderef(void)
+{
+	int __noderef o;
+	int *p = &o;			/* check-should-fail */
+}
+
+static void test_bitwise(void)
+{
+	int __bitwise o;
+	int *p = &o;			/* check-should-fail */
+}
+
+static void test_user(void)
+{
+	int __user o;
+	int *p = &o;			/* check-should-fail */
+}
+
+static void test_nocast(void)
+{
+	int __nocast o;
+	int __nocast *p = &o;		/* check-should-pass */
+}
+
+/* Should be ignored? */
+static void test_static(void)
+{
+	/* storage is not inherited */
+	static int o;
+	int *p = &o;			/* check-should-pass */
+}
+
+static void test_tls(void)
+{
+	/* storage is not inherited */
+	static __thread int o;
+	int *p = &o;			/* check-should-pass */
+}
+
+/*
+ * check-name: ptr-inherit.c
+ *
+ * check-error-start
+ptr-inherit.c:12:19: warning: incorrect type in initializer (different modifiers)
+ptr-inherit.c:12:19:    expected int *p
+ptr-inherit.c:12:19:    got int const *<noident>
+ptr-inherit.c:18:19: warning: incorrect type in initializer (different modifiers)
+ptr-inherit.c:18:19:    expected int *p
+ptr-inherit.c:18:19:    got int volatile *<noident>
+ptr-inherit.c:24:19: warning: incorrect type in initializer (different modifiers)
+ptr-inherit.c:24:19:    expected int *p
+ptr-inherit.c:24:19:    got int [noderef] *<noident>
+ptr-inherit.c:30:19: warning: incorrect type in initializer (different base types)
+ptr-inherit.c:30:19:    expected int *p
+ptr-inherit.c:30:19:    got restricted int *<noident>
+ptr-inherit.c:36:19: warning: incorrect type in initializer (different address spaces)
+ptr-inherit.c:36:19:    expected int *p
+ptr-inherit.c:36:19:    got int <asn:1>*<noident>
+ * check-error-end
+ */
-- 
2.10.2

