From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] add testcases for the linearization of calls
Date: Thu, 21 Dec 2017 01:06:40 +0100
Message-ID: <20171221000642.56954-2-luc.vanoostenryck@gmail.com>
References: <20171221000642.56954-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:42842 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756614AbdLUAIt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Dec 2017 19:08:49 -0500
Received: by mail-wm0-f67.google.com with SMTP id b199so13048061wme.1
        for <linux-sparse@vger.kernel.org>; Wed, 20 Dec 2017 16:08:49 -0800 (PST)
In-Reply-To: <20171221000642.56954-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/builtin-arith.c               | 52 ++++++++++++++++++++++++++++
 validation/function-pointer-type.c       |  9 +++++
 validation/linear/call-basic.c           | 58 ++++++++++++++++++++++++++++++++
 validation/linear/call-builtin.c         | 14 ++++++++
 validation/linear/call-casted-pointer.c  | 32 ++++++++++++++++++
 validation/linear/call-complex-pointer.c | 32 ++++++++++++++++++
 validation/linear/call-direct.c          | 14 ++++++++
 validation/linear/call-indirect.c        | 14 ++++++++
 validation/linear/call-inline.c          | 15 +++++++++
 validation/optim/call-complex-pointer.c  | 13 +++++++
 validation/sizeof-builtin.c              | 15 +++++++++
 validation/sizeof-function.c             | 50 +++++++++++++++++++++++++++
 12 files changed, 318 insertions(+)
 create mode 100644 validation/builtin-arith.c
 create mode 100644 validation/function-pointer-type.c
 create mode 100644 validation/linear/call-basic.c
 create mode 100644 validation/linear/call-builtin.c
 create mode 100644 validation/linear/call-casted-pointer.c
 create mode 100644 validation/linear/call-complex-pointer.c
 create mode 100644 validation/linear/call-direct.c
 create mode 100644 validation/linear/call-indirect.c
 create mode 100644 validation/linear/call-inline.c
 create mode 100644 validation/optim/call-complex-pointer.c
 create mode 100644 validation/sizeof-builtin.c
 create mode 100644 validation/sizeof-function.c

diff --git a/validation/builtin-arith.c b/validation/builtin-arith.c
new file mode 100644
index 000000000..d08c93dab
--- /dev/null
+++ b/validation/builtin-arith.c
@@ -0,0 +1,52 @@
+
+
+void test(void (*fun)(void));
+void test(void (*fun)(void))
+{
+	typedef typeof(__builtin_trap) t;	// OK
+	void (*f)(void);
+	int i;
+
+	f =  __builtin_trap;
+	f = &__builtin_trap;
+	f = *__builtin_trap;			// OK for GCC
+	f =  __builtin_trap + 0;
+	f =  __builtin_trap + 1;
+	f =  __builtin_trap - 1;
+
+	// (void) __builtin_trap;
+	f = (void*) __builtin_trap;
+	f = (unsigned long) __builtin_trap;
+
+	i = !__builtin_trap;
+	i = (__builtin_trap > fun);
+	i = (__builtin_trap == fun);
+	i = (fun <  __builtin_trap);
+	i = (fun == __builtin_trap);
+
+	__builtin_trap - fun;
+	fun - __builtin_trap;
+}
+
+/*
+ * check-name: builtin arithmetic
+ * check-command: sparse -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-error-start
+builtin-arith.c:10:xx: error: ...
+builtin-arith.c:11:xx: error: ...
+builtin-arith.c:13:xx: error: arithmetics on pointers to functions
+builtin-arith.c:14:xx: error: arithmetics on pointers to functions
+builtin-arith.c:15:xx: error: arithmetics on pointers to functions
+builtin-arith.c:18:xx: error: ...
+builtin-arith.c:19:xx: error: ...
+builtin-arith.c:21:xx: error: ...
+builtin-arith.c:22:xx: error: ...
+builtin-arith.c:23:xx: error: ...
+builtin-arith.c:24:xx: error: ...
+builtin-arith.c:25:xx: error: ...
+builtin-arith.c:27:24: error: subtraction of functions? Share your drugs
+builtin-arith.c:28:13: error: subtraction of functions? Share your drugs
+ * check-error-end
+ */
diff --git a/validation/function-pointer-type.c b/validation/function-pointer-type.c
new file mode 100644
index 000000000..8fd792b3b
--- /dev/null
+++ b/validation/function-pointer-type.c
@@ -0,0 +1,9 @@
+extern int fun(void);
+
+void fa(void) { int (*f)(void); f = &fun; }
+void f0(void) { int (*f)(void); f = fun; }	// C99,C11 6.3.2.1p4
+
+/*
+ * check-name: type of function pointers
+ * check-command: sparse -Wno-decl $file
+ */
diff --git a/validation/linear/call-basic.c b/validation/linear/call-basic.c
new file mode 100644
index 000000000..235b443d2
--- /dev/null
+++ b/validation/linear/call-basic.c
@@ -0,0 +1,58 @@
+extern int fun(int a);
+
+int symbol(int a)
+{
+	fun(a);
+}
+
+int pointer0(int a, int (*fun)(int))
+{
+	fun(a);
+}
+
+int pointer1(int a, int (*fun)(int))
+{
+	(*fun)(a);
+}
+
+int builtin(int a)
+{
+	__builtin_popcount(a);
+}
+
+/*
+ * check-name: basic function calls
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-start
+symbol:
+.L0:
+	<entry-point>
+	call.32     %r2 <- fun, %arg1
+	ret.32      %r2
+
+
+pointer0:
+.L2:
+	<entry-point>
+	call.32     %r5 <- %arg2, %arg1
+	ret.32      %r5
+
+
+pointer1:
+.L4:
+	<entry-point>
+	call.32     %r8 <- %arg2, %arg1
+	ret.32      %r8
+
+
+builtin:
+.L6:
+	<entry-point>
+	call.32     %r11 <- __builtin_popcount, %arg1
+	ret.32      %r11
+
+
+ * check-output-end
+ */
diff --git a/validation/linear/call-builtin.c b/validation/linear/call-builtin.c
new file mode 100644
index 000000000..af0148aa4
--- /dev/null
+++ b/validation/linear/call-builtin.c
@@ -0,0 +1,14 @@
+typedef unsigned int u32;
+
+u32 ff(u32 a) { return __builtin_popcount(a); }
+
+u32 f0(u32 a) { return (__builtin_popcount)(a); }
+
+/*
+ * check-name: builtin calls
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: load
+ * check-output-pattern(2): call\..*__builtin_.*, %arg1
+ */
diff --git a/validation/linear/call-casted-pointer.c b/validation/linear/call-casted-pointer.c
new file mode 100644
index 000000000..e66f69990
--- /dev/null
+++ b/validation/linear/call-casted-pointer.c
@@ -0,0 +1,32 @@
+typedef int (*fun_t)(void*);
+
+int foo(void *a, void *fun)
+{
+	return ((fun_t)fun)(a);
+}
+
+int bar(void *a, void *fun)
+{
+	return ((int (*)(void *))fun)(a);
+}
+
+int qux(void *a, void *fun)
+{
+	return (*(fun_t)fun)(a);
+}
+
+int quz(void *a, void *fun)
+{
+	return (*(int (*)(void *))fun)(a);
+}
+
+/*
+ * check-name: call via casted function pointer
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: load
+ * check-output-pattern(4): ptrcast\..* %arg2
+ * check-output-pattern(4): call\..* %arg1
+ */
diff --git a/validation/linear/call-complex-pointer.c b/validation/linear/call-complex-pointer.c
new file mode 100644
index 000000000..d95e18057
--- /dev/null
+++ b/validation/linear/call-complex-pointer.c
@@ -0,0 +1,32 @@
+int foo(int p, int (*f0)(int), int (*f1)(int), int arg)
+{
+	return (p ? f0 : f1)(arg);
+}
+
+/*
+ * check-name: call-complex-pointer
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+foo:
+.L0:
+	<entry-point>
+	cbr         %arg1, .L2, .L3
+
+.L2:
+	phisrc.64   %phi1 <- %arg2
+	br          .L4
+
+.L3:
+	ptrcast.64  %r5 <- (64) %arg3
+	phisrc.64   %phi2 <- %r5
+	br          .L4
+
+.L4:
+	phi.64      %r6 <- %phi1, %phi2
+	call.32     %r7 <- %r6, %arg4
+	ret.32      %r7
+
+
+ * check-output-end
+ */
diff --git a/validation/linear/call-direct.c b/validation/linear/call-direct.c
new file mode 100644
index 000000000..78321ab02
--- /dev/null
+++ b/validation/linear/call-direct.c
@@ -0,0 +1,14 @@
+extern int fun(void);
+
+int ff(void) { return fun(); }
+
+int f0(void) { return (fun)(); }
+
+/*
+ * check-name: direct calls
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: load
+ * check-output-pattern(2): call\..* fun
+ */
diff --git a/validation/linear/call-indirect.c b/validation/linear/call-indirect.c
new file mode 100644
index 000000000..8ab78676b
--- /dev/null
+++ b/validation/linear/call-indirect.c
@@ -0,0 +1,14 @@
+int gg(int (*fun)(void)) { return fun(); }
+
+int g0(int (*fun)(void)) { return (fun)(); }
+int g1(int (*fun)(void)) { return (*fun)(); }	// C99,C11 6.5.3.2p4
+
+/*
+ * check-name: indirect calls
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: load
+ * check-output-pattern(3): call\..* %arg1
+ */
diff --git a/validation/linear/call-inline.c b/validation/linear/call-inline.c
new file mode 100644
index 000000000..32f32461c
--- /dev/null
+++ b/validation/linear/call-inline.c
@@ -0,0 +1,15 @@
+static inline int fun(void) { return 42; }
+
+int fi(void) { return fun(); }
+
+int i0(void) { return (fun)(); }
+
+/*
+ * check-name: inline calls
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: load
+ * check-output-excludes: call
+ * check-output-pattern(2): ret\..* \\$42
+ */
diff --git a/validation/optim/call-complex-pointer.c b/validation/optim/call-complex-pointer.c
new file mode 100644
index 000000000..6cfeb6abd
--- /dev/null
+++ b/validation/optim/call-complex-pointer.c
@@ -0,0 +1,13 @@
+int foo(int p, int (*f0)(int), int (*f1)(int), int arg)
+{
+	return (p ? f0 : f1)(arg);
+}
+/*
+ * check-name: call-complex-pointer
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: ptrcast\.
+ * check-output-contains: select\.
+ */
diff --git a/validation/sizeof-builtin.c b/validation/sizeof-builtin.c
new file mode 100644
index 000000000..7123e4deb
--- /dev/null
+++ b/validation/sizeof-builtin.c
@@ -0,0 +1,15 @@
+int test(void);
+int test(void)
+{
+	return sizeof &__builtin_trap;
+}
+
+/*
+ * check-name: sizeof-builtin
+ * check-command: sparse -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-error-start
+sizeof-function.c:4:16: error: expression using addressof on a builtin function
+ * check-error-end
+ */
diff --git a/validation/sizeof-function.c b/validation/sizeof-function.c
new file mode 100644
index 000000000..20c795e94
--- /dev/null
+++ b/validation/sizeof-function.c
@@ -0,0 +1,50 @@
+extern int fun(void);
+extern int (*ptr)(void);
+
+static inline int inl(int *a)
+{
+	return *a + 1;
+}
+
+
+int test(void);
+int test(void)
+{
+	unsigned int s = 0;
+
+	// OK
+	s += sizeof &fun;
+	s += sizeof  ptr;
+	s += sizeof &ptr;
+	s += sizeof &inl;
+
+	// KO
+	s += sizeof  fun;
+	s += sizeof *fun;
+
+	s += sizeof *ptr;
+
+	s += sizeof  inl;
+	s += sizeof *inl;
+
+	s += sizeof  __builtin_trap;
+	s += sizeof *__builtin_trap;
+
+	return s;
+}
+
+/*
+ * check-name: sizeof-function
+ * check-command: sparse -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-error-start
+sizeof-function.c:22:14: warning: expression using sizeof on a function
+sizeof-function.c:23:14: warning: expression using sizeof on a function
+sizeof-function.c:25:14: warning: expression using sizeof on a function
+sizeof-function.c:27:14: warning: expression using sizeof on a function
+sizeof-function.c:28:14: warning: expression using sizeof on a function
+sizeof-function.c:30:14: warning: expression using sizeof on a function
+sizeof-function.c:31:14: warning: expression using sizeof on a function
+ * check-error-end
+ */
-- 
2.15.0

