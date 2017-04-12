From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix 'simplification' of float-to-int casts
Date: Wed, 12 Apr 2017 15:21:47 +0200
Message-ID: <20170412132147.46876-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33957 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbdDLNYm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 09:24:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id x75so6398964wma.1
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 06:24:42 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, simplify_cast() don't really take floating-points
in account and happily simplify away a float-to-int cast
if both types have the same size.

Fix this by not touching such casts.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
This patch is available at:
	git://github.com/lucvoo/sparse.git fix-f2i-casts
based on commit:
	d440a16358aefd718029963bb2261f1deccfddab (fpops)
up to commit:
	604e7ef9c37100c4ca3dc0b3bee00d114e265684

 simplify.c              |  4 ++++
 validation/cast-kinds.c | 12 ++++++++----
 validation/fp2i-cast.c  | 30 ++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 4 deletions(-)
 create mode 100644 validation/fp2i-cast.c

diff --git a/simplify.c b/simplify.c
index 2286440e0..256a68b22 100644
--- a/simplify.c
+++ b/simplify.c
@@ -900,6 +900,10 @@ static int simplify_cast(struct instruction *insn)
 	if (is_ptr_type(orig_type) || is_ptr_type(insn->type))
 		return 0;
 
+	/* Keep float-to-int casts */
+	if (is_float_type(orig_type) && !is_float_type(insn->type))
+		return 0;
+
 	orig_size = orig_type->bit_size;
 	size = insn->size;
 	src = insn->src;
diff --git a/validation/cast-kinds.c b/validation/cast-kinds.c
index 697f9735e..e686c01ea 100644
--- a/validation/cast-kinds.c
+++ b/validation/cast-kinds.c
@@ -92,7 +92,8 @@ iptr_2_int:
 float_2_int:
 .L10:
 	<entry-point>
-	ret.32      %arg1
+	cast.32     %r17 <- (32) %arg1
+	ret.32      %r17
 
 
 double_2_int:
@@ -139,7 +140,8 @@ iptr_2_uint:
 float_2_uint:
 .L24:
 	<entry-point>
-	ret.32      %arg1
+	cast.32     %r38 <- (32) %arg1
+	ret.32      %r38
 
 
 double_2_uint:
@@ -193,7 +195,8 @@ float_2_long:
 double_2_long:
 .L40:
 	<entry-point>
-	ret.64      %arg1
+	cast.64     %r62 <- (64) %arg1
+	ret.64      %r62
 
 
 int_2_ulong:
@@ -240,7 +243,8 @@ float_2_ulong:
 double_2_ulong:
 .L54:
 	<entry-point>
-	ret.64      %arg1
+	cast.64     %r83 <- (64) %arg1
+	ret.64      %r83
 
 
 int_2_vptr:
diff --git a/validation/fp2i-cast.c b/validation/fp2i-cast.c
new file mode 100644
index 000000000..08f8c9252
--- /dev/null
+++ b/validation/fp2i-cast.c
@@ -0,0 +1,30 @@
+#if __SIZEOF_INT__ == __SIZEOF_FLOAT__
+typedef   signed int si;
+typedef unsigned int ui;
+#else
+#error "no float-sized integer type"
+#endif
+
+#if __SIZEOF_LONG_LONG__ == __SIZEOF_DOUBLE__
+typedef   signed long long sl;
+typedef unsigned long long ul;
+#else
+#error "no double-sized integer type"
+#endif
+
+si f2si(float  a) { return a; }
+ui f2ui(float  a) { return a; }
+sl f2sl(float  a) { return a; }
+ul f2ul(float  a) { return a; }
+si d2si(double a) { return a; }
+ui d2ui(double a) { return a; }
+sl d2sl(double a) { return a; }
+ul d2ul(double a) { return a; }
+
+/*
+ * check-name: fp2i cast
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-pattern-8-times: cast\\.
+ */
-- 
2.12.0

