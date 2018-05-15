From: Nadav Amit <namit@vmware.com>
Subject: [RFC 0/8] Improving compiler inlining decisions
Date: Tue, 15 May 2018 07:11:16 -0700
Message-ID: <20180515141124.84254-10-namit@vmware.com>
References: <20180515141124.84254-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180515141124.84254-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: nadav.amit@gmail.com, Nadav Amit <namit@vmware.com>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org, x86@kernel.org
List-Id: linux-sparse@vger.kernel.org

This patch-set deals with an interesting yet stupid problem: code that
does not get inlined despite its simplicity.

I find 5 classes of causes:

1. Inline assembly blocks in which code and data are added to
alternative sections. The compiler is oblivious to the content of the
blocks and assumes their cost in space and time is proportional to the
number of the perceived assembly "instruction", according to the number
of newlines and semicolons. Alternatives, paravirt and other mechanisms
are affected.

2. Inline assembly with redundant new-lines and semicolons. Similarly to
(1) this code is considered "heavier" than it actually is.

3. Code with constant value optimizations. Quite a few parts of the
kernel check whether a variable is constant (using
__builtin_constant_p()) and perform heavy computations in that case.
These computations are eventually optimized out so they do not land in
the binary. However, the cost of these computations is also associated
with the calling function, which might prevent inlining of the calling
function. ilog2() is an example for such case.

4. Code that is marked with the "cold" attribute, including all the
__init functions. Some may consider it the desired behavior.

5. Code that is marked with a different optimization levels. This
affects for example vmx_vcpu_run(), inducing overheads of up to 10% on
exit.


This patch-set deals with some instances of first 3 classes. 

For (1) we insert an assembly macro, and call it from the inline
assembly block.  As a result, the compiler sees a single "instruction"
and assigns the more appropriate cost to the code.

For (2) the solution is trivial: just remove the newlines.

(3) is somewhat tricky. The proposed solution is to use
__builtin_choose_expr() to check whether a variable is actually constant
instead of using an if-condition or the C ternary operator.
__builtin_choose_expr() is evaluated earlier in the compilation, so it
allows the compiler to associate the right cost for the variable case
before the inlining decisions take place.  So far so good.

Still, there is a drawback. Since __builtin_choose_expr() is evaluated
earlier, it can fail to recognize constants, which an if-condition would
recognize correctly.  As a result, this patch-set only applies it to the
simplest cases.

Overall this patch-set slightly increases the kernel size (my build was
done using localmodconfig + localyesconfig for the record):

   text    data     bss     dec     hex filename
18126699 10066728 2936832 31130259 1db0293 ./vmlinux before
18149210 10064048 2936832 31150090 1db500a ./vmlinux after (+0.06%)

The patch-set eliminates many of the static text symbols:
Before: 40033
After:  39632   (-10%)

There is a measurable effect on performance in some cases. A loop of
MADV_DONTNEED/page-fault shows a 2% performance improvement with this
patch-set.

Some inline comments or self-explaining C macros might still be needed.

[1] https://lkml.org/lkml/2018/5/5/159

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

Nadav Amit (8):
  x86: objtool: use asm macro for better compiler decisions
  x86: bug: prevent gcc distortions
  x86: alternative: macrofy locks for better inlining
  x86: prevent inline distortion by paravirt ops
  x86: refcount: prevent gcc distortions
  x86: removing unneeded new-lines
  ilog2: preventing compiler distortion due to big condition
  bitops: prevent compiler inline decision distortion

 arch/x86/include/asm/alternative.h    | 28 ++++++++++----
 arch/x86/include/asm/asm.h            |  4 +-
 arch/x86/include/asm/bitops.h         |  8 ++--
 arch/x86/include/asm/bug.h            | 48 ++++++++++++++---------
 arch/x86/include/asm/cmpxchg.h        | 10 ++---
 arch/x86/include/asm/paravirt_types.h | 53 +++++++++++++++-----------
 arch/x86/include/asm/refcount.h       | 55 ++++++++++++++++-----------
 arch/x86/include/asm/special_insns.h  | 12 +++---
 include/linux/compiler.h              | 29 ++++++++++----
 include/linux/log2.h                  | 11 +++---
 10 files changed, 156 insertions(+), 102 deletions(-)

-- 
2.17.0
