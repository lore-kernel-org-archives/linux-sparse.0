From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] add testcases for ignored type attributes
Date: Mon, 22 Jan 2018 07:36:03 +0100
Message-ID: <20180122063605.97737-2-luc.vanoostenryck@gmail.com>
References: <20180122063605.97737-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:41851 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbeAVGgR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Jan 2018 01:36:17 -0500
Received: by mail-wm0-f65.google.com with SMTP id f71so14107712wmf.0
        for <linux-sparse@vger.kernel.org>; Sun, 21 Jan 2018 22:36:17 -0800 (PST)
In-Reply-To: <20180122063605.97737-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, sparse doesn't correctly take in account
type attributes.

Add some test cases for those.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/type-attribute-align.c | 20 ++++++++++++++++++++
 validation/type-attribute-as.c    | 34 ++++++++++++++++++++++++++++++++++
 validation/type-attribute-mod.c   | 22 ++++++++++++++++++++++
 3 files changed, 76 insertions(+)
 create mode 100644 validation/type-attribute-align.c
 create mode 100644 validation/type-attribute-as.c
 create mode 100644 validation/type-attribute-mod.c

diff --git a/validation/type-attribute-align.c b/validation/type-attribute-align.c
new file mode 100644
index 000000000..d56769c44
--- /dev/null
+++ b/validation/type-attribute-align.c
@@ -0,0 +1,20 @@
+#define	__aligned(N)	__attribute__((aligned(N)))
+#define alignof(X)	__alignof__(X)
+
+struct s {
+	short a, b, c;
+} __aligned(2*sizeof(short));
+
+static int fs(void) { return  sizeof(struct s); }
+static int fa(void) { return alignof(struct s); }
+
+void main(void)
+{
+	_Static_assert( sizeof(struct s) == 4 * sizeof(short), "size");
+	_Static_assert(alignof(struct s) == 2 * sizeof(short), "alignment");
+}
+
+/*
+ * check-name: type-attribute-align
+ * check-known-to-fail
+ */
diff --git a/validation/type-attribute-as.c b/validation/type-attribute-as.c
new file mode 100644
index 000000000..375ad4c76
--- /dev/null
+++ b/validation/type-attribute-as.c
@@ -0,0 +1,34 @@
+#define	__user		__attribute__((address_space(1)))
+
+struct s {
+	int i;
+} __user;
+
+
+extern void use0(void *);
+extern void use1(void __user *);
+
+void main(void)
+{
+	struct s s;
+	int i;
+
+	use0(&s);	// KO
+	use0(&i);	// OK
+	use1(&s);	// OK
+	use1(&i);	// KO
+}
+
+/*
+ * check-name: type-attribute-as
+ * check-known-to-fail
+ *
+ * check-error-start
+type-attribute-as.c:16:15: warning: incorrect type in argument 1 (different address spaces)
+type-attribute-as.c:16:15:    expected void *<noident>
+type-attribute-as.c:16:15:    got struct s <asn:1>*<noident>
+type-attribute-as.c:19:15: warning: incorrect type in argument 1 (different address spaces)
+type-attribute-as.c:19:15:    expected void <asn:1>*<noident>
+type-attribute-as.c:19:15:    got int *<noident>
+ * check-error-end
+ */
diff --git a/validation/type-attribute-mod.c b/validation/type-attribute-mod.c
new file mode 100644
index 000000000..0e7b166a4
--- /dev/null
+++ b/validation/type-attribute-mod.c
@@ -0,0 +1,22 @@
+#define	__noderef	__attribute__((noderef))
+
+struct s {
+	int i;
+} __noderef;
+
+
+void main(void)
+{
+	struct s s;
+
+	s.i = 0;
+}
+
+/*
+ * check-name: type-attribute-mod
+ * check-known-to-fail
+ *
+ * check-error-start
+type-attribute-mod.c:12:9: warning: dereference of noderef expression
+ * check-error-end
+ */
-- 
2.16.0

