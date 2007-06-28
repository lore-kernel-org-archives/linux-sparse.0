From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 6/6] Add a simple test script,
	embed expected results into test files
Date: Thu, 28 Jun 2007 01:40:19 -0400
Message-ID: <20070628054019.30704.64375.stgit@dv.roinet.com>
References: <20070628053954.30704.66440.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:38940 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758566AbXF1FkV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 01:40:21 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1I3mjs-0008Lk-Hp
	for linux-sparse@vger.kernel.org; Thu, 28 Jun 2007 01:40:20 -0400
Received: from localhost.localdomain ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1I3mjs-00080w-0h
	for linux-sparse@vger.kernel.org; Thu, 28 Jun 2007 01:40:20 -0400
In-Reply-To: <20070628053954.30704.66440.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 validation/.gitignore                         |    3 +
 validation/address_space.c                    |    6 +++
 validation/bad-array-designated-initializer.c |    6 +++
 validation/bad-assignment.c                   |    5 ++
 validation/bad-cast.c                         |    6 +++
 validation/bad-ternary-cond.c                 |    5 ++
 validation/badtype2.c                         |   11 +++++
 validation/badtype3.c                         |   13 ++++++
 validation/badtype4.c                         |    5 ++
 validation/builtin_safe1.c                    |   12 +++++
 validation/check_byte_count-ice.c             |    5 ++
 validation/choose_expr.c                      |   10 ++++
 validation/cond_expr.c                        |    5 ++
 validation/context.c                          |   17 +++++++
 validation/foul-bitwise.c                     |    7 +++
 validation/initializer-entry-defined-twice.c  |    7 +++
 validation/noderef.c                          |    6 +++
 validation/non-pointer-null.c                 |    4 ++
 validation/old-initializer.c                  |    4 ++
 validation/preprocessor-loop.c                |    4 ++
 validation/preprocessor1.c                    |    5 ++
 validation/preprocessor10.c                   |    5 ++
 validation/preprocessor11.c                   |   12 +++++
 validation/preprocessor12.c                   |    5 ++
 validation/preprocessor13.c                   |    7 +++
 validation/preprocessor14.c                   |    5 ++
 validation/preprocessor15.c                   |    5 ++
 validation/preprocessor18.c                   |    5 ++
 validation/preprocessor19.c                   |    7 +++
 validation/preprocessor2.c                    |    5 ++
 validation/preprocessor20.c                   |    5 ++
 validation/preprocessor3.c                    |    6 +++
 validation/preprocessor4.c                    |    5 ++
 validation/preprocessor5.c                    |    5 ++
 validation/preprocessor7.c                    |    5 ++
 validation/preprocessor8.c                    |    9 ++++
 validation/preprocessor9.c                    |    5 ++
 validation/run-tests                          |   58 +++++++++++++++++++++++++
 38 files changed, 300 insertions(+), 0 deletions(-)

diff --git a/validation/.gitignore b/validation/.gitignore
new file mode 100644
index 0000000..515eae1
--- /dev/null
+++ b/validation/.gitignore
@@ -0,0 +1,3 @@
+*.diff
+*.exp
+*.res
diff --git a/validation/address_space.c b/validation/address_space.c
index 377890a..efd98b7 100644
--- a/validation/address_space.c
+++ b/validation/address_space.c
@@ -6,3 +6,9 @@ static int sys_do_stuff(void __user *user_addr)
 {
 	return poke_memory(user_addr);
 }
+
+/* SPARSE
+address_space.c:7:21: warning: incorrect type in argument 1 (different address spaces)
+address_space.c:7:21:    expected void *addr
+address_space.c:7:21:    got void *user_addr<asn:1>
+   SPARSE */
diff --git a/validation/bad-array-designated-initializer.c b/validation/bad-array-designated-initializer.c
index 636fa63..def6944 100644
--- a/validation/bad-array-designated-initializer.c
+++ b/validation/bad-array-designated-initializer.c
@@ -2,3 +2,9 @@ static int a[] = {
 	[0] = 0,		// OK
 	[\0] = 1,		// KO
 };
+
+/* SPARSE
+bad-array-designated-initializer.c:3:3: error: Expected constant expression
+bad-array-designated-initializer.c:3:3: error: Expected } at end of initializer
+bad-array-designated-initializer.c:3:3: error: got \
+   SPARSE */
diff --git a/validation/bad-assignment.c b/validation/bad-assignment.c
index 3b66a11..3054f86 100644
--- a/validation/bad-assignment.c
+++ b/validation/bad-assignment.c
@@ -4,3 +4,8 @@ static int foo(int a)
 
 	return a;
 }
+
+/* SPARSE
+bad-assignment.c:3:6: error: Expected ; at end of statement
+bad-assignment.c:3:6: error: got \
+   SPARSE */
diff --git a/validation/bad-cast.c b/validation/bad-cast.c
index bafd5a2..ed00150 100644
--- a/validation/bad-cast.c
+++ b/validation/bad-cast.c
@@ -4,3 +4,9 @@ static int foo(int a)
 {
 	return (struct/st *) a;
 }
+
+/* SPARSE
+bad-cast.c:5:16: error: expected declaration
+bad-cast.c:5:16: error: Expected ) at end of cast operator
+bad-cast.c:5:16: error: got /
+   SPARSE */
diff --git a/validation/bad-ternary-cond.c b/validation/bad-ternary-cond.c
index d502931..42dc1a5 100644
--- a/validation/bad-ternary-cond.c
+++ b/validation/bad-ternary-cond.c
@@ -5,3 +5,8 @@ static int foo(int a)
 {
 	return a ?? 1 : 0;
 }
+
+/* SPARSE
+bad-ternary-cond.c:6:12: error: Expected : in conditional expression
+bad-ternary-cond.c:6:12: error: got ?
+   SPARSE */
diff --git a/validation/badtype2.c b/validation/badtype2.c
index aad725d..0920145 100644
--- a/validation/badtype2.c
+++ b/validation/badtype2.c
@@ -8,3 +8,14 @@ static undef foo(char *c)
     return bar();
   }
 }
+
+/* SPARSE
+badtype2.c:2:14: error: Expected ; at end of declaration
+badtype2.c:2:14: error: got bar
+badtype2.c:3:14: error: Expected ; at end of declaration
+badtype2.c:3:14: error: got foo
+badtype2.c:6:3: error: Trying to use reserved word 'switch' as identifier
+badtype2.c:7:3: error: not in switch scope
+badtype2.c:10:1: error: Expected ; end of type declaration
+badtype2.c:10:1: error: got }
+   SPARSE */
diff --git a/validation/badtype3.c b/validation/badtype3.c
index 198ef87..edd90f9 100644
--- a/validation/badtype3.c
+++ b/validation/badtype3.c
@@ -8,3 +8,16 @@ foo (int (*func) (undef, void *), void *data)
   }
   return err;
 }
+
+/* SPARSE
+badtype3.c:2:19: error: Expected ) in nested declarator
+badtype3.c:2:19: error: got undef
+badtype3.c:5:3: error: Trying to use reserved word 'while' as identifier
+badtype3.c:7:7: error: break/continue not in iterator scope
+badtype3.c:9:3: error: Trying to use reserved word 'return' as identifier
+badtype3.c:9:10: error: Expected ; at end of declaration
+badtype3.c:9:10: error: got err
+badtype3.c:10:1: error: Expected ; end of type declaration
+badtype3.c:10:1: error: got }
+badtype3.c:6:11: error: undefined identifier 'func'
+   SPARSE */
diff --git a/validation/badtype4.c b/validation/badtype4.c
index 4f0c494..8020155 100644
--- a/validation/badtype4.c
+++ b/validation/badtype4.c
@@ -5,3 +5,8 @@ void a(void)
 		break;
 	}
 }
+
+/* SPARSE
+badtype4.c:3:9: error: undefined identifier 'x'
+badtype4.c:4:7: error: incompatible types for 'case' statement
+   SPARSE */
diff --git a/validation/builtin_safe1.c b/validation/builtin_safe1.c
index d95e46b..f5adb04 100644
--- a/validation/builtin_safe1.c
+++ b/validation/builtin_safe1.c
@@ -24,3 +24,15 @@ static int foo(int x, int y)
   return x;
 }
 
+
+/* SPARSE
+builtin_safe1.c:13:3: warning: Macro argument with side effects
+builtin_safe1.c:14:3: warning: Macro argument with side effects
+builtin_safe1.c:15:3: warning: Macro argument with side effects
+builtin_safe1.c:16:3: warning: Macro argument with side effects
+builtin_safe1.c:17:3: warning: Macro argument with side effects
+builtin_safe1.c:18:3: warning: Macro argument with side effects
+builtin_safe1.c:19:3: warning: Macro argument with side effects
+builtin_safe1.c:22:3: warning: Macro argument with side effects
+builtin_safe1.c:23:3: warning: Macro argument with side effects
+   SPARSE */
diff --git a/validation/check_byte_count-ice.c b/validation/check_byte_count-ice.c
index e58312d..d400542 100644
--- a/validation/check_byte_count-ice.c
+++ b/validation/check_byte_count-ice.c
@@ -4,3 +4,8 @@ static void foo(void *a)
 {
 	memset(foo, + ', 20);
 }
+
+/* SPARSE
+check_byte_count-ice.c:5:18: error: Bad character constant
+check_byte_count-ice.c:5:8: error: not enough arguments for function memset
+   SPARSE */
diff --git a/validation/choose_expr.c b/validation/choose_expr.c
index 55bfa0c..482ec21 100644
--- a/validation/choose_expr.c
+++ b/validation/choose_expr.c
@@ -2,3 +2,13 @@ static int x = __builtin_choose_expr(0,(char *)0,(void)0);
 static int y = __builtin_choose_expr(1,(char *)0,(void)0);
 static char s[42];
 static int z = 1/(sizeof(__builtin_choose_expr(1,s,0)) - 42);
+
+/* SPARSE
+choose_expr.c:1:51: warning: incorrect type in initializer (different types)
+choose_expr.c:1:51:    expected int static [signed] [toplevel] x
+choose_expr.c:1:51:    got void <noident>
+choose_expr.c:2:41: warning: incorrect type in initializer (different base types)
+choose_expr.c:2:41:    expected int static [signed] [toplevel] y
+choose_expr.c:2:41:    got char *<noident>
+choose_expr.c:4:17: warning: division by zero
+   SPARSE */
diff --git a/validation/cond_expr.c b/validation/cond_expr.c
index d5d9e6f..280d358 100644
--- a/validation/cond_expr.c
+++ b/validation/cond_expr.c
@@ -9,3 +9,8 @@ int a(void)
 {
 	return ~(y ? : x);	/* should warn */
 }
+
+/* SPARSE
+cond_expr.c:10:9: error: incompatible types for operation (~)
+cond_expr.c:10:9:    argument has type double 
+   SPARSE */
diff --git a/validation/context.c b/validation/context.c
index f877ec2..dbbfc4e 100644
--- a/validation/context.c
+++ b/validation/context.c
@@ -314,3 +314,20 @@ static void warn_cond_lock1(void)
         condition2 = 1; /* do stuff */
     r();
 }
+
+/* SPARSE
+context.c:69:13: warning: context imbalance in 'warn_lock1' - wrong count at exit
+context.c:74:13: warning: context imbalance in 'warn_lock2' - wrong count at exit
+context.c:81:13: warning: context imbalance in 'warn_lock3' - wrong count at exit
+context.c:88:13: warning: context imbalance in 'warn_unlock1' - unexpected unlock
+context.c:93:13: warning: context imbalance in 'warn_unlock2' - unexpected unlock
+context.c:131:12: warning: context imbalance in 'warn_if1' - wrong count at exit
+context.c:140:12: warning: context imbalance in 'warn_if2' - different lock contexts for basic block
+context.c:202:2: warning: context imbalance in 'warn_while1' - different lock contexts for basic block
+context.c:210:3: warning: context imbalance in 'warn_while2' - unexpected unlock
+context.c:216:2: warning: context imbalance in 'warn_while3' - wrong count at exit
+context.c:274:13: warning: context imbalance in 'warn_goto1' - wrong count at exit
+context.c:283:13: warning: context imbalance in 'warn_goto2' - wrong count at exit
+context.c:300:5: warning: context imbalance in 'warn_goto3' - different lock contexts for basic block
+context.c:315:5: warning: context imbalance in 'warn_cond_lock1' - different lock contexts for basic block
+   SPARSE */
diff --git a/validation/foul-bitwise.c b/validation/foul-bitwise.c
index ca84be6..d8e8ef2 100644
--- a/validation/foul-bitwise.c
+++ b/validation/foul-bitwise.c
@@ -18,3 +18,10 @@ static __le16 bar(__le16 a)
 {
 	return -a;
 }
+
+/* SPARSE
+foul-bitwise.c:9:9: warning: restricted degrades to integer
+foul-bitwise.c:9:15: warning: restricted degrades to integer
+foul-bitwise.c:19:9: error: incompatible types for operation (-)
+foul-bitwise.c:19:9:    argument has type restricted unsigned short [usertype] a
+   SPARSE */
diff --git a/validation/initializer-entry-defined-twice.c b/validation/initializer-entry-defined-twice.c
index 6c48c52..1c04a62 100644
--- a/validation/initializer-entry-defined-twice.c
+++ b/validation/initializer-entry-defined-twice.c
@@ -41,3 +41,10 @@ static struct same_offset not_an_error = {
 	.field1 = { },
 	.field2 = 0
 };
+
+/* SPARSE
+initializer-entry-defined-twice.c:10:3: error: Initializer entry defined twice
+initializer-entry-defined-twice.c:11:3:   also defined here
+initializer-entry-defined-twice.c:26:4: error: Initializer entry defined twice
+initializer-entry-defined-twice.c:27:4:   also defined here
+   SPARSE */
diff --git a/validation/noderef.c b/validation/noderef.c
index 15be327..0666376 100644
--- a/validation/noderef.c
+++ b/validation/noderef.c
@@ -40,3 +40,9 @@ static void h(void)
 	r = py->a+1;
 	r = &py->a[0];
 }
+
+/* SPARSE
+noderef.c:24:5: warning: incorrect type in assignment (different modifiers)
+noderef.c:24:5:    expected char *[noderef] *q2
+noderef.c:24:5:    got char [noderef] **<noident>
+   SPARSE */
diff --git a/validation/non-pointer-null.c b/validation/non-pointer-null.c
index 2d09aa3..29195ed 100644
--- a/validation/non-pointer-null.c
+++ b/validation/non-pointer-null.c
@@ -1 +1,5 @@
 static void *p = 0;
+
+/* SPARSE
+non-pointer-null.c:1:18: warning: Using plain integer as NULL pointer
+   SPARSE */
diff --git a/validation/old-initializer.c b/validation/old-initializer.c
index 5ae8516..ed1c538 100644
--- a/validation/old-initializer.c
+++ b/validation/old-initializer.c
@@ -3,3 +3,7 @@ struct s {
 };
 
 static struct s the_s = { i: 1 };
+
+/* SPARSE
+old-initializer.c:5:27: warning: obsolete struct initializer, use C99 syntax
+   SPARSE */
diff --git a/validation/preprocessor-loop.c b/validation/preprocessor-loop.c
index 035777e..d51cfc3 100644
--- a/validation/preprocessor-loop.c
+++ b/validation/preprocessor-loop.c
@@ -1,2 +1,6 @@
 #if 1
 #if
+
+/* SPARSE
+preprocessor-loop.c:2:2: error: unterminated preprocessor conditional
+   SPARSE */
diff --git a/validation/preprocessor1.c b/validation/preprocessor1.c
index 5ae20aa..5e9f234 100644
--- a/validation/preprocessor1.c
+++ b/validation/preprocessor1.c
@@ -12,3 +12,8 @@
 #define bar func(
 #define foo bar foo
 foo )
+
+/* SPARSE
+builtin:0:0: error: Expected ; at end of declaration
+builtin:0:0: error: got end-of-input
+   SPARSE */
diff --git a/validation/preprocessor10.c b/validation/preprocessor10.c
index 7fcac36..137bafd 100644
--- a/validation/preprocessor10.c
+++ b/validation/preprocessor10.c
@@ -11,3 +11,8 @@ defined
 #else
 undefined
 #endif
+
+/* SPARSE
+builtin:0:0: error: Expected ; at end of declaration
+builtin:0:0: error: got end-of-input
+   SPARSE */
diff --git a/validation/preprocessor11.c b/validation/preprocessor11.c
index 4c6c1c0..276ccf6 100644
--- a/validation/preprocessor11.c
+++ b/validation/preprocessor11.c
@@ -8,3 +8,15 @@
 #define H(x...,y)
 #define I(...+
 #define J(x,y)
+
+/* SPARSE
+preprocessor11.c:1:11: error: "1" may not appear in macro parameter list
+preprocessor11.c:2:11: error: missing ')' in macro parameter list
+preprocessor11.c:3:12: error: missing ')' in macro parameter list
+preprocessor11.c:4:11: error: parameter name missing
+preprocessor11.c:5:11: error: __VA_ARGS__ can only appear in the expansion of a C99 variadic macro
+preprocessor11.c:6:12: error: "+" may not appear in macro parameter list
+preprocessor11.c:7:12: error: missing ')' in macro parameter list
+preprocessor11.c:8:12: error: missing ')' in macro parameter list
+preprocessor11.c:9:11: error: missing ')' in macro parameter list
+   SPARSE */
diff --git a/validation/preprocessor12.c b/validation/preprocessor12.c
index 385c1a7..b86cab0 100644
--- a/validation/preprocessor12.c
+++ b/validation/preprocessor12.c
@@ -5,3 +5,8 @@
 A(1)
 A(1,2)
 A(1,2,3)
+
+/* SPARSE
+preprocessor12.c:5:1: error: Expected ; end of type declaration
+preprocessor12.c:5:1: error: got 1
+   SPARSE */
diff --git a/validation/preprocessor13.c b/validation/preprocessor13.c
index 96c813e..afbdc4f 100644
--- a/validation/preprocessor13.c
+++ b/validation/preprocessor13.c
@@ -5,3 +5,10 @@
 A(1)
 A(1,2)
 A(1,2,3)
+
+/* SPARSE
+preprocessor13.c:6:1: error: '##' failed: concatenation is not a valid token
+preprocessor13.c:7:1: error: '##' failed: concatenation is not a valid token
+preprocessor13.c:5:1: error: Expected ; end of type declaration
+preprocessor13.c:5:1: error: got 1
+   SPARSE */
diff --git a/validation/preprocessor14.c b/validation/preprocessor14.c
index 001f1f2..85210d1 100644
--- a/validation/preprocessor14.c
+++ b/validation/preprocessor14.c
@@ -5,3 +5,8 @@
 A(,1)
 #define B(x,y,...) x##,##__VA_ARGS__
 B(,1)
+
+/* SPARSE
+preprocessor14.c:5:1: error: Expected ; end of type declaration
+preprocessor14.c:5:1: error: got ,
+   SPARSE */
diff --git a/validation/preprocessor15.c b/validation/preprocessor15.c
index 0a2dfd7..63f64fe 100644
--- a/validation/preprocessor15.c
+++ b/validation/preprocessor15.c
@@ -5,3 +5,8 @@
 #if D(A,B) B
 D(1,2)
 #endif
+
+/* SPARSE
+preprocessor15.c:6:1: error: Expected ; end of type declaration
+preprocessor15.c:6:1: error: got 12
+   SPARSE */
diff --git a/validation/preprocessor18.c b/validation/preprocessor18.c
index b5988bf..8fe58e4 100644
--- a/validation/preprocessor18.c
+++ b/validation/preprocessor18.c
@@ -1,3 +1,8 @@
 /* one warning for each, please... */
 #define 1
 #undef 1
+
+/* SPARSE
+preprocessor18.c:2:2: error: expected identifier to 'define'
+preprocessor18.c:3:2: error: expected identifier to 'undef'
+   SPARSE */
diff --git a/validation/preprocessor19.c b/validation/preprocessor19.c
index 0f7da47..f0c01de 100644
--- a/validation/preprocessor19.c
+++ b/validation/preprocessor19.c
@@ -3,3 +3,10 @@
 #define A x
 #define A y
 A
+
+/* SPARSE
+preprocessor19.c:4:9: warning: preprocessor token A redefined
+preprocessor19.c:3:9: this was the original definition
+builtin:0:0: error: Expected ; at end of declaration
+builtin:0:0: error: got end-of-input
+   SPARSE */
diff --git a/validation/preprocessor2.c b/validation/preprocessor2.c
index 340938e..36740b0 100644
--- a/validation/preprocessor2.c
+++ b/validation/preprocessor2.c
@@ -13,3 +13,8 @@
 #define BINARY(x, y) x + y
 
 UNARY(TWO)
+
+/* SPARSE
+preprocessor2.c:15:1: error: Expected ; at end of declaration
+preprocessor2.c:15:1: error: got +
+   SPARSE */
diff --git a/validation/preprocessor20.c b/validation/preprocessor20.c
index 68c0ccc..3101e93 100644
--- a/validation/preprocessor20.c
+++ b/validation/preprocessor20.c
@@ -2,3 +2,8 @@
 #define X
 #define Y
 #include "preprocessor20.h"
+
+/* SPARSE
+preprocessor20.h:2:1: error: Expected ; at end of declaration
+preprocessor20.h:2:1: error: got B
+   SPARSE */
diff --git a/validation/preprocessor3.c b/validation/preprocessor3.c
index 71b9acd..738154e 100644
--- a/validation/preprocessor3.c
+++ b/validation/preprocessor3.c
@@ -35,3 +35,9 @@ A()                     // B ( )
 SCAN( A() )             // A ( )
 SCAN(SCAN( A() ))       // B ( )
 SCAN(SCAN(SCAN( A() ))) // A ( )
+
+/* SPARSE
+preprocessor3.c:34:1: warning: non-ANSI function declaration of function 'B'
+preprocessor3.c:35:1: error: Expected ; at end of declaration
+preprocessor3.c:35:1: error: got A
+   SPARSE */
diff --git a/validation/preprocessor4.c b/validation/preprocessor4.c
index 8b8c4da..1620a8b 100644
--- a/validation/preprocessor4.c
+++ b/validation/preprocessor4.c
@@ -8,3 +8,8 @@
 
 mac(foo)
 
+
+/* SPARSE
+builtin:0:0: error: Expected ; at end of declaration
+builtin:0:0: error: got end-of-input
+   SPARSE */
diff --git a/validation/preprocessor5.c b/validation/preprocessor5.c
index fa38937..8dbfcba 100644
--- a/validation/preprocessor5.c
+++ b/validation/preprocessor5.c
@@ -7,3 +7,8 @@
 #define b(x) x
 
 b(a)
+
+/* SPARSE
+preprocessor5.c:9:1: error: Expected ; at end of declaration
+preprocessor5.c:9:1: error: got |
+   SPARSE */
diff --git a/validation/preprocessor7.c b/validation/preprocessor7.c
index e7e1d37..23dd0cf 100644
--- a/validation/preprocessor7.c
+++ b/validation/preprocessor7.c
@@ -3,3 +3,8 @@
 #define C(x,y) E(y)
 #define E(y) #y
 A(2))
+
+/* SPARSE
+preprocessor7.c:5:1: error: Expected ; end of type declaration
+preprocessor7.c:5:1: error: got "\"D\""
+   SPARSE */
diff --git a/validation/preprocessor8.c b/validation/preprocessor8.c
index 861dfe5..f724692 100644
--- a/validation/preprocessor8.c
+++ b/validation/preprocessor8.c
@@ -14,3 +14,12 @@
 "x#y"			: E
 "ab GH \"G\" 12"	: F(G,H)
 "a ## b"		: I(a,##,b)
+
+/* SPARSE
+preprocessor8.c:1:14: error: '##' cannot appear at the ends of macro expansion
+preprocessor8.c:2:16: error: '##' cannot appear at the ends of macro expansion
+preprocessor8.c:3:22: error: '##' cannot appear at the ends of macro expansion
+preprocessor8.c:4:15: error: '#' is not followed by a macro parameter
+preprocessor8.c:10:1: error: Expected ; end of type declaration
+preprocessor8.c:10:1: error: got "A(x)"
+   SPARSE */
diff --git a/validation/preprocessor9.c b/validation/preprocessor9.c
index 76d6e41..5c73378 100644
--- a/validation/preprocessor9.c
+++ b/validation/preprocessor9.c
@@ -8,3 +8,8 @@
 #define A # define X 1
 A
 X
+
+/* SPARSE
+preprocessor9.c:9:1: error: Expected ; end of type declaration
+preprocessor9.c:9:1: error: got #
+   SPARSE */
diff --git a/validation/run-tests b/validation/run-tests
new file mode 100755
index 0000000..ebe8ffc
--- /dev/null
+++ b/validation/run-tests
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+: ${SPARSE=../sparse}
+: ${SPARSE_FLAGS=}
+
+# Use "--update" to update test files with the actual output
+update=
+if test "$1" = "--update"; then
+	update=1
+	shift
+fi
+
+if test -n "$1"; then
+	tests="$@"
+else
+	tests=`echo *.c`
+fi
+
+bad=
+for test in $tests; do
+	base="`basename $test .c`"
+	exp="$base.exp"
+	res="$base.res"
+	diff="$base.diff"
+	$SPARSE $SPARSE_FLAGS "$test" 2>"$res"
+	if test "$?" != 0; then
+		echo "FATAL: $test"
+		bad="$bad $test"
+		continue
+	fi
+
+	if test -n "$update"; then
+		sed -i '/SPARSE/,/SPARSE/d' "$test"
+		if test -s "$res"; then
+			echo "/* SPARSE" >>"$test"
+			cat "$res" >>"$test"
+			echo "   SPARSE */" >>"$test"
+		fi
+	fi
+
+	sed -n '/SPARSE/,/SPARSE/p' "$test" |grep -v SPARSE >"$exp"
+	diff -u "$exp" "$res" >"$diff"
+	if test -s "$diff"; then
+		echo "FAIL: $test"
+		bad="$bad $test"
+		continue
+	fi
+
+	rm -f "$exp" "$res" "$diff"
+done
+
+if test -n "$bad"; then
+	echo "Failed tests:$bad"
+	exit 1
+fi
+
+echo "Testsuite completed successfully"
+exit 0
