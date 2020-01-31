From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: PATCH: sparse_add_switch() for backends to register new switches
 into main parsing table
Date: Fri, 31 Jan 2020 07:52:11 +0100
Message-ID: <20200131065211.chcnkszckhqupj6u@ltop.local>
References: <CAO6moYtTsA8niRvL135+OMXDjAEnGEGMf8kG+CYgq+YDKPi4UQ@mail.gmail.com>
 <CAO6moYuBpk_qnrs+pMYK4rHjDzOpRDJSC_mYHew8tvfbiehWqw@mail.gmail.com>
 <20200130064911.rbiqkerptoo22dlx@ltop.local>
 <CAO6moYtvgUSAsvt01+jJMznqvCMPNj8-c0nBgMYsJGBQebVo9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42912 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgAaGwR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Jan 2020 01:52:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id k11so7271459wrd.9
        for <linux-sparse@vger.kernel.org>; Thu, 30 Jan 2020 22:52:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAO6moYtvgUSAsvt01+jJMznqvCMPNj8-c0nBgMYsJGBQebVo9A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xan Phung <xan.phung@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Jan 30, 2020 at 10:33:20PM +0800, Xan Phung wrote:
> On Thu, 30 Jan 2020 at 14:49, Luc Van Oostenryck wrote:
> >
> > I'm quite sympathetic to the idea of having customizable options
> > parsing.For example, there is alreay a need to have arch-specific
> > options (in both direction: some unsupported options should be supported
> > on some archs, and some supported options should not on some arches).
> > Also, some cleanup there is more than welcome.
> >
> > Could you describe (some of) your usecases?
> 
> Some immediate use cases are backends that add more IR passes
> eg. loop unrolling/analysis, fine grain (instruction level) liveness.
> 
> For example, in my WASM backend, I do loop analysis of the basic blocks
> Subsequent phases are conversion to stack machine instructions & WASM output
> (stackification requires instruction level liveness analysis, which
> I do using a small augmentation of the current IR structures, not a new IR
> ... the WASM stack machine still has registers/local vars!)
> 
> For these additional IR passes, they would be controlled by switches such as:
> -floop         (OK as top level option)
> -fstackify   (OK as top level option)
> -fdump-ir=loop,stackify  (most consistent if done as sub-option of fdump-ir)
> 
> > Before going into the details, I must say that I'm not convinced by the
> > approach here:
> > * there is a need to add new options but is there also a need to add
> >   new entries for sub-options/option parameters?
> 
> The example I gave above shows sub-options extendability would
> give the best consistency for the user of the command line UI.
> 
> The example also shows it's artificial to separate main options vs suboptions
> ...in the end, they are all just options.

I don't agree with this point of view. Sub-options are option's parameters,
they have their own context and each options can have it's own rules for
parsing its parameters.
But yes, some options can have the same effect than some other, more longish,
option with some parameters.

> My understanding of your concerns are not really about the suboptions.
> Instead it is simple vs complex option (whether it be main- or sub-option).
> ie: you are ok with a table-based approach for simple options (main or sub)
> ... but you prefer escapes into helper functions for complex options
> 
> Is that a correct way for me to reframe your concerns about sub-options?

I'm certainly concerned by hidden complexity and the lack of flexibility
that could result from trying to force everything in the same mold.

> > * the prefix "codes" ("~", "~~", ". #", "@", ...) are to me cryptic.
> >   they don't need to be put in the string but they could be make
> >   explicit (with a good name) as another parameter, kinda like the
> >   OPT_xyz are, or implicit in the definition of the FLAG_WXYZ()
> 
> Noted.   I am happy to rewrite as you propose.
> 
> > * IMO, the parsing of the suboption have generaly no place here.
> >   It's especially the case for --std or --arch but also for things
> >   like -fdump-ir. I would much prefer to keep the helper for these:
> >         * it would keep the generic parsing simpler
> >         * it allow maximum flexibility for these
> 
> Your concern about --arch is noted.
> I can review & redo the helper function.
> (I became aware of --arch very late, as it wasn't in v0.6.1)
> 
> Can you elaborate on your concern about -std?
> To me, it seems to be a very simple option list, that fits in well
> with table based parsing.
> (The ISO names look messy to humans, but they are plain C strings to a computer)

Yes, sure. What I mean is that these strings and their effect are specific
to the option '-std' and as such should be better handled by its specfic
function (even if it's only calling a generic helper with a specific
table for the mapping version-strings / enum.

> > * I haven't look in details but I'm a bit affraid of regressions.
> >   For example, I don't think that the sequence '-v -v -vvvv' is
> >   processed here like it should (*increment* 'verbose' by 6).
> 
> Noted.
> 
> > * you're making a heavy use of positional arguments in
> >   printf & sscanf format strings but these are C99 features.
> >   Currently, Sparse doesn't requires C99 and is just fine with C89.
> > * I'm annoyed at the lost of some typechecking:
> >         * struct flag now use an union to hold pointers
> >         * cast of pointers to void*
> >         * even cast of printf() ...
> > * I'm also somehow worried about a possible increase in startup time.
> >
> > In short, I would much much prefer to:
> > * not specifiy the suboption/parameters in the option table
> > * use specific helper to handle non-simple parameters/sub-options
> 
> Noted.
> 
> IMO I consider suboptions to fall within "simple"
> (they just turn on/off a bit & don't compromise type int* checking
> ...ok, there is some messiness to signed vs unsigned int,
> but it's possible to handle this without casts)
> 
> But I understand your point of view of greater use of helper funcs for
> other situations.
> I can rework my patch to fall within these parameters.

Excellent.
 
> > I think that if  you only need to add some new options meaningful
> > only to your backend it would be much simpler and effective to either:
> > * process your command line before calling sparse_initialize(), or
> > * use some hook to process the options not handled (and thus ignored)
> >   by sparse_initialize()
> >
> 
> Using the -fdump-ir example above, this would presumably require
> filtering out "loop" and "stackify" substrings, before passing argv[]
> to sparse_initialize?
> (ie:rewriting of the strings contained within argv[i]?)

In truth, I wouldn't mind to directly handle in the core code
new options like -floop or -fstackify and new suboptions, like the
ones for -fdump-ir. It would just need a small comment saying that
they are not used by the internal backend but well by some others.

For suboptions setting some enum value, something like this is needed
anyway to avoid clashes between future definitions.
 
> Also, new backend options may mirror existing options,
> eg. new warnings, ie: -Wxxx and -Wno-xxxx
> It would be a shame to duplicate code to parse these options separately
> (rather than just adding new entries into existing arrays for these switches).
> 
> Also, Wsparse-all then wouldn't automatically enable these backend warnings.
> (which may be confusing for the user, who has to know which are considered
> "sparse" and which are "non-sparse" warnings)

Don't worry about -Wsparse-all. It's something that should be removed.
But more importantly, it's not something that is supposed to be used
by users.

> In my approach, backends can add new warnings without new code.
> They can then also specify whether or not Wsparse-all turns these on
> using a control bit (within the flag->action field).
> 
> (Wsparse-error uses this mechanism to prevent Wsparse-all turning it on)
> 
> > > @@ -370,4 +370,10 @@ struct flag {
> > > -       int *flag;
> > > -       int (*fun)(const char *arg, const char *opt, const struct flag
> > > *, int options);
> > > -       unsigned long mask;
> > > -       int val;
> > > +       union {
> > > +               int *flag;
> > > +               long long *long_flag;
> > > +               const char **string;
> > > +       };
> >
> > like already said above, this is annoying from a typechecking point-of-view.
> 
> I understand your point of view re: type checking.
> I can drop the "long long" part and move it into a helper function.
> 
> Are you ok to retain string flags?
> Strings are really the more "natural" type for flags
> ...that's what they start off as in argv[].
> (Transformation to int flag then is an extra step for some switches).
> 
> Also, if you really want to keep ints and strings separate,
> I can make them two distinct fields, rather than a union.

I prefer this, yes.

> > > @@ -419 +429 @@ static void handle_arch_finalize(void)
> > > -static const struct flag warnings[] = {
> > > +static const struct flag warnings[80] = {
> >
> > Why the magic 80, here?
> 
> It was chosen as approx double the current warnings size (~40).
> This would allow backends to register approx another 40 warnings.
> 
> I went for fixed sizes, as IMO dynamic array resizing would be overkill.

Mmmmm. It's maybe acceptable as a first step but it's not robust.
Some chaining of tables could be a beter solution.
 
> > > @@ -482 +492 @@ static void handle_switch_W_finalize(void)
> > > -       if (-1 == Wdeclarationafterstatement) {
> > > +       if (Wdeclarationafterstatement < 0) {
> >
> > What's the motivation for the change?
> 
> Sorry, this change is no longer necessary.
> It was left over from an earlier approach I used, which no longer applies.

OK.
 
> >
> > > (ii) **************** New lines: *****************
> > > The diff below is a direct continuation of the diff above, and adds
> > > the new switch parsing functions and flag array discussed.
> > >
> > >
> > >
> > > @@ -494,0 +505,367 @@ static void handle_switch_W_finalize(void)
> > > +static void set_arch(const char *fmt, ...)
> > > +{
> > > +       unsigned bits = 0, mach = 0, min = 0, big = 0;
> > > +       va_list args;
> > > +       va_start(args, fmt);
> > > +       bits = va_arg(args, int);
> > > +       mach = va_arg(args, int);
> > > +       va_end(args);
> > > +       assert(fmt && sscanf(fmt, "#%*s (%*[^)]) m=%2d,%1d", &min, &big) == 2);
> >
> > I really really dislike this:
> > * the assert
> > * the use of sscanf
> > * the fact that the data are now no more visible
> 
> Noted, I can revisit/redo this.
> set_arch() was a quick, last minute addition, and probably poorly thought out.
> (My original patch was for v0.6.1, not current master)
> 
> > > +static  char opt_grp[sizeof(long long)];  //Placeholder for unused
> >
> > I don't understand this. What will be stored in opt_grp?
> > why it need to be the same suze as a long long?
> 
> Some switches don't currently have any memory loc'ns for their data
> (eg. -G, all add_pre_buffer switches).
> 
> opt_grp is a temporary location to store a pointer to a string, or an
> int/longlong value.
> It needs to be an addressable memory location outside function scope
> (ie: not a stack/auto variable).
> 
> Once the string is processed (eg. by add_pre_buffer), it is no longer needed
> and can be reused for parsing the next argument.

OK, I still don't like it much but something like here below would be
more acceptable:
	struct opt_context {
		int ival;
		long long llval;
		const char *str;
	} tmp_ctxt;
 
> > > +
> > > +#define FLAGS_SIZE             40
> > > +#define BEGIN_flag(a)          [a] = (struct flag[FLAGS_SIZE]) {
> >
> > So, all entries are 40 long ...
> 
> All except warnings (-W) array, which is 80 long.
> I chose a simple fixed size for simplicity, but actually each letter
> have it's own size if required.
> 
> >
> > The only values used for f are 6 or 10. What's the meaning of this
> > parameter? Why the >>2 ?
> 
> At one stage I had a system of various levels for msgs with 0-3 & 4-7
> being two classes of error,
> and 8-11 being "info" type msgs.
> 
> In the end I got rid of this and reduced it down to just two: die(),
> or printf() (eg. for --version)
> 
> I can change this to 0-1 rather than 0-12 if it is unlikely any other
> error msg levels are needed.

Or better, use an enum or some defines with some good names.

> >
> > > +#define FLAG_INCL(n,a)         FLAG_PRNT((n), &add_cmdline_include,
> > > 0, 0, "#%3$s (cmdline_include) path=%1$s", (a))
> > > +#define FLAG_PDEF(n,a,o)       FLAG_PRNT((n), &add_pre_buffer,"1",
> > > "%3$n%7$n%*[^=]=%4$n%5$n", o, (a))
> > > +#define FLAG_ARCH(n,f,m)       FLAG_PRNT((n), &set_arch,      (m),
> > > "%7$n%1$2u%7$n", "#%3$s (arch) m="f",%1$d,%2$d", OPT_INLINE)
> >
> > I find this really cryptic and very very error-prone.
> 
> Noted.  Given many of your concerns relate to my use of sscanf, ie:
> need for positional specifiers, no type checking of variadic params,
> "cryptic" fmt strings,
> I am happy to discard the use of sscanf and instead use helper funcs
> if parsing complex inputs.

I would indeed prefer this much beter.

> > > +       BEGIN_flag('f')
> > > +               FLAG_ENUM("~fmem-report", fmem_report, 1),
> > > +               FLAG_ENUM("~funsigned-char",funsigned_char, 1),
> > > +               FLAG_ENUM("-fsigned-char", funsigned_char, 1),
> >
> > -fno-signed-char is also supported ...
> 
> Noted.
> My test-switches.c program has fno-signed-char as a test case & it
> works correctly.

OK.
 
> > > +               FLAG_ENUM("~fshort-wchar", fshort_wchar, 1),
> > > +               FLAG_ENUM("~fpic", fpic, 1),
> > > +               FLAG_ENUM("~fPIC", fpic, 2),
> > > +               FLAG_ENUM("~fpie", fpie, 1),
> > > +               FLAG_ENUM("~fPIE", fpie, 2),
> > > +               FLAG_OGRP("~fmemcpy-max-count=", opt_grp),
> > > +               FLAG_LNUM(". #unlimited", fmemcpy_max_count, "-1"),
> > > +               FLAG_LNUM(". #0", fmemcpy_max_count, "-1"),
> > > +               FLAG_IVAL(". #", fmemcpy_max_count, "%1$lld"),
> > > +               FLAG_OGRP("~fmax-warnings=", opt_grp),
> > > +               FLAG_ENUM(". #unlimited", fmax_warnings, ~0),
> > > +               FLAG_IVAL(". #", fmax_warnings, "%1$d"),
> > > +               FLAG_ERRM("~ftabstop=0", "error: wrong argument to '%3$s'", 6),
> > > +               FLAG_IVAL("~ftabstop=", tabstop, "%1$2u"),
> >
> > -ftabstop=120 ...
> 
> Noted.  This was where sscanf had some use, the %2u fmt only accepts 0-99,
> (and I had an explicit flags array entry to handle ftabstop=0).
> 
> It prints a "wrong argument" die() error for =0 & >=100 (rather than
> silently ignoring).
> I prefer the die() error, so I consider this a feature, rather than a bug. :)

Yes, it's discutable but if someone currently use -ftabstop=120 it will
break its workflow.
 
> > > +
> > > +int sparse_add_switch(int action, const char *name, ...)
> > > +{
> > > +       static struct flag *switches['z'];
> > > +       static short sizes['z'] = { ['W'] = ARRAY_SIZE(warnings)-FLAGS_SIZE };
> >
> > What's special with 'z'?
> 
> I only wanted to support ASCII values up to 'z' for the switch letter.
> I could do 255 instead of 'z', at cost of an extra 1-2Kb larger arrays.
> Now you point it out, I think I should have chosen 127, as it's easier
> to range check.

OK, I haven't yet really looked at this part.
 
Cheers,
-- Luc
