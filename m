From: Ingo Molnar <mingo@kernel.org>
Subject: [kbuild ack?] Re: [PATCH v6 0/9] x86: macrofying inline asm for
	better compilation
Date: Sun, 15 Jul 2018 23:54:52 +0200
Message-ID: <20180715215452.GA14040@gmail.com>
References: <20180622172212.199633-1-namit@vmware.com>
	<BA4C0931-A51D-41AE-B918-C37EFFF35840@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <BA4C0931-A51D-41AE-B918-C37EFFF35840@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nadav Amit <namit@vmware.com>
Cc: Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christopher Li <sparse@chrisli.org>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>
List-Id: linux-sparse@vger.kernel.org


* Nadav Amit <namit@vmware.com> wrote:

> > I ran some limited number of benchmarks, and in general the performance
> > impact is not very notable. You can still see >10 cycles shaved off some
> > syscalls that manipulate page-tables (e.g., mprotect()), in which
> > paravirt caused many functions not to be inlined. In addition this
> > patch-set can prevent issues such as [1], and improves code readability
> > and maintainability.

Ok, that's good enough as a benefit, I suppose.

> > Nadav Amit (9):
> >  Makefile: Prepare for using macros for inline asm

This non-trivial kbuild patch needs an Acked-by from Masahiro.

Thanks,

	Ingo
