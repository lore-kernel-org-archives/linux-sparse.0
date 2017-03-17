From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix: expansion of integers to floats
Date: Fri, 17 Mar 2017 10:31:55 +0100
Message-ID: <20170317093155.22759-1-luc.vanoostenryck@gmail.com>
References: <CA+55aFxCqUY5k7=rmmfzW+=44+csM71bxcqqGJgLXqsg5C6F4Q@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32778 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdCQJcF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Mar 2017 05:32:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11so2265867wma.0
        for <linux-sparse@vger.kernel.org>; Fri, 17 Mar 2017 02:32:03 -0700 (PDT)
In-Reply-To: <CA+55aFxCqUY5k7=rmmfzW+=44+csM71bxcqqGJgLXqsg5C6F4Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

The test wasn't using is_float_type() and thus missed
SYM_NODE->SUM_BASETYPE::fp_type.

Use is_float_type() now.

Note: there is probably some issue if the expansion of a cast
overflow (at compile-time thus) but that's another story.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
CC: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c                            |   3 +-
 validation/cast-constant-to-float.c |  35 ++++
 validation/cast-constants.c         | 357 ++++++++++++++++++++++++++++++++++++
 3 files changed, 393 insertions(+), 2 deletions(-)
 create mode 100644 validation/cast-constant-to-float.c
 create mode 100644 validation/cast-constants.c

diff --git a/expand.c b/expand.c
index 11f7255bf..5f908c971 100644
--- a/expand.c
+++ b/expand.c
@@ -88,8 +88,7 @@ void cast_value(struct expression *expr, struct symbol *newtype,
 	long long value, mask, signmask;
 	long long oldmask, oldsignmask, dropped;
 
-	if (newtype->ctype.base_type == &fp_type ||
-	    oldtype->ctype.base_type == &fp_type)
+	if (is_float_type(newtype) || is_float_type(oldtype))
 		goto Float;
 
 	// For pointers and integers, we can just move the value around
diff --git a/validation/cast-constant-to-float.c b/validation/cast-constant-to-float.c
new file mode 100644
index 000000000..86b7ac0f7
--- /dev/null
+++ b/validation/cast-constant-to-float.c
@@ -0,0 +1,35 @@
+typedef unsigned int uint;
+typedef unsigned long ulong;
+
+double f1(void) { return -1; }
+double f2(void) { return (double)-1; }
+double f3(void) { return -1.0; }
+
+/*
+ * check-name: cast-constant-to-float
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+f1:
+.L0:
+	<entry-point>
+	set.64      %r1 <- -1.000000
+	ret.64      %r1
+
+
+f2:
+.L2:
+	<entry-point>
+	set.64      %r3 <- -1.000000
+	ret.64      %r3
+
+
+f3:
+.L4:
+	<entry-point>
+	set.64      %r5 <- -1.000000
+	ret.64      %r5
+
+
+ * check-output-end
+ */
diff --git a/validation/cast-constants.c b/validation/cast-constants.c
new file mode 100644
index 000000000..100424c22
--- /dev/null
+++ b/validation/cast-constants.c
@@ -0,0 +1,357 @@
+typedef unsigned int uint;
+typedef unsigned long ulong;
+
+static int uint_2_int(void) { return (int)123U; }
+static int long_2_int(void) { return (int)123L; }
+static int ulong_2_int(void) { return (int)123UL; }
+static int vptr_2_int(void) { return (int)((void*)123); }
+static int iptr_2_int(void) { return (int)((int*)128); }
+static int float_2_int(void) { return (int)1.123F; }
+static int double_2_int(void) { return (int)1.123L; }
+static uint int_2_uint(void) { return (uint)123; }
+static uint long_2_uint(void) { return (uint)123L; }
+static uint ulong_2_uint(void) { return (uint)123UL; }
+static uint vptr_2_uint(void) { return (uint)((void*)123); }
+static uint iptr_2_uint(void) { return (uint)((int*)128); }
+static uint float_2_uint(void) { return (uint)1.123F; }
+static uint double_2_uint(void) { return (uint)1.123L; }
+static long int_2_long(void) { return (long)123; }
+static long uint_2_long(void) { return (long)123U; }
+static long ulong_2_long(void) { return (long)123UL; }
+static long vptr_2_long(void) { return (long)((void*)123); }
+static long iptr_2_long(void) { return (long)((int*)128); }
+static long float_2_long(void) { return (long)1.123F; }
+static long double_2_long(void) { return (long)1.123L; }
+static ulong int_2_ulong(void) { return (ulong)123; }
+static ulong uint_2_ulong(void) { return (ulong)123U; }
+static ulong long_2_ulong(void) { return (ulong)123L; }
+static ulong vptr_2_ulong(void) { return (ulong)((void*)123); }
+static ulong iptr_2_ulong(void) { return (ulong)((int*)128); }
+static ulong float_2_ulong(void) { return (ulong)1.123F; }
+static ulong double_2_ulong(void) { return (ulong)1.123L; }
+static void * int_2_vptr(void) { return (void *)123; }
+static void * uint_2_vptr(void) { return (void *)123U; }
+static void * long_2_vptr(void) { return (void *)123L; }
+static void * ulong_2_vptr(void) { return (void *)123UL; }
+static void * iptr_2_vptr(void) { return (void *)((int*)128); }
+static int * int_2_iptr(void) { return (int *)123; }
+static int * uint_2_iptr(void) { return (int *)123U; }
+static int * long_2_iptr(void) { return (int *)123L; }
+static int * ulong_2_iptr(void) { return (int *)123UL; }
+static int * vptr_2_iptr(void) { return (int *)((void*)123); }
+static float int_2_float(void) { return (float)123; }
+static float uint_2_float(void) { return (float)123U; }
+static float long_2_float(void) { return (float)123L; }
+static float ulong_2_float(void) { return (float)123UL; }
+static float double_2_float(void) { return (float)1.123L; }
+static double int_2_double(void) { return (double)123; }
+static double uint_2_double(void) { return (double)123U; }
+static double long_2_double(void) { return (double)123L; }
+static double ulong_2_double(void) { return (double)123UL; }
+static double float_2_double(void) { return (double)1.123F; }
+
+/*
+ * check-name: cast-constants.c
+ * check-command: test-linearize $file
+ *
+ * check-output-start
+uint_2_int:
+.L0:
+	<entry-point>
+	ret.32      $123
+
+
+long_2_int:
+.L2:
+	<entry-point>
+	ret.32      $123
+
+
+ulong_2_int:
+.L4:
+	<entry-point>
+	ret.32      $123
+
+
+vptr_2_int:
+.L6:
+	<entry-point>
+	ret.32      $123
+
+
+iptr_2_int:
+.L8:
+	<entry-point>
+	ret.32      $128
+
+
+float_2_int:
+.L10:
+	<entry-point>
+	ret.32      $1
+
+
+double_2_int:
+.L12:
+	<entry-point>
+	ret.32      $1
+
+
+int_2_uint:
+.L14:
+	<entry-point>
+	ret.32      $123
+
+
+long_2_uint:
+.L16:
+	<entry-point>
+	ret.32      $123
+
+
+ulong_2_uint:
+.L18:
+	<entry-point>
+	ret.32      $123
+
+
+vptr_2_uint:
+.L20:
+	<entry-point>
+	ret.32      $123
+
+
+iptr_2_uint:
+.L22:
+	<entry-point>
+	ret.32      $128
+
+
+float_2_uint:
+.L24:
+	<entry-point>
+	ret.32      $1
+
+
+double_2_uint:
+.L26:
+	<entry-point>
+	ret.32      $1
+
+
+int_2_long:
+.L28:
+	<entry-point>
+	ret.64      $123
+
+
+uint_2_long:
+.L30:
+	<entry-point>
+	ret.64      $123
+
+
+ulong_2_long:
+.L32:
+	<entry-point>
+	ret.64      $123
+
+
+vptr_2_long:
+.L34:
+	<entry-point>
+	ret.64      $123
+
+
+iptr_2_long:
+.L36:
+	<entry-point>
+	ret.64      $128
+
+
+float_2_long:
+.L38:
+	<entry-point>
+	ret.64      $1
+
+
+double_2_long:
+.L40:
+	<entry-point>
+	ret.64      $1
+
+
+int_2_ulong:
+.L42:
+	<entry-point>
+	ret.64      $123
+
+
+uint_2_ulong:
+.L44:
+	<entry-point>
+	ret.64      $123
+
+
+long_2_ulong:
+.L46:
+	<entry-point>
+	ret.64      $123
+
+
+vptr_2_ulong:
+.L48:
+	<entry-point>
+	ret.64      $123
+
+
+iptr_2_ulong:
+.L50:
+	<entry-point>
+	ret.64      $128
+
+
+float_2_ulong:
+.L52:
+	<entry-point>
+	ret.64      $1
+
+
+double_2_ulong:
+.L54:
+	<entry-point>
+	ret.64      $1
+
+
+int_2_vptr:
+.L56:
+	<entry-point>
+	ret.64      $123
+
+
+uint_2_vptr:
+.L58:
+	<entry-point>
+	ret.64      $123
+
+
+long_2_vptr:
+.L60:
+	<entry-point>
+	ret.64      $123
+
+
+ulong_2_vptr:
+.L62:
+	<entry-point>
+	ret.64      $123
+
+
+iptr_2_vptr:
+.L64:
+	<entry-point>
+	ret.64      $128
+
+
+int_2_iptr:
+.L66:
+	<entry-point>
+	ret.64      $123
+
+
+uint_2_iptr:
+.L68:
+	<entry-point>
+	ret.64      $123
+
+
+long_2_iptr:
+.L70:
+	<entry-point>
+	ret.64      $123
+
+
+ulong_2_iptr:
+.L72:
+	<entry-point>
+	ret.64      $123
+
+
+vptr_2_iptr:
+.L74:
+	<entry-point>
+	ret.64      $123
+
+
+int_2_float:
+.L76:
+	<entry-point>
+	set.32      %r39 <- 123.000000
+	ret.32      %r39
+
+
+uint_2_float:
+.L78:
+	<entry-point>
+	set.32      %r41 <- 123.000000
+	ret.32      %r41
+
+
+long_2_float:
+.L80:
+	<entry-point>
+	set.32      %r43 <- 123.000000
+	ret.32      %r43
+
+
+ulong_2_float:
+.L82:
+	<entry-point>
+	set.32      %r45 <- 123.000000
+	ret.32      %r45
+
+
+double_2_float:
+.L84:
+	<entry-point>
+	set.32      %r47 <- 1.123000
+	ret.32      %r47
+
+
+int_2_double:
+.L86:
+	<entry-point>
+	set.64      %r49 <- 123.000000
+	ret.64      %r49
+
+
+uint_2_double:
+.L88:
+	<entry-point>
+	set.64      %r51 <- 123.000000
+	ret.64      %r51
+
+
+long_2_double:
+.L90:
+	<entry-point>
+	set.64      %r53 <- 123.000000
+	ret.64      %r53
+
+
+ulong_2_double:
+.L92:
+	<entry-point>
+	set.64      %r55 <- 123.000000
+	ret.64      %r55
+
+
+float_2_double:
+.L94:
+	<entry-point>
+	set.64      %r57 <- 1.123000
+	ret.64      %r57
+
+
+ * check-output-end
+ */
-- 
2.12.0

