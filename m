From: Richard Biener <rguenther@suse.de>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Thu, 11 Oct 2018 09:04:58 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1810110901350.16707@zhemvz.fhfr.qr>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org> <5ACDEDEA-0E42-45F2-BC80-B96EC2ABC01D@vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1609908220-1536231581-1539241501=:16707"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5ACDEDEA-0E42-45F2-BC80-B96EC2ABC01D@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nadav Amit <namit@vmware.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-sparse@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1609908220-1536231581-1539241501=:16707
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 10 Oct 2018, Nadav Amit wrote:

> at 7:53 AM, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> 
> > On Mon, Oct 08, 2018 at 11:07:46AM +0200, Richard Biener wrote:
> >> On Mon, 8 Oct 2018, Segher Boessenkool wrote:
> >>> On Sun, Oct 07, 2018 at 03:53:26PM +0000, Michael Matz wrote:
> >>>> On Sun, 7 Oct 2018, Segher Boessenkool wrote:
> >>>>> On Sun, Oct 07, 2018 at 11:18:06AM +0200, Borislav Petkov wrote:
> >>>>>> Now, Richard suggested doing something like:
> >>>>>> 
> >>>>>> 1) inline asm ("...")
> >>>>> 
> >>>>> What would the semantics of this be?
> >>>> 
> >>>> The size of the inline asm wouldn't be counted towards the inliner size 
> >>>> limits (or be counted as "1").
> >>> 
> >>> That sounds like a good option.
> >> 
> >> Yes, I also like it for simplicity.  It also avoids the requirement
> >> of translating the number (in bytes?) given by the user to
> >> "number of GIMPLE instructions" as needed by the inliner.
> > 
> > This patch implements this, for C only so far.  And the syntax is
> > "asm inline", which is more in line with other syntax.
> > 
> > How does this look?
> 
> It looks good to me in general. I have a couple of reservations, but I
> suspect you will not want to address them:
> 
> 1. It is not backward compatible, requiring a C macro to wrap it, as the 
> kernel might be built with different compilers.
> 
> 2. It is specific to asm. I do not have in mind another use case (excluding
> the __builtin_constant_p), but it would be nicer IMHO to have a builtin
> saying “ignore the cost of this statement” for the matter of optimizations.

The only easy possibility that comes to my mid is sth like

__attribute__((always_inline, zero_cost)) foo ()
{
  ... your stmts ...
}

and us, upon inlining, marking the inlined stmts properly.  That would
also work for the asm() case and it would be backwards compatible
(well, you'd get a diagnostic for the unknown zero_cost attribute).

There's the slight complication that if you have, say

 _1 = _2 * 3; // zero-cost
 _4 = _1 * 2;

and optimization ends up combining those to

 _4 = _2 * 6;

then is this stmt supposed to be zero-cost or not?  Compare that to

 _1 = _2 * 3;
 _4 = _1 * 2; // zero-cost

So outside of asm() there are new issues that come up with respect
to expected (cost) semantics.

Richard.
---1609908220-1536231581-1539241501=:16707--
