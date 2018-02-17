From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] builtin: add typechecking of isnan(), isinf(), ...
Date: Sat, 17 Feb 2018 15:56:32 +0100
Message-ID: <20180217145634.53616-3-luc.vanoostenryck@gmail.com>
References: <20180217145634.53616-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37637 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeBQO4p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Feb 2018 09:56:45 -0500
Received: by mail-wm0-f66.google.com with SMTP id v71so7854127wmv.2
        for <linux-sparse@vger.kernel.org>; Sat, 17 Feb 2018 06:56:44 -0800 (PST)
In-Reply-To: <20180217145634.53616-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

These builtins should accept a single argument of any
floating-point type and should not do the usual promotion
of float to double.

Add the type and argument number check in the builtin's
evaluate method.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c                    | 30 ++++++++++++++
 validation/builtin-fp-unop.c | 95 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100644 validation/builtin-fp-unop.c

diff --git a/builtin.c b/builtin.c
index 9aa109d15..dc5f4a68f 100644
--- a/builtin.c
+++ b/builtin.c
@@ -237,6 +237,27 @@ static struct symbol_op bswap_op = {
 };
 
 
+static int evaluate_fp_unop(struct expression *expr)
+{
+	struct expression *arg;
+
+	if (!eval_args(expr, 1))
+		return 0;
+
+	arg = first_expression(expr->args);
+	if (!is_float_type(arg->ctype)) {
+		expression_error(expr, "non-floating-point argument in call to %s()",
+			show_ident(expr->fn->ctype->ident));
+		return 0;
+	}
+	return 1;
+}
+
+static struct symbol_op fp_unop_op = {
+	.evaluate = evaluate_fp_unop,
+};
+
+
 /*
  * Builtin functions
  */
@@ -255,6 +276,12 @@ static struct sym_init {
 	{ "__builtin_bswap16", &builtin_fn_type, MOD_TOPLEVEL, &bswap_op },
 	{ "__builtin_bswap32", &builtin_fn_type, MOD_TOPLEVEL, &bswap_op },
 	{ "__builtin_bswap64", &builtin_fn_type, MOD_TOPLEVEL, &bswap_op },
+	{ "__builtin_isfinite", &builtin_fn_type, MOD_TOPLEVEL, &fp_unop_op },
+	{ "__builtin_isinf", &builtin_fn_type, MOD_TOPLEVEL, &fp_unop_op },
+	{ "__builtin_isinf_sign", &builtin_fn_type, MOD_TOPLEVEL, &fp_unop_op },
+	{ "__builtin_isnan", &builtin_fn_type, MOD_TOPLEVEL, &fp_unop_op },
+	{ "__builtin_isnormal", &builtin_fn_type, MOD_TOPLEVEL, &fp_unop_op },
+	{ "__builtin_signbit", &builtin_fn_type, MOD_TOPLEVEL, &fp_unop_op },
 	{ NULL,		NULL,		0 }
 };
 
@@ -343,11 +370,13 @@ void declare_builtins(void)
 	declare_builtin("__builtin_isfinite", &int_ctype, 1, NULL);
 	declare_builtin("__builtin_isgreater", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
 	declare_builtin("__builtin_isgreaterequal", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
+	declare_builtin("__builtin_isinf", &int_ctype, 1, NULL);
 	declare_builtin("__builtin_isinf_sign", &int_ctype, 1, NULL);
 	declare_builtin("__builtin_isless", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
 	declare_builtin("__builtin_islessequal", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
 	declare_builtin("__builtin_islessgreater", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
 	declare_builtin("__builtin_isnan", &int_ctype, 1, NULL);
+	declare_builtin("__builtin_isnormal", &int_ctype, 1, NULL);
 	declare_builtin("__builtin_isunordered", &int_ctype, 0, &float_ctype, &float_ctype, NULL);
 	declare_builtin("__builtin_labs", &long_ctype, 0, &long_ctype, NULL);
 	declare_builtin("__builtin_llabs", &llong_ctype, 0, &llong_ctype, NULL);
@@ -374,6 +403,7 @@ void declare_builtins(void)
 	declare_builtin("__builtin_realloc", &ptr_ctype, 0, &ptr_ctype, size_t_ctype, NULL);
 	declare_builtin("__builtin_return_address", &ptr_ctype, 0, &uint_ctype, NULL);
 	declare_builtin("__builtin_rindex", &string_ctype, 0, &const_string_ctype, &int_ctype, NULL);
+	declare_builtin("__builtin_signbit", &int_ctype, 1, NULL);
 	declare_builtin("__builtin_snprintf", &int_ctype, 1, &string_ctype, size_t_ctype, &const_string_ctype, NULL);
 	declare_builtin("__builtin_sprintf", &int_ctype, 1, &string_ctype, &const_string_ctype, NULL);
 	declare_builtin("__builtin_stpcpy", &string_ctype, 0, &const_string_ctype, &const_string_ctype, NULL);
diff --git a/validation/builtin-fp-unop.c b/validation/builtin-fp-unop.c
new file mode 100644
index 000000000..f42c587b7
--- /dev/null
+++ b/validation/builtin-fp-unop.c
@@ -0,0 +1,95 @@
+static void test_not_enough_args(void)
+{
+	__builtin_isfinite();
+	__builtin_isinf();
+	__builtin_isinf_sign();
+	__builtin_isnan();
+	__builtin_isnormal();
+	__builtin_signbit();
+}
+
+static void test_too_many_args(double v)
+{
+	__builtin_isfinite(v, v);
+	__builtin_isinf(v, v);
+	__builtin_isinf_sign(v, v);
+	__builtin_isnan(v, v);
+	__builtin_isnormal(v, v);
+	__builtin_signbit(v, v);
+}
+
+static void test_non_float(int v)
+{
+	__builtin_isfinite(v);
+	__builtin_isinf(v);
+	__builtin_isinf_sign(v);
+	__builtin_isnan(v);
+	__builtin_isnormal(v);
+	__builtin_signbit(v);
+}
+
+static void test_float(float v)
+{
+	__builtin_isfinite(v);
+	__builtin_isinf(v);
+	__builtin_isinf_sign(v);
+	__builtin_isnan(v);
+	__builtin_isnormal(v);
+	__builtin_signbit(v);
+}
+
+static void test_double(double v)
+{
+	__builtin_isfinite(v);
+	__builtin_isinf(v);
+	__builtin_isinf_sign(v);
+	__builtin_isnan(v);
+	__builtin_isnormal(v);
+	__builtin_signbit(v);
+}
+
+static void test_ldouble(long double v)
+{
+	__builtin_isfinite(v);
+	__builtin_isinf(v);
+	__builtin_isinf_sign(v);
+	__builtin_isnan(v);
+	__builtin_isnormal(v);
+	__builtin_signbit(v);
+}
+
+static void test_constant(void)
+{
+	__builtin_isfinite(0.0);
+	__builtin_isinf(0.0);
+	__builtin_isinf_sign(0.0);
+	__builtin_isnan(0.0);
+	__builtin_isnormal(0.0);
+	__builtin_signbit(0.0);
+}
+
+/*
+ * check-name: builtin float-point unop
+ * check-command: sparse -Wno-decl $file
+ *
+ * check-error-start
+builtin-fp-unop.c:3:27: error: not enough arguments for __builtin_isfinite
+builtin-fp-unop.c:4:24: error: not enough arguments for __builtin_isinf
+builtin-fp-unop.c:5:29: error: not enough arguments for __builtin_isinf_sign
+builtin-fp-unop.c:6:24: error: not enough arguments for __builtin_isnan
+builtin-fp-unop.c:7:27: error: not enough arguments for __builtin_isnormal
+builtin-fp-unop.c:8:26: error: not enough arguments for __builtin_signbit
+builtin-fp-unop.c:13:27: error: too many arguments for __builtin_isfinite
+builtin-fp-unop.c:14:24: error: too many arguments for __builtin_isinf
+builtin-fp-unop.c:15:29: error: too many arguments for __builtin_isinf_sign
+builtin-fp-unop.c:16:24: error: too many arguments for __builtin_isnan
+builtin-fp-unop.c:17:27: error: too many arguments for __builtin_isnormal
+builtin-fp-unop.c:18:26: error: too many arguments for __builtin_signbit
+builtin-fp-unop.c:23:27: error: non-floating-point argument in call to __builtin_isfinite()
+builtin-fp-unop.c:24:24: error: non-floating-point argument in call to __builtin_isinf()
+builtin-fp-unop.c:25:29: error: non-floating-point argument in call to __builtin_isinf_sign()
+builtin-fp-unop.c:26:24: error: non-floating-point argument in call to __builtin_isnan()
+builtin-fp-unop.c:27:27: error: non-floating-point argument in call to __builtin_isnormal()
+builtin-fp-unop.c:28:26: error: non-floating-point argument in call to __builtin_signbit()
+ * check-error-end
+ */
-- 
2.16.0

