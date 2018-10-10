From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Wed, 10 Oct 2018 03:03:25 -0500
Message-ID: <20181010080324.GV29268@gate.crashing.org>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr> <20181009145330.GT29268@gate.crashing.org> <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr> <20181010072240.GB103159@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gcc-return-197394-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Content-Disposition: inline
In-Reply-To: <20181010072240.GB103159@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Richard Biener <rguenther@suse.de>, Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>, gcc@gcc.gnu.org, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-sparse@vger.kernel.org

On Wed, Oct 10, 2018 at 09:22:40AM +0200, Ingo Molnar wrote:
> * Richard Biener <rguenther@suse.de> wrote:
> > Can kernel folks give this a second and third thought please so we
> > don't implement sth that in the end won't satisfy you guys?
> 
> So this basically passes '0 size' to the inliner, which should be better
> than passing in the explicit size, as we'd inevitably get it wrong
> in cases.

The code immediately after this makes it size 1, even for things like
asm(""), I suppose this works better for the inliner.  But that's a detail
(and it might change); the description says "consider this asm as minimum
length and cost for inlining decisions", which works for either 0 or 1.

> I also like 'size 0' for the reason that we tend to write assembly code
> and mark it 'inline' if we really think it matters to performance,
> so making it more likely to be inlined when used within another inline
> function is a plus as well.

You can think of it as meaning "we want this asm inlined always", and then
whether that actually happens depends on if the function around it is
inlined or not.


Segher
