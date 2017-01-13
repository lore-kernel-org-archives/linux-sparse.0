From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix cast's target type info
Date: Fri, 13 Jan 2017 18:23:59 +0100
Message-ID: <20170113172359.23297-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33663 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdAMRZG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 13 Jan 2017 12:25:06 -0500
Received: by mail-wm0-f65.google.com with SMTP id r144so13144246wme.0
        for <linux-sparse@vger.kernel.org>; Fri, 13 Jan 2017 09:24:07 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

commit a0962f7893 ("Fix cast instruction generation") correctly
used the source type instead of the destination type to decide
between OP_CAST & OP_SCAST but at the same time made the choice
between OP_PTRCAST & OP_FPCAST depends on the source's type too,
thus losing all information about the target type (but its size).
In other words, in the code here below:
	int i ;
	...
	(long) i;
	(void*) i;
	(double) i;
	(float) i;
the three first casts generate exactly the same code (for a LP64 arch):
	scast.64   %r.. <- (32) %r..
and the last one will not generate any code at all.

Fix this by using the source type only to determine if the cast is an
OP_CAST or an OP_SCAST but using the target type to determine if the
cast is a cast to a pointer type (OP_PTRCAST), a floating-point type
(OP_FPCAST) or an integer type (OP_CAST or OP_SCAST).

Note: this is still not correct for floating-point to integer cast
as it is needed to know if the destination is a signed or unsigned
integer type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c             |   4 +-
 validation/cast-kinds.c | 387 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 389 insertions(+), 2 deletions(-)
 create mode 100644 validation/cast-kinds.c

diff --git a/linearize.c b/linearize.c
index cb252282..a50699d1 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1104,9 +1104,9 @@ static pseudo_t linearize_postop(struct entrypoint *ep, struct expression *expr)
 static struct instruction *alloc_cast_instruction(struct symbol *src, struct symbol *ctype)
 {
 	int opcode = OP_CAST;
-	struct symbol *base = src;
+	struct symbol *base = ctype;
 
-	if (base->ctype.modifiers & MOD_SIGNED)
+	if (src->ctype.modifiers & MOD_SIGNED)
 		opcode = OP_SCAST;
 	if (base->type == SYM_NODE)
 		base = base->ctype.base_type;
diff --git a/validation/cast-kinds.c b/validation/cast-kinds.c
new file mode 100644
index 00000000..697f9735
--- /dev/null
+++ b/validation/cast-kinds.c
@@ -0,0 +1,387 @@
+typedef unsigned int uint;
+typedef unsigned long ulong;
+
+static int uint_2_int(uint a) { return (int)a; }
+static int long_2_int(long a) { return (int)a; }
+static int ulong_2_int(ulong a) { return (int)a; }
+static int vptr_2_int(void *a) { return (int)a; }
+static int iptr_2_int(int *a) { return (int)a; }
+static int float_2_int(float a) { return (int)a; }
+static int double_2_int(double a) { return (int)a; }
+static uint int_2_uint(int a) { return (uint)a; }
+static uint long_2_uint(long a) { return (uint)a; }
+static uint ulong_2_uint(ulong a) { return (uint)a; }
+static uint vptr_2_uint(void *a) { return (uint)a; }
+static uint iptr_2_uint(int *a) { return (uint)a; }
+static uint float_2_uint(float a) { return (uint)a; }
+static uint double_2_uint(double a) { return (uint)a; }
+static long int_2_long(int a) { return (long)a; }
+static long uint_2_long(uint a) { return (long)a; }
+static long ulong_2_long(ulong a) { return (long)a; }
+static long vptr_2_long(void *a) { return (long)a; }
+static long iptr_2_long(int *a) { return (long)a; }
+static long float_2_long(float a) { return (long)a; }
+static long double_2_long(double a) { return (long)a; }
+static ulong int_2_ulong(int a) { return (ulong)a; }
+static ulong uint_2_ulong(uint a) { return (ulong)a; }
+static ulong long_2_ulong(long a) { return (ulong)a; }
+static ulong vptr_2_ulong(void *a) { return (ulong)a; }
+static ulong iptr_2_ulong(int *a) { return (ulong)a; }
+static ulong float_2_ulong(float a) { return (ulong)a; }
+static ulong double_2_ulong(double a) { return (ulong)a; }
+static void * int_2_vptr(int a) { return (void *)a; }
+static void * uint_2_vptr(uint a) { return (void *)a; }
+static void * long_2_vptr(long a) { return (void *)a; }
+static void * ulong_2_vptr(ulong a) { return (void *)a; }
+static void * iptr_2_vptr(int *a) { return (void *)a; }
+static int * int_2_iptr(int a) { return (int *)a; }
+static int * uint_2_iptr(uint a) { return (int *)a; }
+static int * long_2_iptr(long a) { return (int *)a; }
+static int * ulong_2_iptr(ulong a) { return (int *)a; }
+static int * vptr_2_iptr(void *a) { return (int *)a; }
+static float int_2_float(int a) { return (float)a; }
+static float uint_2_float(uint a) { return (float)a; }
+static float long_2_float(long a) { return (float)a; }
+static float ulong_2_float(ulong a) { return (float)a; }
+static float double_2_float(double a) { return (float)a; }
+static double int_2_double(int a) { return (double)a; }
+static double uint_2_double(uint a) { return (double)a; }
+static double long_2_double(long a) { return (double)a; }
+static double ulong_2_double(ulong a) { return (double)a; }
+static double float_2_double(float a) { return (double)a; }
+
+/*
+ * check-name: cast-kinds
+ * check-command: test-linearize -m64 $file
+ *
+ * check-output-start
+uint_2_int:
+.L0:
+	<entry-point>
+	ret.32      %arg1
+
+
+long_2_int:
+.L2:
+	<entry-point>
+	scast.32    %r5 <- (64) %arg1
+	ret.32      %r5
+
+
+ulong_2_int:
+.L4:
+	<entry-point>
+	cast.32     %r8 <- (64) %arg1
+	ret.32      %r8
+
+
+vptr_2_int:
+.L6:
+	<entry-point>
+	cast.32     %r11 <- (64) %arg1
+	ret.32      %r11
+
+
+iptr_2_int:
+.L8:
+	<entry-point>
+	cast.32     %r14 <- (64) %arg1
+	ret.32      %r14
+
+
+float_2_int:
+.L10:
+	<entry-point>
+	ret.32      %arg1
+
+
+double_2_int:
+.L12:
+	<entry-point>
+	cast.32     %r20 <- (64) %arg1
+	ret.32      %r20
+
+
+int_2_uint:
+.L14:
+	<entry-point>
+	ret.32      %arg1
+
+
+long_2_uint:
+.L16:
+	<entry-point>
+	scast.32    %r26 <- (64) %arg1
+	ret.32      %r26
+
+
+ulong_2_uint:
+.L18:
+	<entry-point>
+	cast.32     %r29 <- (64) %arg1
+	ret.32      %r29
+
+
+vptr_2_uint:
+.L20:
+	<entry-point>
+	cast.32     %r32 <- (64) %arg1
+	ret.32      %r32
+
+
+iptr_2_uint:
+.L22:
+	<entry-point>
+	cast.32     %r35 <- (64) %arg1
+	ret.32      %r35
+
+
+float_2_uint:
+.L24:
+	<entry-point>
+	ret.32      %arg1
+
+
+double_2_uint:
+.L26:
+	<entry-point>
+	cast.32     %r41 <- (64) %arg1
+	ret.32      %r41
+
+
+int_2_long:
+.L28:
+	<entry-point>
+	scast.64    %r44 <- (32) %arg1
+	ret.64      %r44
+
+
+uint_2_long:
+.L30:
+	<entry-point>
+	cast.64     %r47 <- (32) %arg1
+	ret.64      %r47
+
+
+ulong_2_long:
+.L32:
+	<entry-point>
+	ret.64      %arg1
+
+
+vptr_2_long:
+.L34:
+	<entry-point>
+	cast.64     %r53 <- (64) %arg1
+	ret.64      %r53
+
+
+iptr_2_long:
+.L36:
+	<entry-point>
+	cast.64     %r56 <- (64) %arg1
+	ret.64      %r56
+
+
+float_2_long:
+.L38:
+	<entry-point>
+	cast.64     %r59 <- (32) %arg1
+	ret.64      %r59
+
+
+double_2_long:
+.L40:
+	<entry-point>
+	ret.64      %arg1
+
+
+int_2_ulong:
+.L42:
+	<entry-point>
+	scast.64    %r65 <- (32) %arg1
+	ret.64      %r65
+
+
+uint_2_ulong:
+.L44:
+	<entry-point>
+	cast.64     %r68 <- (32) %arg1
+	ret.64      %r68
+
+
+long_2_ulong:
+.L46:
+	<entry-point>
+	ret.64      %arg1
+
+
+vptr_2_ulong:
+.L48:
+	<entry-point>
+	cast.64     %r74 <- (64) %arg1
+	ret.64      %r74
+
+
+iptr_2_ulong:
+.L50:
+	<entry-point>
+	cast.64     %r77 <- (64) %arg1
+	ret.64      %r77
+
+
+float_2_ulong:
+.L52:
+	<entry-point>
+	cast.64     %r80 <- (32) %arg1
+	ret.64      %r80
+
+
+double_2_ulong:
+.L54:
+	<entry-point>
+	ret.64      %arg1
+
+
+int_2_vptr:
+.L56:
+	<entry-point>
+	scast.64    %r86 <- (32) %arg1
+	ret.64      %r86
+
+
+uint_2_vptr:
+.L58:
+	<entry-point>
+	cast.64     %r89 <- (32) %arg1
+	ret.64      %r89
+
+
+long_2_vptr:
+.L60:
+	<entry-point>
+	scast.64    %r92 <- (64) %arg1
+	ret.64      %r92
+
+
+ulong_2_vptr:
+.L62:
+	<entry-point>
+	cast.64     %r95 <- (64) %arg1
+	ret.64      %r95
+
+
+iptr_2_vptr:
+.L64:
+	<entry-point>
+	cast.64     %r98 <- (64) %arg1
+	ret.64      %r98
+
+
+int_2_iptr:
+.L66:
+	<entry-point>
+	ptrcast.64  %r101 <- (32) %arg1
+	ret.64      %r101
+
+
+uint_2_iptr:
+.L68:
+	<entry-point>
+	ptrcast.64  %r104 <- (32) %arg1
+	ret.64      %r104
+
+
+long_2_iptr:
+.L70:
+	<entry-point>
+	ptrcast.64  %r107 <- (64) %arg1
+	ret.64      %r107
+
+
+ulong_2_iptr:
+.L72:
+	<entry-point>
+	ptrcast.64  %r110 <- (64) %arg1
+	ret.64      %r110
+
+
+vptr_2_iptr:
+.L74:
+	<entry-point>
+	ptrcast.64  %r113 <- (64) %arg1
+	ret.64      %r113
+
+
+int_2_float:
+.L76:
+	<entry-point>
+	fpcast.32   %r116 <- (32) %arg1
+	ret.32      %r116
+
+
+uint_2_float:
+.L78:
+	<entry-point>
+	fpcast.32   %r119 <- (32) %arg1
+	ret.32      %r119
+
+
+long_2_float:
+.L80:
+	<entry-point>
+	fpcast.32   %r122 <- (64) %arg1
+	ret.32      %r122
+
+
+ulong_2_float:
+.L82:
+	<entry-point>
+	fpcast.32   %r125 <- (64) %arg1
+	ret.32      %r125
+
+
+double_2_float:
+.L84:
+	<entry-point>
+	fpcast.32   %r128 <- (64) %arg1
+	ret.32      %r128
+
+
+int_2_double:
+.L86:
+	<entry-point>
+	fpcast.64   %r131 <- (32) %arg1
+	ret.64      %r131
+
+
+uint_2_double:
+.L88:
+	<entry-point>
+	fpcast.64   %r134 <- (32) %arg1
+	ret.64      %r134
+
+
+long_2_double:
+.L90:
+	<entry-point>
+	fpcast.64   %r137 <- (64) %arg1
+	ret.64      %r137
+
+
+ulong_2_double:
+.L92:
+	<entry-point>
+	fpcast.64   %r140 <- (64) %arg1
+	ret.64      %r140
+
+
+float_2_double:
+.L94:
+	<entry-point>
+	fpcast.64   %r143 <- (32) %arg1
+	ret.64      %r143
+
+
+ * check-output-end
+ */
-- 
2.11.0

