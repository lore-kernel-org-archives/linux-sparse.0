From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v8 00/10] x86: macrofying inline asm for better compilation
Date: Fri, 21 Sep 2018 11:26:38 -0700
Message-ID: <CAGXu5jK307b+bs6h-1f6dhRCj3HfoQQmbACuurOE9RbhzijHAQ@mail.gmail.com>
References: <20180918212847.199085-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180918212847.199085-1-namit@vmware.com>
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Christopher Li <sparse@chrisli.org>, virtualization@lists.linux-foundation.org, Max Filippov <jcmvbkbc@gmail.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, linux-xtensa@linux-xtensa.org, Josh Poimboeuf <jpoimboe@redhat.com>, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, Chris Zankel <chris@zankel.net>, Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-sparse@vger.kernel.org

On Tue, Sep 18, 2018 at 2:28 PM, Nadav Amit <namit@vmware.com> wrote:
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
>    text    data     bss     dec     hex filename
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
> [1] https://patchwork.kernel.org/patch/10450037/
>
> v7->v8: * Add acks (Masahiro, Max)
>         * Rebase on 4.19 (Ingo)

I've tested the series for booting and with the refcount lkdtm tests.
Looks good, thanks!

Tested-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
