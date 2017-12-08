From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/16] testsuite: fix invalid 'check-...' tags
Date: Fri,  8 Dec 2017 14:14:47 +0100
Message-ID: <20171208131455.7786-9-luc.vanoostenryck@gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39516 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752989AbdLHNPS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:18 -0500
Received: by mail-wm0-f68.google.com with SMTP id i11so3132783wmf.4
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:17 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A few testcases had typos in their 'check-...' tags or
the tag was plainly invalid.

Fix them in accordance to the doc.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/cond-address.c         | 2 +-
 validation/cond-err-expand.c      | 2 +-
 validation/nested-declarator.c    | 4 ++--
 validation/nested-declarator2.c   | 4 ++--
 validation/optim/canonical-cmp.c  | 2 +-
 validation/optim/canonical-fcmp.c | 2 +-
 validation/reserved.c             | 4 ++--
 validation/typedef_shadow.c       | 4 ++--
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/validation/cond-address.c b/validation/cond-address.c
index 2a69f4b92..c9253ad04 100644
--- a/validation/cond-address.c
+++ b/validation/cond-address.c
@@ -10,5 +10,5 @@ int qux(void) { if (f && a) return 1; return 0; }
  * check-command: test-linearize -Wno-decl $file
  * check-output-ignore
  *
- * check-excludes: VOID
+ * check-output-excludes: VOID
  */
diff --git a/validation/cond-err-expand.c b/validation/cond-err-expand.c
index 93bbac153..7936a2d00 100644
--- a/validation/cond-err-expand.c
+++ b/validation/cond-err-expand.c
@@ -23,5 +23,5 @@ cond-err-expand.c:13:11: error: incompatible types in conditional expression (di
  * check-error-end
  *
  * check-output-ignore
- * check-excludes: call.* __builtin_constant_p
+ * check-output-excludes: call.* __builtin_constant_p
  */
diff --git a/validation/nested-declarator.c b/validation/nested-declarator.c
index 1efe20ce4..f258d457b 100644
--- a/validation/nested-declarator.c
+++ b/validation/nested-declarator.c
@@ -15,7 +15,7 @@ int i(void (void)(*f));
 int j(int [2](*));
 /*
  * check-name: nested declarator vs. parameters
- * check-error-start:
+ * check-error-start
 nested-declarator.c:11:23: warning: missing identifier in declaration
 nested-declarator.c:11:23: error: Expected ; at the end of type declaration
 nested-declarator.c:11:23: error: got (
@@ -25,5 +25,5 @@ nested-declarator.c:14:18: error: Expected ) in function declarator
 nested-declarator.c:14:18: error: got (
 nested-declarator.c:15:14: error: Expected ) in function declarator
 nested-declarator.c:15:14: error: got (
- * check-error-end:
+ * check-error-end
  */
diff --git a/validation/nested-declarator2.c b/validation/nested-declarator2.c
index 345a04b06..983b7ef5c 100644
--- a/validation/nested-declarator2.c
+++ b/validation/nested-declarator2.c
@@ -27,7 +27,7 @@ static int (-bad2);
 static void [2](*bad3);
 /*
  * check-name: more on handling of ( in direct-declarator
- * check-error-start:
+ * check-error-start
 nested-declarator2.c:17:1: warning: non-ANSI definition of function 'w1'
 nested-declarator2.c:21:21: warning: non-ANSI function declaration of function '<noident>'
 nested-declarator2.c:22:16: warning: variadic functions must have one named argument
@@ -37,5 +37,5 @@ nested-declarator2.c:26:13: error: Expected ) in nested declarator
 nested-declarator2.c:26:13: error: got -
 nested-declarator2.c:27:16: error: Expected ; at the end of type declaration
 nested-declarator2.c:27:16: error: got (
- * check-error-end:
+ * check-error-end
  */
diff --git a/validation/optim/canonical-cmp.c b/validation/optim/canonical-cmp.c
index 19b416310..6f3b5180e 100644
--- a/validation/optim/canonical-cmp.c
+++ b/validation/optim/canonical-cmp.c
@@ -21,7 +21,7 @@ uint uat(uint p, uint a) { return (123 <  p) ? a : 0; }
  * check-name: canonical-cmp
  * check-command: test-linearize -Wno-decl $file
  *
- * check-output-exclude: \$123,
+ * check-output-excludes: \$123,
  *
  * check-output-start
 seq:
diff --git a/validation/optim/canonical-fcmp.c b/validation/optim/canonical-fcmp.c
index e3e758a9b..d098da64f 100644
--- a/validation/optim/canonical-fcmp.c
+++ b/validation/optim/canonical-fcmp.c
@@ -20,7 +20,7 @@ int nfcmp_ge(double a) { return !(g <  a); }
  * check-name: canonical-cmp
  * check-command: test-linearize -Wno-decl $file
  *
- * check-output-exclude: \$123,
+ * check-output-excludes: \$123,
  *
  * check-output-start
 fcmp_eq:
diff --git a/validation/reserved.c b/validation/reserved.c
index 29554560b..6a2163e9a 100644
--- a/validation/reserved.c
+++ b/validation/reserved.c
@@ -81,7 +81,7 @@ static int (__builtin_va_list);
 
 /*
  * check-name: const et.al. are reserved identifiers
- * check-error-start:
+ * check-error-start
 reserved.c:1:12: error: Trying to use reserved word 'auto' as identifier
 reserved.c:2:12: error: Trying to use reserved word 'break' as identifier
 reserved.c:3:12: error: Trying to use reserved word 'case' as identifier
@@ -154,5 +154,5 @@ reserved.c:77:12: error: Trying to use reserved word '__builtin_ms_va_list' as i
 reserved.c:78:12: error: Trying to use reserved word '__builtin_offsetof' as identifier
 reserved.c:79:12: error: Trying to use reserved word '__builtin_types_compatible_p' as identifier
 reserved.c:80:12: error: Trying to use reserved word '__builtin_va_list' as identifier
- * check-error-end:
+ * check-error-end
  */
diff --git a/validation/typedef_shadow.c b/validation/typedef_shadow.c
index e52de80f2..e8e4c229b 100644
--- a/validation/typedef_shadow.c
+++ b/validation/typedef_shadow.c
@@ -5,9 +5,9 @@ static void f(int T)
 }
 /*
  * check-name: typedef shadowing
- * check-error-start:
+ * check-error-start
 typedef_shadow.c:4:16: warning: 'T' has implicit type
 typedef_shadow.c:4:18: error: Expected ; at end of declaration
 typedef_shadow.c:4:18: error: got a
- * check-error-end:
+ * check-error-end
  */
-- 
2.15.0

