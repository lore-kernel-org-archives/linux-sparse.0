From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] use shorter name for constexpr tests
Date: Fri, 15 Sep 2017 08:53:47 +0200
Message-ID: <20170915065347.6772-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36782 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdIOGzz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 02:55:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id r136so1919003wmf.3
        for <linux-sparse@vger.kernel.org>; Thu, 14 Sep 2017 23:55:54 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The name used for these tests, while very correct, are a bit
longuish. They generaly take more than one line on the screen
which is annoying when running the testsuite.

Change this by using shorter names for these tests.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/constexpr-addr-of-static-member.c | 2 +-
 validation/constexpr-addr-of-static.c        | 2 +-
 validation/constexpr-binop.c                 | 2 +-
 validation/constexpr-cast.c                  | 2 +-
 validation/constexpr-compound-literal.c      | 2 +-
 validation/constexpr-conditional.c           | 2 +-
 validation/constexpr-init.c                  | 2 +-
 validation/constexpr-labelref.c              | 2 +-
 validation/constexpr-offsetof.c              | 2 +-
 validation/constexpr-pointer-arith.c         | 2 +-
 validation/constexpr-pointer-cast.c          | 2 +-
 validation/constexpr-preop.c                 | 2 +-
 validation/constexpr-string.c                | 2 +-
 validation/constexpr-types-compatible-p.c    | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/validation/constexpr-addr-of-static-member.c b/validation/constexpr-addr-of-static-member.c
index f944f213e..c2a74ac78 100644
--- a/validation/constexpr-addr-of-static-member.c
+++ b/validation/constexpr-addr-of-static-member.c
@@ -18,7 +18,7 @@ static int *f = &a.d.b[1];	// OK
 static int *g = &(&a.d)->b[1];	// OK
 
 /*
- * check-name: address of static object's member constness verification.
+ * check-name: constexpr static object's member address
  * check-command: sparse -Wconstexpr-not-const $file
  *
  * check-error-start
diff --git a/validation/constexpr-addr-of-static.c b/validation/constexpr-addr-of-static.c
index a3af99ae7..1af9438c6 100644
--- a/validation/constexpr-addr-of-static.c
+++ b/validation/constexpr-addr-of-static.c
@@ -25,7 +25,7 @@ static void m(void) {
 }
 
 /*
- * check-name: address of static object constness verification.
+ * check-name: constexpr static object address
  * check-command: sparse -Wconstexpr-not-const $file
  *
  * check-error-start
diff --git a/validation/constexpr-binop.c b/validation/constexpr-binop.c
index 85a88e3cd..01261de9c 100644
--- a/validation/constexpr-binop.c
+++ b/validation/constexpr-binop.c
@@ -19,7 +19,7 @@ static int a[] = {
 };
 
 /*
- * check-name: Expression constness propagation in binops and alike
+ * check-name: constexprness in binops and alike
  *
  * check-error-start
 constexpr-binop.c:3:12: error: bad constant expression
diff --git a/validation/constexpr-cast.c b/validation/constexpr-cast.c
index 27069614c..993c46675 100644
--- a/validation/constexpr-cast.c
+++ b/validation/constexpr-cast.c
@@ -14,7 +14,7 @@ static int a[] = {
 
 };
 /*
- * check-name: Expression constness propagation in casts
+ * check-name: constexprness in casts
  *
  * check-error-start
 constexpr-cast.c:9:11: error: bad integer constant expression
diff --git a/validation/constexpr-compound-literal.c b/validation/constexpr-compound-literal.c
index d7f21ad7a..e13787395 100644
--- a/validation/constexpr-compound-literal.c
+++ b/validation/constexpr-compound-literal.c
@@ -9,7 +9,7 @@ static void foo(void)
 }
 
 /*
- * check-name: compound literal address constness verification
+ * check-name: constexpr compound literal address
  * check-command: sparse -Wconstexpr-not-const $file
  *
  * check-error-start
diff --git a/validation/constexpr-conditional.c b/validation/constexpr-conditional.c
index a3331b3ef..0f2409bf2 100644
--- a/validation/constexpr-conditional.c
+++ b/validation/constexpr-conditional.c
@@ -21,7 +21,7 @@ static int a[] = {
 };
 
 /*
- * check-name: Expression constness propagation in conditional expressions
+ * check-name: constexprness in conditionals
  *
  * check-error-start
 constexpr-conditional.c:12:13: error: bad constant expression
diff --git a/validation/constexpr-init.c b/validation/constexpr-init.c
index d7e7a450f..c182fe79c 100644
--- a/validation/constexpr-init.c
+++ b/validation/constexpr-init.c
@@ -39,7 +39,7 @@ static void s(void) {
 }
 
 /*
- * check-name: static storage object initializer constness verification.
+ * check-name: constexprness static storage object initializer
  * check-command: sparse -Wconstexpr-not-const $file
  *
  * check-error-start
diff --git a/validation/constexpr-labelref.c b/validation/constexpr-labelref.c
index 15b5293ae..93dc5ccc5 100644
--- a/validation/constexpr-labelref.c
+++ b/validation/constexpr-labelref.c
@@ -6,7 +6,7 @@ label1:
 }
 
 /*
- * check-name: label reference constness verification.
+ * check-name: constexprness label reference
  * check-command: sparse -Wconstexpr-not-const $file
  *
  * check-error-start
diff --git a/validation/constexpr-offsetof.c b/validation/constexpr-offsetof.c
index d1697b0c5..f55cb5639 100644
--- a/validation/constexpr-offsetof.c
+++ b/validation/constexpr-offsetof.c
@@ -13,7 +13,7 @@ static int o[] = {
 };
 
 /*
- * check-name: __builtin_offsetof() constness verification.
+ * check-name: constexprness __builtin_offsetof()
  *
  * check-error-start
 constexpr-offsetof.c:12:39: error: bad constant expression
diff --git a/validation/constexpr-pointer-arith.c b/validation/constexpr-pointer-arith.c
index a92202800..f27d117a0 100644
--- a/validation/constexpr-pointer-arith.c
+++ b/validation/constexpr-pointer-arith.c
@@ -17,7 +17,7 @@ static int *o = &*(b + 1);				// OK
 static int *p = &*(d + 1);				// KO
 
 /*
- * check-name: pointer arithmetic constness verification.
+ * check-name: consrexprness pointer arithmetic
  * check-command: sparse -Wconstexpr-not-const $file
  *
  * check-error-start
diff --git a/validation/constexpr-pointer-cast.c b/validation/constexpr-pointer-cast.c
index d19c10828..bdf668c1a 100644
--- a/validation/constexpr-pointer-cast.c
+++ b/validation/constexpr-pointer-cast.c
@@ -4,7 +4,7 @@ static int *c = (int*)b;	// KO
 
 
 /*
- * check-name: integer literal cast to pointer type constness verification.
+ * check-name: constexprness integer literal cast to pointer type
  * check-command: sparse -Wconstexpr-not-const $file
  *
  * check-error-start
diff --git a/validation/constexpr-preop.c b/validation/constexpr-preop.c
index 5d869da4f..4b54defd9 100644
--- a/validation/constexpr-preop.c
+++ b/validation/constexpr-preop.c
@@ -16,7 +16,7 @@ static int a[] = {
 };
 
 /*
- * check-name: Expression constness propagation in preops
+ * check-name: constexprness in preops
  *
  * check-error-start
 constexpr-preop.c:4:5: error: bad constant expression
diff --git a/validation/constexpr-string.c b/validation/constexpr-string.c
index e641a83eb..1db101eeb 100644
--- a/validation/constexpr-string.c
+++ b/validation/constexpr-string.c
@@ -1,7 +1,7 @@
 static char *a = "foobar";	// OK
 
 /*
- * check-name: string literal constness verification.
+ * check-name: constness of string literal
  * check-command: sparse -Wconstexpr-not-const $file
  *
  * check-error-start
diff --git a/validation/constexpr-types-compatible-p.c b/validation/constexpr-types-compatible-p.c
index 1969bf3bd..1179e9d60 100644
--- a/validation/constexpr-types-compatible-p.c
+++ b/validation/constexpr-types-compatible-p.c
@@ -1,7 +1,7 @@
 static int a[] = {[__builtin_types_compatible_p(int, int)] = 0};
 
 /*
- * check-name: __builtin_types_compatible_p() constness verification.
+ * check-name: constness of __builtin_types_compatible_p()
  *
  * check-error-start
  * check-error-end
-- 
2.14.0

