From: Nadav Amit <namit@vmware.com>
Subject: [PATCH 0/6] Macrofying inline assembly for better compilation
Date: Thu, 17 May 2018 09:13:56 -0700
Message-ID: <20180517161402.78089-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: nadav.amit@gmail.com, Nadav Amit <namit@vmware.com>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org
List-Id: linux-sparse@vger.kernel.org

This patch-set deals with an interesting yet stupid problem: kernel code
that does not get inlined despite its simplicity. There are several
causes for this behavior: "cold" attribute on __init, different function
optimization levels; conditional constant computations based on
__builtin_constant_p(); and finally large inline assembly blocks.

This patch-set deals with the inline assembly problem. I separated these
patches from the others (that were sent in the RFC) for easier
inclusion.

The problem with inline assembly is that inline assembly is often used
by the kernel for things that are other than code - for example,
assembly directives and data. GCC however is oblivious to the content of
the blocks and assumes their cost in space and time is proportional to
the number of the perceived assembly "instruction", according to the
number of newlines and semicolons. Alternatives, paravirt and other
mechanisms are affected, causing code not to be inlined, and degrading
compilation quality in general.

The solution that this patch-set carries for this problem is to create
an assembly macro, and then call it from the inline assembly block.  As
a result, the compiler sees a single "instruction" and assigns the more
appropriate cost to the code. In addition, this patch-set removes
unneeded new-lines from common x86 inline asm's, which "confuse" GCC
heuristics.

Overall this patch-set slightly increases the kernel size (my build was
done using my localmodconfig + localyesconfig for the record):

   text    data     bss     dec     hex filename
18126699 10066728 2936832 31130259 1db0293 ./vmlinux before
18148888 10064016 2936832 31149736 1db4ea8 ./vmlinux after (+0.06%)

The patch-set eliminates many of the static text symbols:
Before: 40033
After:	39650	(-1%)

A microbenchmark with a loop of page-fault and MADV_DONTNEED show 2%
performance improvement with this patch-set (when PTI is off).

Changes from RFC:
- Better formatting [Jan]
- i386 build problems [0-day]
- Inline comments
- Separating __builtin_constant_p() into a different future patch-set

Cc: Alok Kataria <akataria@vmware.com>
Cc: Christopher Li <sparse@chrisli.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jan Beulich <JBeulich@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-sparse@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: virtualization@lists.linux-foundation.org
Cc: x86@kernel.org

Nadav Amit (6):
  x86: objtool: use asm macro for better compiler decisions
  x86: bug: prevent gcc distortions
  x86: alternative: macrofy locks for better inlining
  x86: prevent inline distortion by paravirt ops
  x86: refcount: prevent gcc distortions
  x86: removing unneeded new-lines

 arch/x86/include/asm/alternative.h    | 34 +++++++++++----
 arch/x86/include/asm/asm.h            |  4 +-
 arch/x86/include/asm/bug.h            | 56 ++++++++++++++++--------
 arch/x86/include/asm/cmpxchg.h        | 10 ++---
 arch/x86/include/asm/paravirt_types.h | 63 +++++++++++++++++----------
 arch/x86/include/asm/refcount.h       | 62 ++++++++++++++++----------
 arch/x86/include/asm/special_insns.h  | 12 ++---
 include/linux/compiler.h              | 37 ++++++++++++----
 8 files changed, 183 insertions(+), 95 deletions(-)

-- 
2.17.0
