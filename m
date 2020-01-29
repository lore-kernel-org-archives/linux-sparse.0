From: Xan Phung <xan.phung@gmail.com>
Subject: PATCH: sparse_add_switch() for backends to register new switches into
 main parsing table
Date: Wed, 29 Jan 2020 19:25:40 +0800
Message-ID: <CAO6moYuBpk_qnrs+pMYK4rHjDzOpRDJSC_mYHew8tvfbiehWqw@mail.gmail.com>
References: <CAO6moYtTsA8niRvL135+OMXDjAEnGEGMf8kG+CYgq+YDKPi4UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42254 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgA2L0Y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 29 Jan 2020 06:26:24 -0500
Received: by mail-lj1-f194.google.com with SMTP id d10so9798ljl.9
        for <linux-sparse@vger.kernel.org>; Wed, 29 Jan 2020 03:26:19 -0800 (PST)
In-Reply-To: <CAO6moYtTsA8niRvL135+OMXDjAEnGEGMf8kG+CYgq+YDKPi4UQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org, luc.vanoostenryck@gmail.com

Hi,

I propose (& provide an implementation of) a "sparse_add_switch()"
function to enable any backend to register new switches for
sparse_initialize().  The background to this is that I am creating a
backend to link Sparse to the WebAssembly ecosystem (in the same way
Sparse-LLVM links to LLVM ecosystem).  As backends for Sparse
proliferate, they will inevitably need new command line switches.

A sparse_add_switch() function enables lib.c to provide extensible
switch parsing for arbitrary backends.

** What it does **: sparse_add_switch() adds new entries into lib.c's
flag tables (which drive the parsing of command line switches).

** Other benefits **: Simplification of lib.c - ie: removal of approx
800 lines (as of the Jan 2020 master branch), comprising the all
handle_switch_[a-z] code.  The same functionality is instead provided
by 200 lines of flag array initialisers, and approx 100 lines of new
"general purpose" switch parsing code.  (The only switch-specific code
left are the finalizer for v & W switch, an --arch helper and --arch
finalizer).

** How it works **: General purpose switch parsing code consists of 3
functions in just 100 lines of code.  Everything else (except
finalisation code) is encoded in an array of flag structures, which
are initialized by compile time constants.  The 3 functions are:

(1) handle_switch(): matches an argv switch (eg. -fdump-ir) to flag
structures within the flag array (against the field flag->name, eg.
name="dump-ir").

(2) match_suboption(): matches suboption text (eg. "optim" & "final"
in fdump-ir=optim,final) with a suboption flag structure.  This
replaces the (current) lib.c handle_suboption_mask(), a key change
being the suboption flag structure follows same format as flag
structure.  This change allows match_param (#3 below) to be
indifferent to whether it is called by #2 (suboption) or directly by
#1 (main option).

(3) match_param(): is called by either #1 or #2 above, and can (in any
combination) apply a mask, call sscanf(), and call printf-like
functions - ie: printf(), die(), add_pre_buffer(), set_arch().
NOTE: struct flag has been expanded with new char* in_fmt, out_fmt
fields for the sscanf & printf functions, and int "val" has been
renamed as int "action".

** Validation (separate patch) **: I have also written a demo
"test-switches" program, which demonstrates the use of
sparse_add_switch() and tests correctness of the code.  I am
submitting it as a separate patch, as it's an optional/lower priority
add-on.  I don't need to have it in the sparse upstream tree for my
backend, whereas my backend won't work without the sparse_add_switch
function.

** Documentation (separate patch) **: I can provide documentation of
the sparse_add_switch() function's interface as a separate patch, once
a decision on the final form of this patch is finalised.

** DIFFS **: The changes proposed are best understood as 3 diffs
comprising (i) changes to existing code, (ii) new code, and (iii)
deleted code:



(i) **************** Changed lines: ****************
* New in_fmt & out_fmt fields are added to struct flag as discussed above.
* My code supports sscanf into flags which are strings (eg. outfile),
long long's (eg. fmemcpy_max_count) or int's, but I don't support
long's (hence fpasses and fdump-ir changed to unsigned int).  I could
add long support, but such support seems to be unnecessary, ie: ILP32,
LP64 and LLP64 all provide 64 & 32 bit fields via just long long and
int, and hence long doesn't add anything new to this.
* Function signature changes: add_cmdline_include changed to be
consistent with printf function signature by adding char *fmt field,
and handle_onoff_switch_finalize no longer uses array size parameter
(it detects a guard NULL entry instead).
* Makefile: the Wmissing-braces compiler setting is disabled, but
could be re-enabled at the cost of adding an extra set of braces to
each line of the lib.c warnings array, eg. { "shift-count-negative",
&Wshift_count_negative } becomes { "shift-count-negative",
{&Wshift_count_negative} }.  This wasn't done as I didn't want to
complicate the diff output.  My code otherwise does not create any
compiler warnings when compiled with GNU make & mac OS (command line)
clang.
* Please see note in part (iii) diff below about applying delete diff
first before applying this diff



diff --git a/Makefile b/Makefile
index deab489..8da31c3 100644
--- a/Makefile
+++ b/Makefile
@@ -96 +96 @@ cflags = -fno-strict-aliasing
-cflags += -Wall -Wwrite-strings
+cflags += -Wall -Wwrite-strings -Wno-missing-braces

diff --git a/lib.h b/lib.h
index 3e565c6..0aff45e 100644
--- a/lib.h
+++ b/lib.h
@@ -198 +198 @@ extern int dbg_postorder;
-extern unsigned int fmax_warnings;
+extern unsigned fmax_warnings;
@@ -200 +200 @@ extern int fmem_report;
-extern unsigned long fdump_ir;
+extern unsigned fdump_ir;
@@ -202 +202 @@ extern unsigned long long fmemcpy_max_count;
-extern unsigned long fpasses;
+extern unsigned fpasses;
@@ -248,0 +249,10 @@ extern void report_stats(void);
+extern int sparse_add_switch(int action, const char *name, ...);
+
+#define OPT_INVERSE 0x0001
+#define OPT_VAL     0x0002
+#define OPT_MASK    0x0004
+#define OPT_NO_SEP  0x0008
+#define OPT_INEXT   0x0010
+#define OPT_INLINE  0x0020
+#define OPT_NO_RET  0x0040
+#define OPT_INPUT   (OPT_INLINE | OPT_INEXT)

diff --git a/lib.c b/lib.c
index 60a6941..4e400b2 100644
--- a/lib.c
+++ b/lib.c
@@ -5,0 +6 @@
+ *               2020 Xan Phung
@@ -33,0 +35 @@
+#include <inttypes.h>
@@ -310 +312 @@ int dbg_postorder = 0;
-unsigned long fdump_ir;
+unsigned fdump_ir;
@@ -313 +315 @@ unsigned long long fmemcpy_max_count = 100000;
-unsigned long fpasses = ~0UL;
+unsigned fpasses = ~0U;
@@ -366,2 +367,0 @@ static const char *match_option(const char *arg,
const char *prefix)
-#define OPT_INVERSE    1
-#define OPT_VAL                2
@@ -370,4 +370,10 @@ struct flag {
-       int *flag;
-       int (*fun)(const char *arg, const char *opt, const struct flag
*, int options);
-       unsigned long mask;
-       int val;
+       union {
+               int *flag;
+               long long *long_flag;
+               const char **string;
+       };
+       uintptr_t mask;
+       const char *in_fmt;
+       const char *out_fmt;
+       void (*out_fn)(const char *,...);
+       int action;
@@ -382 +388 @@ enum {
-static void add_cmdline_include(char *filename)
+static void add_cmdline_include(const char *fmt, ...)
@@ -383,0 +390,4 @@ static void add_cmdline_include(char *filename)
+       va_list args;
+       va_start(args, fmt);
+       char *filename = va_arg(args, char *);
+       va_end(args);
@@ -419 +429 @@ static void handle_arch_finalize(void)
-static const struct flag warnings[] = {
+static const struct flag warnings[80] = {
@@ -457 +467 @@ static const struct flag warnings[] = {
-       { "sparse-error", &Wsparse_error },
+       { "sparse-error", &Wsparse_error, .mask=1, .action=OPT_MASK },
@@ -467 +477 @@ static const struct flag warnings[] = {
-static void handle_onoff_switch_finalize(const struct flag warnings[], int n)
+static void handle_switch_finalize(const struct flag warnings[])
@@ -471,3 +481,3 @@ static void handle_onoff_switch_finalize(const
struct flag warnings[], int n)
-       for (i = 0; i < n; i++) {
-               if (*warnings[i].flag == WARNING_FORCE_OFF)
-                       *warnings[i].flag = WARNING_OFF;
+       for (i = 0; warnings[i].flag; i++) {
+               if (!warnings[i].action && *warnings[i].flag &
WARNING_FORCE_OFF)
+                       *warnings[i].flag &= ~WARNING_FORCE_OFF;
@@ -479 +489 @@ static void handle_switch_W_finalize(void)
-       handle_onoff_switch_finalize(warnings, ARRAY_SIZE(warnings));
+       handle_switch_finalize(warnings);
@@ -482 +492 @@ static void handle_switch_W_finalize(void)
-       if (-1 == Wdeclarationafterstatement) {
+       if (Wdeclarationafterstatement < 0) {




(ii) **************** New lines: *****************
The diff below is a direct continuation of the diff above, and adds
the new switch parsing functions and flag array discussed.



@@ -494,0 +505,367 @@ static void handle_switch_W_finalize(void)
+static void set_arch(const char *fmt, ...)
+{
+       unsigned bits = 0, mach = 0, min = 0, big = 0;
+       va_list args;
+       va_start(args, fmt);
+       bits = va_arg(args, int);
+       mach = va_arg(args, int);
+       va_end(args);
+       assert(fmt && sscanf(fmt, "#%*s (%*[^)]) m=%2d,%1d", &min, &big) == 2);
+       assert(big <= 1 && min % 32 == 0);
+       if (bits & ~63) {
+               arch_mach = mach | 1;
+               arch_m64  = (arch_m64 == ARCH_LP32) ? ARCH_LP64 : arch_m64;
+       } else {
+               arch_mach = mach;
+               arch_m64  = ARCH_LP32;
+       }
+       arch_big_endian = (big == '1') ? 1 : 0;
+}
+
+typedef void (*out_fn)(const char *, ...);
+static  char opt_grp[sizeof(long long)];  //Placeholder for unused
input which is parsed & discarded;
+
+#define FLAGS_SIZE             40
+#define BEGIN_flag(a)          [a] = (struct flag[FLAGS_SIZE]) {
+#define END_flag               {NULL} }
+
+#define FLAG_DATA(n,p,m,i,o,a) { n+2, (void *)&(p), (uintptr_t)m,
i"%7$n", "#%3$s "#p" "o"\n", NULL, OPT_MASK + a }
+#define FLAG_STRG(n,p,a)       FLAG_DATA((n), (p), 0,   "%3$n",
"strg=%1$s",       OPT_VAL+(a))
+#define FLAG_IVAL(n,p,i)       FLAG_DATA((n), (p), 0,   i,
"ival=%1$"PRIdPTR, OPT_VAL+OPT_INLINE )
+#define FLAG_ENUM(n,p,m)       FLAG_DATA((n), (p), (m), "\0",
"bset=%1$"PRIdPTR,-OPT_MASK+(*(n)-'@')&0x7)
+#define FLAG_LNUM(n,p,m)       FLAG_DATA((n), (p), (m),
"%1$lli","lnum=%1$"PRIdPTR, OPT_VAL)
+#define FLAG_OGRP(n,p)         FLAG_DATA((n),
(p),*(n)=='*',"\0","true=%1$"PRIdPTR, OPT_VAL+OPT_NO_SEP)
+
+#define FLAG_PRNT(n,f,m,i,o,a) { n+2, (void *)&opt_grp,
(uintptr_t)(m), (i), o"\n", f, OPT_MASK | OPT_VAL | a}
+#define FLAG_ERRM(n,m,f)       { n+2, (void *)&opt_grp, 0, NULL, (m),
(f)>>2 ? &die : (out_fn)&printf, OPT_INLINE|OPT_NO_RET }
+#define FLAG_INCL(n,a)         FLAG_PRNT((n), &add_cmdline_include,
0, 0, "#%3$s (cmdline_include) path=%1$s", (a))
+#define FLAG_PDEF(n,a,o)       FLAG_PRNT((n), &add_pre_buffer,"1",
"%3$n%7$n%*[^=]=%4$n%5$n", o, (a))
+#define FLAG_ARCH(n,f,m)       FLAG_PRNT((n), &set_arch,      (m),
"%7$n%1$2u%7$n", "#%3$s (arch) m="f",%1$d,%2$d", OPT_INLINE)
+
+static struct flag *flags[] = {
+       BEGIN_flag('D')
+               FLAG_OGRP("~D", opt_grp),
+               FLAG_PDEF("~D#", OPT_INPUT, "#define %s %s"),
+       END_flag,
+       BEGIN_flag('U')
+               FLAG_OGRP("~U", opt_grp),
+               FLAG_PDEF("~U#", OPT_INPUT, "#undef %s"),
+       END_flag,
+       BEGIN_flag('d')
+               FLAG_OGRP("~d", opt_grp),
+               FLAG_OGRP(". #M", dump_macro_defs),
+               FLAG_OGRP("* #D", dump_macro_defs),
+               FLAG_OGRP("* #N", dump_macros_only),
+               FLAG_OGRP("* #I", dump_macros_only),
+               FLAG_OGRP("* #U", dump_macros_only),
+               FLAG_OGRP("~d", opt_grp),
+               FLAG_OGRP("* #M", dump_macros_only),
+               FLAG_OGRP(". #D", dump_macros_only),
+               FLAG_OGRP(". #N", dump_macros_only),
+               FLAG_OGRP(". #I", dump_macros_only),
+               FLAG_OGRP(". #U", dump_macros_only),
+       END_flag,
+       BEGIN_flag('E')
+               FLAG_ENUM("~E", preprocess_only, 1),
+       END_flag,
+       BEGIN_flag('f')
+               FLAG_ENUM("~fmem-report", fmem_report, 1),
+               FLAG_ENUM("~funsigned-char",funsigned_char, 1),
+               FLAG_ENUM("-fsigned-char", funsigned_char, 1),
+               FLAG_ENUM("~fshort-wchar", fshort_wchar, 1),
+               FLAG_ENUM("~fpic", fpic, 1),
+               FLAG_ENUM("~fPIC", fpic, 2),
+               FLAG_ENUM("~fpie", fpie, 1),
+               FLAG_ENUM("~fPIE", fpie, 2),
+               FLAG_OGRP("~fmemcpy-max-count=", opt_grp),
+               FLAG_LNUM(". #unlimited", fmemcpy_max_count, "-1"),
+               FLAG_LNUM(". #0", fmemcpy_max_count, "-1"),
+               FLAG_IVAL(". #", fmemcpy_max_count, "%1$lld"),
+               FLAG_OGRP("~fmax-warnings=", opt_grp),
+               FLAG_ENUM(". #unlimited", fmax_warnings, ~0),
+               FLAG_IVAL(". #", fmax_warnings, "%1$d"),
+               FLAG_ERRM("~ftabstop=0", "error: wrong argument to '%3$s'", 6),
+               FLAG_IVAL("~ftabstop=", tabstop, "%1$2u"),
+               FLAG_DATA("~fdiagnostic-prefix", diag_prefix, "sparse:
", "\0", "strg=%1$s", OPT_VAL),
+               FLAG_STRG(". #", diag_prefix, OPT_INLINE),
+               FLAG_ENUM("~fdump-ir", fdump_ir, PASS_LINEARIZE),
+               FLAG_ENUM(", #linearize", fdump_ir, PASS_LINEARIZE),
+               FLAG_ENUM(", #mem2reg", fdump_ir, PASS_MEM2REG),
+               FLAG_ENUM(", #final", fdump_ir,  PASS_FINAL),
+               FLAG_ENUM("$flinearize",fpasses, PASS_LINEARIZE),
+               FLAG_ENUM("- #last", fpasses, ~(PASS_LINEARIZE |
PASS_LINEARIZE-1)),
+               FLAG_ENUM("$fmem2reg", fpasses, PASS_MEM2REG),
+               FLAG_ENUM("- #last", fpasses, ~(PASS_MEM2REG | PASS_MEM2REG-1)),
+               FLAG_ENUM("$foptim", fpasses,   PASS_OPTIM),
+               FLAG_ENUM("- #last", fpasses, ~(PASS_OPTIM | PASS_OPTIM-1)),
+       END_flag,
+       BEGIN_flag('g')
+               FLAG_STRG("~gcc-base-dir", gcc_base_dir, OPT_INEXT),
+       END_flag,
+       BEGIN_flag('G')
+               FLAG_OGRP("~G", opt_grp),
+               FLAG_STRG("~G#", opt_grp, OPT_INPUT),
+       END_flag,
+       BEGIN_flag('I')
+               FLAG_OGRP("~I", opt_grp),
+               FLAG_PDEF("~I#-", OPT_NO_SEP, "#split_include"),
+               FLAG_PDEF("~I#", OPT_NO_SEP|OPT_INPUT, "#add_include \"%s/\""),
+       END_flag,
+       BEGIN_flag('i')
+               FLAG_INCL("~include",   OPT_INPUT),
+               FLAG_INCL("~imacro",    OPT_INPUT),
+               FLAG_PDEF("~isystem",   OPT_INPUT, "#add_isystem \"%s/\""),
+               FLAG_PDEF("~idirafter", OPT_INPUT, "#add_dirafter \"%s/\""),
+       END_flag,
+       BEGIN_flag('m')
+               FLAG_ENUM("~m16", arch_m64, ARCH_LP32),
+               FLAG_ENUM("~m31", arch_m64, ARCH_LP32),
+               FLAG_ENUM("~m32", arch_m64, ARCH_LP32),
+               FLAG_ENUM("~mx32", arch_m64, ARCH_X32),
+               FLAG_ENUM("~m64", arch_m64, ARCH_LP64),
+               FLAG_ENUM("~msize-llp64", arch_m64, ARCH_LLP64),
+               FLAG_ENUM("~msize-long", arch_msize_long, 1),
+               FLAG_ENUM("~mbig-endian", arch_big_endian, 1),
+               FLAG_ENUM("-mlittle-endian",arch_big_endian, 1),
+               FLAG_STRG("~multiarch-dir", multiarch_dir, OPT_INEXT),
+               FLAG_OGRP("~mcmodel", opt_grp),
+               FLAG_ENUM(". #kernel",  arch_cmodel, CMODEL_KERNEL),
+               FLAG_ENUM(". #large",   arch_cmodel, CMODEL_LARGE),
+               FLAG_ENUM(". #medany",  arch_cmodel, CMODEL_MEDANY),
+               FLAG_ENUM(". #medium",  arch_cmodel, CMODEL_MEDIUM),
+               FLAG_ENUM(". #medlow",  arch_cmodel, CMODEL_MEDLOW),
+               FLAG_ENUM(". #small",   arch_cmodel, CMODEL_SMALL),
+               FLAG_ENUM(". #tiny",      arch_cmodel, CMODEL_TINY),
+               FLAG_OGRP("~mfloat-abi", opt_grp),
+               FLAG_ENUM(". #hard", arch_fp_abi, FP_ABI_HARD),
+               FLAG_ENUM(". #soft", arch_fp_abi, FP_ABI_SOFT),
+               FLAG_ENUM(". #softfp", arch_fp_abi, FP_ABI_HYBRID),
+               FLAG_ENUM("~mhard-float", arch_fp_abi, FP_ABI_HARD),
+               FLAG_ENUM("~msoft-float", arch_fp_abi, FP_ABI_SOFT),
+       END_flag,
+       BEGIN_flag('M')
+               FLAG_STRG("~MF", opt_grp, OPT_INEXT),
+               FLAG_STRG("~MQ", opt_grp, OPT_INEXT),
+               FLAG_STRG("~MT", opt_grp, OPT_INEXT),
+       END_flag,
+       BEGIN_flag('n')
+               FLAG_PDEF("~nostdinc", 0, "#nostdinc"),
+       END_flag,
+       BEGIN_flag('o')
+               FLAG_STRG("~o", outfile, OPT_INPUT),
+       END_flag,
+       BEGIN_flag('O')
+               FLAG_OGRP("~O", opt_grp),
+               FLAG_ENUM(". #s", optimize_size, 1),
+               FLAG_IVAL(". #",  optimize_size,  "%7$n1%1$n"), //
writes one into flag if O1 or zero otherwise
+               FLAG_OGRP("~O", opt_grp),
+               FLAG_ENUM(". #s", optimize_level, 1),
+               FLAG_IVAL(". #",  optimize_level, "%1$1u"),
+       END_flag,
+       BEGIN_flag('a')
+               FLAG_ENUM("~ansi", standard, STANDARD_C89),
+       END_flag,
+       BEGIN_flag('s')
+               FLAG_OGRP("~std=", opt_grp),
+               FLAG_ENUM(". #c89", standard, STANDARD_C89),
+               FLAG_ENUM(". #iso9899:1990", standard, STANDARD_C89),
+               FLAG_ENUM(". #c94", standard, STANDARD_C94),
+               FLAG_ENUM(". #iso9899:199409",standard, STANDARD_C94),
+               FLAG_ENUM(". #c99", standard, STANDARD_C99),
+               FLAG_ENUM(". #c9x", standard, STANDARD_C99),
+               FLAG_ENUM(". #iso9899:1999", standard, STANDARD_C99),
+               FLAG_ENUM(". #iso9899:199x", standard, STANDARD_C99),
+               FLAG_ENUM(". #gnu89", standard, STANDARD_GNU89),
+               FLAG_ENUM(". #gnu99", standard, STANDARD_GNU99),
+               FLAG_ENUM(". #gnu9x", standard, STANDARD_GNU99),
+               FLAG_ENUM(". #c11", standard, STANDARD_C11),
+               FLAG_ENUM(". #c1x", standard, STANDARD_C11),
+               FLAG_ENUM(". #iso9899:2011", standard, STANDARD_C11),
+               FLAG_ENUM(". #gnu11", standard, STANDARD_GNU11),
+               FLAG_ENUM(". #c17", standard, STANDARD_C17),
+               FLAG_ENUM(". #c18", standard, STANDARD_C17),
+               FLAG_ENUM(". #iso9899:2017", standard, STANDARD_C17),
+               FLAG_ENUM(". #iso9899:2018", standard, STANDARD_C17),
+               FLAG_ENUM(". #gnu17", standard, STANDARD_GNU17),
+               FLAG_ENUM(". #gnu18", standard, STANDARD_GNU17),
+               FLAG_ERRM(". #", "Unsupported C dialect", 6),
+       END_flag,
+       BEGIN_flag('v')
+               FLAG_OGRP("~vvv", opt_grp),
+               FLAG_DATA(". #v", verbose, "4", "\0", "ival=%1$d",
OPT_VAL+OPT_NO_SEP+OPT_INLINE),
+               FLAG_ENUM(". #", verbose, 3),
+               FLAG_ENUM("~vv", verbose, 2),
+               FLAG_ENUM("~v", verbose, 1),
+               FLAG_ENUM("@vcompound", dbg_compound, 0),
+               FLAG_ENUM("@vdomtree", dbg_domtree, 0),
+               FLAG_ENUM("@ventry", dbg_entry, 0),
+               FLAG_ENUM("@vir", dbg_ir, 0),
+               FLAG_ENUM("@vpostorder", dbg_postorder, 0),
+       END_flag,
+       BEGIN_flag('x')
+               FLAG_STRG("~x", opt_grp, OPT_INEXT),
+       END_flag,
+       ['W'] = (struct flag *)warnings,
+       BEGIN_flag('-')
+               FLAG_ERRM("~~version", SPARSE_VERSION, 10),
+               FLAG_STRG("~~param", opt_grp, OPT_INEXT),
+               FLAG_STRG(". #", opt_grp, OPT_INPUT),
+               FLAG_OGRP("~~arch", opt_grp),
+               FLAG_ARCH(". #=aarch64","64,0", MACH_ARM64),
+               FLAG_ARCH(". #=arm",    "32,0", MACH_ARM),
+               FLAG_ARCH(". #=i386",   "32,0", MACH_I386),
+               FLAG_ARCH(". #=m68k",   "32,0", MACH_M68K),
+               FLAG_ARCH(". #=mips",   "32,1", MACH_MIPS32),
+               FLAG_ARCH(". #=powerpc","32,1", MACH_PPC32),
+               FLAG_ARCH(". #=ppc",    "32,1", MACH_PPC32),
+               FLAG_ARCH(". #=riscv",  "32,0", MACH_RISCV32),
+               FLAG_ARCH(". #=s390x",  "64,1", MACH_S390X),
+               FLAG_ARCH(". #=s390",   "32,1", MACH_S390),
+               FLAG_ARCH(". #=sparc",  "32,1", MACH_SPARC32),
+               FLAG_ARCH(". #=x86_64", "64,0", MACH_X86_64),
+               FLAG_ARCH(". #=x86-64", "64,0", MACH_X86_64),
+               FLAG_ERRM(". #=", "invalid architecture: '%3$s'", 6),
+               FLAG_ERRM(". #", "missing argument for --arch option", 6),
+       END_flag,
+};
+
+static char **match_params(char *arg, char **args, const struct flag
*current, int neg)
+{
+       union { long long i; char *s; } val0 = {0}, val1 = {0}, val2 = {0};
+       const unsigned action = current->action;
+       char *ori = *args;
+
+       /* setup & mask val1 & val2 inputs (!OPT_MASK=set dirty bit,
OPT_VAL=zero val1) */
+       neg = (neg != 0) ^ (action & OPT_INVERSE);
+       val2.i = (action & OPT_MASK) ? current->mask :
WARNING_ON|WARNING_FORCE_OFF;
+       if (action & OPT_INPUT) {
+               if ((action & OPT_INLINE) && (*arg || ~action &
OPT_INEXT)) val1.s = arg;
+               else val1.s = *++args;
+       } else {
+               val1.i = (action & OPT_VAL) ? 0 : *current->flag;
+               val1.i = neg ? val1.i & ~val2.i : val1.i | val2.i;
+               *current->flag = (int)val1.i | (~action & OPT_MASK) >> 1;
+       }
+
+       /* scanf of val1: can accept int, %l, %ll, or strings (use
%3$n% and don't use %s) */
+       /* (%ll cannot assume zero init & need separate check, eg. see
-fmemcpy_max_count)  */
+       if (current->in_fmt && *current->in_fmt) {
+               int len0 = -1, len1 = -1, len2 = -1, len3 = -1, end = -1;
+               sscanf(val0.s = val1.s, current->in_fmt,
current->flag, &val2.i, &len0, &len1, &len2, &len3, &end);
+               sscanf(val0.s, current->in_fmt, &val1.i, &val2.i,
&len0, &len1, &len2, &len3, &end);
+               if (end  == 0) val1.i = *current->flag = 0;
+               else if (end  == -1 || val0.s[end] != 0) die("error:
wrong argument to \'%s\'", ori);
+               if (len0 >= 0) {
+                       *current->string = val1.s = val0.s + len0;
+                       if (len1 >= 0) val0.s[len1-1] = 0;
+               }
+               if (len2 >= 0) {
+                       val2.s = val0.s + len2;
+                       if (len3 >= 0) val0.s[len3-1] = 0;
+               }
+       }
+
+       /* printf of val1&2: print strings or int of size intptr_t
(use PRIdPTR)  */
+       if (verbose >= 2 && current->out_fmt) printf(current->out_fmt,
val1.s, val2.s, ori, arg, *args);
+       if (current->out_fn) (current->out_fn)(current->out_fmt,
val1.s, val2.s, ori);
+       if (action & OPT_NO_RET) exit(1); else return args;
+}
+
+#define peek(p,c,o) (current->action & o || *p == c)
+static char **match_suboption(char *opt, char **args, const struct
flag *parent, int neg)
+{
+       for (const struct flag *current = parent; ; opt += (*opt ==',')) {
+               char **next_args, *next_opt = opt;
+               if (!neg && !strncmp(opt, "no-", 3)) opt += neg = 3;
+
+               do if (!(++current)->name || *current->name != '#')
+                       die("wrong option '%.*s' for \'%s\'",
(int)strcspn(opt, ","), opt, *args);
+               while (!(next_opt = (char *)match_option(opt,
current->name+1)));
+
+               /* if any OPT_INPUT bit is set then remainder of opt
assumed processed by match_param */
+               next_args = match_params(next_opt, args, current, neg);
+               if (peek(next_opt, '\0', OPT_INPUT)) return next_args;
+               if (peek(next_opt, ',', OPT_NO_SEP)) (current =
parent) && (opt = next_opt);
+       }
+}
+
+static char **handle_switch(char *arg, char **args, const struct flag *current)
+{
+       char **current_args = args, **next_args = args;
+       int neg = !strncmp(arg += 1, "no-", 3) ? 3 : (!strncmp(arg-1,
"Wno", 3) ? 2 : 0);
+       int all =  !strcmp(arg += neg, "sparse-all");
+
+       if (current) for (; current->name; current++) {
+               char *opt = (char *)match_option(arg, current->name),
*next_opt = opt;
+               if (all && !current->action && !(*current->flag & ~1))
*current->flag = neg ? 0 : 1;
+               if (!opt) continue;
+
+               if (peek(opt++, '=', OPT_NO_SEP)) next_args =
match_suboption(opt, args, current, neg);
+               else if (peek(next_opt, '\0', OPT_INPUT)) next_args =
match_params(next_opt, args, current, neg);
+               if (!*next_args) die("missing argument for %s option", arg-2);
+               if (current_args < next_args) current_args = next_args;
+       }
+       return current_args;
+}
+
+int sparse_add_switch(int action, const char *name, ...)
+{
+       static struct flag *switches['z'];
+       static short sizes['z'] = { ['W'] = ARRAY_SIZE(warnings)-FLAGS_SIZE };
+       const char *ori = name;
+       int c;
+       struct flag opt = {};
+       va_list args;
+
+       va_start(args, name);
+       for (c = *name++; c == '%'; c= *name++) {
+               switch (c = *name++) {
+               case 'p':
+                       opt.flag = va_arg(args, void *);
+                       break;
+               case 'L':
+                       opt.mask = (uintptr_t) va_arg(args, long long);
+                       break;
+               case 'i':
+                       case 'd': opt.mask = va_arg(args, int);
+                       break;
+               case 's':
+                       opt.mask  = (uintptr_t) va_arg(args, char *);
+                       break;
+               case '<':
+                       opt.in_fmt  = va_arg(args, char *);
+                       break;
+               case '>':
+                       opt.out_fmt = va_arg(args, char *);
+                       break;
+               case '^':
+                       opt.out_fn = va_arg(args, void (*)(const char *,...));
+                       break;
+               default:
+                       die("unknown format %%'%c' in '%s'", c, ori);
+               }
+       }
+       va_end(args);
+
+       c = *name++;
+       opt.name = name;
+       opt.action = action;
+       if (!switches[c]) {
+               if (!flags[c]) {
+                       int size = FLAGS_SIZE*sizeof(struct flag);
+                       flags[c] = (struct flag *) malloc(size);
+                       memset(flags[c], 0, size);
+               }
+               switches[c] = flags[c];
+       }
+
+       /* never use last entry to ensure NULL guard entry*/
+       for (; --sizes[c]+FLAGS_SIZE > 1; ++switches[c]) {
+               if (!(switches[c])->name) {
+                       *switches[c] = opt;
+                       return sizes[c]+FLAGS_SIZE-1;
+               }
+       }
+       die("flags registry overflowed whilst adding entry %s", name-1);
+}
+
@@ -970 +1347 @@ struct symbol_list *sparse_initialize(int argc, char
**argv, struct string_list
-                       args = handle_switch(arg+1, args);
+                       args = handle_switch(arg+1, args, flags[(int)arg[1]]);
@@ -976 +1353 @@ struct symbol_list *sparse_initialize(int argc, char
**argv, struct string_list
-       handle_switch_v_finalize();
+       handle_switch_finalize(flags['v']);





(iii) ************* Deleted lines **************
* Approx 800 lines of code is deleted, as per patch below.  All
deleted code and functions are static scope (so there is no impact
outside of lib.c itself).  (The patch below should be applied first to
delete code, before the patch above is applied to insert new code).


diff --git a/lib.c b/lib.c
index 711e8fb..60a6941 100644
--- a/lib.c
+++ b/lib.c
@@ -358,74 +357,0 @@ void add_pre_buffer(const char *fmt, ...)
-struct val_map {
-       const char *name;
-       int val;
-};
-
-static int handle_subopt_val(const char *opt, const char *arg, const
struct val_map *map, int *flag)
-{
-       const char *name;
-
-       if (*arg++ != '=')
-               die("missing argument for option '%s'", opt);
-       for (;(name = map->name); map++) {
-               if (strcmp(name, arg) == 0 || strcmp(name, "*") == 0) {
-                       *flag = map->val;
-                       return 1;
-               }
-               if (strcmp(name, "?") == 0)
-                       die("invalid argument '%s' in option '%s'", arg, opt);
-       }
-       return 0;
-}
-
-
-struct mask_map {
-       const char *name;
-       unsigned long mask;
-};
-
-static int apply_mask(unsigned long *val, const char *str, unsigned
len, const struct mask_map *map, int neg)
-{
-       const char *name;
-
-       for (;(name = map->name); map++) {
-               if (!strncmp(name, str, len) && !name[len]) {
-                       if (neg == 0)
-                               *val |= map->mask;
-                       else
-                               *val &= ~map->mask;
-                       return 0;
-               }
-       }
-       return 1;
-}
-
-static int handle_suboption_mask(const char *arg, const char *opt,
const struct mask_map *map, unsigned long *flag)
-{
-       if (*opt == '\0') {
-               apply_mask(flag, "", 0, map, 0);
-               return 1;
-       }
-       if (*opt++ != '=')
-               return 0;
-       while (1) {
-               unsigned int len = strcspn(opt, ",+");
-               int neg = 0;
-               if (len == 0)
-                       goto end;
-               if (!strncmp(opt, "no-", 3)) {
-                       opt += 3;
-                       len -= 3;
-                       neg = 1;
-               }
-               if (apply_mask(flag, opt, len, map, neg))
-                       die("error: wrong option '%.*s' for \'%s\'",
len, opt, arg);
-
-end:
-               opt += len;
-               if (*opt++ == '\0')
-                       break;
-       }
-       return 1;
-}
-
-
@@ -450,73 +375,0 @@ struct flag {
-static int handle_switches(const char *ori, const char *opt, const
struct flag *flags)
-{
-       const char *arg = opt;
-       int val = 1;
-
-       // Prefixe "no-" mean to turn flag off.
-       if (strncmp(arg, "no-", 3) == 0) {
-               arg += 3;
-               val = 0;
-       }
-
-       for (; flags->name; flags++) {
-               const char *opt = match_option(arg, flags->name);
-               int rc;
-
-               if (!opt)
-                       continue;
-
-               if (flags->fun) {
-                       int options = 0;
-                       if (!val)
-                               options |= OPT_INVERSE;
-                       if ((rc = flags->fun(ori, opt, flags, options)))
-                               return rc;
-               }
-
-               // boolean flag
-               if (opt[0] == '\0' && flags->flag) {
-                       if (flags->mask & OPT_VAL)
-                               val = flags->val;
-                       if (flags->mask & OPT_INVERSE)
-                               val = !val;
-                       *flags->flag = val;
-                       return 1;
-               }
-       }
-
-       // not handled
-       return 0;
-}
-
-static int handle_switch_setval(const char *arg, const char *opt,
const struct flag *flag, int options)
-{
-       *(flag->flag) = flag->mask;
-       return 1;
-}
-
-
-#define        OPTNUM_ZERO_IS_INF              1
-#define        OPTNUM_UNLIMITED                2
-
-#define OPT_NUMERIC(NAME, TYPE, FUNCTION)      \
-static int opt_##NAME(const char *arg, const char *opt, TYPE *ptr,
int flag)   \
-{                                                                      \
-       char *end;                                                      \
-       TYPE val;                                                       \
-                                                                       \
-       val = FUNCTION(opt, &end, 0);                                   \
-       if (*end != '\0' || end == opt) {                               \
-               if ((flag & OPTNUM_UNLIMITED) && !strcmp(opt,
"unlimited"))     \
-                       val = ~val;                                     \
-               else                                                    \
-                       die("error: wrong argument to \'%s\'", arg);    \
-       }                                                               \
-       if ((flag & OPTNUM_ZERO_IS_INF) && val == 0)                    \
-               val = ~val;                                             \
-       *ptr = val;                                                     \
-       return 1;                                                       \
-}
-
-OPT_NUMERIC(ullong, unsigned long long, strtoull)
-OPT_NUMERIC(uint, unsigned int, strtoul)
-
@@ -529,90 +381,0 @@ enum {
-static char **handle_onoff_switch(char *arg, char **next, const
struct flag warnings[], int n)
-{
-       int flag = WARNING_ON;
-       char *p = arg + 1;
-       unsigned i;
-
-       if (!strcmp(p, "sparse-all")) {
-               for (i = 0; i < n; i++) {
-                       if (*warnings[i].flag != WARNING_FORCE_OFF &&
warnings[i].flag != &Wsparse_error)
-                               *warnings[i].flag = WARNING_ON;
-               }
-               return NULL;
-       }
-
-       // Prefixes "no" and "no-" mean to turn warning off.
-       if (p[0] == 'n' && p[1] == 'o') {
-               p += 2;
-               if (p[0] == '-')
-                       p++;
-               flag = WARNING_FORCE_OFF;
-       }
-
-       for (i = 0; i < n; i++) {
-               if (!strcmp(p,warnings[i].name)) {
-                       *warnings[i].flag = flag;
-                       return next;
-               }
-       }
-
-       // Unknown.
-       return NULL;
-}
-
-////////////////////////////////////////////////////////////////////////////////
-// Option parsing
-
-static char **handle_switch_D(char *arg, char **next)
-{
-       const char *name = arg + 1;
-       const char *value = "1";
-
-       if (!*name) {
-               arg = *++next;
-               if (!arg)
-                       die("argument to `-D' is missing");
-               name = arg;
-       }
-
-       for (;;arg++) {
-               char c;
-               c = *arg;
-               if (!c)
-                       break;
-               if (c == '=') {
-                       *arg = '\0';
-                       value = arg + 1;
-                       break;
-               }
-       }
-       add_pre_buffer("#define %s %s\n", name, value);
-       return next;
-}
-
-static char **handle_switch_E(char *arg, char **next)
-{
-       if (arg[1] == '\0')
-               preprocess_only = 1;
-       return next;
-}
-
-static char **handle_switch_I(char *arg, char **next)
-{
-       char *path = arg+1;
-
-       switch (arg[1]) {
-       case '-':
-               add_pre_buffer("#split_include\n");
-               break;
-
-       case '\0':      /* Plain "-I" */
-               path = *++next;
-               if (!path)
-                       die("missing argument for -I option");
-               /* Fall through */
-       default:
-               add_pre_buffer("#add_include \"%s/\"\n", path);
-       }
-       return next;
-}
-
@@ -626,91 +388,0 @@ static void add_cmdline_include(char *filename)
-static char **handle_switch_i(char *arg, char **next)
-{
-       if (*next && !strcmp(arg, "include"))
-               add_cmdline_include(*++next);
-       else if (*next && !strcmp(arg, "imacros"))
-               add_cmdline_include(*++next);
-       else if (*next && !strcmp(arg, "isystem")) {
-               char *path = *++next;
-               if (!path)
-                       die("missing argument for -isystem option");
-               add_pre_buffer("#add_isystem \"%s/\"\n", path);
-       } else if (*next && !strcmp(arg, "idirafter")) {
-               char *path = *++next;
-               if (!path)
-                       die("missing argument for -idirafter option");
-               add_pre_buffer("#add_dirafter \"%s/\"\n", path);
-       }
-       return next;
-}
-
-static char **handle_switch_M(char *arg, char **next)
-{
-       if (!strcmp(arg, "MF") || !strcmp(arg,"MQ") || !strcmp(arg,"MT")) {
-               if (!*next)
-                       die("missing argument for -%s option", arg);
-               return next + 1;
-       }
-       return next;
-}
-
-static char **handle_multiarch_dir(char *arg, char **next)
-{
-       multiarch_dir = *++next;
-       if (!multiarch_dir)
-               die("missing argument for -multiarch-dir option");
-       return next;
-}
-
-static int handle_cmodel(const char *opt, const char *arg, const
struct flag *flag, int options)
-{
-       static const struct val_map cmodels[] = {
-               { "kernel",     CMODEL_KERNEL },
-               { "large",      CMODEL_LARGE },
-               { "medany",     CMODEL_MEDANY },
-               { "medium",     CMODEL_MEDIUM },
-               { "medlow",     CMODEL_MEDLOW },
-               { "small",      CMODEL_SMALL },
-               { "tiny",       CMODEL_TINY },
-               { },
-       };
-       return handle_subopt_val(opt, arg, cmodels, flag->flag);
-}
-
-static int handle_float_abi(const char *opt, const char *arg, const
struct flag *flag, int options) {
-       static const struct val_map fp_abis[] = {
-               { "hard",               FP_ABI_HARD },
-               { "soft",               FP_ABI_SOFT },
-               { "softfp",             FP_ABI_HYBRID },
-               { "?" },
-       };
-       return handle_subopt_val(opt, arg, fp_abis, flag->flag);
-}
-
-static const struct flag mflags[] = {
-       { "64", &arch_m64, NULL, OPT_VAL, ARCH_LP64 },
-       { "32", &arch_m64, NULL, OPT_VAL, ARCH_LP32 },
-       { "31", &arch_m64, NULL, OPT_VAL, ARCH_LP32 },
-       { "16", &arch_m64, NULL, OPT_VAL, ARCH_LP32 },
-       { "x32",&arch_m64, NULL, OPT_VAL, ARCH_X32 },
-       { "size-llp64", &arch_m64, NULL, OPT_VAL, ARCH_LLP64 },
-       { "size-long", &arch_msize_long },
-       { "big-endian", &arch_big_endian, NULL },
-       { "little-endian", &arch_big_endian, NULL, OPT_INVERSE },
-       { "cmodel", &arch_cmodel, handle_cmodel },
-       { "float-abi", &arch_fp_abi, handle_float_abi },
-       { "hard-float", &arch_fp_abi, NULL, OPT_VAL, FP_ABI_HARD },
-       { "soft-float", &arch_fp_abi, NULL, OPT_VAL, FP_ABI_SOFT },
-       { }
-};
-
-static char **handle_switch_m(char *arg, char **next)
-{
-       if (!strcmp(arg, "multiarch-dir")) {
-               return handle_multiarch_dir(arg, next);
-       } else {
-               handle_switches(arg-1, arg+1, mflags);
-       }
-
-       return next;
-}
-
@@ -747,12 +418,0 @@ static void handle_arch_finalize(void)
-static char **handle_switch_o(char *arg, char **next)
-{
-       if (!strcmp (arg, "o")) {       // "-o foo"
-               if (!*++next)
-                       die("argument to '-o' is missing");
-               outfile = *next;
-       }
-       // else "-ofoo"
-
-       return next;
-}
-
@@ -807,65 +466,0 @@ static const struct flag warnings[] = {
-static char **handle_switch_W(char *arg, char **next)
-{
-       char ** ret = handle_onoff_switch(arg, next, warnings,
ARRAY_SIZE(warnings));
-       if (ret)
-               return ret;
-
-       // Unknown.
-       return next;
-}
-
-static struct flag debugs[] = {
-       { "compound", &dbg_compound},
-       { "dead", &dbg_dead},
-       { "domtree", &dbg_domtree},
-       { "entry", &dbg_entry},
-       { "ir", &dbg_ir},
-       { "postorder", &dbg_postorder},
-};
-
-
-static char **handle_switch_v(char *arg, char **next)
-{
-       char ** ret = handle_onoff_switch(arg, next, debugs,
ARRAY_SIZE(debugs));
-       if (ret)
-               return ret;
-
-       // Unknown.
-       do {
-               verbose++;
-       } while (*++arg == 'v');
-       return next;
-}
-
-static char **handle_switch_d(char *arg, char **next)
-{
-       char *arg_char = arg + 1;
-
-       /*
-        * -d<CHARS>, where <CHARS> is a sequence of characters, not preceded
-        * by a space. If you specify characters whose behaviour conflicts,
-        * the result is undefined.
-        */
-       while (*arg_char) {
-               switch (*arg_char) {
-               case 'M': /* dump just the macro definitions */
-                       dump_macros_only = 1;
-                       dump_macro_defs = 0;
-                       break;
-               case 'D': /* like 'M', but also output pre-processed text */
-                       dump_macro_defs = 1;
-                       dump_macros_only = 0;
-                       break;
-               case 'N': /* like 'D', but only output macro names not bodies */
-                       break;
-               case 'I': /* like 'D', but also output #include directives */
-                       break;
-               case 'U': /* like 'D', but only output expanded macros */
-                       break;
-               }
-               arg_char++;
-       }
-       return next;
-}
-
-
@@ -900,383 +494,0 @@ static void handle_switch_W_finalize(void)
-static void handle_switch_v_finalize(void)
-{
-       handle_onoff_switch_finalize(debugs, ARRAY_SIZE(debugs));
-}
-
-static char **handle_switch_U(char *arg, char **next)
-{
-       const char *name = arg + 1;
-       add_pre_buffer ("#undef %s\n", name);
-       return next;
-}
-
-static char **handle_switch_O(char *arg, char **next)
-{
-       int level = 1;
-       if (arg[1] >= '0' && arg[1] <= '9')
-               level = arg[1] - '0';
-       optimize_level = level;
-       optimize_size = arg[1] == 's';
-       return next;
-}
-
-static int handle_ftabstop(const char *arg, const char *opt, const
struct flag *flag, int options)
-{
-       unsigned long val;
-       char *end;
-
-       if (*opt == '\0')
-               die("error: missing argument to \"%s\"", arg);
-
-       /* we silently ignore silly values */
-       val = strtoul(opt, &end, 10);
-       if (*end == '\0' && 1 <= val && val <= 100)
-               tabstop = val;
-
-       return 1;
-}
-
-static int handle_fpasses(const char *arg, const char *opt, const
struct flag *flag, int options)
-{
-       unsigned long mask;
-
-       mask = flag->mask;
-       if (*opt == '\0') {
-               if (options & OPT_INVERSE)
-                       fpasses &= ~mask;
-               else
-                       fpasses |=  mask;
-               return 1;
-       }
-       if (options & OPT_INVERSE)
-               return 0;
-       if (!strcmp(opt, "-enable")) {
-               fpasses |= mask;
-               return 1;
-       }
-       if (!strcmp(opt, "-disable")) {
-               fpasses &= ~mask;
-               return 1;
-       }
-       if (!strcmp(opt, "=last")) {
-               // clear everything above
-               mask |= mask - 1;
-               fpasses &= mask;
-               return 1;
-       }
-       return 0;
-}
-
-static int handle_fdiagnostic_prefix(const char *arg, const char
*opt, const struct flag *flag, int options)
-{
-       switch (*opt) {
-       case '\0':
-               diag_prefix = "sparse: ";
-               return 1;
-       case '=':
-               diag_prefix = xasprintf("%s: ", opt+1);
-               return 1;
-       default:
-               return 0;
-       }
-}
-
-static int handle_fdump_ir(const char *arg, const char *opt, const
struct flag *flag, int options)
-{
-       static const struct mask_map dump_ir_options[] = {
-               { "",                   PASS_LINEARIZE },
-               { "linearize",          PASS_LINEARIZE },
-               { "mem2reg",            PASS_MEM2REG },
-               { "final",              PASS_FINAL },
-               { },
-       };
-
-       return handle_suboption_mask(arg, opt, dump_ir_options, &fdump_ir);
-}
-
-static int handle_fmemcpy_max_count(const char *arg, const char *opt,
const struct flag *flag, int options)
-{
-       opt_ullong(arg, opt, &fmemcpy_max_count,
OPTNUM_ZERO_IS_INF|OPTNUM_UNLIMITED);
-       return 1;
-}
-
-static int handle_fmax_warnings(const char *arg, const char *opt,
const struct flag *flag, int options)
-{
-       opt_uint(arg, opt, &fmax_warnings, OPTNUM_UNLIMITED);
-       return 1;
-}
-
-static struct flag fflags[] = {
-       { "diagnostic-prefix",  NULL,   handle_fdiagnostic_prefix },
-       { "dump-ir",            NULL,   handle_fdump_ir },
-       { "linearize",          NULL,   handle_fpasses, PASS_LINEARIZE },
-       { "max-warnings=",      NULL,   handle_fmax_warnings },
-       { "mem-report",         &fmem_report },
-       { "memcpy-max-count=",  NULL,   handle_fmemcpy_max_count },
-       { "tabstop=",           NULL,   handle_ftabstop },
-       { "mem2reg",            NULL,   handle_fpasses, PASS_MEM2REG },
-       { "optim",              NULL,   handle_fpasses, PASS_OPTIM },
-       { "pic",                &fpic,  handle_switch_setval, 1 },
-       { "PIC",                &fpic,  handle_switch_setval, 2 },
-       { "pie",                &fpie,  handle_switch_setval, 1 },
-       { "PIE",                &fpie,  handle_switch_setval, 2 },
-       { "signed-char",        &funsigned_char, NULL,  OPT_INVERSE },
-       { "short-wchar",        &fshort_wchar },
-       { "unsigned-char",      &funsigned_char, NULL, },
-       { },
-};
-
-static char **handle_switch_f(char *arg, char **next)
-{
-       if (handle_switches(arg-1, arg+1, fflags))
-               return next;
-
-       return next;
-}
-
-static char **handle_switch_G(char *arg, char **next)
-{
-       if (!strcmp (arg, "G") && *next)
-               return next + 1; // "-G 0"
-       else
-               return next;     // "-G0" or (bogus) terminal "-G"
-}
-
-static char **handle_switch_a(char *arg, char **next)
-{
-       if (!strcmp (arg, "ansi"))
-               standard = STANDARD_C89;
-
-       return next;
-}
-
-static char **handle_switch_s(const char *arg, char **next)
-{
-       if ((arg = match_option(arg, "std="))) {
-               if (!strcmp (arg, "c89") ||
-                   !strcmp (arg, "iso9899:1990"))
-                       standard = STANDARD_C89;
-
-               else if (!strcmp (arg, "iso9899:199409"))
-                       standard = STANDARD_C94;
-
-               else if (!strcmp (arg, "c99") ||
-                        !strcmp (arg, "c9x") ||
-                        !strcmp (arg, "iso9899:1999") ||
-                        !strcmp (arg, "iso9899:199x"))
-                       standard = STANDARD_C99;
-
-               else if (!strcmp (arg, "gnu89"))
-                       standard = STANDARD_GNU89;
-
-               else if (!strcmp (arg, "gnu99") || !strcmp (arg, "gnu9x"))
-                       standard = STANDARD_GNU99;
-
-               else if (!strcmp(arg, "c11") ||
-                        !strcmp(arg, "c1x") ||
-                        !strcmp(arg, "iso9899:2011"))
-                       standard = STANDARD_C11;
-
-               else if (!strcmp(arg, "gnu11"))
-                       standard = STANDARD_GNU11;
-
-               else if (!strcmp(arg, "c17") ||
-                        !strcmp(arg, "c18") ||
-                        !strcmp(arg, "iso9899:2017") ||
-                        !strcmp(arg, "iso9899:2018"))
-                       standard = STANDARD_C17;
-               else if (!strcmp(arg, "gnu17") ||
-                        !strcmp(arg, "gnu18"))
-                       standard = STANDARD_GNU17;
-
-               else
-                       die ("Unsupported C dialect");
-       }
-
-       return next;
-}
-
-static char **handle_nostdinc(char *arg, char **next)
-{
-       add_pre_buffer("#nostdinc\n");
-       return next;
-}
-
-static char **handle_switch_n(char *arg, char **next)
-{
-       if (!strcmp (arg, "nostdinc"))
-               return handle_nostdinc(arg, next);
-
-       return next;
-}
-
-static char **handle_base_dir(char *arg, char **next)
-{
-       gcc_base_dir = *++next;
-       if (!gcc_base_dir)
-               die("missing argument for -gcc-base-dir option");
-       return next;
-}
-
-static char **handle_switch_g(char *arg, char **next)
-{
-       if (!strcmp (arg, "gcc-base-dir"))
-               return handle_base_dir(arg, next);
-
-       return next;
-}
-
-static char **handle_switch_x(char *arg, char **next)
-{
-       if (!*++next)
-               die("missing argument for -x option");
-       return next;
-}
-
-
-static char **handle_arch(char *arg, char **next)
-{
-       static const struct arch {
-               const char *name;
-               char mach;
-               char bits;
-               bool big_endian:1;
-       } archs[] = {
-               { "aarch64",    MACH_ARM64,     64, 0 },
-               { "arm64",      MACH_ARM64,     64, 0 },
-               { "arm",        MACH_ARM,       32, 0 },
-               { "i386",       MACH_I386,      32, 0 },
-               { "m68k",       MACH_M68K,      32, 0 },
-               { "mips",       MACH_MIPS32,    0,  1 },
-               { "powerpc",    MACH_PPC32,     0,  1 },
-               { "ppc",        MACH_PPC32,     0,  1 },
-               { "riscv",      MACH_RISCV32,   0,  0 },
-               { "s390x",      MACH_S390X,     64, 1 },
-               { "s390",       MACH_S390,      32, 1 },
-               { "sparc",      MACH_SPARC32,   0,  1 },
-               { "x86_64",     MACH_X86_64,    64, 0 },
-               { "x86-64",     MACH_X86_64,    64, 0 },
-               { NULL },
-       };
-       const struct arch *p;
-
-       if (*arg++ != '=')
-               die("missing argument for --arch option");
-
-       for (p = &archs[0]; p->name; p++) {
-               size_t len = strlen(p->name);
-               if (strncmp(p->name, arg, len) == 0) {
-                       const char *suf = arg + len;
-                       int bits = p->bits;
-
-                       arch_mach = p->mach;
-                       if (bits == 0) {
-                               if (!strcmp(suf, "")) {
-                                       bits = 32;
-                               } else if (!strcmp(suf, "32")) {
-                                       bits = 32;
-                               } else if (!strcmp(suf, "64")) {
-                                       bits = 64;
-                                       arch_mach += 1;
-                               } else {
-                                       die("invalid architecture: %s", arg);
-                               }
-                       } else {
-                               if (strcmp(suf, ""))
-                                       die("invalid architecture: %s", arg);
-                       }
-
-                       // adjust the arch size (but keep x32 & llp64)
-                       if (bits == 32)
-                               arch_m64 = ARCH_LP32;
-                       else if (bits == 64 && arch_m64 == ARCH_LP32)
-                               arch_m64 = ARCH_LP64;
-                       arch_big_endian = p->big_endian;
-                       break;
-               }
-       }
-
-       return next;
-}
-
-static char **handle_version(char *arg, char **next)
-{
-       printf("%s\n", SPARSE_VERSION);
-       exit(0);
-}
-
-static char **handle_param(char *arg, char **next)
-{
-       char *value = NULL;
-
-       /* For now just skip any '--param=*' or '--param *' */
-       if (*arg == '\0') {
-               value = *++next;
-       } else if (isspace((unsigned char)*arg) || *arg == '=') {
-               value = ++arg;
-       }
-
-       if (!value)
-               die("missing argument for --param option");
-
-       return next;
-}
-
-struct switches {
-       const char *name;
-       char **(*fn)(char *, char **);
-       unsigned int prefix:1;
-};
-
-static char **handle_long_options(char *arg, char **next)
-{
-       static struct switches cmd[] = {
-               { "arch", handle_arch, 1 },
-               { "param", handle_param, 1 },
-               { "version", handle_version },
-               { NULL, NULL }
-       };
-       struct switches *s = cmd;
-
-       while (s->name) {
-               int optlen = strlen(s->name);
-               if (!strncmp(s->name, arg, optlen + !s->prefix))
-                       return s->fn(arg + optlen, next);
-               s++;
-       }
-       return next;
-}
-
-static char **handle_switch(char *arg, char **next)
-{
-       switch (*arg) {
-       case 'a': return handle_switch_a(arg, next);
-       case 'D': return handle_switch_D(arg, next);
-       case 'd': return handle_switch_d(arg, next);
-       case 'E': return handle_switch_E(arg, next);
-       case 'f': return handle_switch_f(arg, next);
-       case 'g': return handle_switch_g(arg, next);
-       case 'G': return handle_switch_G(arg, next);
-       case 'I': return handle_switch_I(arg, next);
-       case 'i': return handle_switch_i(arg, next);
-       case 'M': return handle_switch_M(arg, next);
-       case 'm': return handle_switch_m(arg, next);
-       case 'n': return handle_switch_n(arg, next);
-       case 'o': return handle_switch_o(arg, next);
-       case 'O': return handle_switch_O(arg, next);
-       case 's': return handle_switch_s(arg, next);
-       case 'U': return handle_switch_U(arg, next);
-       case 'v': return handle_switch_v(arg, next);
-       case 'W': return handle_switch_W(arg, next);
-       case 'x': return handle_switch_x(arg, next);
-       case '-': return handle_long_options(arg + 1, next);
-       default:
-               break;
-       }
-
-       /*
-        * Ignore unknown command line options:
-        * they're probably gcc switches
-        */
-       return next;
-}
