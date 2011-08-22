From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 2/5] sparse: Enable unhandled validation tests
Date: Mon, 22 Aug 2011 16:57:28 +0300
Message-ID: <1314021451-24808-2-git-send-email-penberg@kernel.org>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:59194 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab1HVN5f (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Aug 2011 09:57:35 -0400
In-Reply-To: <1314021451-24808-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>

This patch enables unhandled tests that did not have "check-name" specified.
It's pointless not to run them.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 validation/badtype1.c                 |    5 +++++
 validation/badtype2.c                 |   14 ++++++++++++++
 validation/badtype3.c                 |   17 +++++++++++++++++
 validation/bitfields.c                |    3 +++
 validation/builtin_safe1.c            |   13 +++++++++++++
 validation/choose_expr.c              |   13 +++++++++++++
 validation/field-overlap.c            |    4 ++++
 validation/foul-bitwise.c             |   10 ++++++++++
 validation/inline_compound_literals.c |    4 ++++
 validation/struct-ns2.c               |    5 +++++
 validation/struct-size1.c             |    4 ++++
 validation/test-be.c                  |    3 +++
 validation/type1.c                    |    4 ++++
 13 files changed, 99 insertions(+), 0 deletions(-)

diff --git a/validation/badtype1.c b/validation/badtype1.c
index 4366d8d..ced7f9f 100644
--- a/validation/badtype1.c
+++ b/validation/badtype1.c
@@ -1 +1,6 @@
 static void foo(enum bar baz);
+
+/*
+ * check-name: enum not in scope
+ * check-known-to-fail
+ */
diff --git a/validation/badtype2.c b/validation/badtype2.c
index aad725d..90a5fa1 100644
--- a/validation/badtype2.c
+++ b/validation/badtype2.c
@@ -8,3 +8,17 @@ static undef foo(char *c)
     return bar();
   }
 }
+
+/*
+ * check-name: missing type
+ * check-error-start
+badtype2.c:2:14: error: Expected ; at end of declaration
+badtype2.c:2:14: error: got bar
+badtype2.c:3:14: error: Expected ; at end of declaration
+badtype2.c:3:14: error: got foo
+badtype2.c:6:3: error: Trying to use reserved word 'switch' as identifier
+badtype2.c:7:3: error: not in switch scope
+badtype2.c:10:1: error: Expected ; at the end of type declaration
+badtype2.c:10:1: error: got }
+ * check-error-end
+ */
diff --git a/validation/badtype3.c b/validation/badtype3.c
index 198ef87..20f346c 100644
--- a/validation/badtype3.c
+++ b/validation/badtype3.c
@@ -8,3 +8,20 @@ foo (int (*func) (undef, void *), void *data)
   }
   return err;
 }
+
+/*
+ * check-name: missing type in argument list
+ * check-error-start
+badtype3.c:2:18: warning: identifier list not in definition
+badtype3.c:2:24: error: Expected ) in function declarator
+badtype3.c:2:24: error: got ,
+badtype3.c:5:3: error: Trying to use reserved word 'while' as identifier
+badtype3.c:7:7: error: break/continue not in iterator scope
+badtype3.c:9:3: error: Trying to use reserved word 'return' as identifier
+badtype3.c:9:10: error: Expected ; at end of declaration
+badtype3.c:9:10: error: got err
+badtype3.c:10:1: error: Expected ; at the end of type declaration
+badtype3.c:10:1: error: got }
+badtype3.c:6:11: error: undefined identifier 'func'
+ * check-error-end
+ */
diff --git a/validation/bitfields.c b/validation/bitfields.c
index 16aa16d..ea24841 100644
--- a/validation/bitfields.c
+++ b/validation/bitfields.c
@@ -16,3 +16,6 @@ static int b(void)
 	return a[y.x];
 }
 
+/*
+ * check-name: bitfield to integer promotion
+ */
diff --git a/validation/builtin_safe1.c b/validation/builtin_safe1.c
index 8a8b979..2f6c9d2 100644
--- a/validation/builtin_safe1.c
+++ b/validation/builtin_safe1.c
@@ -24,3 +24,16 @@ static int foo(int x, int y)
   return x;
 }
 
+/*
+ * check-name: __builtin_safe
+ * check-known-to-fail
+ * check-error-start
+builtin_safe1.c:13:3: warning: Macro argument with side effects: x++
+builtin_safe1.c:14:3: warning: Macro argument with side effects: x+=1
+builtin_safe1.c:15:3: warning: Macro argument with side effects: x=x+1
+builtin_safe1.c:16:3: warning: Macro argument with side effects: x%=y
+builtin_safe1.c:17:3: warning: Macro argument with side effects: x=y
+builtin_safe1.c:18:3: warning: Macro argument with side effects: g(x)
+builtin_safe1.c:19:3: warning: Macro argument with side effects: (y,g(x))
+ * check-error-end
+ */
diff --git a/validation/choose_expr.c b/validation/choose_expr.c
index 55bfa0c..f6fd84c 100644
--- a/validation/choose_expr.c
+++ b/validation/choose_expr.c
@@ -2,3 +2,16 @@ static int x = __builtin_choose_expr(0,(char *)0,(void)0);
 static int y = __builtin_choose_expr(1,(char *)0,(void)0);
 static char s[42];
 static int z = 1/(sizeof(__builtin_choose_expr(1,s,0)) - 42);
+
+/*
+ * check-name: choose expr builtin
+ * check-error-start
+choose_expr.c:1:51: warning: incorrect type in initializer (different base types)
+choose_expr.c:1:51:    expected int static [signed] [toplevel] x
+choose_expr.c:1:51:    got void <noident>
+choose_expr.c:2:41: warning: incorrect type in initializer (different base types)
+choose_expr.c:2:41:    expected int static [signed] [toplevel] y
+choose_expr.c:2:41:    got char *<noident>
+choose_expr.c:4:17: warning: division by zero
+ * check-error-end
+ */
diff --git a/validation/field-overlap.c b/validation/field-overlap.c
index 15b974a..a6abab2 100644
--- a/validation/field-overlap.c
+++ b/validation/field-overlap.c
@@ -10,3 +10,7 @@ static struct {int x, y, z;} w[2] = {
 	{.x = 1, .y = 2, .z = 3},
 	{.x = 1, .y = 2, .z = 3}
 };
+
+/*
+ * check-name: field overlap
+ */
diff --git a/validation/foul-bitwise.c b/validation/foul-bitwise.c
index ca84be6..9e21eab 100644
--- a/validation/foul-bitwise.c
+++ b/validation/foul-bitwise.c
@@ -18,3 +18,13 @@ static __le16 bar(__le16 a)
 {
 	return -a;
 }
+
+/*
+ * check-name: foul bitwise
+ * check-error-start
+foul-bitwise.c:9:16: warning: restricted __le16 degrades to integer
+foul-bitwise.c:9:22: warning: restricted __le16 degrades to integer
+foul-bitwise.c:19:16: error: incompatible types for operation (-)
+foul-bitwise.c:19:16:    argument has type restricted __le16 [usertype] a
+ * check-error-end
+ */
diff --git a/validation/inline_compound_literals.c b/validation/inline_compound_literals.c
index 649d42a..fc223ff 100644
--- a/validation/inline_compound_literals.c
+++ b/validation/inline_compound_literals.c
@@ -16,3 +16,7 @@ static void foo(void)
 {
 	baz();
 }
+
+/*
+ * check-name: inline compound literals
+ */
diff --git a/validation/struct-ns2.c b/validation/struct-ns2.c
index b38af0a..4dd2c3b 100644
--- a/validation/struct-ns2.c
+++ b/validation/struct-ns2.c
@@ -12,3 +12,8 @@ h (void)
   struct Bar y;
   y.i = 1;
 }
+
+/*
+ * check-name: struct not in scope
+ * check-known-to-fail
+ */
diff --git a/validation/struct-size1.c b/validation/struct-size1.c
index 4748cd3..cf956a4 100644
--- a/validation/struct-size1.c
+++ b/validation/struct-size1.c
@@ -15,3 +15,7 @@ static const struct { int x; } foo[] = {{ 1 }};
 struct C {
   int bar[(sizeof foo/sizeof foo[0])];
 };
+
+/*
+ * check-name: struct size
+ */
diff --git a/validation/test-be.c b/validation/test-be.c
index 6b74555..deda3cc 100644
--- a/validation/test-be.c
+++ b/validation/test-be.c
@@ -41,3 +41,6 @@ int main (int argc, char *argv[])
 	return 0;
 }
 
+/*
+ * check-name: binary operations
+ */
diff --git a/validation/type1.c b/validation/type1.c
index 4f08f88..2a55f2a 100644
--- a/validation/type1.c
+++ b/validation/type1.c
@@ -21,3 +21,7 @@ static int test(struct hello *arg)
 {
 	return deref(arg->array);
 }
+
+/*
+ * check-name: "char []" to "char *" demotion
+ */
-- 
1.7.4.1

