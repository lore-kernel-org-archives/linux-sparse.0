From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] add testcases for unexamined base type
Date: Thu, 21 Dec 2017 01:30:16 +0100
Message-ID: <20171221003017.57211-2-luc.vanoostenryck@gmail.com>
References: <20171221003017.57211-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:46454 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756575AbdLUAaX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Dec 2017 19:30:23 -0500
Received: by mail-wm0-f65.google.com with SMTP id r78so13073089wme.5
        for <linux-sparse@vger.kernel.org>; Wed, 20 Dec 2017 16:30:22 -0800 (PST)
In-Reply-To: <20171221003017.57211-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

evaluate_dereference() lacks an explicit examination of the
base type. Most of the time, the base type has already been
examined via another path, but in some case, it's not.

The symptom here is the dereferenced value having a null size.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/linear/deref-ptr-ptr.c        | 27 +++++++++++++++++++++++
 validation/linear/unexamined-base-type.c | 37 ++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 validation/linear/deref-ptr-ptr.c
 create mode 100644 validation/linear/unexamined-base-type.c

diff --git a/validation/linear/deref-ptr-ptr.c b/validation/linear/deref-ptr-ptr.c
new file mode 100644
index 000000000..022595d78
--- /dev/null
+++ b/validation/linear/deref-ptr-ptr.c
@@ -0,0 +1,27 @@
+char *foo(char **pfmt)
+{
+	return ++*pfmt;
+}
+
+/*
+ * check-name: deref-ptr-ptr
+ * check-command: test-linearize -m64 -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-excludes: load[^.]
+ * check-output-contains: load\.
+ * check-output-excludes: store[^.]
+ * check-output-contains: store\.
+ *
+ * check-output-start
+foo:
+.L0:
+	<entry-point>
+	load.64     %r2 <- 0[%arg1]
+	add.64      %r3 <- %r2, $1
+	store.64    %r3 -> 0[%arg1]
+	ret.64      %r3
+
+
+ * check-output-end
+ */
diff --git a/validation/linear/unexamined-base-type.c b/validation/linear/unexamined-base-type.c
new file mode 100644
index 000000000..a138ba132
--- /dev/null
+++ b/validation/linear/unexamined-base-type.c
@@ -0,0 +1,37 @@
+# define __force	__attribute__((force))
+
+struct s {
+	int a;
+};
+
+static int foo(struct s *s)
+{
+	return (*((typeof(s->a) __force *) &s->a)) & 1;
+}
+
+static void bar(struct s *d, struct s *s1, struct s *s2)
+{
+	*d = *s1, *d = *s2;
+}
+
+/*
+ * check-name: unexamined base type
+ * check-command: test-linearize -Wno-decl $file
+ * check-description:
+ *	Test case for missing examine in evaluate_dereference()'s
+ *	target base type. In this case, the loaded value has a
+ *	a null size, giving the wrongly generated code for foo():
+ *		ptrcast.64  %r3 <- (64) %arg1
+ *		load        %r4 <- 0[%r3]
+ *		    ^^^				!! WRONG !!
+ *		cast.32     %r5 <- (0) %r4
+ *		                   ^^^		!! WRONG !!
+ *		and.32      %r6 <- %r5, $1
+ *		ret.32      %r6
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: load[^.]
+ * check-output-excludes: cast\..*(0)
+ * check-output-excludes: store[^.]
+ */
-- 
2.15.0

