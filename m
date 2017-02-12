From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 3/3] expand __builtin_bswap*() with constant args
Date: Sun, 12 Feb 2017 16:11:00 +0100
Message-ID: <20170212151100.15868-4-luc.vanoostenryck@gmail.com>
References: <20170212150332.33xlxmzohgb7hrpp@macpro.local>
 <20170212151100.15868-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36353 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdBLPMX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 10:12:23 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so14671546wmd.3
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 07:12:22 -0800 (PST)
In-Reply-To: <20170212151100.15868-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Johannes Berg <johannes@sipsolutions.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Things are greatly simplified now that such builtins can have a
prototype: the args and result are already evaluated, the
arguments number and their type are already checked, etc.

Based-on-patch-by: Christopher Li <sparse@chrisli.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c                                          | 30 +++++++++++++++
 lib.c                                              | 35 ++---------------
 lib.h                                              |  5 +++
 validation/builtin-args-checking.c                 | 45 ++++++++++++++++++++++
 ...in-constant-eval.c => builtin-bswap-constant.c} |  2 +-
 validation/builtin-bswap-variable.c                | 32 +++++++++++++++
 6 files changed, 116 insertions(+), 33 deletions(-)
 create mode 100644 validation/builtin-args-checking.c
 rename validation/{builtin-constant-eval.c => builtin-bswap-constant.c} (93%)
 create mode 100644 validation/builtin-bswap-variable.c

diff --git a/builtin.c b/builtin.c
index c6c97ed85..dbb81032b 100644
--- a/builtin.c
+++ b/builtin.c
@@ -176,6 +176,33 @@ static struct symbol_op choose_op = {
 	.args = arguments_choose,
 };
 
+/* The argument is constant and valid if the cost is zero */
+static int expand_bswap(struct expression *expr, int cost)
+{
+	long long val;
+
+	if (cost)
+		return cost;
+
+	/* the arguments number & type have already been checked */
+	val = const_expression_value(first_expression(expr->args));
+	switch (expr->ctype->bit_size) {
+	case 16: expr->value = __builtin_bswap16(val); break;
+	case 32: expr->value = __builtin_bswap32(val); break;
+	case 64: expr->value = __builtin_bswap64(val); break;
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
index 467e040be..d47325243 100644
--- a/lib.c
+++ b/lib.c
@@ -867,38 +867,9 @@ void declare_builtin_functions(void)
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
index 57aea9e46..095b1f517 100644
--- a/lib.h
+++ b/lib.h
@@ -201,6 +201,11 @@ static inline struct instruction *first_instruction(struct instruction_list *hea
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
diff --git a/validation/builtin-args-checking.c b/validation/builtin-args-checking.c
new file mode 100644
index 000000000..55f34d2bc
--- /dev/null
+++ b/validation/builtin-args-checking.c
@@ -0,0 +1,45 @@
+static unsigned int bad_nbr_args_cte(int a)
+{
+	int r = 0;
+	r |= __builtin_bswap16();
+	r |= __builtin_bswap16(1, 2);
+	r |= __builtin_bswap32();
+	r |= __builtin_bswap32(1, 2);
+	r |= __builtin_bswap64();
+	r |= __builtin_bswap64(1, 2);
+	return r;
+}
+
+static unsigned int bad_nbr_args_var(int a, int b)
+{
+	int r = 0;
+	r |= __builtin_bswap16();
+	r |= __builtin_bswap16(a, b);
+	r |= __builtin_bswap32();
+	r |= __builtin_bswap32(a, b);
+	r |= __builtin_bswap64();
+	r |= __builtin_bswap64(a, b);
+	return r;
+}
+
+/*
+ * check-name: builtin-args-checking
+ * check-command: sparse $file
+ * check-description: Check that the arguments checking is done
+ *                    for expanded builtins with a prototype.
+ *
+ * check-error-start
+builtin-args-checking.c:4:31: error: not enough arguments for function __builtin_bswap16
+builtin-args-checking.c:5:31: error: too many arguments for function __builtin_bswap16
+builtin-args-checking.c:6:31: error: not enough arguments for function __builtin_bswap32
+builtin-args-checking.c:7:31: error: too many arguments for function __builtin_bswap32
+builtin-args-checking.c:8:31: error: not enough arguments for function __builtin_bswap64
+builtin-args-checking.c:9:31: error: too many arguments for function __builtin_bswap64
+builtin-args-checking.c:16:31: error: not enough arguments for function __builtin_bswap16
+builtin-args-checking.c:17:31: error: too many arguments for function __builtin_bswap16
+builtin-args-checking.c:18:31: error: not enough arguments for function __builtin_bswap32
+builtin-args-checking.c:19:31: error: too many arguments for function __builtin_bswap32
+builtin-args-checking.c:20:31: error: not enough arguments for function __builtin_bswap64
+builtin-args-checking.c:21:31: error: too many arguments for function __builtin_bswap64
+ * check-error-end
+ */
diff --git a/validation/builtin-constant-eval.c b/validation/builtin-bswap-constant.c
similarity index 93%
rename from validation/builtin-constant-eval.c
rename to validation/builtin-bswap-constant.c
index 63e586e99..4560f67e9 100644
--- a/validation/builtin-constant-eval.c
+++ b/validation/builtin-bswap-constant.c
@@ -17,7 +17,7 @@ unsigned long long bswap64(void)
 }
 
 /*
- * check-name: builtin-eval
+ * check-name: builtin-bswap-constant
  * check-command: test-linearize $file
  *
  * check-output-ignore
diff --git a/validation/builtin-bswap-variable.c b/validation/builtin-bswap-variable.c
new file mode 100644
index 000000000..738ba2a45
--- /dev/null
+++ b/validation/builtin-bswap-variable.c
@@ -0,0 +1,32 @@
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
+/*
+ * check-name: builtin-bswap
+ * check-command: test-linearize $file
+ * check-description: Check that the right builtin function is called, and
+ *                    that the args are correctly promoted or truncated.
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

