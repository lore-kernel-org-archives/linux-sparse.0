From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 06/28] bad-goto: reorganize testcases and add some more
Date: Tue, 19 May 2020 02:57:06 +0200
Message-ID: <20200519005728.84594-7-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgESA5k (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:40 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88162C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:40 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l5so3701432edn.7
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:40 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reorganize the testcases related to the 'scope' of labels
and add a few new ones.

Also, some related testcases have some unreported errors other
than the features being tested. This is a problem since such
tescases can still fail after the feature being tested is fixed
or implemented. So, fix these testcases or split them so that
they each test a unique feature.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/__func__-scope.c                   |  8 ++
 .../{asm-goto-lables.c => asm-goto-labels.c}  |  0
 validation/label-asm.c                        |  1 +
 validation/label-attr.c                       |  2 +-
 validation/label-scope-cgoto.c                | 83 +++++++++++++++++++
 validation/label-scope.c                      |  5 +-
 validation/label-scope1.c                     | 42 ++++++++++
 validation/label-scope2.c                     | 32 +++++++
 validation/label-stmt-expr0.c                 | 39 +++++++++
 validation/label-stmt-expr2.c                 | 47 +++++++++++
 validation/label-unused.c                     | 24 ++++++
 .../{invalid-labels0.c => goto-invalid.c}     |  4 +-
 ...r-stmt0.c => goto-stmt-expr-conditional.c} |  4 +-
 .../linear/goto-stmt-expr-short-circuit.c     | 32 +++++++
 validation/linear/label-scope-cgoto.c         | 11 +++
 .../label-stmt-dropped.c}                     |  4 +-
 .../label-stmt-expr0.c}                       |  4 +-
 ...reachable-label0.c => label-unreachable.c} |  3 +-
 18 files changed, 332 insertions(+), 13 deletions(-)
 create mode 100644 validation/__func__-scope.c
 rename validation/{asm-goto-lables.c => asm-goto-labels.c} (100%)
 create mode 100644 validation/label-scope-cgoto.c
 create mode 100644 validation/label-scope1.c
 create mode 100644 validation/label-scope2.c
 create mode 100644 validation/label-stmt-expr0.c
 create mode 100644 validation/label-stmt-expr2.c
 create mode 100644 validation/label-unused.c
 rename validation/linear/{invalid-labels0.c => goto-invalid.c} (88%)
 rename validation/linear/{goto-and-expr-stmt0.c => goto-stmt-expr-conditional.c} (87%)
 create mode 100644 validation/linear/goto-stmt-expr-short-circuit.c
 create mode 100644 validation/linear/label-scope-cgoto.c
 rename validation/{discarded-label-statement.c => linear/label-stmt-dropped.c} (84%)
 rename validation/{label-expr.c => linear/label-stmt-expr0.c} (75%)
 rename validation/linear/{unreachable-label0.c => label-unreachable.c} (80%)

diff --git a/validation/__func__-scope.c b/validation/__func__-scope.c
new file mode 100644
index 000000000000..508a8b91d407
--- /dev/null
+++ b/validation/__func__-scope.c
@@ -0,0 +1,8 @@
+static void foo(void)
+{
+	const char *name = ({ __func__; });
+}
+/*
+ * check-name: __func__'s scope
+ * check-command: sparse -Wall $file
+ */
diff --git a/validation/asm-goto-lables.c b/validation/asm-goto-labels.c
similarity index 100%
rename from validation/asm-goto-lables.c
rename to validation/asm-goto-labels.c
diff --git a/validation/label-asm.c b/validation/label-asm.c
index 411020ac361b..b58d1e52e5fd 100644
--- a/validation/label-asm.c
+++ b/validation/label-asm.c
@@ -3,6 +3,7 @@
 static void f(void)
 {
 	barrier();
+	goto l;
 l:
 	barrier();
 }
diff --git a/validation/label-attr.c b/validation/label-attr.c
index a82d7bc98b39..81c4ac3c6aef 100644
--- a/validation/label-attr.c
+++ b/validation/label-attr.c
@@ -1,6 +1,6 @@
 static int foo(void)
 {
-       return 0;
+       goto rtattr_failure;
 rtattr_failure: __attribute__ ((unused))
        return -1;
 }
diff --git a/validation/label-scope-cgoto.c b/validation/label-scope-cgoto.c
new file mode 100644
index 000000000000..c5d278d3d654
--- /dev/null
+++ b/validation/label-scope-cgoto.c
@@ -0,0 +1,83 @@
+void foo(void)
+{
+	void *p = &&l;
+	{
+l:		 ;
+	}
+	goto *p;			// OK
+}
+
+void bar(void)
+{
+	void *p = &&l;			// KO: 'jump' inside
+	({
+l:		 1;
+	});
+	goto *p;
+}
+
+void baz(void)
+{
+	void *p = &&l;			// KO: 'jump' inside
+	0 ? 1 : ({
+l:		 1;
+		 });
+	goto *p;
+}
+
+void qux(void)
+{
+	void *p = &&l;			// KO: 'jump' inside + removed
+	1 ? 1 : ({
+l:		 1;
+		 });
+	goto *p;
+}
+
+void quz(void)
+{
+	void *p;
+	p = &&l;			// KO: undeclared
+	goto *p;
+}
+
+void qxu(void)
+{
+	void *p;
+	({
+l:		1;
+	 });
+	p = &&l;			// KO: 'jump' inside
+	goto *p;
+}
+
+void qzu(void)
+{
+	void *p;
+	1 ? 1 : ({
+l:		 1;
+		 });
+	p = &&l;			// KO: 'jump' inside + removed
+	goto *p;
+}
+
+
+/*
+ * check-name: label-scope-cgoto
+ * check-command: sparse -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-error-start
+label-scope-cgoto.c:12:19: error: label 'l' used outside statement expression
+label-scope-cgoto.c:14:1:    label 'l' defined here
+label-scope-cgoto.c:21:19: error: label 'l' used outside statement expression
+label-scope-cgoto.c:23:1:    label 'l' defined here
+label-scope-cgoto.c:30:19: error: label 'l' used outside statement expression
+label-scope-cgoto.c:32:1:    label 'l' defined here
+label-scope-cgoto.c:50:13: error: label 'l' used outside statement expression
+label-scope-cgoto.c:48:1:    label 'l' defined here
+label-scope-cgoto.c:60:13: error: label 'l' used outside statement expression
+label-scope-cgoto.c:58:1:    label 'l' defined here
+label-scope-cgoto.c:40:13: error: label 'l' was not declared
+ * check-error-end
+ */
diff --git a/validation/label-scope.c b/validation/label-scope.c
index 7af3d916c347..0ffaaf4a4ccc 100644
--- a/validation/label-scope.c
+++ b/validation/label-scope.c
@@ -3,10 +3,7 @@ static int f(int n)
 	__label__ n;
 n:	return n;
 }
-static int g(int n)
-{
-n:	return n;
-}
+
 /*
  * check-name: __label__ scope
  */
diff --git a/validation/label-scope1.c b/validation/label-scope1.c
new file mode 100644
index 000000000000..f2b1ae9b158a
--- /dev/null
+++ b/validation/label-scope1.c
@@ -0,0 +1,42 @@
+static void ok_top(void)
+{
+	__label__ l;
+l:
+	goto l;
+}
+
+static void ko_undecl(void)
+{
+	__label__ l;
+	goto l;				// KO: undeclared
+}
+
+static void ok_local(void)
+{
+l:
+	{
+		__label__ l;
+l:
+		goto l;
+	}
+goto l;
+}
+
+static void ko_scope(void)
+{
+	{
+		__label__ l;
+l:
+		goto l;
+	}
+goto l;					// KO: undeclared
+}
+
+/*
+ * check-name: label-scope1
+ *
+ * check-error-start
+label-scope1.c:11:9: error: label 'l' was not declared
+label-scope1.c:32:1: error: label 'l' was not declared
+ * check-error-end
+ */
diff --git a/validation/label-scope2.c b/validation/label-scope2.c
new file mode 100644
index 000000000000..8c04ac6525e5
--- /dev/null
+++ b/validation/label-scope2.c
@@ -0,0 +1,32 @@
+static void ok_lvl2(void)
+{
+	__label__ l;
+
+	{
+	l:
+		goto l;
+	}
+}
+
+static void ko_expr2(void)
+{
+	{
+		__label__ a;
+
+		({
+a:
+			 0;
+		});
+		goto a;
+	}
+}
+
+/*
+ * check-name: label-scope2
+ * check-known-to-fail
+ *
+ * check-error-start
+label-scope2.c:20:17: error: label 'a' used outside statement expression
+label-scope2.c:17:1:    label 'a' defined here
+ * check-error-end
+ */
diff --git a/validation/label-stmt-expr0.c b/validation/label-stmt-expr0.c
new file mode 100644
index 000000000000..66a6490241bd
--- /dev/null
+++ b/validation/label-stmt-expr0.c
@@ -0,0 +1,39 @@
+void aft(void)
+{
+	({
+l:		 1;
+	});
+	goto l;				// KO
+}
+
+void bef(void)
+{
+	goto l;				// KO
+	({
+l:		 1;
+	});
+}
+
+void lab(void)
+{
+	__label__ l;
+	({
+l:		 1;
+	});
+	goto l;				// KO
+}
+
+/*
+ * check-name: label-stmt-expr0
+ * check-command: sparse -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-error-start
+label-stmt-expr0.c:6:9: error: label 'l' used outside statement expression
+label-stmt-expr0.c:4:1:    label 'l' defined here
+label-stmt-expr0.c:11:9: error: label 'l' used outside statement expression
+label-stmt-expr0.c:13:1:    label 'l' defined here
+label-stmt-expr0.c:23:9: error: label 'l' used outside statement expression
+label-stmt-expr0.c:21:1:    label 'l' defined here
+ * check-error-end
+ */
diff --git a/validation/label-stmt-expr2.c b/validation/label-stmt-expr2.c
new file mode 100644
index 000000000000..7a38e3799c55
--- /dev/null
+++ b/validation/label-stmt-expr2.c
@@ -0,0 +1,47 @@
+static int foo(void)
+{
+	goto l;
+	({
+l:
+		0;
+	});
+	goto l;
+}
+
+static void bar(void)
+{
+	goto l;
+	goto l;
+	({
+l:
+		0;
+	});
+}
+
+static void baz(void)
+{
+	({
+l:
+		0;
+	});
+	goto l;
+	goto l;
+}
+
+/*
+ * check-name: label-stmt-expr2
+ * check-known-to-fail
+ *
+ * check-error-start
+label-stmt-expr2.c:3:9: error: label 'l' used outside statement expression
+label-stmt-expr2.c:5:1:    label 'l' defined here
+label-stmt-expr2.c:8:9: error: label 'l' used outside statement expression
+label-stmt-expr2.c:5:1:    label 'l' defined here
+label-stmt-expr2.c:13:9: error: label 'l' used outside statement expression
+label-stmt-expr2.c:16:1:    label 'l' defined here
+label-stmt-expr2.c:27:9: error: label 'l' used outside statement expression
+label-stmt-expr2.c:24:1:    label 'l' defined here
+label-stmt-expr2.c:28:9: error: label 'l' used outside statement expression
+label-stmt-expr2.c:24:1:    label 'l' defined here
+ * check-error-end
+ */
diff --git a/validation/label-unused.c b/validation/label-unused.c
new file mode 100644
index 000000000000..c136c7a8813e
--- /dev/null
+++ b/validation/label-unused.c
@@ -0,0 +1,24 @@
+static void foo(void)
+{
+l:
+	return;
+}
+
+static int bar(void)
+{
+	return  ({
+l:
+		;
+		0;
+	});
+}
+
+/*
+ * check-name: label-unused
+ * check-known-to-fail
+ *
+ * check-error-start
+label-unused.c:3:1: warning: unused label 'l'
+label-unused.c:10:1: warning: unused label 'l'
+ * check-error-end
+ */
diff --git a/validation/linear/invalid-labels0.c b/validation/linear/goto-invalid.c
similarity index 88%
rename from validation/linear/invalid-labels0.c
rename to validation/linear/goto-invalid.c
index ae3bf7283fb8..569d0b0d2db1 100644
--- a/validation/linear/invalid-labels0.c
+++ b/validation/linear/goto-invalid.c
@@ -9,11 +9,11 @@ void bar(void)
 }
 
 /*
- * check-name: invalid-labels0
+ * check-name: goto-invalid
  * check-command: test-linearize -Wno-decl $file
  * check-known-to-fail
  *
+ * check-error-ignore
  * check-output-ignore
  * check-output-excludes: END
- * check-error-ignore
  */
diff --git a/validation/linear/goto-and-expr-stmt0.c b/validation/linear/goto-stmt-expr-conditional.c
similarity index 87%
rename from validation/linear/goto-and-expr-stmt0.c
rename to validation/linear/goto-stmt-expr-conditional.c
index 548813531779..6576052b50ac 100644
--- a/validation/linear/goto-and-expr-stmt0.c
+++ b/validation/linear/goto-stmt-expr-conditional.c
@@ -18,11 +18,11 @@ a:
 }
 
 /*
- * check-name: goto-and-expr-stmt0
+ * check-name: goto-stmt-expr-conditional
  * check-command: test-linearize -Wno-decl $file
  * check-known-to-fail
  *
+ * check-error-ignore
  * check-output-ignore
  * check-output-excludes: END
- * check-error-ignore
  */
diff --git a/validation/linear/goto-stmt-expr-short-circuit.c b/validation/linear/goto-stmt-expr-short-circuit.c
new file mode 100644
index 000000000000..426315e69fbd
--- /dev/null
+++ b/validation/linear/goto-stmt-expr-short-circuit.c
@@ -0,0 +1,32 @@
+int foo(int p)
+{
+	goto inside;
+	if (0 && ({
+inside:
+		return 1;
+		2;
+		}))
+		return 3;
+	return 4;
+}
+
+int bar(int p)
+{
+	if (0 && ({
+inside:
+		return 1;
+		2;
+		}))
+		return 3;
+	goto inside;
+}
+
+/*
+ * check-name: goto-stmt-expr-short-circuit
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-error-ignore
+ * check-output-ignore
+ * check-output-excludes: END
+ */
diff --git a/validation/linear/label-scope-cgoto.c b/validation/linear/label-scope-cgoto.c
new file mode 100644
index 000000000000..592f1ce4f664
--- /dev/null
+++ b/validation/linear/label-scope-cgoto.c
@@ -0,0 +1,11 @@
+#include <label-scope-cgoto.c>
+
+/*
+ * check-name: linear/label-scope-cgoto
+ * check-command: test-linearize -Wno-decl -I. $file
+ * check-known-to-fail
+ *
+ * check-error-ignore
+ * check-output-ignore
+ * check-output-excludes: END
+ */
diff --git a/validation/discarded-label-statement.c b/validation/linear/label-stmt-dropped.c
similarity index 84%
rename from validation/discarded-label-statement.c
rename to validation/linear/label-stmt-dropped.c
index b4e58ac64e1d..74e0f2e63aff 100644
--- a/validation/discarded-label-statement.c
+++ b/validation/linear/label-stmt-dropped.c
@@ -11,11 +11,13 @@ start:
 	r += a;
 	r += b;
 
+	if (!r)
+		goto start;
 	return r;
 }
 
 /*
- * check-name: discarded-label-statement
+ * check-name: label-stmt-dropped
  * check-command: test-linearize $file
  *
  * check-output-ignore
diff --git a/validation/label-expr.c b/validation/linear/label-stmt-expr0.c
similarity index 75%
rename from validation/label-expr.c
rename to validation/linear/label-stmt-expr0.c
index e578ed0042e6..ff3c098077d3 100644
--- a/validation/label-expr.c
+++ b/validation/linear/label-stmt-expr0.c
@@ -3,12 +3,12 @@ int foo(void)
 {
 	int r;
 
-	r = ({ label: 1; });
+	r = ({ goto label; label: 1; });
 	return r;
 }
 
 /*
- * check-name: label-expr
+ * check-name: label-stmt-expr0
  * check-command: test-linearize $file
  * check-output-ignore
  *
diff --git a/validation/linear/unreachable-label0.c b/validation/linear/label-unreachable.c
similarity index 80%
rename from validation/linear/unreachable-label0.c
rename to validation/linear/label-unreachable.c
index 695e5cb072d0..a44e121154d0 100644
--- a/validation/linear/unreachable-label0.c
+++ b/validation/linear/label-unreachable.c
@@ -10,9 +10,10 @@ label:
 }
 
 /*
- * check-name: unreachable-label0
+ * check-name: label-unreachable
  * check-command: test-linearize $file
  *
+ * check-error-ignore
  * check-output-ignore
  * check-output-contains: ret\\.
  * check-output-excludes: END
-- 
2.26.2
