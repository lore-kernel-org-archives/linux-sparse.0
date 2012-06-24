From: Daniel Santos <danielfsantos@att.net>
Subject: Re: [PATCH v4 0/13] Generic Red-Black Trees
Date: Sat, 23 Jun 2012 19:40:24 -0500
Message-ID: <4FE661F8.3000109@att.net>
References: <1340424048-7759-1-git-send-email-daniel.santos@pobox.com> <4FE64AB4.1010904@landley.net>
Reply-To: daniel.santos@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <4FE64AB4.1010904@landley.net>
Sender: linux-doc-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: Daniel Santos <daniel.santos@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Ingo Molnar <mingo@kernel.org>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Turner <pjt@google.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Richard Weinberger <richard@nod.at>, Steven Rostedt <rostedt@goodmis.org>, Suresh Siddha <suresh.b.siddha@intel.com>
List-Id: linux-sparse@vger.kernel.org

First off, thanks for your lively commentary!

On 06/23/2012 06:01 PM, Rob Landley wrote:
> On 06/22/2012 11:00 PM, Daniel Santos wrote:
>> Theory of Operation
>> ===================
>> Historically, genericity in C meant function pointers, the overhead of a
>> function call and the inability of the compiler to optimize code across
>> the function call boundary.  GCC has been getting better and better at
>> optimization and determining when a value is a compile-time constant and
>> compiling it out.  As of gcc 4.6, it has finally reached a point where
>> it's possible to have generic search & insert cores that optimize
>> exactly as well as if they were hand-coded. (see also gcc man page:
>> -findirect-inlining)
> For those of us who stopped upgrading gcc when it went to a non-open
> license, and the people trying to escape to llvm/pcc/open64/tcc/qcc/etc
> and build the kernel with that, this will simply be "less optimized"
> rather than "you're SOL, hail stallman"?
Forgive me, but I'm a little stumped here.  When did GCC move to a
"non-open" license?

Either way, yes, one thing that must be considered with this is that
code compiled prior to gcc 4.6 is indeed "less optimized." For gcc 4.2
through 4.5, the difference is very minor (the compare function is not
inlined).  From there back, it starts to grow.  In gcc 3.4.6, it's
fairly ugly.

I haven't performed tests on other compilers yet, but I wouldn't be
surprised if llvm/clang does this better.  My next phase is to build a
test module so we can quickly get performance data on various platforms
& compilers.  Either way, an alternate compiler will have to support at
least some of gcc's extensions to compile Linux.

Another question that has to be asked is "Is Linux ready for this?"  The
answer today may be "yes" or "no", but to say that it can never be ready
is pure folly.  Eventually, you have to decide to stop supporting older
compilers and move to newer paradigms that lower the maintenance burden,
enabling your developers to work on more important things.  C++ offers
lots of these types of paradigms, but the compilers just aren't good
enough yet (of course, there's the laundry list of reasons to not use C++).
>
>> Layer 2: Type-Safety
>> --------------------
>> In order to achieve type-safety of a generic interface in C, we must
>> delve deep into the darkened Swamps of The Preprocessor and confront the
>> Prince of Darkness himself: Big Ugly Macro.  To be fair, there is an
>> alternative solution (discussed in History & Design Goals), the
>> so-called "x-macro" or "supermacro" where you #define some pre-processor
>> values and include an unguarded header file.  With 17 parameters, I
>> choose this solution for its ease of use and brevity, but it's an area
>> worth debate.
> Because this is just _filling_ me with confidence about portability and
> c99 compliance.
This is actually C99 compliant, even though it wont work on all
compilers.  Somebody tested it on msvc and told me that it broke
(*faints*).  The "iffy" macro is IFF_EMPTY(), which uses a similar
mechanism to kconfig.h's IS_ENABLED() macro.  I kinda doubt that one
would break and not the other.  It's fairly easy to test though.

Aside from that, is the size of the macro.  After stripping comments,
the size is roughly 4155 bytes, indeed beyond the C99's minimum required
size of 4096 bytes (even though most compilers use a much larger
buffer).  So that's another issue that can break on other compilers,
unless it stores the macro with whitespace condensed, which would bring
it down to 3416 bytes.
> (Or I suppose C11!!one! compliance. The new thing that puts asserts in
> the base language and makes u8 a keyword since _that_ won't break
> existing code and putting utf8 string constants within quotes wasn't
> previously possible.)
>
> I'm not saying the standard's perfect, I'm saying a web page that ties
> itself to mozilla at the expense of working on firefox, let alone
> chrome, might be a bit short-sighted these days. XFree86 begat x.org,
> OpenOffice begat libre, etc. The FSF went nuts again and this time
> around EGCS is called LLVM, so talking about gcc 4.6-only features
> thrills some of us less than you might expect.
It's really just a "not broken on gcc 4.6", since -findirect-inlining
was introduced in gcc 4.4 or some such.

Thanks for your feedback!

Daniel
