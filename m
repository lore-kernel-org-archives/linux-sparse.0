From: Borislav Petkov <bp@alien8.de>
Subject: PROPOSAL: Extend inline asm syntax with size spec
Date: Sun, 7 Oct 2018 11:18:06 +0200
Message-ID: <20181007091805.GA30687@zn.tnic>
References: <20181003213100.189959-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181003213100.189959-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gcc@gcc.gnu.org, Richard Biener <rguenther@suse.de>, Michael Matz <matz@suse.de>
Cc: Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foun>
List-Id: linux-sparse@vger.kernel.org

Hi people,

this is an attempt to see whether gcc's inline asm heuristic when
estimating inline asm statements' cost for better inlining can be
improved.

AFAIU, the problematic arises when one ends up using a lot of inline
asm statements in the kernel but due to the inline asm cost estimation
heuristic which counts lines, I think, for example like in this here
macro:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/include/asm/cpufeature.h#n162

the resulting code ends up not inlining the functions themselves which
use this macro. I.e., you see a CALL <function> instead of its body
getting inlined directly.

Even though it should be because the actual instructions are only a
couple in most cases and all those other directives end up in another
section anyway.

The issue is explained below in the forwarded mail in a larger detail
too.

Now, Richard suggested doing something like:

 1) inline asm ("...")
 2) asm ("..." : : : : <size-expr>)
 3) asm ("...") __attribute__((asm_size(<size-expr>)));

with which user can tell gcc what the size of that inline asm statement
is and thus allow for more precise cost estimation and in the end better
inlining.

And FWIW 3) looks pretty straight-forward to me because attributes are
pretty common anyways.

But I'm sure there are other options and I'm sure people will have
better/different ideas so feel free to chime in.

Thx.

On Wed, Oct 03, 2018 at 02:30:50PM -0700, Nadav Amit wrote:
> This patch-set deals with an interesting yet stupid problem: kernel code
> that does not get inlined despite its simplicity. There are several
> causes for this behavior: "cold" attribute on __init, different function
> optimization levels; conditional constant computations based on
> __builtin_constant_p(); and finally large inline assembly blocks.
> 
> This patch-set deals with the inline assembly problem. I separated these
> patches from the others (that were sent in the RFC) for easier
> inclusion. I also separated the removal of unnecessary new-lines which
> would be sent separately.
> 
> The problem with inline assembly is that inline assembly is often used
> by the kernel for things that are other than code - for example,
> assembly directives and data. GCC however is oblivious to the content of
> the blocks and assumes their cost in space and time is proportional to
> the number of the perceived assembly "instruction", according to the
> number of newlines and semicolons. Alternatives, paravirt and other
> mechanisms are affected, causing code not to be inlined, and degrading
> compilation quality in general.
> 
> The solution that this patch-set carries for this problem is to create
> an assembly macro, and then call it from the inline assembly block.  As
> a result, the compiler sees a single "instruction" and assigns the more
> appropriate cost to the code.
> 
> To avoid uglification of the code, as many noted, the macros are first
> precompiled into an assembly file, which is later assembled together
> with the C files. This also enables to avoid duplicate implementation
> that was set before for the asm and C code. This can be seen in the
> exception table changes.
> 
> Overall this patch-set slightly increases the kernel size (my build was
> done using my Ubuntu 18.04 config + localyesconfig for the record):
> 
>    text	   data	    bss	    dec	    hex	filename
> 18140829 10224724 2957312 31322865 1ddf2f1 ./vmlinux before
> 18163608 10227348 2957312 31348268 1de562c ./vmlinux after (+0.1%)
> 
> The number of static functions in the image is reduced by 379, but
> actually inlining is even better, which does not always shows in these
> numbers: a function may be inlined causing the calling function not to
> be inlined.
> 
> I ran some limited number of benchmarks, and in general the performance
> impact is not very notable. You can still see >10 cycles shaved off some
> syscalls that manipulate page-tables (e.g., mprotect()), in which
> paravirt caused many functions not to be inlined. In addition this
> patch-set can prevent issues such as [1], and improves code readability
> and maintainability.
> 
> Update: Rasmus recently caused me (inadvertently) to become paranoid
> about the dependencies. To clarify: if any of the headers changes, any c
> file which uses macros that are included in macros.S would be fine as
> long as it includes the header as well (as it should). Adding an
> assertion to check this is done might become slightly ugly, and nobody
> else is concerned about it. Another minor issue is that changes of
> macros.S would not trigger a global rebuild, but that is pretty similar
> to changes of the Makefile that do not trigger a rebuild.
> 
> [1] https://patchwork.kernel.org/patch/10450037/
> 
> v8->v9: * Restoring the '-pipe' parameter (Rasmus)
> 	* Adding Kees's tested-by tag (Kees)
> 
> v7->v8:	* Add acks (Masahiro, Max)
> 	* Rebase on 4.19 (Ingo)
> 
> v6->v7: * Fix context switch tracking (Ingo)
> 	* Fix xtensa build error (Ingo)
> 	* Rebase on 4.18-rc8
> 
> v5->v6:	* Removing more code from jump-labels (PeterZ)
> 	* Fix build issue on i386 (0-day, PeterZ)
> 
> v4->v5:	* Makefile fixes (Masahiro, Sam)
> 
> v3->v4: * Changed naming of macros in 2 patches (PeterZ)
> 	* Minor cleanup of the paravirt patch
> 
> v2->v3: * Several build issues resolved (0-day)
> 	* Wrong comments fix (Josh)
> 	* Change asm vs C order in refcount (Kees)
> 
> v1->v2:	* Compiling the macros into a separate .s file, improving
> 	  readability (Linus)
> 	* Improving assembly formatting, applying most of the comments
> 	  according to my judgment (Jan)
> 	* Adding exception-table, cpufeature and jump-labels
> 	* Removing new-line cleanup; to be submitted separately
> 
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
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> 
> Nadav Amit (10):
>   xtensa: defining LINKER_SCRIPT for the linker script
>   Makefile: Prepare for using macros for inline asm
>   x86: objtool: use asm macro for better compiler decisions
>   x86: refcount: prevent gcc distortions
>   x86: alternatives: macrofy locks for better inlining
>   x86: bug: prevent gcc distortions
>   x86: prevent inline distortion by paravirt ops
>   x86: extable: use macros instead of inline assembly
>   x86: cpufeature: use macros instead of inline assembly
>   x86: jump-labels: use macros instead of inline assembly
> 
>  Makefile                               |  9 ++-
>  arch/x86/Makefile                      |  7 ++
>  arch/x86/entry/calling.h               |  2 +-
>  arch/x86/include/asm/alternative-asm.h | 20 ++++--
>  arch/x86/include/asm/alternative.h     | 11 +--
>  arch/x86/include/asm/asm.h             | 61 +++++++---------
>  arch/x86/include/asm/bug.h             | 98 +++++++++++++++-----------
>  arch/x86/include/asm/cpufeature.h      | 82 ++++++++++++---------
>  arch/x86/include/asm/jump_label.h      | 77 ++++++++------------
>  arch/x86/include/asm/paravirt_types.h  | 56 +++++++--------
>  arch/x86/include/asm/refcount.h        | 74 +++++++++++--------
>  arch/x86/kernel/macros.S               | 16 +++++
>  arch/xtensa/kernel/Makefile            |  4 +-
>  include/asm-generic/bug.h              |  8 +--
>  include/linux/compiler.h               | 56 +++++++++++----
>  scripts/Kbuild.include                 |  4 +-
>  scripts/mod/Makefile                   |  2 +
>  17 files changed, 331 insertions(+), 256 deletions(-)
>  create mode 100644 arch/x86/kernel/macros.S
> 
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
