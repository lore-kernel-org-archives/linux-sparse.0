From: Borislav Petkov <bp@alien8.de>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Sun, 7 Oct 2018 16:13:49 +0200
Message-ID: <20181007141349.GD30687@zn.tnic>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181007091805.GA30687@zn.tnic>
 <20181007132228.GJ29268@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181007132228.GJ29268@gate.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: gcc@gcc.gnu.org, Richard Biener <rguenther@suse.de>, Michael Matz <matz@suse.de>, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-sparse@vger.kernel.org

On Sun, Oct 07, 2018 at 08:22:28AM -0500, Segher Boessenkool wrote:
> GCC already estimates the *size* of inline asm, and this is required
> *for correctness*.

I didn't say it didn't - but the heuristic could use improving.

> So I guess the real issue is that the inline asm size estimate for x86
> isn't very good (since it has to be pessimistic, and x86 insns can be
> huge)?

Well, the size thing could be just a "parameter" or "hint" of sorts, to
tell gcc to inline the function X which is inlining the asm statement
into the function Y which is calling function X. If you look at the
patchset, it is moving everything to asm macros where gcc is apparently
able to do better inlining.

> >  3) asm ("...") __attribute__((asm_size(<size-expr>)));
> 
> Eww.

Why?

> More precise *size* estimates, yes.  And if the user lies he should not
> be surprised to get assembler errors, etc.

Yes.

Another option would be if gcc parses the inline asm directly and
does a more precise size estimation. Which is a lot more involved and
complicated solution so I guess we wanna look at the simpler ones first.

:-)

> I don't like 2) either.  But 1) looks interesting, depends what its
> semantics would be?  "Don't count this insn's size for inlining decisions",
> maybe?

Or simply "this asm statement has a size of 1" to mean, inline it
everywhere. Which has the same caveats as above.

> Another option is to just force inlining for those few functions where
> GCC currently makes an inlining decision you don't like.  Or are there
> more than a few?

I'm afraid they're more than a few and this should work automatically,
if possible.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
