From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/6] testsuite: remove unneeded './' before commands
Date: Sun, 28 May 2017 21:29:05 +0200
Message-ID: <20170528192906.1023-6-luc.vanoostenryck@gmail.com>
References: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36569 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdE1T3R (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 May 2017 15:29:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id k15so12962817wmh.3
        for <linux-sparse@vger.kernel.org>; Sun, 28 May 2017 12:29:17 -0700 (PDT)
In-Reply-To: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Some testcase have their command specified as './<command name>'
but the './' part is unneeded as all commands are first prefixed
with '../' before being run.

Furthermore, the possible presence of these './' force the
use of 'basename' when filtering out the disabled commands.

Change this by stripping the './' where is was used.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/backend/arithmetic-ops.c   | 2 +-
 validation/backend/array.c            | 2 +-
 validation/backend/bitwise-ops.c      | 2 +-
 validation/backend/bool-test.c        | 2 +-
 validation/backend/cast.c             | 2 +-
 validation/backend/cmp-ops.c          | 2 +-
 validation/backend/extern.c           | 2 +-
 validation/backend/function-ptr.c     | 2 +-
 validation/backend/hello.c            | 2 +-
 validation/backend/int-cond.c         | 2 +-
 validation/backend/load-type.c        | 2 +-
 validation/backend/logical-ops.c      | 2 +-
 validation/backend/loop.c             | 2 +-
 validation/backend/loop2.c            | 2 +-
 validation/backend/ptrcast.c          | 2 +-
 validation/backend/store-type.c       | 2 +-
 validation/backend/struct-access.c    | 2 +-
 validation/backend/struct.c           | 2 +-
 validation/backend/sum.c              | 2 +-
 validation/backend/union.c            | 2 +-
 validation/backend/void-return-type.c | 2 +-
 validation/prototype.c                | 2 +-
 22 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/validation/backend/arithmetic-ops.c b/validation/backend/arithmetic-ops.c
index 7c299d033..55996d9c3 100644
--- a/validation/backend/arithmetic-ops.c
+++ b/validation/backend/arithmetic-ops.c
@@ -90,5 +90,5 @@ static unsigned int umod(unsigned int x, unsigned int y)
 
 /*
  * check-name: Arithmetic operator code generation
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/array.c b/validation/backend/array.c
index bd3ec5960..4e87b79ee 100644
--- a/validation/backend/array.c
+++ b/validation/backend/array.c
@@ -2,5 +2,5 @@ static char array[128];
 
 /*
  * check-name: Array code generation
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/bitwise-ops.c b/validation/backend/bitwise-ops.c
index 659c76398..9f61fca14 100644
--- a/validation/backend/bitwise-ops.c
+++ b/validation/backend/bitwise-ops.c
@@ -60,5 +60,5 @@ static unsigned int unot(unsigned int x)
 
 /*
  * check-name: Bitwise operator code generation
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/bool-test.c b/validation/backend/bool-test.c
index a6f33a1ac..cd20a4bd9 100644
--- a/validation/backend/bool-test.c
+++ b/validation/backend/bool-test.c
@@ -5,5 +5,5 @@ static _Bool return_false(void)
 
 /*
  * check-name: Boolean type code generation
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/cast.c b/validation/backend/cast.c
index 598b16aab..4ca531b53 100644
--- a/validation/backend/cast.c
+++ b/validation/backend/cast.c
@@ -46,5 +46,5 @@ DEFINE_CASTS(double)
 
 /*
  * check-name: Cast code generation
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/cmp-ops.c b/validation/backend/cmp-ops.c
index a5f736d7a..c7918da1a 100644
--- a/validation/backend/cmp-ops.c
+++ b/validation/backend/cmp-ops.c
@@ -80,5 +80,5 @@ static int setfge(float x, float y)
 
 /*
  * check-name: Comparison operator code generation
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/extern.c b/validation/backend/extern.c
index 24cbae557..b5c14d842 100644
--- a/validation/backend/extern.c
+++ b/validation/backend/extern.c
@@ -7,5 +7,5 @@ static unsigned long bar(void)
 
 /*
  * check-name: Extern symbol code generation
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/function-ptr.c b/validation/backend/function-ptr.c
index fc022b3cd..35fb678af 100644
--- a/validation/backend/function-ptr.c
+++ b/validation/backend/function-ptr.c
@@ -7,5 +7,5 @@ static int run(fn_t fn, int x, int y)
 
 /*
  * check-name: Function pointer code generation
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/hello.c b/validation/backend/hello.c
index 79905004e..b0e514be4 100644
--- a/validation/backend/hello.c
+++ b/validation/backend/hello.c
@@ -9,5 +9,5 @@ int main(int argc, char *argv[])
 
 /*
  * check-name: 'hello, world' code generation
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/int-cond.c b/validation/backend/int-cond.c
index 48b25a776..2a5a43482 100644
--- a/validation/backend/int-cond.c
+++ b/validation/backend/int-cond.c
@@ -26,5 +26,5 @@ static long bar_bool(_Bool a, long b, long c)
 
 /*
  * check-name: Non-bool condition values in branch/select
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/load-type.c b/validation/backend/load-type.c
index 80416cad9..825567694 100644
--- a/validation/backend/load-type.c
+++ b/validation/backend/load-type.c
@@ -8,5 +8,5 @@ static void test(void) {
 
 /*
  * check-name: Type of loaded objects
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/logical-ops.c b/validation/backend/logical-ops.c
index 8b2a6a85b..ec5b7c6dc 100644
--- a/validation/backend/logical-ops.c
+++ b/validation/backend/logical-ops.c
@@ -20,5 +20,5 @@ static unsigned int uor_bool(unsigned int x, unsigned int y)
 
 /*
  * check-name: Logical operator code generation
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/loop.c b/validation/backend/loop.c
index 31054f52f..181a00689 100644
--- a/validation/backend/loop.c
+++ b/validation/backend/loop.c
@@ -17,5 +17,5 @@ int foo (int x)
 
 /*
  * check-name: Loops
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/loop2.c b/validation/backend/loop2.c
index 279af2146..d827b5d32 100644
--- a/validation/backend/loop2.c
+++ b/validation/backend/loop2.c
@@ -10,5 +10,5 @@ static void test(void)
 
 /*
  * check-name: Loops with unused counter
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/ptrcast.c b/validation/backend/ptrcast.c
index 46f8add82..8e4df0700 100644
--- a/validation/backend/ptrcast.c
+++ b/validation/backend/ptrcast.c
@@ -5,5 +5,5 @@ static char *ptrcast(unsigned long *x)
 
 /*
  * check-name: Pointer cast code generation
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/store-type.c b/validation/backend/store-type.c
index 9e2ce73fa..2246a3b3b 100644
--- a/validation/backend/store-type.c
+++ b/validation/backend/store-type.c
@@ -8,5 +8,5 @@ static void set(struct foo *f)
 
 /*
  * check-name: Type of stored objects
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/struct-access.c b/validation/backend/struct-access.c
index 884b4706d..3d193e331 100644
--- a/validation/backend/struct-access.c
+++ b/validation/backend/struct-access.c
@@ -24,5 +24,5 @@ static void store_d(struct st *st, int *d)
 
 /*
  * check-name: struct access code generation
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/struct.c b/validation/backend/struct.c
index 905339afb..083b05c3b 100644
--- a/validation/backend/struct.c
+++ b/validation/backend/struct.c
@@ -21,5 +21,5 @@ static struct unnamed un;
 
 /*
  * check-name: Struct code generation
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/sum.c b/validation/backend/sum.c
index c9451d4bc..06042999f 100644
--- a/validation/backend/sum.c
+++ b/validation/backend/sum.c
@@ -19,7 +19,7 @@ int main(int argc, char **argv)
 
 /*
  * check-name: sum from 1 to n
- * check-command: ./sparsei $file
+ * check-command: sparsei $file
  *
  * check-output-start
 15
diff --git a/validation/backend/union.c b/validation/backend/union.c
index e155f6ad1..7ec35c7a8 100644
--- a/validation/backend/union.c
+++ b/validation/backend/union.c
@@ -8,5 +8,5 @@ static union foo foo;
 
 /*
  * check-name: Union code generation
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/backend/void-return-type.c b/validation/backend/void-return-type.c
index b282fdee0..e540a9d41 100644
--- a/validation/backend/void-return-type.c
+++ b/validation/backend/void-return-type.c
@@ -9,5 +9,5 @@ static void *bar(void *p)
 
 /*
  * check-name: void return type code generation
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
diff --git a/validation/prototype.c b/validation/prototype.c
index 481cc93e0..c338e1619 100644
--- a/validation/prototype.c
+++ b/validation/prototype.c
@@ -2,5 +2,5 @@ static int prototype(void);
 
 /*
  * check-name: Compile skip function prototype
- * check-command: ./sparsec -c $file -o tmp.o
+ * check-command: sparsec -c $file -o tmp.o
  */
-- 
2.13.0

