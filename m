From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 12/15] options: keep the options sorted
Date: Sun,  5 Jul 2020 15:02:17 +0200
Message-ID: <20200705130220.26230-13-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgGENCl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:41 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069D1C08C5DE
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w6so39615457ejq.6
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:40 -0700 (PDT)
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The declarations and definitions of the variables corresponding to
the options half-sorted half-unsorted.

Sort them a little more.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 options.c |  98 +++++++++++++++++++-------------------
 options.h | 137 ++++++++++++++++++++++++++++--------------------------
 2 files changed, 120 insertions(+), 115 deletions(-)

diff --git a/options.c b/options.c
index 092c8690d054..9f05bdf9cf4f 100644
--- a/options.c
+++ b/options.c
@@ -18,20 +18,33 @@
 #include <string.h>
 
 
-int verbose, optimize_level, optimize_size, preprocessing;
-int die_if_error = 0;
-int has_error = 0;
-int do_output = 1;
-
 #ifndef __GNUC__
 # define __GNUC__ 2
 # define __GNUC_MINOR__ 95
 # define __GNUC_PATCHLEVEL__ 0
 #endif
 
+enum flag_type {
+	FLAG_OFF,
+	FLAG_ON,
+	FLAG_FORCE_OFF
+};
+
+int die_if_error = 0;
+int do_output = 1;
 int gcc_major = __GNUC__;
 int gcc_minor = __GNUC_MINOR__;
 int gcc_patchlevel = __GNUC_PATCHLEVEL__;
+int has_error = 0;
+int optimize_level;
+int optimize_size;
+int preprocess_only;
+int preprocessing;
+int verbose;
+
+#define CMDLINE_INCLUDE 20
+int cmdline_include_nr = 0;
+char *cmdline_include[CMDLINE_INCLUDE];
 
 const char *base_filename;
 const char *diag_prefix = "";
@@ -39,11 +52,35 @@ const char *gcc_base_dir = GCC_BASE;
 const char *multiarch_dir = MULTIARCH_TRIPLET;
 const char *outfile = NULL;
 
-enum flag_type {
-	FLAG_OFF,
-	FLAG_ON,
-	FLAG_FORCE_OFF
-};
+enum standard standard = STANDARD_GNU89;
+
+int arch_big_endian = ARCH_BIG_ENDIAN;
+int arch_cmodel = CMODEL_UNKNOWN;
+int arch_fp_abi = FP_ABI_NATIVE;
+int arch_m64 = ARCH_M64_DEFAULT;
+int arch_msize_long = 0;
+int arch_os = OS_NATIVE;
+
+int dbg_compound = 0;
+int dbg_dead = 0;
+int dbg_domtree = 0;
+int dbg_entry = 0;
+int dbg_ir = 0;
+int dbg_postorder = 0;
+
+int dump_macro_defs = 0;
+int dump_macros_only = 0;
+
+unsigned long fdump_ir;
+int fhosted = 1;
+unsigned int fmax_warnings = 100;
+int fmem_report = 0;
+unsigned long long fmemcpy_max_count = 100000;
+unsigned long fpasses = ~0UL;
+int fpic = 0;
+int fpie = 0;
+int fshort_wchar = 0;
+int funsigned_char = 0;
 
 int Waddress = 0;
 int Waddress_space = 1;
@@ -60,11 +97,11 @@ int Wdeclarationafterstatement = -1;
 int Wdefault_bitfield_sign = 0;
 int Wdesignated_init = 1;
 int Wdo_while = 0;
+int Wenum_mismatch = 1;
+int Wexternal_function_has_definition = 1;
 int Wimplicit_int = 1;
 int Winit_cstring = 0;
 int Wint_to_pointer_cast = 1;
-int Wenum_mismatch = 1;
-int Wexternal_function_has_definition = 1;
 int Wmemcpy_max_count = 1;
 int Wnewline_eof = 1;
 int Wnon_pointer_null = 1;
@@ -95,43 +132,6 @@ int Wuniversal_initializer = 0;
 int Wunknown_attribute = 0;
 int Wvla = 1;
 
-int dump_macro_defs = 0;
-int dump_macros_only = 0;
-
-int dbg_compound = 0;
-int dbg_dead = 0;
-int dbg_domtree = 0;
-int dbg_entry = 0;
-int dbg_ir = 0;
-int dbg_postorder = 0;
-
-unsigned long fdump_ir;
-int fhosted = 1;
-unsigned int fmax_warnings = 100;
-int fmem_report = 0;
-unsigned long long fmemcpy_max_count = 100000;
-unsigned long fpasses = ~0UL;
-int fpic = 0;
-int fpie = 0;
-int fshort_wchar = 0;
-int funsigned_char = 0;
-
-int preprocess_only;
-
-enum standard standard = STANDARD_GNU89;
-
-int arch_msize_long = 0;
-int arch_m64 = ARCH_M64_DEFAULT;
-int arch_big_endian = ARCH_BIG_ENDIAN;
-int arch_fp_abi = FP_ABI_NATIVE;
-int arch_os = OS_NATIVE;
-int arch_cmodel = CMODEL_UNKNOWN;
-
-
-#define CMDLINE_INCLUDE 20
-int cmdline_include_nr = 0;
-char *cmdline_include[CMDLINE_INCLUDE];
-
 ////////////////////////////////////////////////////////////////////////////////
 // Helpers for option parsing
 
diff --git a/options.h b/options.h
index 52d1106e7576..7fd01ec6cebe 100644
--- a/options.h
+++ b/options.h
@@ -1,26 +1,85 @@
 #ifndef OPTIONS_H
 #define OPTIONS_H
 
-extern int verbose, optimize_level, optimize_size, preprocessing;
+enum {
+	CMODEL_UNKNOWN,
+	CMODEL_KERNEL,
+	CMODEL_LARGE,
+	CMODEL_MEDANY,
+	CMODEL_MEDIUM,
+	CMODEL_MEDLOW,
+	CMODEL_PIC,
+	CMODEL_SMALL,
+	CMODEL_TINY,
+	CMODEL_LAST,
+};
+
+enum standard {
+	STANDARD_NONE,
+	STANDARD_GNU,
+	STANDARD_C89,
+	STANDARD_GNU89 = STANDARD_C89 | STANDARD_GNU,
+	STANDARD_C94,
+	STANDARD_GNU94 = STANDARD_C94 | STANDARD_GNU,
+	STANDARD_C99,
+	STANDARD_GNU99 = STANDARD_C99 | STANDARD_GNU,
+	STANDARD_C11,
+	STANDARD_GNU11 = STANDARD_C11 | STANDARD_GNU,
+	STANDARD_C17,
+	STANDARD_GNU17 = STANDARD_C17 | STANDARD_GNU,
+};
+
 extern int die_if_error;
-extern int repeat_phase;
 extern int do_output;
-extern int gcc_major, gcc_minor, gcc_patchlevel;
-extern unsigned int tabstop;
+extern int gcc_major;
+extern int gcc_minor;
+extern int gcc_patchlevel;
+extern int optimize_level;
+extern int optimize_size;
+extern int preprocess_only;
+extern int preprocessing;
+extern int repeat_phase;
+extern int verbose;
+
+extern int cmdline_include_nr;
+extern char *cmdline_include[];
 
 extern const char *base_filename;
 extern const char *diag_prefix;
 extern const char *gcc_base_dir;
 extern const char *multiarch_dir;
 extern const char *outfile;
-extern int cmdline_include_nr;
-extern char *cmdline_include[];
 
-extern char **handle_switch(char *arg, char **next);
-extern void handle_switch_finalize(void);
+extern enum standard standard;
+extern unsigned int tabstop;
 
+extern int arch_big_endian;
+extern int arch_cmodel;
+extern int arch_fp_abi;
+extern int arch_m64;
+extern int arch_msize_long;
+extern int arch_os;
 
-extern int preprocess_only;
+extern int dbg_compound;
+extern int dbg_dead;
+extern int dbg_domtree;
+extern int dbg_entry;
+extern int dbg_ir;
+extern int dbg_postorder;
+
+extern int dump_macro_defs;
+extern int dump_macros_only;
+
+extern unsigned long fdump_ir;
+extern int fhosted;
+extern unsigned int fmax_warnings;
+extern int fmem_report;
+extern unsigned long long fmemcpy_max_count;
+extern unsigned long fpasses;
+extern int fpic;
+extern int fpie;
+extern int fshort_wchar;
+extern int funsigned_char;
 
 extern int Waddress;
 extern int Waddress_space;
@@ -39,7 +98,6 @@ extern int Wdesignated_init;
 extern int Wdo_while;
 extern int Wenum_mismatch;
 extern int Wexternal_function_has_definition;
-extern int Wsparse_error;
 extern int Wimplicit_int;
 extern int Winit_cstring;
 extern int Wint_to_pointer_cast;
@@ -62,6 +120,7 @@ extern int Wshadow;
 extern int Wshift_count_negative;
 extern int Wshift_count_overflow;
 extern int Wsizeof_bool;
+extern int Wsparse_error;
 extern int Wstrict_prototypes;
 extern int Wtautological_compare;
 extern int Wtransparent_union;
@@ -72,61 +131,7 @@ extern int Wuniversal_initializer;
 extern int Wunknown_attribute;
 extern int Wvla;
 
-extern int dump_macro_defs;
-extern int dump_macros_only;
-
-extern int dbg_compound;
-extern int dbg_dead;
-extern int dbg_domtree;
-extern int dbg_entry;
-extern int dbg_ir;
-extern int dbg_postorder;
-
-extern unsigned int fmax_warnings;
-extern int fmem_report;
-extern unsigned long fdump_ir;
-extern int fhosted;
-extern unsigned long long fmemcpy_max_count;
-extern unsigned long fpasses;
-extern int fpic;
-extern int fpie;
-extern int fshort_wchar;
-extern int funsigned_char;
-
-extern int arch_msize_long;
-extern int arch_m64;
-extern int arch_big_endian;
-extern int arch_fp_abi;
-extern int arch_os;
-
-enum {
-	CMODEL_UNKNOWN,
-	CMODEL_KERNEL,
-	CMODEL_LARGE,
-	CMODEL_MEDANY,
-	CMODEL_MEDIUM,
-	CMODEL_MEDLOW,
-	CMODEL_PIC,
-	CMODEL_SMALL,
-	CMODEL_TINY,
-	CMODEL_LAST,
-};
-extern int arch_cmodel;
