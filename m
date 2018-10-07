From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Sun, 7 Oct 2018 10:14:28 -0500
Message-ID: <20181007151427.GK29268@gate.crashing.org>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <20181007141349.GD30687@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gcc-return-197344-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Content-Disposition: inline
In-Reply-To: <20181007141349.GD30687@zn.tnic>
To: Borislav Petkov <bp@alien8.de>
Cc: gcc@gcc.gnu.org, Richard Biener <rguenther@suse.de>, Michael Matz <matz@suse.de>, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredan ne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-found
List-Id: linux-sparse@vger.kernel.org

On Sun, Oct 07, 2018 at 04:13:49PM +0200, Borislav Petkov wrote:
> On Sun, Oct 07, 2018 at 08:22:28AM -0500, Segher Boessenkool wrote:
> > GCC already estimates the *size* of inline asm, and this is required
> > *for correctness*.
> 
> I didn't say it didn't - but the heuristic could use improving.

How?  It is as sharp an estimate as can be *already*: number of insns
times maximum size per insn.

If you get this wrong, conditional branches (and similar things, but
conditional branches usually hit first, and hurt most) will stop working
correctly, unless binutils uses relaxation for those on your architecture
(most don't).

> > So I guess the real issue is that the inline asm size estimate for x86
> > isn't very good (since it has to be pessimistic, and x86 insns can be
> > huge)?
> 
> Well, the size thing could be just a "parameter" or "hint" of sorts, to
> tell gcc to inline the function X which is inlining the asm statement
> into the function Y which is calling function X. If you look at the
> patchset, it is moving everything to asm macros where gcc is apparently
> able to do better inlining.

Yes, that will cause fewer problems I think: do not override size _at all_,
but give a hint to the inliner.

> > >  3) asm ("...") __attribute__((asm_size(<size-expr>)));
> > 
> > Eww.
> 
> Why?

Attributes are clumsy and clunky and kludgy.

It never is well-defined how attributes interact, and the more attributes
we define and use, the more that matters.

> > More precise *size* estimates, yes.  And if the user lies he should not
> > be surprised to get assembler errors, etc.
> 
> Yes.
> 
> Another option would be if gcc parses the inline asm directly and
> does a more precise size estimation. Which is a lot more involved and
> complicated solution so I guess we wanna look at the simpler ones first.
> 
> :-)

Which is *impossible* to do.  Inline assembler is free-form text.

> > I don't like 2) either.  But 1) looks interesting, depends what its
> > semantics would be?  "Don't count this insn's size for inlining decisions",
> > maybe?
> 
> Or simply "this asm statement has a size of 1" to mean, inline it
> everywhere. Which has the same caveats as above.

"Has minimum length" then (size 1 cannot work on most archs).

> > Another option is to just force inlining for those few functions where
> > GCC currently makes an inlining decision you don't like.  Or are there
> > more than a few?
> 
> I'm afraid they're more than a few and this should work automatically,
> if possible.

Would counting *all* asms as having minimum length for inlining decisions
work?  Will that give bad side effects?

Or since this problem is quite specific to x86, maybe some target hook is
wanted?  Things work quite well elsewhere as-is, degrading that is not a
good idea.


Segher
