From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: PATCH: sparse_add_switch() for backends to register new switches
 into main parsing table
Date: Thu, 30 Jan 2020 07:49:11 +0100
Message-ID: <20200130064911.rbiqkerptoo22dlx@ltop.local>
References: <CAO6moYtTsA8niRvL135+OMXDjAEnGEGMf8kG+CYgq+YDKPi4UQ@mail.gmail.com>
 <CAO6moYuBpk_qnrs+pMYK4rHjDzOpRDJSC_mYHew8tvfbiehWqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f43.google.com ([209.85.128.43]:35499 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgA3GtR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Jan 2020 01:49:17 -0500
Received: by mail-wm1-f43.google.com with SMTP id b17so2868078wmb.0
        for <linux-sparse@vger.kernel.org>; Wed, 29 Jan 2020 22:49:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAO6moYuBpk_qnrs+pMYK4rHjDzOpRDJSC_mYHew8tvfbiehWqw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xan Phung <xan.phung@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Wed, Jan 29, 2020 at 07:25:40PM +0800, Xan Phung wrote:
> Hi,

Hi Xan,
 
> I propose (& provide an implementation of) a "sparse_add_switch()"
> function to enable any backend to register new switches for
> sparse_initialize().  The background to this is that I am creating a
> backend to link Sparse to the WebAssembly ecosystem (in the same way
> Sparse-LLVM links to LLVM ecosystem).

Interesting.

> As backends for Sparse
> proliferate, they will inevitably need new command line switches.
> 
> A sparse_add_switch() function enables lib.c to provide extensible
> switch parsing for arbitrary backends.
> 
> ** What it does **: sparse_add_switch() adds new entries into lib.c's
> flag tables (which drive the parsing of command line switches).
> 
> ** Other benefits **: Simplification of lib.c - ie: removal of approx
> 800 lines (as of the Jan 2020 master branch), comprising the all
> handle_switch_[a-z] code.  The same functionality is instead provided
> by 200 lines of flag array initialisers, and approx 100 lines of new
> "general purpose" switch parsing code.  (The only switch-specific code
> left are the finalizer for v & W switch, an --arch helper and --arch
> finalizer).

I'm quite sympathetic to the idea of having customizable options
parsing.For example, there is alreay a need to have arch-specific
options (in both direction: some unsupported options should be supported
on some archs, and some supported options should not on some arches).
Also, some cleanup there is more than welcome.

Could you describe (some of) your usecases?

> ** How it works **: General purpose switch parsing code consists of 3
> functions in just 100 lines of code.  Everything else (except
> finalisation code) is encoded in an array of flag structures, which
> are initialized by compile time constants.  The 3 functions are:
> 
> (1) handle_switch(): matches an argv switch (eg. -fdump-ir) to flag
> structures within the flag array (against the field flag->name, eg.
> name="dump-ir").
> 
> (2) match_suboption(): matches suboption text (eg. "optim" & "final"
> in fdump-ir=optim,final) with a suboption flag structure.  This
> replaces the (current) lib.c handle_suboption_mask(), a key change
> being the suboption flag structure follows same format as flag
> structure.  This change allows match_param (#3 below) to be
> indifferent to whether it is called by #2 (suboption) or directly by
> #1 (main option).
> 
> (3) match_param(): is called by either #1 or #2 above, and can (in any
> combination) apply a mask, call sscanf(), and call printf-like
> functions - ie: printf(), die(), add_pre_buffer(), set_arch().
> NOTE: struct flag has been expanded with new char* in_fmt, out_fmt
> fields for the sscanf & printf functions, and int "val" has been
> renamed as int "action".
> 
> ** Validation (separate patch) **: I have also written a demo
> "test-switches" program, which demonstrates the use of
> sparse_add_switch() and tests correctness of the code.  I am
> submitting it as a separate patch, as it's an optional/lower priority
> add-on.  I don't need to have it in the sparse upstream tree for my
> backend, whereas my backend won't work without the sparse_add_switch
> function.
> 
> ** Documentation (separate patch) **: I can provide documentation of
> the sparse_add_switch() function's interface as a separate patch, once
> a decision on the final form of this patch is finalised.

Documentation will certainly be needed.

> ** DIFFS **: The changes proposed are best understood as 3 diffs
> comprising (i) changes to existing code, (ii) new code, and (iii)
> deleted code:

I certainly prefer a big set of small patches than a small set of
big patches.


 
> 
> 
> (i) **************** Changed lines: ****************
> * New in_fmt & out_fmt fields are added to struct flag as discussed above.
> * My code supports sscanf into flags which are strings (eg. outfile),
> long long's (eg. fmemcpy_max_count) or int's, but I don't support
> long's (hence fpasses and fdump-ir changed to unsigned int).  I could
> add long support, but such support seems to be unnecessary, ie: ILP32,
> LP64 and LLP64 all provide 64 & 32 bit fields via just long long and
> int, and hence long doesn't add anything new to this.

It should be fine.

> * Function signature changes: add_cmdline_include changed to be
> consistent with printf function signature by adding char *fmt field,

OK in itself but more about it here below.

> and handle_onoff_switch_finalize no longer uses array size parameter
> (it detects a guard NULL entry instead).

> * Makefile: the Wmissing-braces compiler setting is disabled, but
> could be re-enabled at the cost of adding an extra set of braces to
> each line of the lib.c warnings array, eg. { "shift-count-negative",
> &Wshift_count_negative } becomes { "shift-count-negative",
> {&Wshift_count_negative} }.  This wasn't done as I didn't want to
> complicate the diff output.  My code otherwise does not create any
> compiler warnings when compiled with GNU make & mac OS (command line)
> clang.

That will need to be reinstanted as it's a safeguard for other, future,
code.


Before going into the details, I must say that I'm not convinced by the
approach here:
* there is a need to add new options but is there also a need to add
  new entries for sub-options/option parameters?
* the prefix "codes" ("~", "~~", ". #", "@", ...) are to me cryptic.
  they don't need to be put in the string but they could be make
  explicit (with a good name) as another parameter, kinda like the
  OPT_xyz are, or implicit in the definition of the FLAG_WXYZ()
* IMO, the parsing of the suboption have generaly no place here.
  It's especially the case for --std or --arch but also for things
  like -fdump-ir. I would much prefer to keep the helper for these:
	* it would keep the generic parsing simpler
	* it allow maximum flexibility for these
* I haven't look in details but I'm a bit affraid of regressions.
  For example, I don't think that the sequence '-v -v -vvvv' is
  processed here like it should (*increment* 'verbose' by 6).
* you're making a heavy use of positional arguments in
  printf & sscanf format strings but these are C99 features.
  Currently, Sparse doesn't requires C99 and is just fine with C89.
* I'm annoyed at the lost of some typechecking:
	* struct flag now use an union to hold pointers
	* cast of pointers to void*
	* even cast of printf() ...
* I'm also somehow worried about a possible increase in startup time.

In short, I would much much prefer to:
* not specifiy the suboption/parameters in the option table
* use specific helper to handle non-simple parameters/sub-options

I think that if  you only need to add some new options meaningful
only to your backend it would be much simpler and effective to either:
* process your command line before calling sparse_initialize(), or
* use some hook to process the options not handled (and thus ignored)
  by sparse_initialize()

I also have some questions or remarks here below.

> * Please see note in part (iii) diff below about applying delete diff
> first before applying this diff
> 
> diff --git a/lib.c b/lib.c
> index 60a6941..4e400b2 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -5,0 +6 @@
> + *               2020 Xan Phung
> @@ -33,0 +35 @@
> +#include <inttypes.h>
> @@ -310 +312 @@ int dbg_postorder = 0;
> -unsigned long fdump_ir;
> +unsigned fdump_ir;
> @@ -313 +315 @@ unsigned long long fmemcpy_max_count = 100000;
> -unsigned long fpasses = ~0UL;
> +unsigned fpasses = ~0U;
> @@ -366,2 +367,0 @@ static const char *match_option(const char *arg,
> const char *prefix)
> -#define OPT_INVERSE    1
> -#define OPT_VAL                2
> @@ -370,4 +370,10 @@ struct flag {
> -       int *flag;
> -       int (*fun)(const char *arg, const char *opt, const struct flag
> *, int options);
> -       unsigned long mask;
> -       int val;
> +       union {
> +               int *flag;
> +               long long *long_flag;
> +               const char **string;
> +       };

like already said above, this is annoying from a typechecking point-of-view.

> @@ -382 +388 @@ enum {
> -static void add_cmdline_include(char *filename)
> +static void add_cmdline_include(const char *fmt, ...)
> @@ -383,0 +390,4 @@ static void add_cmdline_include(char *filename)
> +       va_list args;
> +       va_start(args, fmt);
> +       char *filename = va_arg(args, char *);
> +       va_end(args);

IMO, this is unneeded complication and slightly confusing:
the function is variadic but really has a single parameter which
is not a printf format (and should thus not be called 'fmt').

> @@ -419 +429 @@ static void handle_arch_finalize(void)
> -static const struct flag warnings[] = {
> +static const struct flag warnings[80] = {

Why the magic 80, here?

> @@ -457 +467 @@ static const struct flag warnings[] = {
> -       { "sparse-error", &Wsparse_error },
> +       { "sparse-error", &Wsparse_error, .mask=1, .action=OPT_MASK },
> @@ -467 +477 @@ static const struct flag warnings[] = {
> -static void handle_onoff_switch_finalize(const struct flag warnings[], int n)
> +static void handle_switch_finalize(const struct flag warnings[])
> @@ -471,3 +481,3 @@ static void handle_onoff_switch_finalize(const
> struct flag warnings[], int n)
> -       for (i = 0; i < n; i++) {
> -               if (*warnings[i].flag == WARNING_FORCE_OFF)
> -                       *warnings[i].flag = WARNING_OFF;
> +       for (i = 0; warnings[i].flag; i++) {
> +               if (!warnings[i].action && *warnings[i].flag &
> WARNING_FORCE_OFF)
> +                       *warnings[i].flag &= ~WARNING_FORCE_OFF;
> @@ -479 +489 @@ static void handle_switch_W_finalize(void)
> -       handle_onoff_switch_finalize(warnings, ARRAY_SIZE(warnings));
> +       handle_switch_finalize(warnings);

> @@ -482 +492 @@ static void handle_switch_W_finalize(void)
> -       if (-1 == Wdeclarationafterstatement) {
> +       if (Wdeclarationafterstatement < 0) {

What's the motivation for the change?

> (ii) **************** New lines: *****************
> The diff below is a direct continuation of the diff above, and adds
> the new switch parsing functions and flag array discussed.
> 
> 
> 
> @@ -494,0 +505,367 @@ static void handle_switch_W_finalize(void)
> +static void set_arch(const char *fmt, ...)
> +{
> +       unsigned bits = 0, mach = 0, min = 0, big = 0;
> +       va_list args;
> +       va_start(args, fmt);
> +       bits = va_arg(args, int);
> +       mach = va_arg(args, int);
> +       va_end(args);
> +       assert(fmt && sscanf(fmt, "#%*s (%*[^)]) m=%2d,%1d", &min, &big) == 2);

I really really dislike this:
* the assert
* the use of sscanf
* the fact that the data are now no more visible

> +       assert(big <= 1 && min % 32 == 0);

'min' is not used

> +       if (bits & ~63) {

the only admissble values for bits are 32 & 64

> +               arch_mach = mach | 1;
> +               arch_m64  = (arch_m64 == ARCH_LP32) ? ARCH_LP64 : arch_m64;
> +       } else {
> +               arch_mach = mach;
> +               arch_m64  = ARCH_LP32;
> +       }
> +       arch_big_endian = (big == '1') ? 1 : 0;
> +}
> +
> +typedef void (*out_fn)(const char *, ...);
> +static  char opt_grp[sizeof(long long)];  //Placeholder for unused

I don't understand this. What will be stored in opt_grp?
why it need to be the same suze as a long long?

> input which is parsed & discarded;
> +
> +#define FLAGS_SIZE             40
> +#define BEGIN_flag(a)          [a] = (struct flag[FLAGS_SIZE]) {

So, all entries are 40 long ...

> +#define END_flag               {NULL} }
> +
> +#define FLAG_DATA(n,p,m,i,o,a) { n+2, (void *)&(p), (uintptr_t)m,
> i"%7$n", "#%3$s "#p" "o"\n", NULL, OPT_MASK + a }
> +#define FLAG_STRG(n,p,a)       FLAG_DATA((n), (p), 0,   "%3$n",
> "strg=%1$s",       OPT_VAL+(a))
> +#define FLAG_IVAL(n,p,i)       FLAG_DATA((n), (p), 0,   i,
> "ival=%1$"PRIdPTR, OPT_VAL+OPT_INLINE )
> +#define FLAG_ENUM(n,p,m)       FLAG_DATA((n), (p), (m), "\0",
> "bset=%1$"PRIdPTR,-OPT_MASK+(*(n)-'@')&0x7)
> +#define FLAG_LNUM(n,p,m)       FLAG_DATA((n), (p), (m),
> "%1$lli","lnum=%1$"PRIdPTR, OPT_VAL)
> +#define FLAG_OGRP(n,p)         FLAG_DATA((n),
> (p),*(n)=='*',"\0","true=%1$"PRIdPTR, OPT_VAL+OPT_NO_SEP)
> +
> +#define FLAG_PRNT(n,f,m,i,o,a) { n+2, (void *)&opt_grp,
> (uintptr_t)(m), (i), o"\n", f, OPT_MASK | OPT_VAL | a}
> +#define FLAG_ERRM(n,m,f)       { n+2, (void *)&opt_grp, 0, NULL, (m),
> (f)>>2 ? &die : (out_fn)&printf, OPT_INLINE|OPT_NO_RET }

The only values used for f are 6 or 10. What's the meaning of this
parameter? Why the >>2 ?

> +#define FLAG_INCL(n,a)         FLAG_PRNT((n), &add_cmdline_include,
> 0, 0, "#%3$s (cmdline_include) path=%1$s", (a))
> +#define FLAG_PDEF(n,a,o)       FLAG_PRNT((n), &add_pre_buffer,"1",
> "%3$n%7$n%*[^=]=%4$n%5$n", o, (a))
> +#define FLAG_ARCH(n,f,m)       FLAG_PRNT((n), &set_arch,      (m),
> "%7$n%1$2u%7$n", "#%3$s (arch) m="f",%1$d,%2$d", OPT_INLINE)

I find this really cryptic and very very error-prone.


> +static struct flag *flags[] = {
> +       BEGIN_flag('D')
> +               FLAG_OGRP("~D", opt_grp),
> +               FLAG_PDEF("~D#", OPT_INPUT, "#define %s %s"),
> +       END_flag,
> +       BEGIN_flag('U')
> +               FLAG_OGRP("~U", opt_grp),
> +               FLAG_PDEF("~U#", OPT_INPUT, "#undef %s"),
> +       END_flag,
> +       BEGIN_flag('d')
> +               FLAG_OGRP("~d", opt_grp),
> +               FLAG_OGRP(". #M", dump_macro_defs),
> +               FLAG_OGRP("* #D", dump_macro_defs),
> +               FLAG_OGRP("* #N", dump_macros_only),
> +               FLAG_OGRP("* #I", dump_macros_only),
> +               FLAG_OGRP("* #U", dump_macros_only),
> +               FLAG_OGRP("~d", opt_grp),
> +               FLAG_OGRP("* #M", dump_macros_only),
> +               FLAG_OGRP(". #D", dump_macros_only),
> +               FLAG_OGRP(". #N", dump_macros_only),
> +               FLAG_OGRP(". #I", dump_macros_only),
> +               FLAG_OGRP(". #U", dump_macros_only),
> +       END_flag,
> +       BEGIN_flag('E')
> +               FLAG_ENUM("~E", preprocess_only, 1),
> +       END_flag,
> +       BEGIN_flag('f')
> +               FLAG_ENUM("~fmem-report", fmem_report, 1),
> +               FLAG_ENUM("~funsigned-char",funsigned_char, 1),
> +               FLAG_ENUM("-fsigned-char", funsigned_char, 1),

-fno-signed-char is also supported ...

> +               FLAG_ENUM("~fshort-wchar", fshort_wchar, 1),
> +               FLAG_ENUM("~fpic", fpic, 1),
> +               FLAG_ENUM("~fPIC", fpic, 2),
> +               FLAG_ENUM("~fpie", fpie, 1),
> +               FLAG_ENUM("~fPIE", fpie, 2),
> +               FLAG_OGRP("~fmemcpy-max-count=", opt_grp),
> +               FLAG_LNUM(". #unlimited", fmemcpy_max_count, "-1"),
> +               FLAG_LNUM(". #0", fmemcpy_max_count, "-1"),
> +               FLAG_IVAL(". #", fmemcpy_max_count, "%1$lld"),
> +               FLAG_OGRP("~fmax-warnings=", opt_grp),
> +               FLAG_ENUM(". #unlimited", fmax_warnings, ~0),
> +               FLAG_IVAL(". #", fmax_warnings, "%1$d"),
> +               FLAG_ERRM("~ftabstop=0", "error: wrong argument to '%3$s'", 6),
> +               FLAG_IVAL("~ftabstop=", tabstop, "%1$2u"),

-ftabstop=120 ...


> +
> +int sparse_add_switch(int action, const char *name, ...)
> +{
> +       static struct flag *switches['z'];
> +       static short sizes['z'] = { ['W'] = ARRAY_SIZE(warnings)-FLAGS_SIZE };

What's special with 'z'?



Best regards,
-- Luc
