From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] Add some test-suite metadata for various tests
Date: Sat, 28 Jul 2007 17:21:06 +0100
Message-ID: <46AB6CF2.6030505@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:4302 "EHLO
	anchor-post-36.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753180AbXG1Rtb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 28 Jul 2007 13:49:31 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Note that while re-basing this patch, git told me that it introduced some
trailing whitespace to validation/cond_expr.c; in particular to the second
line of the error message. If you look at show-parse.c:256, you will see
that sparse does indeed introduce tailing whitespace.

Also note that preprocessor13.c crashes gcc 4.1.2 (ubuntu) but not
gcc 3.4.4 (cygwin). Furthermore, preprocessor14.c produces different
output from gcc and sparse (and I think both are wrong!). However, since
the precedence and associativity of the # and ## operators are undefined,
then the answer is probably implementation defined.

ATB,

Ramsay Jones

 validation/check_byte_count-ice.c        |    8 ++++++++
 validation/cond_expr.c                   |    8 ++++++++
 validation/double-semicolon.c            |    3 +++
 validation/preprocessor/preprocessor11.c |   21 +++++++++++++++++++++
 validation/preprocessor/preprocessor12.c |   11 +++++++++++
 validation/preprocessor/preprocessor15.c |    9 +++++++++
 validation/preprocessor/preprocessor16.c |    9 +++++++++
 validation/preprocessor/preprocessor7.c  |    9 +++++++++
 validation/preprocessor/preprocessor8.c  |   22 ++++++++++++++++++++++
 9 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/validation/check_byte_count-ice.c b/validation/check_byte_count-ice.c
index e58312d..0be8a38 100644
--- a/validation/check_byte_count-ice.c
+++ b/validation/check_byte_count-ice.c
@@ -4,3 +4,11 @@ static void foo(void *a)
 {
 	memset(foo, + ', 20);
 }
+/*
+ * check-name: Byte Count ICE
+ *
+ * check-error-start
+check_byte_count-ice.c:5:18: error: Bad character constant
+check_byte_count-ice.c:5:8: error: not enough arguments for function memset
+ * check-error-end
+ */
diff --git a/validation/cond_expr.c b/validation/cond_expr.c
index d5d9e6f..8e8232c 100644
--- a/validation/cond_expr.c
+++ b/validation/cond_expr.c
@@ -9,3 +9,11 @@ int a(void)
 {
 	return ~(y ? : x);	/* should warn */
 }
+/*
+ * check-name: type of conditional
+ *
+ * check-error-start
+cond_expr.c:10:9: error: incompatible types for operation (~)
+cond_expr.c:10:9:    argument has type double 
+ * check-error-end
+ */
diff --git a/validation/double-semicolon.c b/validation/double-semicolon.c
index 36cb332..c0011da 100644
--- a/validation/double-semicolon.c
+++ b/validation/double-semicolon.c
@@ -4,3 +4,6 @@ static void test(void)
 	struct { int foo;; } val;
 	memset(&val, 0, sizeof(val));
 }
+/*
+ * check-name: Empty struct field declaration
+ */
diff --git a/validation/preprocessor/preprocessor11.c b/validation/preprocessor/preprocessor11.c
index 4c6c1c0..4b37664 100644
--- a/validation/preprocessor/preprocessor11.c
+++ b/validation/preprocessor/preprocessor11.c
@@ -8,3 +8,24 @@
 #define H(x...,y)
 #define I(...+
 #define J(x,y)
+/*
+ * check-name: Preprocessor #11
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+
+ * check-output-end
+ *
+ * check-error-start
+preprocessor/preprocessor11.c:1:11: error: "1" may not appear in macro parameter list
+preprocessor/preprocessor11.c:2:11: error: missing ')' in macro parameter list
+preprocessor/preprocessor11.c:3:12: error: missing ')' in macro parameter list
+preprocessor/preprocessor11.c:4:11: error: parameter name missing
+preprocessor/preprocessor11.c:5:11: error: __VA_ARGS__ can only appear in the expansion of a C99 variadic macro
+preprocessor/preprocessor11.c:6:12: error: "+" may not appear in macro parameter list
+preprocessor/preprocessor11.c:7:12: error: missing ')' in macro parameter list
+preprocessor/preprocessor11.c:8:12: error: missing ')' in macro parameter list
+preprocessor/preprocessor11.c:9:11: error: missing ')' in macro parameter list
+ * check-error-end
+ */
diff --git a/validation/preprocessor/preprocessor12.c b/validation/preprocessor/preprocessor12.c
index 385c1a7..e23e53b 100644
--- a/validation/preprocessor/preprocessor12.c
+++ b/validation/preprocessor/preprocessor12.c
@@ -5,3 +5,14 @@
 A(1)
 A(1,2)
 A(1,2,3)
+/*
+ * check-name: Preprocessor #12
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+1
+1,2
+1,2,3
+ * check-output-end
+ */
diff --git a/validation/preprocessor/preprocessor15.c b/validation/preprocessor/preprocessor15.c
index 0a2dfd7..df87751 100644
--- a/validation/preprocessor/preprocessor15.c
+++ b/validation/preprocessor/preprocessor15.c
@@ -5,3 +5,12 @@
 #if D(A,B) B
 D(1,2)
 #endif
+/*
+ * check-name: Preprocessor #15
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+12
+ * check-output-end
+ */
diff --git a/validation/preprocessor/preprocessor16.c b/validation/preprocessor/preprocessor16.c
index e3bd0d9..75a4a0b 100644
--- a/validation/preprocessor/preprocessor16.c
+++ b/validation/preprocessor/preprocessor16.c
@@ -19,3 +19,12 @@ they hit before we get to the level of groups.
 #bullshit
 
 #endif
+/*
+ * check-name: Preprocessor #16
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+
+ * check-output-end
+ */
diff --git a/validation/preprocessor/preprocessor7.c b/validation/preprocessor/preprocessor7.c
index e7e1d37..07fce8c 100644
--- a/validation/preprocessor/preprocessor7.c
+++ b/validation/preprocessor/preprocessor7.c
@@ -3,3 +3,12 @@
 #define C(x,y) E(y)
 #define E(y) #y
 A(2))
+/*
+ * check-name: Preprocessor #7
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+"\"D\""
+ * check-output-end
+ */
diff --git a/validation/preprocessor/preprocessor8.c b/validation/preprocessor/preprocessor8.c
index 861dfe5..524825c 100644
--- a/validation/preprocessor/preprocessor8.c
+++ b/validation/preprocessor/preprocessor8.c
@@ -14,3 +14,25 @@
 "x#y"			: E
 "ab GH \"G\" 12"	: F(G,H)
 "a ## b"		: I(a,##,b)
+/*
+ * check-name: Preprocessor #8
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+"A(x)" : A(x)
+"B(x)" : B(x)
+"C(x)" : C(x)
+"D(x)" : D(x)
+"x#y" : x#y
+"ab GH \"G\" 12" : ab GH "G" 12
+"a ## b" : a ## b
+ * check-output-end
+ *
+ * check-error-start
+preprocessor/preprocessor8.c:1:14: error: '##' cannot appear at the ends of macro expansion
+preprocessor/preprocessor8.c:2:16: error: '##' cannot appear at the ends of macro expansion
+preprocessor/preprocessor8.c:3:22: error: '##' cannot appear at the ends of macro expansion
+preprocessor/preprocessor8.c:4:15: error: '#' is not followed by a macro parameter
+ * check-error-end
+ */
-- 
1.5.2
