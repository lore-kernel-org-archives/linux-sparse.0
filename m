From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] add testcase for mem2reg/SSA conversion
Date: Sat, 16 Sep 2017 11:01:47 +0200
Message-ID: <20170916090147.38083-4-luc.vanoostenryck@gmail.com>
References: <20170916090147.38083-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34778 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdIPJB6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 16 Sep 2017 05:01:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id i131so4597994wma.1
        for <linux-sparse@vger.kernel.org>; Sat, 16 Sep 2017 02:01:58 -0700 (PDT)
In-Reply-To: <20170916090147.38083-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/mem2reg/address-used00.c      | 19 +++++++++++++++++++
 validation/mem2reg/broken-phi02.c        | 28 ++++++++++++++++++++++++++++
 validation/mem2reg/broken-phi03.c        | 29 +++++++++++++++++++++++++++++
 validation/mem2reg/cond-expr.c           | 13 +++++++++++++
 validation/mem2reg/cond-expr5.c          | 18 ++++++++++++++++++
 validation/mem2reg/global-direct-undef.c | 23 +++++++++++++++++++++++
 validation/mem2reg/global-direct.c       | 23 +++++++++++++++++++++++
 validation/mem2reg/global-loop.c         | 20 ++++++++++++++++++++
 validation/mem2reg/global-noalias.c      | 21 +++++++++++++++++++++
 validation/mem2reg/global-pointer.c      | 26 ++++++++++++++++++++++++++
 validation/mem2reg/if-direct.c           | 19 +++++++++++++++++++
 validation/mem2reg/if-pointer.c          | 21 +++++++++++++++++++++
 validation/mem2reg/init-global-array.c   | 17 +++++++++++++++++
 validation/mem2reg/init-local-array.c    | 25 +++++++++++++++++++++++++
 validation/mem2reg/init-local-union0.c   | 18 ++++++++++++++++++
 validation/mem2reg/init-local-union1.c   | 32 ++++++++++++++++++++++++++++++++
 validation/mem2reg/init-local.c          | 27 +++++++++++++++++++++++++++
 validation/mem2reg/loop00.c              | 16 ++++++++++++++++
 validation/mem2reg/loop01-global.c       | 18 ++++++++++++++++++
 validation/mem2reg/loop02-array.c        | 23 +++++++++++++++++++++++
 validation/mem2reg/loop02-global.c       | 22 ++++++++++++++++++++++
 validation/mem2reg/loop02-local.c        | 23 +++++++++++++++++++++++
 validation/mem2reg/loop02-pointer.c      | 23 +++++++++++++++++++++++
 validation/mem2reg/quadra00.c            | 28 ++++++++++++++++++++++++++++
 validation/mem2reg/short-load.c          | 29 +++++++++++++++++++++++++++++
 validation/mem2reg/undef00.c             | 14 ++++++++++++++
 validation/mem2reg/volatile-store00.c    | 27 +++++++++++++++++++++++++++
 validation/optim/volatile-store00.c      | 28 ++++++++++++++++++++++++++++
 28 files changed, 630 insertions(+)
 create mode 100644 validation/mem2reg/address-used00.c
 create mode 100644 validation/mem2reg/broken-phi02.c
 create mode 100644 validation/mem2reg/broken-phi03.c
 create mode 100644 validation/mem2reg/cond-expr.c
 create mode 100644 validation/mem2reg/cond-expr5.c
 create mode 100644 validation/mem2reg/global-direct-undef.c
 create mode 100644 validation/mem2reg/global-direct.c
 create mode 100644 validation/mem2reg/global-loop.c
 create mode 100644 validation/mem2reg/global-noalias.c
 create mode 100644 validation/mem2reg/global-pointer.c
 create mode 100644 validation/mem2reg/if-direct.c
 create mode 100644 validation/mem2reg/if-pointer.c
 create mode 100644 validation/mem2reg/init-global-array.c
 create mode 100644 validation/mem2reg/init-local-array.c
 create mode 100644 validation/mem2reg/init-local-union0.c
 create mode 100644 validation/mem2reg/init-local-union1.c
 create mode 100644 validation/mem2reg/init-local.c
 create mode 100644 validation/mem2reg/loop00.c
 create mode 100644 validation/mem2reg/loop01-global.c
 create mode 100644 validation/mem2reg/loop02-array.c
 create mode 100644 validation/mem2reg/loop02-global.c
 create mode 100644 validation/mem2reg/loop02-local.c
 create mode 100644 validation/mem2reg/loop02-pointer.c
 create mode 100644 validation/mem2reg/quadra00.c
 create mode 100644 validation/mem2reg/short-load.c
 create mode 100644 validation/mem2reg/undef00.c
 create mode 100644 validation/mem2reg/volatile-store00.c
 create mode 100644 validation/optim/volatile-store00.c

diff --git a/validation/mem2reg/address-used00.c b/validation/mem2reg/address-used00.c
new file mode 100644
index 000000000..f2d6c87bd
--- /dev/null
+++ b/validation/mem2reg/address-used00.c
@@ -0,0 +1,19 @@
+int foo(int **g, int j)
+{
+	int i = 1;
+	int *a;
+	int **p;
+
+	a = &i;
+	p = &a;
+	*p[0] = 0;
+	return i;
+}
+
+/*
+ * check-name: address-used00
+ * check-command: test-linearize -Wno-decl -fdump-ir=final $file
+ * check-known-to-fail
+ * check-output-ignore
+ * check-output-excludes: ret\\..* \\$1
+ */
diff --git a/validation/mem2reg/broken-phi02.c b/validation/mem2reg/broken-phi02.c
new file mode 100644
index 000000000..69776e0f1
--- /dev/null
+++ b/validation/mem2reg/broken-phi02.c
@@ -0,0 +1,28 @@
+int foo(int a, int b)
+{
+	int x;
+	int i;
+
+	if (a)
+		i = 0;
+	else
+		i = 1;
+
+	x = 0;
+	if (b)
+		x = i;
+	return x;
+}
+
+/*
+ * check-name: broken-phi02
+ * check-description:
+ *	This is an indirect test to check correctness of phi-node placement.
+ *	The misplaced phi-node for 'i' (not at the meet point but where 'i'
+ *	is used) causes a missed select-conversion at later stage.
+ *
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ * check-output-ignore
+ * check-output-contains: select\\.
+ */
diff --git a/validation/mem2reg/broken-phi03.c b/validation/mem2reg/broken-phi03.c
new file mode 100644
index 000000000..58b479791
--- /dev/null
+++ b/validation/mem2reg/broken-phi03.c
@@ -0,0 +1,29 @@
+int foo(int a, int b)
+{
+	int x;
+	int i;
+
+	switch (a) {
+	case  0: i = 0; break;
+	case  1: i = 1; break;
+	default: i = -1; break;
+	}
+
+	x = 0;
+	if (b)
+		x = i;
+	return x;
+}
+
+/*
+ * check-name: broken-phi03
+ * check-description:
+ *	This is an indirect test to check correctness of phi-node placement.
+ *	The misplaced phi-node for 'i' (not at the meet point but where 'i'
+ *	is used) causes a missed select-conversion at later stage.
+ *
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ * check-output-ignore
+ * check-output-contains: select\\.
+ */
diff --git a/validation/mem2reg/cond-expr.c b/validation/mem2reg/cond-expr.c
new file mode 100644
index 000000000..f38564ef8
--- /dev/null
+++ b/validation/mem2reg/cond-expr.c
@@ -0,0 +1,13 @@
+int fun(int);
+
+int foo(int a, int b, int c)
+{
+	return a ? fun(b) : fun(c);
+}
+
+/*
+ * check-name: cond-expr
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-pattern(2): phi\\.
+ */
diff --git a/validation/mem2reg/cond-expr5.c b/validation/mem2reg/cond-expr5.c
new file mode 100644
index 000000000..6c1e1c34d
--- /dev/null
+++ b/validation/mem2reg/cond-expr5.c
@@ -0,0 +1,18 @@
+int foo(int p, int q, int a)
+{
+	if (p)
+		a = 0;
+	if (q)
+		a = 1;
+
+	return a;
+}
+
+/*
+ * check-name: cond-expr5
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-excludes: load\\.
+ * check-output-excludes: store\\.
+ * check-output-pattern(2): phi\\.
+ */
diff --git a/validation/mem2reg/global-direct-undef.c b/validation/mem2reg/global-direct-undef.c
new file mode 100644
index 000000000..34960e74d
--- /dev/null
+++ b/validation/mem2reg/global-direct-undef.c
@@ -0,0 +1,23 @@
+int a, c, d;
+
+int foo(void)
+{
+	int b, e;
+	if (a)
+		b = c;
+	else
+		b = d;
+	if (c)
+		a = b;
+	if (b)
+		e = a;
+	return e;
+}
+
+/*
+ * check-name: global direct undef
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-pattern(4,5): load\\.
+ * check-output-pattern(1): store\\.
+ */
diff --git a/validation/mem2reg/global-direct.c b/validation/mem2reg/global-direct.c
new file mode 100644
index 000000000..ea5d42dcf
--- /dev/null
+++ b/validation/mem2reg/global-direct.c
@@ -0,0 +1,23 @@
+int a, c, d;
+
+int foo(void)
+{
+	int b, e = 0;
+	if (a)
+		b = c;
+	else
+		b = d;
+	if (c)
+		a = b;
+	if (b)
+		e = a;
+	return e;
+}
+
+/*
+ * check-name: global direct
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-pattern(4,5): load\\.
+ * check-output-pattern(1): store\\.
+ */
diff --git a/validation/mem2reg/global-loop.c b/validation/mem2reg/global-loop.c
new file mode 100644
index 000000000..a232f7edf
--- /dev/null
+++ b/validation/mem2reg/global-loop.c
@@ -0,0 +1,20 @@
+struct s {
+	int c;
+	int a[];
+} s;
+int f;
+
+void fun(void);
+void foo(void)
+{
+	for (f = 1;;)
+		if (s.a[f])
+			fun();
+}
+
+/*
+ * check-name: global var as loop index
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-contains: load\\..*\\[f\\]
+ */
diff --git a/validation/mem2reg/global-noalias.c b/validation/mem2reg/global-noalias.c
new file mode 100644
index 000000000..b78b51174
--- /dev/null
+++ b/validation/mem2reg/global-noalias.c
@@ -0,0 +1,21 @@
+int a, b, c, d, e;
+
+void foo(void)
+{
+	if (a)
+		b = c;
+	else
+		b = d;
+	if (c)
+		a = b;
+	if (b)
+		e = a;
+}
+
+/*
+ * check-name: global no-alias
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-pattern(4,7): load\\.
+ * check-output-pattern(4): store\\.
+ */
diff --git a/validation/mem2reg/global-pointer.c b/validation/mem2reg/global-pointer.c
new file mode 100644
index 000000000..d312577a3
--- /dev/null
+++ b/validation/mem2reg/global-pointer.c
@@ -0,0 +1,26 @@
+int a, c, d;
+
+int foo_ptr(void)
+{
+	int b, *bp = &b;
+	int e, *ep = &e;
+
+	if (a)
+		*bp = c;
+	else
+		*bp = d;
+	if (c)
+		a = *bp;
+	if (b)
+		e = a;
+	return e;
+}
+
+/*
+ * check-name: global pointer
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-known-to-fail
+ * check-output-ignore
+ * check-output-pattern(4,5): load\\.
+ * check-output-pattern(3): store\\.
+ */
diff --git a/validation/mem2reg/if-direct.c b/validation/mem2reg/if-direct.c
new file mode 100644
index 000000000..1b5a07ccd
--- /dev/null
+++ b/validation/mem2reg/if-direct.c
@@ -0,0 +1,19 @@
+int foo(int c, int a, int b)
+{
+	int l;
+
+	if (c)
+		l = a;
+	else
+		l = b;
+
+	return l;
+}
+
+/*
+ * check-name: if-then-else direct
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-excludes: load\\.
+ * check-output-contains: phi\\.
+ */
diff --git a/validation/mem2reg/if-pointer.c b/validation/mem2reg/if-pointer.c
new file mode 100644
index 000000000..acfceb718
--- /dev/null
+++ b/validation/mem2reg/if-pointer.c
@@ -0,0 +1,21 @@
+int foo(int c, int a, int b)
+{
+	int l, *p = &l;
+
+	if (c)
+		*p = a;
+	else
+		*p = b;
+
+	return l + *p;
+}
+
+/*
+ * check-name: if-then-else pointer
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-known-to-fail
+ * check-output-ignore
+ * check-output-excludes: load\\.
+ * check-output-excludes: store\\.
+ * check-output-contains: phi\\.
+ */
diff --git a/validation/mem2reg/init-global-array.c b/validation/mem2reg/init-global-array.c
new file mode 100644
index 000000000..aea4135ae
--- /dev/null
+++ b/validation/mem2reg/init-global-array.c
@@ -0,0 +1,17 @@
+struct {
+	int a[2];
+} s;
+
+int sarray(void)
+{
+	s.a[1] = 1;
+	return s.a[1];
+}
+
+/*
+ * check-name: init global array
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-excludes: load\\.
+ * check-output-pattern(1): store\\.
+ */
diff --git a/validation/mem2reg/init-local-array.c b/validation/mem2reg/init-local-array.c
new file mode 100644
index 000000000..2ac53bc77
--- /dev/null
+++ b/validation/mem2reg/init-local-array.c
@@ -0,0 +1,25 @@
+int array(void)
+{
+	int a[2];
+
+	a[1] = 1;
+	return a[1];
+}
+
+int sarray(void)
+{
+	struct {
+		int a[2];
+	} s;
+
+	s.a[1] = 1;
+	return s.a[1];
+}
+
+/*
+ * check-name: init local array
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-excludes: load\\.
+ * check-output-excludes: store\\.
+ */
diff --git a/validation/mem2reg/init-local-union0.c b/validation/mem2reg/init-local-union0.c
new file mode 100644
index 000000000..3a57e781f
--- /dev/null
+++ b/validation/mem2reg/init-local-union0.c
@@ -0,0 +1,18 @@
+double uintfloat(void)
+{
+	union {
+		int a;
+		double f;
+	} s;
+
+	s.a = 1;
+	return s.f;
+}
+
+/*
+ * check-name: init-local union 0
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-pattern(1): store\\.32
+ * check-output-pattern(1): load\\.64
+ */
diff --git a/validation/mem2reg/init-local-union1.c b/validation/mem2reg/init-local-union1.c
new file mode 100644
index 000000000..925b0a737
--- /dev/null
+++ b/validation/mem2reg/init-local-union1.c
@@ -0,0 +1,32 @@
+double uintfloat(void)
+{
+	union {
+		int a;
+		double f;
+	} s;
+
+	s.a = 1;
+	return s.f;
+}
+
+
+int uarray(void)
+{
+	union {
+		double d;
+		int a[2];
+	} s;
+
+	s.d = 1;
+	return s.a[0];
+}
+
+/*
+ * check-name: init-local union 1
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-pattern(1): store\\.32
+ * check-output-pattern(1): load\\.64
+ * check-output-pattern(1): store\\.64
+ * check-output-pattern(1): load\\.32
+ */
diff --git a/validation/mem2reg/init-local.c b/validation/mem2reg/init-local.c
new file mode 100644
index 000000000..d51c9247a
--- /dev/null
+++ b/validation/mem2reg/init-local.c
@@ -0,0 +1,27 @@
+int ssimple(void)
+{
+	struct {
+		int a;
+	} s;
+
+	s.a = 1;
+	return s.a;
+}
+
+double sdouble(void)
+{
+	struct {
+		double a;
+	} s;
+
+	s.a = 1.23;
+	return s.a;
+}
+
+/*
+ * check-name: init-local
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-excludes: load\\.
+ * check-output-excludes: store\\.
+ */
diff --git a/validation/mem2reg/loop00.c b/validation/mem2reg/loop00.c
new file mode 100644
index 000000000..de33d9f64
--- /dev/null
+++ b/validation/mem2reg/loop00.c
@@ -0,0 +1,16 @@
+int loop00(int n)
+{
+	int i, r = 0;
+
+	for (i = 1; i <= n; ++i)
+		r += i;
+	return r;
+}
+
+/*
+ * check-name: loop00
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-excludes: store\\.
+ * check-output-excludes: load\\.
+ */
diff --git a/validation/mem2reg/loop01-global.c b/validation/mem2reg/loop01-global.c
new file mode 100644
index 000000000..b67981378
--- /dev/null
+++ b/validation/mem2reg/loop01-global.c
@@ -0,0 +1,18 @@
+extern int g;
+
+void fun(void);
+void loop01(void)
+{
+	int i;
+	for (i = 0; i <= 2;)
+		if (g)
+			fun();
+}
+
+/*
+ * check-name: loop01 global
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-excludes: load\\..*\\[i\\]
+ * check-output-contains: load\\..*\\[g\\]
+ */
diff --git a/validation/mem2reg/loop02-array.c b/validation/mem2reg/loop02-array.c
new file mode 100644
index 000000000..13b0aeaf9
--- /dev/null
+++ b/validation/mem2reg/loop02-array.c
@@ -0,0 +1,23 @@
+
+
+int foo(int i[])
+{
+	int j = 1;
+	i[0] = 6;
+
+	do {
+		if (i[0] != 6)
+			i[0]++;
+		i[0]++;
+	} while (i[0] != j);
+
+	return j;
+}
+
+/*
+ * check-name: loop02 array
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-pattern(0,4): load\\.
+ * check-output-pattern(1,3): store\\.
+ */
diff --git a/validation/mem2reg/loop02-global.c b/validation/mem2reg/loop02-global.c
new file mode 100644
index 000000000..a0a8b42b0
--- /dev/null
+++ b/validation/mem2reg/loop02-global.c
@@ -0,0 +1,22 @@
+int i;
+
+int foo(void)
+{
+	int j = 1;
+	i = 6;
+
+	do {
+		if (i != 6)
+			i++;
+		i++;
+	} while (i != j);
+
+	return j;
+}
+
+/*
+ * check-name: loop02 global
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-excludes: load\\.
+ */
diff --git a/validation/mem2reg/loop02-local.c b/validation/mem2reg/loop02-local.c
new file mode 100644
index 000000000..a1bd602b7
--- /dev/null
+++ b/validation/mem2reg/loop02-local.c
@@ -0,0 +1,23 @@
+
+
+int foo(void)
+{
+	int j = 1;
+	int i = 6;
+
+	do {
+		if (i != 6)
+			i++;
+		i++;
+	} while (i != j);
+
+	return j;
+}
+
+/*
+ * check-name: loop02 pointer
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ *
+ * check-output-ignore
+ * check-output-excludes: load\\.
+ */
diff --git a/validation/mem2reg/loop02-pointer.c b/validation/mem2reg/loop02-pointer.c
new file mode 100644
index 000000000..fdb0a8fb5
--- /dev/null
+++ b/validation/mem2reg/loop02-pointer.c
@@ -0,0 +1,23 @@
+
+
+int foo(int *i)
+{
+	int j = 1;
+	*i = 6;
+
+	do {
+		if (*i != 6)
+			(*i)++;
+		(*i)++;
+	} while (*i != j);
+
+	return j;
+}
+
+/*
+ * check-name: loop02 pointer
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-pattern(0,4): load\\.
+ * check-output-pattern(1,3): store\\.
+ */
diff --git a/validation/mem2reg/quadra00.c b/validation/mem2reg/quadra00.c
new file mode 100644
index 000000000..63b489c98
--- /dev/null
+++ b/validation/mem2reg/quadra00.c
@@ -0,0 +1,28 @@
+#define	TEST(N)			\
+	do {			\
+		d = b + a[N];	\
+		if (d < b)	\
+			c++;	\
+		b = d;		\
+	} while (0)
+
+int foo(int *a, int b, int c)
+{
+	int d;
+
+	TEST(0);
+	TEST(1);
+	TEST(2);
+
+	return d + c;
+}
+
+/*
+ * check-name: quadratic phisrc
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ * check-output-ignore
+ * check-output-excludes: phi\\..*, .*, .*
+ * check-output-excludes: phi\\..*, .*, .*, .*
+ * check-output-pattern(6): phisrc\\.
+ */
diff --git a/validation/mem2reg/short-load.c b/validation/mem2reg/short-load.c
new file mode 100644
index 000000000..c4b4dc4be
--- /dev/null
+++ b/validation/mem2reg/short-load.c
@@ -0,0 +1,29 @@
+#ifdef __SIZEOF_INT__ == 4
+typedef unsigned int u32;
+#endif
+#ifdef __SIZEOF_SHORT__ == 2
+typedef unsigned short u16;
+#endif
+
+
+union u {
+	u32	a;
+	u16	b;
+};
+
+void bar(u16, union u);
+
+void foo(u16 val)
+{
+	union u u;
+
+	u.b = val;
+	bar(u.b, u);
+}
+
+/*
+ * check-name: short-load
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-contains: load\\.32
+ */
diff --git a/validation/mem2reg/undef00.c b/validation/mem2reg/undef00.c
new file mode 100644
index 000000000..ba9ba915c
--- /dev/null
+++ b/validation/mem2reg/undef00.c
@@ -0,0 +1,14 @@
+void bad0(void)
+{
+	int *a;
+	*a++;
+}
+
+/*
+ * check-name: undef00
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-known-to-fail
+ * check-output-ignore
+ * check-output-pattern(1): load\\.
+ * check-output-pattern(1): load\\..*\\[UNDEF\\]
+ */
diff --git a/validation/mem2reg/volatile-store00.c b/validation/mem2reg/volatile-store00.c
new file mode 100644
index 000000000..d565037ac
--- /dev/null
+++ b/validation/mem2reg/volatile-store00.c
@@ -0,0 +1,27 @@
+void foo(volatile int *p)
+{
+	*p = 0;
+	*p = 0;
+}
+
+void bar(void)
+{
+	extern volatile int i;
+	i = 0;
+	i = 0;
+}
+
+
+void baz(void)
+{
+	volatile int i;
+	i = 0;
+	i = 0;
+}
+
+/*
+ * check-name: keep volatile stores
+ * check-command: test-linearize -Wno-decl -fdump-ir=mem2reg $file
+ * check-output-ignore
+ * check-output-pattern(1,6): store\\.
+ */
diff --git a/validation/optim/volatile-store00.c b/validation/optim/volatile-store00.c
new file mode 100644
index 000000000..0b6db1d24
--- /dev/null
+++ b/validation/optim/volatile-store00.c
@@ -0,0 +1,28 @@
+void foo(volatile int *p)
+{
+	*p = 0;
+	*p = 0;
+}
+
+void bar(void)
+{
+	extern volatile int i;
+	i = 0;
+	i = 0;
+}
+
+
+void baz(void)
+{
+	volatile int i;
+	i = 0;
+	i = 0;
+}
+
+/*
+ * check-name: keep volatile stores
+ * check-command: test-linearize -Wno-decl -fdump-ir=final $file
+ * check-known-to-fail
+ * check-output-ignore
+ * check-output-pattern(6): store\\.
+ */
-- 
2.14.0

