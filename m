From: Ingo Molnar <mingo@kernel.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Mon, 8 Oct 2018 08:13:23 +0200
Message-ID: <20181008061323.GB66819@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
	<20181007091805.GA30687@zn.tnic>
	<20181007132228.GJ29268@gate.crashing.org>
	<alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michael Matz <matz@suse.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Christopher Li <sparse@chrisli.org>, virtualization@lists.linux-foundation.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Nadav Amit <namit@vmware.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-sparse@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Segher Boessenkool <segher@kernel.crashing.org>, Chris Zankel <chris@zankel.net>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, gcc@gcc.gnu.org, Richard Biener <rguenther@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-sparse@vger.kernel.org


* Michael Matz <matz@suse.de> wrote:

> (without an built-in assembler which hopefully noone proposes).

There are disadvantages (the main one is having to implement it), but a built-in assembler has 
numerous advantages as well:

 - Better optimizations: for example -Os could more accurately estimate true instruction size.

 - Better inlining: as the examples in this thread are showing.

 - Better padding/alignment: right now GCC has no notion about the precise cache layout of the 
   assembly code it generates and the code alignment options it has are crude. It got away with 
   this so far because the x86 rule of thumb is that dense code is usually the right choice.

 - Better compiler performance: it would be faster as well to immediately emit assembly
   instructions, just like GCC's preprocessor library use speeds up compilation *significantly*
   instead of creating a separate preprocessor task.

 - Better future integration of assembly blocks: GCC could begin to actually understand the 
   assembly statements in inline asm and allow more user-friendly extensions to its 
   historically complex and difficult to master inline asm syntax.

I mean, it's a fact that the GNU project has *already* defined their own assembly syntax which 
departs from decades old platform assembly syntax - and how the assembler is called by the 
compiler is basically an implementation detail, not a conceptual choice. The random 
multi-process unidirectional assembler choice of the past should not be treated as orthodoxy.

Thanks,

	Ingo
