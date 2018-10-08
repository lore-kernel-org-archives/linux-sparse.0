From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Mon, 8 Oct 2018 03:18:57 -0500
Message-ID: <20181008081856.GO29268@gate.crashing.org>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008061323.GB66819@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gcc-return-197354-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Content-Disposition: inline
In-Reply-To: <20181008061323.GB66819@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>, gcc@gcc.gnu.org, Richard Biener <rguenther@suse.de>, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 08, 2018 at 08:13:23AM +0200, Ingo Molnar wrote:
> * Michael Matz <matz@suse.de> wrote:
> > (without an built-in assembler which hopefully noone proposes).
> There are disadvantages (the main one is having to implement it), but a built-in assembler has 
> numerous advantages as well:
> 
>  - Better optimizations: for example -Os could more accurately estimate true instruction size.

GCC already knows the exact instruction size in almost all cases, for most
backends.  It is an advantage to not *have to* keep track of exact insn
size in all cases.

>  - Better inlining: as the examples in this thread are showing.

That's a red herring, the actual issue is inlining makes some spectacularly
wrong decisions for code involving asm currently.  That would not be solved
by outputting binary code instead of assembler code.  All those decisions
are done long before code is output.

>  - Better padding/alignment: right now GCC has no notion about the precise cache layout of the 
>    assembly code it generates and the code alignment options it has are crude.

This isn't true.  Maybe some targets do not care.

And of course GCC only knows this as far as it knows the alignments of the
sections it outputs into; for example, ASLR is a nice performance killer
at times.  And if your linker scripts align sections to less than a cache
line things do not look rosy either, etc.

> It got away with 
>    this so far because the x86 rule of thumb is that dense code is usually the right choice.

>  - Better compiler performance: it would be faster as well to immediately emit assembly
>    instructions, just like GCC's preprocessor library use speeds up compilation *significantly*
>    instead of creating a separate preprocessor task.

So how much faster do you think it would be?  Do you have actual numbers?
And no, -O0 does not count.

>  - Better future integration of assembly blocks: GCC could begin to actually understand the 
>    assembly statements in inline asm and allow more user-friendly extensions to its 
>    historically complex and difficult to master inline asm syntax.

If you want to add a different kind of inline assembler, you can already.
There is no need for outputting binary code for that.

> I mean, it's a fact that the GNU project has *already* defined their own assembly syntax which 
> departs from decades old platform assembly syntax

GCC's asm syntax is over three decades old itself.  When it was defined
all other C inline assembler syntaxes were much younger than that.  I don't
see what your argument is here.

> - and how the assembler is called by the 
> compiler is basically an implementation detail, not a conceptual choice.

But the *format* of the interface representation, in this case textual
assembler code, is quite fundamental.

> The random 
> multi-process unidirectional assembler choice of the past should not be treated as orthodoxy.

Then I have good news for you: no assembler works that way these days, and
that has been true for decades.


Segher
