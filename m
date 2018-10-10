From: Richard Biener <rguenther@suse.de>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Wed, 10 Oct 2018 12:29:03 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1810101228180.16707@zhemvz.fhfr.qr>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org> <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr> <20181010072240.GB103159@gmail.com> <20181010080324.GV29268@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010080324.GV29268@gate.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Ingo Molnar <mingo@kernel.org>, Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>, gcc@gcc.gnu.org, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas
List-Id: linux-sparse@vger.kernel.org

On Wed, 10 Oct 2018, Segher Boessenkool wrote:

> On Wed, Oct 10, 2018 at 09:22:40AM +0200, Ingo Molnar wrote:
> > * Richard Biener <rguenther@suse.de> wrote:
> > > Can kernel folks give this a second and third thought please so we
> > > don't implement sth that in the end won't satisfy you guys?
> > 
> > So this basically passes '0 size' to the inliner, which should be better
> > than passing in the explicit size, as we'd inevitably get it wrong
> > in cases.
> 
> The code immediately after this makes it size 1, even for things like
> asm(""), I suppose this works better for the inliner.  But that's a detail
> (and it might change); the description says "consider this asm as minimum
> length and cost for inlining decisions", which works for either 0 or 1.

It was made 1 as otherwise the inliner happily explodes on

void foo () { asm(""); foo(); }

> > I also like 'size 0' for the reason that we tend to write assembly code
> > and mark it 'inline' if we really think it matters to performance,
> > so making it more likely to be inlined when used within another inline
> > function is a plus as well.
> 
> You can think of it as meaning "we want this asm inlined always", and then
> whether that actually happens depends on if the function around it is
> inlined or not.

Richard.
