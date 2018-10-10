From: Richard Biener <rguenther@suse.de>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Wed, 10 Oct 2018 10:35:54 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1810101034020.16707@zhemvz.fhfr.qr>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org> <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr> <20181010072240.GB103159@gmail.com> <20181010080324.GV29268@gate.crashing.org> <20181010081906.GA5533@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010081906.GA5533@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Ingo Molnar <mingo@kernel.org>, Michael Matz <matz@suse.de>, gcc@gcc.gnu.org, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-Id: linux-sparse@vger.kernel.org

On Wed, 10 Oct 2018, Borislav Petkov wrote:

> On Wed, Oct 10, 2018 at 03:03:25AM -0500, Segher Boessenkool wrote:
> > The code immediately after this makes it size 1, even for things like
> > asm(""), I suppose this works better for the inliner.  But that's a detail
> > (and it might change); the description says "consider this asm as minimum
> > length and cost for inlining decisions", which works for either 0 or 1.
> 
> Thanks for implementing this, much appreciated. If you need people to
> test stuff, lemme know.
> 
> > You can think of it as meaning "we want this asm inlined always", and then
> > whether that actually happens depends on if the function around it is
> > inlined or not.
> 
> My only concern is how we would catch the other extremity where the
> inline asm grows too big and we end up inlining it everywhere and thus
> getting fat. The 0day bot already builds tinyconfigs but we should be
> looking at vmlinux size growth too.

Well, it's like always-inline functions, you have to be careful
and _not_ put it everywhere...  It's also somewhat different to
always-inline functions as those lose their special-ness once
inlined (the inlined body is properly accounted for size).

Richard.
