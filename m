From: Michael Matz <matz@suse.de>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Sun, 7 Oct 2018 15:53:26 +0000 (UTC)
Message-ID: <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181007132228.GJ29268@gate.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>, gcc@gcc.gnu.org, Richard Biener <rguenther@suse.de>, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutroni>
List-Id: linux-sparse@vger.kernel.org

Hi Segher,

On Sun, 7 Oct 2018, Segher Boessenkool wrote:

> On Sun, Oct 07, 2018 at 11:18:06AM +0200, Borislav Petkov wrote:
> > this is an attempt to see whether gcc's inline asm heuristic when
> > estimating inline asm statements' cost for better inlining can be
> > improved.
> 
> GCC already estimates the *size* of inline asm, and this is required
> *for correctness*.  So any workaround that works against this will only
> end in tears.

You're right and wrong.  GCC can't even estimate the size of mildly 
complicated inline asms right now, so your claim of it being necessary for 
correctness can't be true in this absolute form.  I know what you try to 
say, but still, consider inline asms like this:

     insn1
  .section bla
     insn2
  .previous

or
   invoke_asm_macro foo,bar

in both cases GCCs size estimate will be wrong however you want to count 
it.  This is actually the motivating example for the kernel guys, the 
games they play within their inline asms make the estimates be wildly 
wrong to a point it interacts with the inliner.

> So I guess the real issue is that the inline asm size estimate for x86 
> isn't very good (since it has to be pessimistic, and x86 insns can be 
> huge)?

No, see above, even if we were to improve the size estimates (e.g. based 
on some average instruction size) the kernel examples would still be off 
because they switch sections back and forth, use asm macros and computed 
.fill directives and maybe further stuff.  GCC will never be able to 
accurately calculate these sizes (without an built-in assembler which 
hopefully noone proposes).

So, there is a case for extending the inline-asm facility to say 
"size is complicated here, assume this for inline decisions".

> > Now, Richard suggested doing something like:
> > 
> >  1) inline asm ("...")
> 
> What would the semantics of this be?

The size of the inline asm wouldn't be counted towards the inliner size 
limits (or be counted as "1").

> I don't like 2) either.  But 1) looks interesting, depends what its
> semantics would be?  "Don't count this insn's size for inlining decisions",
> maybe?

TBH, I like the inline asm (...) suggestion most currently, but what if we 
want to add more attributes to asms?  We could add further special 
keywords to the clobber list:
  asm ("...." : : : "cc,memory,inline");
sure, it might seem strange to "clobber" inline, but if we reinterpret the 
clobber list as arbitrary set of attributes for this asm, it'd be fine.

> Another option is to just force inlining for those few functions where 
> GCC currently makes an inlining decision you don't like.  Or are there 
> more than a few?

I think the examples I saw from Boris were all indirect inlines:

  static inline void foo() { asm("large-looking-but-small-asm"); }
  static void bar1() { ... foo() ... }
  static void bar2() { ... foo() ... }
  void goo (void) { bar1(); }  // bar1 should have been inlined

So, while the immediate asm user was marked as always inline that in turn 
caused users of it to become non-inlined.  I'm assuming the kernel guys 
did proper measurements that they _really_ get some non-trivial speed 
benefit by inlining bar1/bar2, but for some reasons (I didn't inquire) 
didn't want to mark them all as inline as well.


Ciao,
Michael.
