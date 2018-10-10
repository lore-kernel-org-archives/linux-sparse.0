From: Ingo Molnar <mingo@kernel.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Wed, 10 Oct 2018 08:35:36 +0200
Message-ID: <20181010063536.GA124923@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
	<20181007091805.GA30687@zn.tnic>
	<20181007132228.GJ29268@gate.crashing.org>
	<alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
	<20181008073128.GL29268@gate.crashing.org>
	<alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
	<20181009145330.GT29268@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181009145330.GT29268@gate.crashing.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Christopher Li <sparse@chrisli.org>, virtualization@lists.linux-foundation.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Nadav Amit <namit@vmware.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-sparse@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Chris Zankel <chris@zankel.net>, Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, gcc@gcc.gnu.org, Richard Biener <rguenther@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger
List-Id: linux-sparse@vger.kernel.org


* Segher Boessenkool <segher@kernel.crashing.org> wrote:

> On Mon, Oct 08, 2018 at 11:07:46AM +0200, Richard Biener wrote:
> > On Mon, 8 Oct 2018, Segher Boessenkool wrote:
> > > On Sun, Oct 07, 2018 at 03:53:26PM +0000, Michael Matz wrote:
> > > > On Sun, 7 Oct 2018, Segher Boessenkool wrote:
> > > > > On Sun, Oct 07, 2018 at 11:18:06AM +0200, Borislav Petkov wrote:
> > > > > > Now, Richard suggested doing something like:
> > > > > > 
> > > > > >  1) inline asm ("...")
> > > > > 
> > > > > What would the semantics of this be?
> > > > 
> > > > The size of the inline asm wouldn't be counted towards the inliner size 
> > > > limits (or be counted as "1").
> > > 
> > > That sounds like a good option.
> > 
> > Yes, I also like it for simplicity.  It also avoids the requirement
> > of translating the number (in bytes?) given by the user to
> > "number of GIMPLE instructions" as needed by the inliner.
> 
> This patch implements this, for C only so far.  And the syntax is
> "asm inline", which is more in line with other syntax.
> 
> How does this look?

Cool, thanks for implementing this!

In the kernel we'd likely wrap this in some "asm_inline()" type of construct to be
compatible with older toolchains and other compilers.

Thanks,

	Ingo
