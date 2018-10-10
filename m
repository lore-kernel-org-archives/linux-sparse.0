From: Ingo Molnar <mingo@kernel.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Wed, 10 Oct 2018 09:22:40 +0200
Message-ID: <20181010072240.GB103159@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
	<20181007091805.GA30687@zn.tnic>
	<20181007132228.GJ29268@gate.crashing.org>
	<alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
	<20181008073128.GL29268@gate.crashing.org>
	<alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
	<20181009145330.GT29268@gate.crashing.org>
	<alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Richard Biener <rguenther@suse.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Christopher Li <sparse@chrisli.org>, virtualization@lists.linux-foundation.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Nadav Amit <namit@vmware.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-sparse@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Segher Boessenkool <segher@kernel.crashing.org>, Chris Zankel <chris@zankel.net>, Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, gcc@gcc.gnu.org, Max Filippov <jcmvbkbc@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>lin
List-Id: linux-sparse@vger.kernel.org


* Richard Biener <rguenther@suse.de> wrote:

> Can kernel folks give this a second and third thought please so we
> don't implement sth that in the end won't satisfy you guys?

So this basically passes '0 size' to the inliner, which should be better
than passing in the explicit size, as we'd inevitably get it wrong
in cases.

I also like 'size 0' for the reason that we tend to write assembly code
and mark it 'inline' if we really think it matters to performance,
so making it more likely to be inlined when used within another inline
function is a plus as well.

Does anyone have any concerns about this?

Thanks,

	Ingo
