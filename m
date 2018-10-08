From: Richard Biener <rguenther@suse.de>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Mon, 8 Oct 2018 11:07:46 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181008073128.GL29268@gate.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>, gcc@gcc.gnu.org, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-sparse@vger.kernel.org

On Mon, 8 Oct 2018, Segher Boessenkool wrote:

> Hi!
> 
> On Sun, Oct 07, 2018 at 03:53:26PM +0000, Michael Matz wrote:
> > On Sun, 7 Oct 2018, Segher Boessenkool wrote:
> > > On Sun, Oct 07, 2018 at 11:18:06AM +0200, Borislav Petkov wrote:
> > > > this is an attempt to see whether gcc's inline asm heuristic when
> > > > estimating inline asm statements' cost for better inlining can be
> > > > improved.
> > > 
> > > GCC already estimates the *size* of inline asm, and this is required
> > > *for correctness*.  So any workaround that works against this will only
> > > end in tears.
> > 
> > You're right and wrong.  GCC can't even estimate the size of mildly 
> > complicated inline asms right now, so your claim of it being necessary for 
> > correctness can't be true in this absolute form.  I know what you try to 
> > say, but still, consider inline asms like this:
> > 
> >      insn1
> >   .section bla
> >      insn2
> >   .previous
> > 
> > or
> >    invoke_asm_macro foo,bar
> > 
> > in both cases GCCs size estimate will be wrong however you want to count 
> > it.  This is actually the motivating example for the kernel guys, the 
> > games they play within their inline asms make the estimates be wildly 
> > wrong to a point it interacts with the inliner.
> 
> Right.  The manual says:
> 
> """
> Some targets require that GCC track the size of each instruction used
> in order to generate correct code.  Because the final length of the
> code produced by an @code{asm} statement is only known by the
> assembler, GCC must make an estimate as to how big it will be.  It
> does this by counting the number of instructions in the pattern of the
> @code{asm} and multiplying that by the length of the longest
> instruction supported by that processor.  (When working out the number
> of instructions, it assumes that any occurrence of a newline or of
> whatever statement separator character is supported by the assembler --
> typically @samp{;} --- indicates the end of an instruction.)
> 
> Normally, GCC's estimate is adequate to ensure that correct
> code is generated, but it is possible to confuse the compiler if you use
> pseudo instructions or assembler macros that expand into multiple real
> instructions, or if you use assembler directives that expand to more
> space in the object file than is needed for a single instruction.
> If this happens then the assembler may produce a diagnostic saying that
> a label is unreachable.
> """
> 
> It *is* necessary for correctness, except you can do things that can
> confuse the compiler and then you are on your own anyway.
> 
> > > So I guess the real issue is that the inline asm size estimate for x86 
> > > isn't very good (since it has to be pessimistic, and x86 insns can be 
> > > huge)?
> > 
> > No, see above, even if we were to improve the size estimates (e.g. based 
> > on some average instruction size) the kernel examples would still be off 
> > because they switch sections back and forth, use asm macros and computed 
> > .fill directives and maybe further stuff.  GCC will never be able to 
> > accurately calculate these sizes
> 
> What *is* such a size, anyway?  If it can be spread over multiple sections
> (some of which support section merging), and you can have huge alignments,
> etc.  What is needed here is not knowing the maximum size of the binary
> output (however you want to define that), but some way for the compiler
> to understand how bad it is to inline some assembler.  Maybe manual
> direction, maybe just the current jeuristics can be tweaked a bit, maybe
> we need to invent some attribute or two.
> 
> > (without an built-in assembler which hopefully noone proposes).
> 
> Not me, that's for sure.
> 
> > So, there is a case for extending the inline-asm facility to say 
> > "size is complicated here, assume this for inline decisions".
> 
> Yeah, that's an option.  It may be too complicated though, or just not
> useful in its generality, so that everyone will use "1" (or "1 normal
> size instruction"), and then we are better off just making something
> for _that_ (or making it the default).
> 
> > > > Now, Richard suggested doing something like:
> > > > 
> > > >  1) inline asm ("...")
> > > 
> > > What would the semantics of this be?
> > 
> > The size of the inline asm wouldn't be counted towards the inliner size 
> > limits (or be counted as "1").
> 
> That sounds like a good option.

Yes, I also like it for simplicity.  It also avoids the requirement
of translating the number (in bytes?) given by the user to
"number of GIMPLE instructions" as needed by the inliner.

> > > I don't like 2) either.  But 1) looks interesting, depends what its
> > > semantics would be?  "Don't count this insn's size for inlining decisions",
> > > maybe?
> > 
> > TBH, I like the inline asm (...) suggestion most currently, but what if we 
> > want to add more attributes to asms?  We could add further special 
> > keywords to the clobber list:
> >   asm ("...." : : : "cc,memory,inline");
> > sure, it might seem strange to "clobber" inline, but if we reinterpret the 
> > clobber list as arbitrary set of attributes for this asm, it'd be fine.
> 
> All of a targets register names and alternative register names are
> allowed in the clobber list.  Will that never conflict with an attribute
> name?  We already *have* syntax for specifying attributes on an asm (on
> *any* statement even), so mixing these two things has no advantage.

Heh, but I failed to make an example with attribute synatx working.
IIRC attributes do not work on stmts.  What could work is to use
a #pragma though.

Richard.

> Both "cc" and "memory" have their own problems of course, adding more
> things to this just feels bad.  It may not be so bad ;-)
> 
> > > Another option is to just force inlining for those few functions where 
> > > GCC currently makes an inlining decision you don't like.  Or are there 
> > > more than a few?
> > 
> > I think the examples I saw from Boris were all indirect inlines:
> > 
> >   static inline void foo() { asm("large-looking-but-small-asm"); }
> >   static void bar1() { ... foo() ... }
> >   static void bar2() { ... foo() ... }
> >   void goo (void) { bar1(); }  // bar1 should have been inlined
> > 
> > So, while the immediate asm user was marked as always inline that in turn 
> > caused users of it to become non-inlined.  I'm assuming the kernel guys 
> > did proper measurements that they _really_ get some non-trivial speed 
> > benefit by inlining bar1/bar2, but for some reasons (I didn't inquire) 
> > didn't want to mark them all as inline as well.
> 
> Yeah that makes sense, like if this happens with the fixup stuff, it will
> quickly spiral out of control.
