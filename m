From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 07/15] options: alphasort the handle_switch_[a-zA_Z]()
Date: Sun,  5 Jul 2020 15:02:12 +0200
Message-ID: <20200705130220.26230-8-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgGENCg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A70C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a8so30993309edy.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:36 -0700 (PDT)
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

These function have probably been added in 'historical order' and
as result it's not easy to quickly see where they're defined.

Change this arranging them in asciibetical order.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 656 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 327 insertions(+), 329 deletions(-)

diff --git a/lib.c b/lib.c
index 4868154fa3de..5f4e6b2d76c8 100644
--- a/lib.c
+++ b/lib.c
@@ -568,6 +568,14 @@ OPT_NUMERIC(uint, unsigned int, strtoul)
 ////////////////////////////////////////////////////////////////////////////////
 // Option parsing
 
+static char **handle_switch_a(char *arg, char **next)
+{
+	if (!strcmp (arg, "ansi"))
+		standard = STANDARD_C89;
+
+	return next;
+}
+
 static char **handle_switch_D(char *arg, char **next)
 {
 	const char *name = arg + 1;
@@ -595,6 +603,37 @@ static char **handle_switch_D(char *arg, char **next)
 	return next;
 }
 
+static char **handle_switch_d(char *arg, char **next)
+{
+	char *arg_char = arg + 1;
+
+	/*
+	 * -d<CHARS>, where <CHARS> is a sequence of characters, not preceded
+	 * by a space. If you specify characters whose behaviour conflicts,
+	 * the result is undefined.
+	 */
+	while (*arg_char) {
+		switch (*arg_char) {
+		case 'M': /* dump just the macro definitions */
+			dump_macros_only = 1;
+			dump_macro_defs = 0;
+			break;
+		case 'D': /* like 'M', but also output pre-processed text */
+			dump_macro_defs = 1;
+			dump_macros_only = 0;
+			break;
+		case 'N': /* like 'D', but only output macro names not bodies */
+			break;
+		case 'I': /* like 'D', but also output #include directives */
+			break;
+		case 'U': /* like 'D', but only output expanded macros */
+			break;
+		}
+		arg_char++;
+	}
+	return next;
+}
+
 static char **handle_switch_E(char *arg, char **next)
 {
 	if (arg[1] == '\0')
@@ -602,6 +641,146 @@ static char **handle_switch_E(char *arg, char **next)
 	return next;
 }
 
+static int handle_ftabstop(const char *arg, const char *opt, const struct flag *flag, int options)
+{
+	unsigned long val;
+	char *end;
+
+	if (*opt == '\0')
+		die("error: missing argument to \"%s\"", arg);
+
+	/* we silently ignore silly values */
+	val = strtoul(opt, &end, 10);
+	if (*end == '\0' && 1 <= val && val <= 100)
+		tabstop = val;
+
+	return 1;
+}
+
+static int handle_fpasses(const char *arg, const char *opt, const struct flag *flag, int options)
+{
+	unsigned long mask;
+
+	mask = flag->mask;
+	if (*opt == '\0') {
+		if (options & OPT_INVERSE)
+			fpasses &= ~mask;
+		else
+			fpasses |=  mask;
+		return 1;
+	}
+	if (options & OPT_INVERSE)
+		return 0;
+	if (!strcmp(opt, "-enable")) {
+		fpasses |= mask;
+		return 1;
+	}
+	if (!strcmp(opt, "-disable")) {
+		fpasses &= ~mask;
+		return 1;
+	}
+	if (!strcmp(opt, "=last")) {
+		// clear everything above
+		mask |= mask - 1;
+		fpasses &= mask;
+		return 1;
+	}
+	return 0;
+}
+
+static int handle_fdiagnostic_prefix(const char *arg, const char *opt, const struct flag *flag, int options)
+{
+	switch (*opt) {
+	case '\0':
+		diag_prefix = "sparse: ";
+		return 1;
+	case '=':
+		diag_prefix = xasprintf("%s: ", opt+1);
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int handle_fdump_ir(const char *arg, const char *opt, const struct flag *flag, int options)
+{
+	static const struct mask_map dump_ir_options[] = {
+		{ "",			PASS_LINEARIZE },
+		{ "linearize",		PASS_LINEARIZE },
+		{ "mem2reg",		PASS_MEM2REG },
+		{ "final",		PASS_FINAL },
+		{ },
+	};
+
+	return handle_suboption_mask(arg, opt, dump_ir_options, &fdump_ir);
+}
+
+static int handle_fmemcpy_max_count(const char *arg, const char *opt, const struct flag *flag, int options)
+{
+	opt_ullong(arg, opt, &fmemcpy_max_count, OPTNUM_ZERO_IS_INF|OPTNUM_UNLIMITED);
+	return 1;
+}
+
+static int handle_fmax_warnings(const char *arg, const char *opt, const struct flag *flag, int options)
+{
+	opt_uint(arg, opt, &fmax_warnings, OPTNUM_UNLIMITED);
+	return 1;
+}
+
+static struct flag fflags[] = {
+	{ "diagnostic-prefix",	NULL,	handle_fdiagnostic_prefix },
+	{ "dump-ir",		NULL,	handle_fdump_ir },
+	{ "freestanding",	&fhosted, NULL, OPT_INVERSE },
+	{ "hosted",		&fhosted },
+	{ "linearize",		NULL,	handle_fpasses,	PASS_LINEARIZE },
+	{ "max-warnings=",	NULL,	handle_fmax_warnings },
+	{ "mem-report",		&fmem_report },
+	{ "memcpy-max-count=",	NULL,	handle_fmemcpy_max_count },
+	{ "tabstop=",		NULL,	handle_ftabstop },
+	{ "mem2reg",		NULL,	handle_fpasses,	PASS_MEM2REG },
+	{ "optim",		NULL,	handle_fpasses,	PASS_OPTIM },
+	{ "pic",		&fpic,	handle_switch_setval, 1 },
+	{ "PIC",		&fpic,	handle_switch_setval, 2 },
+	{ "pie",		&fpie,	handle_switch_setval, 1 },
+	{ "PIE",		&fpie,	handle_switch_setval, 2 },
+	{ "signed-char",	&funsigned_char, NULL,	OPT_INVERSE },
+	{ "short-wchar",	&fshort_wchar },
+	{ "unsigned-char",	&funsigned_char, NULL, },
+	{ },
+};
+
+static char **handle_switch_f(char *arg, char **next)
+{
+	if (handle_switches(arg-1, arg+1, fflags))
+		return next;
+
+	return next;
+}
+
+static char **handle_switch_G(char *arg, char **next)
+{
+	if (!strcmp (arg, "G") && *next)
+		return next + 1; // "-G 0"
+	else
+		return next;     // "-G0" or (bogus) terminal "-G"
+}
+
+static char **handle_base_dir(char *arg, char **next)
+{
+	gcc_base_dir = *++next;
+	if (!gcc_base_dir)
+		die("missing argument for -gcc-base-dir option");
+	return next;
+}
+
+static char **handle_switch_g(char *arg, char **next)
+{
+	if (!strcmp (arg, "gcc-base-dir"))
+		return handle_base_dir(arg, next);
+
+	return next;
+}
+
 static char **handle_switch_I(char *arg, char **next)
 {
 	char *path = arg+1;
@@ -659,15 +838,7 @@ static char **handle_switch_M(char *arg, char **next)
 	return next;
 }
 
-static char **handle_multiarch_dir(char *arg, char **next)
-{
-	multiarch_dir = *++next;
-	if (!multiarch_dir)
-		die("missing argument for -multiarch-dir option");
-	return next;
-}
-
-static int handle_cmodel(const char *opt, const char *arg, const struct flag *flag, int options)
+static int handle_mcmodel(const char *opt, const char *arg, const struct flag *flag, int options)
 {
 	static const struct val_map cmodels[] = {
 		{ "kernel",	CMODEL_KERNEL },
@@ -682,7 +853,7 @@ static int handle_cmodel(const char *opt, const char *arg, const struct flag *fl
 	return handle_subopt_val(opt, arg, cmodels, flag->flag);
 }
 
-static int handle_float_abi(const char *opt, const char *arg, const struct flag *flag, int options) {
+static int handle_mfloat_abi(const char *opt, const char *arg, const struct flag *flag, int options) {
 	static const struct val_map fp_abis[] = {
 		{ "hard",		FP_ABI_HARD },
 		{ "soft",		FP_ABI_SOFT },
@@ -692,6 +863,14 @@ static int handle_float_abi(const char *opt, const char *arg, const struct flag
 	return handle_subopt_val(opt, arg, fp_abis, flag->flag);
 }
 
+static char **handle_multiarch_dir(char *arg, char **next)
+{
+	multiarch_dir = *++next;
+	if (!multiarch_dir)
+		die("missing argument for -multiarch-dir option");
+	return next;
+}
+
 static const struct flag mflags[] = {
 	{ "64", &arch_m64, NULL, OPT_VAL, ARCH_LP64 },
 	{ "32", &arch_m64, NULL, OPT_VAL, ARCH_LP32 },
@@ -702,8 +881,8 @@ static const struct flag mflags[] = {
 	{ "size-long", &arch_msize_long },
 	{ "big-endian", &arch_big_endian, NULL },
 	{ "little-endian", &arch_big_endian, NULL, OPT_INVERSE },
-	{ "cmodel", &arch_cmodel, handle_cmodel },
-	{ "float-abi", &arch_fp_abi, handle_float_abi },
+	{ "cmodel", &arch_cmodel, handle_mcmodel },
+	{ "float-abi", &arch_fp_abi, handle_mfloat_abi },
 	{ "hard-float", &arch_fp_abi, NULL, OPT_VAL, FP_ABI_HARD },
 	{ "soft-float", &arch_fp_abi, NULL, OPT_VAL, FP_ABI_SOFT },
 	{ }
@@ -720,6 +899,30 @@ static char **handle_switch_m(char *arg, char **next)
 	return next;
 }
 
+static char **handle_nostdinc(char *arg, char **next)
+{
+	add_pre_buffer("#nostdinc\n");
+	return next;
+}
+
+static char **handle_switch_n(char *arg, char **next)
+{
+	if (!strcmp (arg, "nostdinc"))
+		return handle_nostdinc(arg, next);
+
+	return next;
+}
+
+static char **handle_switch_O(char *arg, char **next)
+{
+	int level = 1;
+	if (arg[1] >= '0' && arg[1] <= '9')
+		level = arg[1] - '0';
+	optimize_level = level;
+	optimize_size = arg[1] == 's';
+	return next;
+}
+
 static char **handle_switch_o(char *arg, char **next)
 {
 	if (!strcmp (arg, "o")) {       // "-o foo"
@@ -743,304 +946,6 @@ static char **handle_switch_p(char *arg, char **next)
 	return next;
 }
 
-static const struct flag warnings[] = {
-	{ "address", &Waddress },
-	{ "address-space", &Waddress_space },
-	{ "bitwise", &Wbitwise },
-	{ "bitwise-pointer", &Wbitwise_pointer},
-	{ "cast-from-as", &Wcast_from_as },
-	{ "cast-to-as", &Wcast_to_as },
-	{ "cast-truncate", &Wcast_truncate },
-	{ "constant-suffix", &Wconstant_suffix },
-	{ "constexpr-not-const", &Wconstexpr_not_const},
-	{ "context", &Wcontext },
-	{ "decl", &Wdecl },
-	{ "declaration-after-statement", &Wdeclarationafterstatement },
-	{ "default-bitfield-sign", &Wdefault_bitfield_sign },
-	{ "designated-init", &Wdesignated_init },
-	{ "do-while", &Wdo_while },
-	{ "enum-mismatch", &Wenum_mismatch },
-	{ "external-function-has-definition", &Wexternal_function_has_definition },
-	{ "implicit-int", &Wimplicit_int },
-	{ "init-cstring", &Winit_cstring },
-	{ "int-to-pointer-cast", &Wint_to_pointer_cast },
-	{ "memcpy-max-count", &Wmemcpy_max_count },
-	{ "non-pointer-null", &Wnon_pointer_null },
-	{ "newline-eof", &Wnewline_eof },
-	{ "old-initializer", &Wold_initializer },
-	{ "old-style-definition", &Wold_style_definition },
-	{ "one-bit-signed-bitfield", &Wone_bit_signed_bitfield },
-	{ "override-init", &Woverride_init },
-	{ "override-init-all", &Woverride_init_all },
-	{ "paren-string", &Wparen_string },
-	{ "pedantic", &Wpedantic },
-	{ "pointer-to-int-cast", &Wpointer_to_int_cast },
-	{ "ptr-subtraction-blows", &Wptr_subtraction_blows },
-	{ "return-void", &Wreturn_void },
-	{ "shadow", &Wshadow },
-	{ "shift-count-negative", &Wshift_count_negative },
-	{ "shift-count-overflow", &Wshift_count_overflow },
-	{ "sizeof-bool", &Wsizeof_bool },
-	{ "strict-prototypes", &Wstrict_prototypes },
-	{ "pointer-arith", &Wpointer_arith },
-	{ "sparse-error", &Wsparse_error },
-	{ "tautological-compare", &Wtautological_compare },
-	{ "transparent-union", &Wtransparent_union },
-	{ "typesign", &Wtypesign },
-	{ "undef", &Wundef },
-	{ "uninitialized", &Wuninitialized },
-	{ "universal-initializer", &Wuniversal_initializer },
-	{ "unknown-attribute", &Wunknown_attribute },
-	{ "vla", &Wvla },
-	{ }
-};
-
-static char **handle_switch_W(char *arg, char **next)
-{
-	char ** ret = handle_onoff_switch(arg, next, warnings);
-	if (ret)
-		return ret;
-
-	if (!strcmp(arg, "Wsparse-all")) {
-		int i;
-		for (i = 0; warnings[i].name; i++) {
-			if (*warnings[i].flag != FLAG_FORCE_OFF)
-				*warnings[i].flag = FLAG_ON;
-		}
-	}
-
-	// Unknown.
-	return next;
-}
-
-static struct flag debugs[] = {
-	{ "compound", &dbg_compound},
-	{ "dead", &dbg_dead},
-	{ "domtree", &dbg_domtree},
-	{ "entry", &dbg_entry},
-	{ "ir", &dbg_ir},
-	{ "postorder", &dbg_postorder},
-	{ }
-};
-
-
-static char **handle_switch_v(char *arg, char **next)
-{
-	char ** ret = handle_onoff_switch(arg, next, debugs);
-	if (ret)
-		return ret;
-
-	// Unknown.
-	do {
-		verbose++;
-	} while (*++arg == 'v');
-	return next;
-}
-
-static char **handle_switch_d(char *arg, char **next)
-{
-	char *arg_char = arg + 1;
-
-	/*
-	 * -d<CHARS>, where <CHARS> is a sequence of characters, not preceded
-	 * by a space. If you specify characters whose behaviour conflicts,
-	 * the result is undefined.
-	 */
-	while (*arg_char) {
-		switch (*arg_char) {
-		case 'M': /* dump just the macro definitions */
-			dump_macros_only = 1;
-			dump_macro_defs = 0;
-			break;
-		case 'D': /* like 'M', but also output pre-processed text */
-			dump_macro_defs = 1;
-			dump_macros_only = 0;
-			break;
-		case 'N': /* like 'D', but only output macro names not bodies */
-			break;
-		case 'I': /* like 'D', but also output #include directives */
-			break;
-		case 'U': /* like 'D', but only output expanded macros */
-			break;
-		}
-		arg_char++;
-	}
-	return next;
-}
-
-
-static void handle_switch_W_finalize(void)
-{
-	handle_onoff_switch_finalize(warnings);
-
-	/* default Wdeclarationafterstatement based on the C dialect */
-	if (-1 == Wdeclarationafterstatement) {
-		switch (standard) {
-			case STANDARD_C89:
-			case STANDARD_C94:
-				Wdeclarationafterstatement = 1;
-				break;
-			default:
-				Wdeclarationafterstatement = 0;
-				break;
-		}
-	}
-}
-
-static void handle_switch_v_finalize(void)
-{
-	handle_onoff_switch_finalize(debugs);
-}
-
-static char **handle_switch_U(char *arg, char **next)
-{
-	const char *name = arg + 1;
-	add_pre_buffer ("#undef %s\n", name);
-	return next;
-}
-
-static char **handle_switch_O(char *arg, char **next)
-{
-	int level = 1;
-	if (arg[1] >= '0' && arg[1] <= '9')
-		level = arg[1] - '0';
-	optimize_level = level;
-	optimize_size = arg[1] == 's';
-	return next;
-}
-
-static int handle_ftabstop(const char *arg, const char *opt, const struct flag *flag, int options)
-{
-	unsigned long val;
-	char *end;
-
-	if (*opt == '\0')
-		die("error: missing argument to \"%s\"", arg);
-
-	/* we silently ignore silly values */
-	val = strtoul(opt, &end, 10);
-	if (*end == '\0' && 1 <= val && val <= 100)
-		tabstop = val;
-
-	return 1;
-}
-
-static int handle_fpasses(const char *arg, const char *opt, const struct flag *flag, int options)
-{
-	unsigned long mask;
-
-	mask = flag->mask;
-	if (*opt == '\0') {
-		if (options & OPT_INVERSE)
-			fpasses &= ~mask;
-		else
-			fpasses |=  mask;
-		return 1;
-	}
-	if (options & OPT_INVERSE)
-		return 0;
-	if (!strcmp(opt, "-enable")) {
-		fpasses |= mask;
-		return 1;
-	}
-	if (!strcmp(opt, "-disable")) {
-		fpasses &= ~mask;
-		return 1;
-	}
-	if (!strcmp(opt, "=last")) {
-		// clear everything above
-		mask |= mask - 1;
-		fpasses &= mask;
-		return 1;
-	}
-	return 0;
-}
-
-static int handle_fdiagnostic_prefix(const char *arg, const char *opt, const struct flag *flag, int options)
-{
-	switch (*opt) {
-	case '\0':
-		diag_prefix = "sparse: ";
-		return 1;
-	case '=':
-		diag_prefix = xasprintf("%s: ", opt+1);
-		return 1;
-	default:
-		return 0;
-	}
-}
-
-static int handle_fdump_ir(const char *arg, const char *opt, const struct flag *flag, int options)
-{
-	static const struct mask_map dump_ir_options[] = {
-		{ "",			PASS_LINEARIZE },
-		{ "linearize",		PASS_LINEARIZE },
-		{ "mem2reg",		PASS_MEM2REG },
-		{ "final",		PASS_FINAL },
-		{ },
-	};
-
-	return handle_suboption_mask(arg, opt, dump_ir_options, &fdump_ir);
-}
-
-static int handle_fmemcpy_max_count(const char *arg, const char *opt, const struct flag *flag, int options)
-{
-	opt_ullong(arg, opt, &fmemcpy_max_count, OPTNUM_ZERO_IS_INF|OPTNUM_UNLIMITED);
-	return 1;
-}
-
-static int handle_fmax_warnings(const char *arg, const char *opt, const struct flag *flag, int options)
-{
-	opt_uint(arg, opt, &fmax_warnings, OPTNUM_UNLIMITED);
-	return 1;
-}
-
-static struct flag fflags[] = {
-	{ "diagnostic-prefix",	NULL,	handle_fdiagnostic_prefix },
-	{ "dump-ir",		NULL,	handle_fdump_ir },
-	{ "freestanding",	&fhosted, NULL, OPT_INVERSE },
-	{ "hosted",		&fhosted },
-	{ "linearize",		NULL,	handle_fpasses,	PASS_LINEARIZE },
-	{ "max-warnings=",	NULL,	handle_fmax_warnings },
-	{ "mem-report",		&fmem_report },
-	{ "memcpy-max-count=",	NULL,	handle_fmemcpy_max_count },
-	{ "tabstop=",		NULL,	handle_ftabstop },
-	{ "mem2reg",		NULL,	handle_fpasses,	PASS_MEM2REG },
-	{ "optim",		NULL,	handle_fpasses,	PASS_OPTIM },
-	{ "pic",		&fpic,	handle_switch_setval, 1 },
-	{ "PIC",		&fpic,	handle_switch_setval, 2 },
-	{ "pie",		&fpie,	handle_switch_setval, 1 },
-	{ "PIE",		&fpie,	handle_switch_setval, 2 },
-	{ "signed-char",	&funsigned_char, NULL,	OPT_INVERSE },
-	{ "short-wchar",	&fshort_wchar },
-	{ "unsigned-char",	&funsigned_char, NULL, },
-	{ },
-};
-
-static char **handle_switch_f(char *arg, char **next)
-{
-	if (handle_switches(arg-1, arg+1, fflags))
-		return next;
-
-	return next;
-}
-
-static char **handle_switch_G(char *arg, char **next)
-{
-	if (!strcmp (arg, "G") && *next)
-		return next + 1; // "-G 0"
-	else
-		return next;     // "-G0" or (bogus) terminal "-G"
-}
-
-static char **handle_switch_a(char *arg, char **next)
-{
-	if (!strcmp (arg, "ansi"))
-		standard = STANDARD_C89;
-
-	return next;
-}
-
 static char **handle_switch_s(const char *arg, char **next)
 {
 	if ((arg = match_option(arg, "std="))) {
@@ -1087,36 +992,129 @@ static char **handle_switch_s(const char *arg, char **next)
 	return next;
 }
 
-static char **handle_nostdinc(char *arg, char **next)
+static char **handle_switch_U(char *arg, char **next)
 {
-	add_pre_buffer("#nostdinc\n");
+	const char *name = arg + 1;
+	add_pre_buffer ("#undef %s\n", name);
 	return next;
 }
 
-static char **handle_switch_n(char *arg, char **next)
+static struct flag debugs[] = {
+	{ "compound", &dbg_compound},
+	{ "dead", &dbg_dead},
+	{ "domtree", &dbg_domtree},
+	{ "entry", &dbg_entry},
+	{ "ir", &dbg_ir},
+	{ "postorder", &dbg_postorder},
+	{ }
+};
+
+static char **handle_switch_v(char *arg, char **next)
 {
-	if (!strcmp (arg, "nostdinc"))
-		return handle_nostdinc(arg, next);
+	char ** ret = handle_onoff_switch(arg, next, debugs);
+	if (ret)
+		return ret;
 
+	// Unknown.
+	do {
+		verbose++;
+	} while (*++arg == 'v');
 	return next;
 }
 
-static char **handle_base_dir(char *arg, char **next)
+static void handle_switch_v_finalize(void)
 {
-	gcc_base_dir = *++next;
-	if (!gcc_base_dir)
-		die("missing argument for -gcc-base-dir option");
-	return next;
+	handle_onoff_switch_finalize(debugs);
 }
 
-static char **handle_switch_g(char *arg, char **next)
+static const struct flag warnings[] = {
+	{ "address", &Waddress },
+	{ "address-space", &Waddress_space },
+	{ "bitwise", &Wbitwise },
+	{ "bitwise-pointer", &Wbitwise_pointer},
+	{ "cast-from-as", &Wcast_from_as },
+	{ "cast-to-as", &Wcast_to_as },
+	{ "cast-truncate", &Wcast_truncate },
+	{ "constant-suffix", &Wconstant_suffix },
+	{ "constexpr-not-const", &Wconstexpr_not_const},
+	{ "context", &Wcontext },
+	{ "decl", &Wdecl },
+	{ "declaration-after-statement", &Wdeclarationafterstatement },
+	{ "default-bitfield-sign", &Wdefault_bitfield_sign },
+	{ "designated-init", &Wdesignated_init },
+	{ "do-while", &Wdo_while },
+	{ "enum-mismatch", &Wenum_mismatch },
+	{ "external-function-has-definition", &Wexternal_function_has_definition },
+	{ "implicit-int", &Wimplicit_int },
+	{ "init-cstring", &Winit_cstring },
+	{ "int-to-pointer-cast", &Wint_to_pointer_cast },
+	{ "memcpy-max-count", &Wmemcpy_max_count },
+	{ "non-pointer-null", &Wnon_pointer_null },
+	{ "newline-eof", &Wnewline_eof },
+	{ "old-initializer", &Wold_initializer },
+	{ "old-style-definition", &Wold_style_definition },
+	{ "one-bit-signed-bitfield", &Wone_bit_signed_bitfield },
+	{ "override-init", &Woverride_init },
+	{ "override-init-all", &Woverride_init_all },
+	{ "paren-string", &Wparen_string },
+	{ "pedantic", &Wpedantic },
+	{ "pointer-to-int-cast", &Wpointer_to_int_cast },
+	{ "ptr-subtraction-blows", &Wptr_subtraction_blows },
+	{ "return-void", &Wreturn_void },
+	{ "shadow", &Wshadow },
+	{ "shift-count-negative", &Wshift_count_negative },
+	{ "shift-count-overflow", &Wshift_count_overflow },
+	{ "sizeof-bool", &Wsizeof_bool },
+	{ "strict-prototypes", &Wstrict_prototypes },
+	{ "pointer-arith", &Wpointer_arith },
+	{ "sparse-error", &Wsparse_error },
+	{ "tautological-compare", &Wtautological_compare },
+	{ "transparent-union", &Wtransparent_union },
+	{ "typesign", &Wtypesign },
+	{ "undef", &Wundef },
+	{ "uninitialized", &Wuninitialized },
+	{ "universal-initializer", &Wuniversal_initializer },
+	{ "unknown-attribute", &Wunknown_attribute },
+	{ "vla", &Wvla },
+	{ }
+};
+
+static char **handle_switch_W(char *arg, char **next)
 {
-	if (!strcmp (arg, "gcc-base-dir"))
-		return handle_base_dir(arg, next);
+	char ** ret = handle_onoff_switch(arg, next, warnings);
+	if (ret)
+		return ret;
 
+	if (!strcmp(arg, "Wsparse-all")) {
+		int i;
+		for (i = 0; warnings[i].name; i++) {
+			if (*warnings[i].flag != FLAG_FORCE_OFF)
+				*warnings[i].flag = FLAG_ON;
+		}
+	}
+
+	// Unknown.
 	return next;
 }
 
+static void handle_switch_W_finalize(void)
+{
+	handle_onoff_switch_finalize(warnings);
+
+	/* default Wdeclarationafterstatement based on the C dialect */
+	if (-1 == Wdeclarationafterstatement) {
+		switch (standard) {
+			case STANDARD_C89:
+			case STANDARD_C94:
+				Wdeclarationafterstatement = 1;
+				break;
+			default:
+				Wdeclarationafterstatement = 0;
+				break;
+		}
+	}
+}
+
 static char **handle_switch_x(char *arg, char **next)
 {
 	if (!*++next)
@@ -1139,12 +1137,6 @@ static char **handle_arch(char *arg, char **next)
 	return next;
 }
 
-static char **handle_version(char *arg, char **next)
-{
-	printf("%s\n", SPARSE_VERSION);
-	exit(0);
-}
