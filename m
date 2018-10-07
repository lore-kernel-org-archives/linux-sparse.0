From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Sun, 7 Oct 2018 08:22:28 -0500
Message-ID: <20181007132228.GJ29268@gate.crashing.org>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gcc-return-197342-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Content-Disposition: inline
In-Reply-To: <20181007091805.GA30687@zn.tnic>
To: Borislav Petkov <bp@alien8.de>
Cc: gcc@gcc.gnu.org, Richard Biener <rguenther@suse.de>, Michael Matz <matz@suse.de>, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredan ne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-found
List-Id: linux-sparse@vger.kernel.org

On Sun, Oct 07, 2018 at 11:18:06AM +0200, Borislav Petkov wrote:
> this is an attempt to see whether gcc's inline asm heuristic when
> estimating inline asm statements' cost for better inlining can be
> improved.

GCC already estimates the *size* of inline asm, and this is required
*for correctness*.  So any workaround that works against this will only
end in tears.

Taking size as an estimate of cost is not very good.  But in your
motivating example you actually *do* care mostly about size, namely, for
the inlining decisions.

So I guess the real issue is that the inline asm size estimate for x86
isn't very good (since it has to be pessimistic, and x86 insns can be
huge)?

> Now, Richard suggested doing something like:
> 
>  1) inline asm ("...")

What would the semantics of this be?

>  2) asm ("..." : : : : <size-expr>)

This potentially conflicts with the syntax for asm goto.

>  3) asm ("...") __attribute__((asm_size(<size-expr>)));

Eww.

> with which user can tell gcc what the size of that inline asm statement
> is and thus allow for more precise cost estimation and in the end better
> inlining.

More precise *size* estimates, yes.  And if the user lies he should not
be surprised to get assembler errors, etc.

> And FWIW 3) looks pretty straight-forward to me because attributes are
> pretty common anyways.

I don't like 2) either.  But 1) looks interesting, depends what its
semantics would be?  "Don't count this insn's size for inlining decisions",
maybe?


Another option is to just force inlining for those few functions where
GCC currently makes an inlining decision you don't like.  Or are there
more than a few?


Segher
