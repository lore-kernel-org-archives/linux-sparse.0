From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] expand __builtin_bswap*() with constant args
Date: Mon, 23 Jan 2017 22:37:28 +0100
Message-ID: <20170123213728.89900-4-luc.vanoostenryck@gmail.com>
References: <20170123213728.89900-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35993 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdAWVht (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 23 Jan 2017 16:37:49 -0500
Received: by mail-wm0-f68.google.com with SMTP id r126so29585128wmr.3
        for <linux-sparse@vger.kernel.org>; Mon, 23 Jan 2017 13:37:43 -0800 (PST)
In-Reply-To: <20170123213728.89900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Things are greatly simplified now that such builtins can have a
prototype: the args and result are already evaluated, the argument
number and type are already checked, ...

Based-on-patch-by: Christopher Li <sparse@chrisli.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c                           | 30 +++++++++++++++++++++
 lib.c                               | 35 +++----------------------
 lib.h                               |  5 ++++
 validation/builtin-bswap-constant.c | 48 ++++++++++++++++++++++++++++++++++
 validation/builtin-bswap.c          | 52 +++++++++++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+), 32 deletions(-)
 create mode 100644 validation/builtin-bswap-constant.c
 create mode 100644 validation/builtin-bswap.c

diff --git a/builtin.c b/builtin.c
index ddc71f785..4dddb1e1d 100644
--- a/builtin.c
+++ b/builtin.c
@@ -176,6 +176,33 @@ static struct symbol_op choose_op = {
 	.args = arguments_choose,
 };
 
+/* The argument is constant and valid if the cost is zero */
+static int expand_bswap(struct expression *expr, int cost)
+{
+	long long input;
+
+	if (cost)
+		return cost;
+
+	/* the argument's number have already been checked */
+	input = const_expression_value(first_expression(expr->args));
+	switch (expr->ctype->bit_size) {
+	case 16: expr->value = __builtin_bswap16(input); break;
+	case 32: expr->value = __builtin_bswap32(input); break;
+	case 64: expr->value = __builtin_bswap64(input); break;
+	default: /* impossible error */
+		return SIDE_EFFECTS;
+	}
+
+	expr->type = EXPR_VALUE;
+	expr->taint = 0;
+	return 0;
+}
+
+static struct symbol_op bswap_op = {
+	.expand = expand_bswap,
+};
+
 
 /*
  * Builtin functions
@@ -192,6 +219,9 @@ static struct sym_init {
 	{ "__builtin_warning", &builtin_fn_type, MOD_TOPLEVEL, &warning_op },
 	{ "__builtin_expect", &builtin_fn_type, MOD_TOPLEVEL, &expect_op },
 	{ "__builtin_choose_expr", &builtin_fn_type, MOD_TOPLEVEL, &choose_op },
+	{ "__builtin_bswap16", NULL, MOD_TOPLEVEL, &bswap_op },
+	{ "__builtin_bswap32", NULL, MOD_TOPLEVEL, &bswap_op },
+	{ "__builtin_bswap64", NULL, MOD_TOPLEVEL, &bswap_op },
 	{ NULL,		NULL,		0 }
 };
 
diff --git a/lib.c b/lib.c
index 2660575b1..460e07609 100644
--- a/lib.c
+++ b/lib.c
@@ -820,38 +820,9 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern int __builtin_popcountll(unsigned long long);\n");
 
 	/* And byte swaps.. */
-	add_pre_buffer("extern unsigned short ____builtin_bswap16(unsigned short);\n");
-	add_pre_buffer("extern unsigned int ____builtin_bswap32(unsigned int);\n");
-	add_pre_buffer("extern unsigned long long ____builtin_bswap64(unsigned long long);\n");
-	add_pre_buffer("#define __sparse_constant_swab16(x) ((unsigned short)("
-		       "	(((unsigned short)(x) & (unsigned short)0x00ffU) << 8) |"
-		       "	(((unsigned short)(x) & (unsigned short)0xff00U) >> 8)))\n");
-	add_pre_buffer("#define __sparse_constant_swab32(x) ((unsigned int)("
-		       "	(((unsigned int)(x) & (unsigned int)0x000000ffUL) << 24) |"
-		       "	(((unsigned int)(x) & (unsigned int)0x0000ff00UL) <<  8) |"
-		       "	(((unsigned int)(x) & (unsigned int)0x00ff0000UL) >>  8) |"
-		       "	(((unsigned int)(x) & (unsigned int)0xff000000UL) >> 24)))\n");
-	add_pre_buffer("#define __sparse_constant_swab64(x) ((unsigned long long)("
-		       "	(((unsigned long long)(x) & (unsigned long long)0x00000000000000ffULL) << 56) |"
-		       "	(((unsigned long long)(x) & (unsigned long long)0x000000000000ff00ULL) << 40) |"
-		       "	(((unsigned long long)(x) & (unsigned long long)0x0000000000ff0000ULL) << 24) |"
-		       "	(((unsigned long long)(x) & (unsigned long long)0x00000000ff000000ULL) <<  8) |"
-		       "	(((unsigned long long)(x) & (unsigned long long)0x000000ff00000000ULL) >>  8) |"
-		       "	(((unsigned long long)(x) & (unsigned long long)0x0000ff0000000000ULL) >> 24) |"
-		       "	(((unsigned long long)(x) & (unsigned long long)0x00ff000000000000ULL) >> 40) |"
-		       "	(((unsigned long long)(x) & (unsigned long long)0xff00000000000000ULL) >> 56)))\n");
-	add_pre_buffer("#define __builtin_bswap16(x)"
-		       "	(__builtin_constant_p((unsigned short)(x)) ?"
-		       "	__sparse_constant_swab16(x) :"
-		       "	____builtin_bswap16(x))\n");
-	add_pre_buffer("#define __builtin_bswap32(x)"
-		       "	(__builtin_constant_p((unsigned int)(x)) ?"
-		       "	__sparse_constant_swab32(x) :"
-		       "	____builtin_bswap32(x))\n");
-	add_pre_buffer("#define __builtin_bswap64(x)"
-		       "	(__builtin_constant_p((unsigned long long)(x)) ?"
-		       "	__sparse_constant_swab64(x) :"
-		       "	____builtin_bswap64(x))\n");
+	add_pre_buffer("extern unsigned short __builtin_bswap16(unsigned short);\n");
+	add_pre_buffer("extern unsigned int __builtin_bswap32(unsigned int);\n");
+	add_pre_buffer("extern unsigned long long __builtin_bswap64(unsigned long long);\n");
 
 	/* And atomic memory access functions.. */
 	add_pre_buffer("extern int __sync_fetch_and_add(void *, ...);\n");
diff --git a/lib.h b/lib.h
index b778bdcd0..306ee4545 100644
--- a/lib.h
+++ b/lib.h
@@ -200,6 +200,11 @@ static inline struct instruction *first_instruction(struct instruction_list *hea
 	return first_ptr_list((struct ptr_list *)head);
 }
 
+static inline struct expression *first_expression(struct expression_list *head)
+{
+	return first_ptr_list((struct ptr_list *)head);
+}
+
 static inline pseudo_t first_pseudo(struct pseudo_list *head)
 {
 	return first_ptr_list((struct ptr_list *)head);
diff --git a/validation/builtin-bswap-constant.c b/validation/builtin-bswap-constant.c
new file mode 100644
index 000000000..788806f0b
--- /dev/null
+++ b/validation/builtin-bswap-constant.c
@@ -0,0 +1,48 @@
+unsigned short bswap16(void);
+unsigned short bswap16(void)
+{
+	return __builtin_bswap16(0x1234);
+}
+
+unsigned int bswap32(void);
+unsigned int bswap32(void)
+{
+	return __builtin_bswap32(0x12345678);
+}
+
+unsigned long long bswap64(void);
+unsigned long long bswap64(void)
+{
+	return __builtin_bswap64(0x123456789abcdef0ULL);
+}
+
+static unsigned int bad_nbr_args(int a)
+{
+	a |=  __builtin_bswap16();
+	a |=  __builtin_bswap16(1, 2);
+	a |=  __builtin_bswap32();
+	a |=  __builtin_bswap32(1, 2);
+	a |=  __builtin_bswap64();
+	a |=  __builtin_bswap64(1, 2);
+	return a;
+}
+
+/*
+ * check-name: builtin-bswap-constant
+ * check-command: test-linearize $file
+ *
+ * check-output-ignore
+ * check-output-excludes: __builtin_bswap
+ * check-output-contains:ret.16 *.0x3412
+ * check-output-contains:ret.32 *.0x78563412
+ * check-output-contains:ret.64 *.0xf0debc9a78563412
+ *
+ * check-error-start
+builtin-bswap-constant.c:21:32: error: not enough arguments for function __builtin_bswap16
+builtin-bswap-constant.c:22:32: error: too many arguments for function __builtin_bswap16
+builtin-bswap-constant.c:23:32: error: not enough arguments for function __builtin_bswap32
+builtin-bswap-constant.c:24:32: error: too many arguments for function __builtin_bswap32
+builtin-bswap-constant.c:25:32: error: not enough arguments for function __builtin_bswap64
+builtin-bswap-constant.c:26:32: error: too many arguments for function __builtin_bswap64
+ * check-error-end
+ */
diff --git a/validation/builtin-bswap.c b/validation/builtin-bswap.c
new file mode 100644
index 000000000..f98b7fc07
--- /dev/null
+++ b/validation/builtin-bswap.c
@@ -0,0 +1,52 @@
+typedef unsigned short	   u16;
+typedef unsigned int	   u32;
+typedef unsigned long long u64;
+
+static u16 swap16v(u16 a)
+{
+	return __builtin_bswap16(a);
+}
+
+static u32 swap32v(u64 a)
+{
+	return __builtin_bswap32(a);
+}
+
+static u64 swap64v(u32 a)
+{
+	return __builtin_bswap64(a);
+}
+
+static unsigned int bad_nbr_args(int a, int b)
+{
+	a |=  __builtin_bswap16();
+	a |=  __builtin_bswap16(a, b);
+	a |=  __builtin_bswap32();
+	a |=  __builtin_bswap32(a, b);
+	a |=  __builtin_bswap64();
+	a |=  __builtin_bswap64(a, b);
+	return a;
+}
+
+/*
+ * check-name: builtin-bswap
+ * check-command: test-linearize $file
+ * check-description: Check that the right builtin function is called, and
+ *                    that the args are correctly promoted or truncated.
+ *
+ * check-error-start
+builtin-bswap.c:22:32: error: not enough arguments for function __builtin_bswap16
+builtin-bswap.c:23:32: error: too many arguments for function __builtin_bswap16
+builtin-bswap.c:24:32: error: not enough arguments for function __builtin_bswap32
+builtin-bswap.c:25:32: error: too many arguments for function __builtin_bswap32
+builtin-bswap.c:26:32: error: not enough arguments for function __builtin_bswap64
+builtin-bswap.c:27:32: error: too many arguments for function __builtin_bswap64
+ * check-error-end
+ *
+ * check-output-ignore
+ * check-output-contains:call.16 .* __builtin_bswap16
+ * check-output-contains:cast.32 .* (64) %arg1
+ * check-output-contains:call.32 .* __builtin_bswap32
+ * check-output-contains:cast.64 .* (32) %arg1
+ * check-output-contains:call.64 .* __builtin_bswap64
+ */
-- 
2.11.0

