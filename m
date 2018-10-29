From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Date: Mon, 29 Oct 2018 22:03:38 +0900
Message-ID: <CAK7LNASiGPar_Aj1KDu8E+S=NKRf7mEJ8gwe2=OMUGggZmtfNQ@mail.gmail.com>
References: <20181028130945.23581-1-changbin.du@gmail.com> <20181028130945.23581-3-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181028130945.23581-3-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Michal Marek <michal.lkml@markovi.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-sparse@vger.kernel.org

On Sun, Oct 28, 2018 at 10:13 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting


I fixed "This patch add ..." to "This patch adds ..."
then applied to linux-kbuild.




> this option will prevent the compiler from optimizing the kernel by
> auto-inlining functions not marked with the inline keyword.
>
> With this option, only functions explicitly marked with "inline" will
> be inlined. This will allow the function tracer to trace more functions
> because it only traces functions that the compiler has not inlined.
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  Makefile          |  6 ++++++
>  lib/Kconfig.debug | 17 +++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 7d4ba5196010..04beb822ddfc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -749,6 +749,12 @@ KBUILD_CFLAGS      += $(call cc-option, -femit-struct-debug-baseonly) \
>                    $(call cc-option,-fno-var-tracking)
>  endif
>
> +ifdef CONFIG_NO_AUTO_INLINE
> +KBUILD_CFLAGS   += $(call cc-option, -fno-inline-functions) \
> +                  $(call cc-option, -fno-inline-small-functions) \
> +                  $(call cc-option, -fno-inline-functions-called-once)
> +endif
> +
>  ifdef CONFIG_FUNCTION_TRACER
>  ifdef CONFIG_FTRACE_MCOUNT_RECORD
>    # gcc 5 supports generating the mcount tables directly
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 04adfc3b185e..d50711b41dad 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -211,6 +211,23 @@ config GDB_SCRIPTS
>           instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
>           for further details.
>
> +config NO_AUTO_INLINE
> +       bool "Disable compiler auto-inline optimizations"
> +       help
> +         This will prevent the compiler from optimizing the kernel by
> +         auto-inlining functions not marked with the inline keyword.
> +         With this option, only functions explicitly marked with
> +         "inline" will be inlined. This will allow the function tracer
> +         to trace more functions because it only traces functions that
> +         the compiler has not inlined.
> +
> +         Enabling this function can help debugging a kernel if using
> +         the function tracer. But it can also change how the kernel
> +         works, because inlining functions may change the timing,
> +         which could make it difficult while debugging race conditions.
> +
> +         If unsure, select N.
> +
>  config ENABLE_MUST_CHECK
>         bool "Enable __must_check logic"
>         default y
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
