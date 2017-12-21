From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] add testcases for multiple deref of calls
Date: Thu, 21 Dec 2017 01:19:13 +0100
Message-ID: <20171221001915.57047-2-luc.vanoostenryck@gmail.com>
References: <20171221001915.57047-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46458 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756134AbdLUAVZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Dec 2017 19:21:25 -0500
Received: by mail-wm0-f66.google.com with SMTP id r78so13051903wme.5
        for <linux-sparse@vger.kernel.org>; Wed, 20 Dec 2017 16:21:24 -0800 (PST)
In-Reply-To: <20171221001915.57047-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/function-pointer-type.c | 4 ++++
 validation/linear/call-builtin.c   | 6 +++++-
 validation/linear/call-direct.c    | 6 +++++-
 validation/linear/call-indirect.c  | 5 ++++-
 validation/linear/call-inline.c    | 6 +++++-
 5 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/validation/function-pointer-type.c b/validation/function-pointer-type.c
index 8fd792b3b..cb1f59b2a 100644
--- a/validation/function-pointer-type.c
+++ b/validation/function-pointer-type.c
@@ -2,8 +2,12 @@ extern int fun(void);
 
 void fa(void) { int (*f)(void); f = &fun; }
 void f0(void) { int (*f)(void); f = fun; }	// C99,C11 6.3.2.1p4
+void f1(void) { int (*f)(void); f = *fun; }	// C99,C11 6.5.3.2p4
+void f2(void) { int (*f)(void); f = **fun; }	// C99,C11 6.5.3.2p4
+void f3(void) { int (*f)(void); f = ***fun; }	// C99,C11 6.5.3.2p4
 
 /*
  * check-name: type of function pointers
  * check-command: sparse -Wno-decl $file
+ * check-known-to-fail
  */
diff --git a/validation/linear/call-builtin.c b/validation/linear/call-builtin.c
index af0148aa4..b0261e992 100644
--- a/validation/linear/call-builtin.c
+++ b/validation/linear/call-builtin.c
@@ -3,12 +3,16 @@ typedef unsigned int u32;
 u32 ff(u32 a) { return __builtin_popcount(a); }
 
 u32 f0(u32 a) { return (__builtin_popcount)(a); }
+u32 f1(u32 a) { return (*__builtin_popcount)(a); }	// C99,C11 6.5.3.2p4
+u32 f2(u32 a) { return (**__builtin_popcount)(a); }	// C99,C11 6.5.3.2p4
+u32 f3(u32 a) { return (***__builtin_popcount)(a); }	// C99,C11 6.5.3.2p4
 
 /*
  * check-name: builtin calls
  * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: load
- * check-output-pattern(2): call\..*__builtin_.*, %arg1
+ * check-output-pattern(5): call\..*__builtin_.*, %arg1
  */
diff --git a/validation/linear/call-direct.c b/validation/linear/call-direct.c
index 78321ab02..176bfe229 100644
--- a/validation/linear/call-direct.c
+++ b/validation/linear/call-direct.c
@@ -3,12 +3,16 @@ extern int fun(void);
 int ff(void) { return fun(); }
 
 int f0(void) { return (fun)(); }
+int f1(void) { return (*fun)(); }	// C99,C11 6.5.3.2p4
+int f2(void) { return (**fun)(); }	// C99,C11 6.5.3.2p4
+int f3(void) { return (***fun)(); }	// C99,C11 6.5.3.2p4
 
 /*
  * check-name: direct calls
  * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: load
- * check-output-pattern(2): call\..* fun
+ * check-output-pattern(5): call\..* fun
  */
diff --git a/validation/linear/call-indirect.c b/validation/linear/call-indirect.c
index f5f2adaf1..d8797b024 100644
--- a/validation/linear/call-indirect.c
+++ b/validation/linear/call-indirect.c
@@ -2,12 +2,15 @@ int gg(int (*fun)(void)) { return fun(); }
 
 int g0(int (*fun)(void)) { return (fun)(); }
 int g1(int (*fun)(void)) { return (*fun)(); }	// C99,C11 6.5.3.2p4
+int g2(int (*fun)(void)) { return (**fun)(); }	// C99,C11 6.5.3.2p4
+int g3(int (*fun)(void)) { return (***fun)(); }	// C99,C11 6.5.3.2p4
 
 /*
  * check-name: indirect calls
  * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: load
- * check-output-pattern(3): call\..* %arg1
+ * check-output-pattern(5): call\..* %arg1
  */
diff --git a/validation/linear/call-inline.c b/validation/linear/call-inline.c
index 32f32461c..d931a3cba 100644
--- a/validation/linear/call-inline.c
+++ b/validation/linear/call-inline.c
@@ -3,13 +3,17 @@ static inline int fun(void) { return 42; }
 int fi(void) { return fun(); }
 
 int i0(void) { return (fun)(); }
+int i1(void) { return (*fun)(); }		// C99,C11 6.5.3.2p4
+int i2(void) { return (**fun)(); }		// C99,C11 6.5.3.2p4
+int i3(void) { return (***fun)(); }		// C99,C11 6.5.3.2p4
 
 /*
  * check-name: inline calls
  * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: load
  * check-output-excludes: call
- * check-output-pattern(2): ret\..* \\$42
+ * check-output-pattern(5): ret\..* \\$42
  */
-- 
2.15.0

