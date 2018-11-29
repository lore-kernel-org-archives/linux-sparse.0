From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Thu, 29 Nov 2018 06:25:02 -0600
Message-ID: <20181129122500.GX23873@gate.crashing.org>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr> <20181009145330.GT29268@gate.crashing.org> <CAK7LNARmrdtyE7JRAdJH_zbfvD_cej+TGLh+5KfT20o538KUcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gcc-return-197771-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Content-Disposition: inline
In-Reply-To: <CAK7LNARmrdtyE7JRAdJH_zbfvD_cej+TGLh+5KfT20o538KUcA@mail.gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, rguenther@suse.de, matz@suse.de, Borislav Petkov <bp@alien8.de>, gcc@gcc.gnu.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Philippe Ombredanne <pomb redanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-
List-Id: linux-sparse@vger.kernel.org

On Thu, Nov 29, 2018 at 08:46:34PM +0900, Masahiro Yamada wrote:
> On Wed, Oct 10, 2018 at 1:14 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
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
> 
> Thank you very much for your work.
> 
> 
> https://gcc.gnu.org/ml/gcc-patches/2018-10/msg01932.html
> 
> How is the progress of this in GCC ML?

Latest patch was pinged a few times:
https://gcc.gnu.org/ml/gcc-patches/2018-11/msg01569.html .

I'll ping it again.  Will fix the subject as well if I remember to, sigh.

> I am really hoping the issue will be solved by compiler
> instead of the in-kernel workaround.

This will only be fixed from GCC 9 on, if the compiler adopts it.  The
kernel wants to support ancient GCC, so it will need to have a workaround
for older GCC versions anyway.


Segher
