From: Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v6 0/9] x86: macrofying inline asm for better compilation
Date: Wed, 11 Jul 2018 01:59:49 +0000
Message-ID: <BA4C0931-A51D-41AE-B918-C37EFFF35840@vmware.com>
References: <20180622172212.199633-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180622172212.199633-1-namit@vmware.com>
Content-Language: en-US
Content-ID: <8CFB5CE65CBFE64CB34D20BD84B183DC@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-sparse@vger.kernel.org

at 1:22 PM, Nadav Amit <namit@vmware.com> wrote:

> This patch-set deals with an interesting yet stupid problem: kernel code
> that does not get inlined despite its simplicity. There are several
> causes for this behavior: "cold" attribute on __init, different function
> optimization levels; conditional constant computations based on
> __builtin_constant_p(); and finally large inline assembly blocks.
>=20
> This patch-set deals with the inline assembly problem. I separated these
> patches from the others (that were sent in the RFC) for easier
> inclusion. I also separated the removal of unnecessary new-lines which
> would be sent separately.
>=20
> The problem with inline assembly is that inline assembly is often used
> by the kernel for things that are other than code - for example,
> assembly directives and data. GCC however is oblivious to the content of
> the blocks and assumes their cost in space and time is proportional to
> the number of the perceived assembly "instruction", according to the
> number of newlines and semicolons. Alternatives, paravirt and other
> mechanisms are affected, causing code not to be inlined, and degrading
> compilation quality in general.
>=20
> The solution that this patch-set carries for this problem is to create
> an assembly macro, and then call it from the inline assembly block.  As
> a result, the compiler sees a single "instruction" and assigns the more
> appropriate cost to the code.
>=20
> To avoid uglification of the code, as many noted, the macros are first
> precompiled into an assembly file, which is later assembled together
> with the C files. This also enables to avoid duplicate implementation
> that was set before for the asm and C code. This can be seen in the
> exception table changes.
>=20
> Overall this patch-set slightly increases the kernel size (my build was
> done using my Ubuntu 18.04 config + localyesconfig for the record):
>=20
>   text	   data	    bss	    dec	    hex	filename
> 18140829 10224724 2957312 31322865 1ddf2f1 ./vmlinux before
> 18163608 10227348 2957312 31348268 1de562c ./vmlinux after (+0.1%)
>=20
> The number of static functions in the image is reduced by 379, but
> actually inlining is even better, which does not always shows in these
> numbers: a function may be inlined causing the calling function not to
> be inlined.
>=20
> I ran some limited number of benchmarks, and in general the performance
> impact is not very notable. You can still see >10 cycles shaved off some
> syscalls that manipulate page-tables (e.g., mprotect()), in which
> paravirt caused many functions not to be inlined. In addition this
> patch-set can prevent issues such as [1], and improves code readability
> and maintainability.
>=20
> [1] https://patchwork.kernel.org/patch/10450037/
>=20
> v5->v6:	* Removing more code from jump-labels (PeterZ)
> 	* Fix build issue on i386 (0-day, PeterZ)
>=20
> v4->v5:	* Makefile fixes (Masahiro, Sam)
>=20
> v3->v4: * Changed naming of macros in 2 patches (PeterZ)
> 	* Minor cleanup of the paravirt patch
>=20
> v2->v3: * Several build issues resolved (0-day)
> 	* Wrong comments fix (Josh)
> 	* Change asm vs C order in refcount (Kees)
>=20
> v1->v2:	* Compiling the macros into a separate .s file, improving
> 	  readability (Linus)
> 	* Improving assembly formatting, applying most of the comments
> 	  according to my judgment (Jan)
> 	* Adding exception-table, cpufeature and jump-labels
> 	* Removing new-line cleanup; to be submitted separately
>=20
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alok Kataria <akataria@vmware.com>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jan Beulich <JBeulich@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: linux-sparse@vger.kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: virtualization@lists.linux-foundation.org
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: x86@kernel.org
>=20
>=20
> Nadav Amit (9):
>  Makefile: Prepare for using macros for inline asm
>  x86: objtool: use asm macro for better compiler decisions
>  x86: refcount: prevent gcc distortions
>  x86: alternatives: macrofy locks for better inlining
>  x86: bug: prevent gcc distortions
>  x86: prevent inline distortion by paravirt ops
>  x86: extable: use macros instead of inline assembly
>  x86: cpufeature: use macros instead of inline assembly
>  x86: jump-labels: use macros instead of inline assembly
>=20
> Makefile                               |  9 ++-
> arch/x86/Makefile                      | 11 ++-
> arch/x86/entry/calling.h               |  2 +-
> arch/x86/include/asm/alternative-asm.h | 20 ++++--
> arch/x86/include/asm/alternative.h     | 11 +--
> arch/x86/include/asm/asm.h             | 61 +++++++---------
> arch/x86/include/asm/bug.h             | 98 +++++++++++++++-----------
> arch/x86/include/asm/cpufeature.h      | 82 ++++++++++++---------
> arch/x86/include/asm/jump_label.h      | 77 ++++++++------------
> arch/x86/include/asm/paravirt_types.h  | 56 +++++++--------
> arch/x86/include/asm/refcount.h        | 74 +++++++++++--------
> arch/x86/kernel/macros.S               | 16 +++++
> include/asm-generic/bug.h              |  8 +--
> include/linux/compiler.h               | 56 +++++++++++----
> scripts/Kbuild.include                 |  4 +-
> scripts/mod/Makefile                   |  2 +
> 16 files changed, 331 insertions(+), 256 deletions(-)
> create mode 100644 arch/x86/kernel/macros.S
>=20
> --=20
> 2.17.1

Ping?
