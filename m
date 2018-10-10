From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Wed, 10 Oct 2018 02:53:54 -0500
Message-ID: <20181010075353.GU29268@gate.crashing.org>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr> <20181009145330.GT29268@gate.crashing.org> <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gcc-return-197393-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
To: Richard Biener <rguenther@suse.de>
Cc: Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>, gcc@gcc.gnu.org, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@n>, exb.com, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundatio
List-Id: linux-sparse@vger.kernel.org

On Wed, Oct 10, 2018 at 09:12:48AM +0200, Richard Biener wrote:
> On Tue, 9 Oct 2018, Segher Boessenkool wrote:
> > On Mon, Oct 08, 2018 at 11:07:46AM +0200, Richard Biener wrote:
> > > On Mon, 8 Oct 2018, Segher Boessenkool wrote:
> > > > On Sun, Oct 07, 2018 at 03:53:26PM +0000, Michael Matz wrote:
> > > > > On Sun, 7 Oct 2018, Segher Boessenkool wrote:
> > > > > > On Sun, Oct 07, 2018 at 11:18:06AM +0200, Borislav Petkov wrote:
> > > > > > > Now, Richard suggested doing something like:
> > > > > > > 
> > > > > > >  1) inline asm ("...")
> > > > > > 
> > > > > > What would the semantics of this be?
> > > > > 
> > > > > The size of the inline asm wouldn't be counted towards the inliner size 
> > > > > limits (or be counted as "1").
> > > > 
> > > > That sounds like a good option.
> > > 
> > > Yes, I also like it for simplicity.  It also avoids the requirement
> > > of translating the number (in bytes?) given by the user to
> > > "number of GIMPLE instructions" as needed by the inliner.
> > 
> > This patch implements this, for C only so far.  And the syntax is
> > "asm inline", which is more in line with other syntax.
> > 
> > How does this look?
> 
> Looks good.  A few nits - you need to document this in extend.texi, the

Yup.

> tree flag use needs documenting in tree-core.h,

Ah yes.

> and we need a testcase
> (I'd suggest one that shows we inline a function with "large" asm inline 
> () even at -Os).

I have one.  Oh, and I probably should do a comment at the one line of
code that isn't just bookkeeping ;-)

> Oh, and I don't think we want C and C++ to diverge - so you need to
> cook up C++ support as well.

Right, that's why I said "C only so far".

> Can kernel folks give this a second and third thought please so we
> don't implement sth that in the end won't satisfy you guys?

Or actually try it out and see if it has the desired effect!  Nothing
beats field trials.

I'll do the C++ thing today hopefully, and send things to gcc-patches@.


Segher
