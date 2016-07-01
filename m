From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 1/2] arm64: implement FTRACE_WITH_REGS
Date: Fri, 1 Jul 2016 07:53:44 -0500
Message-ID: <20160701125344.usuovsvbpilzen4m@treble>
References: <20160627151500.2247A68D20@newverein.lst.de>
 <20160627151717.BD25468D26@newverein.lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37269 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbcGAMxt (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 1 Jul 2016 08:53:49 -0400
Content-Disposition: inline
In-Reply-To: <20160627151717.BD25468D26@newverein.lst.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Torsten Duwe <duwe@lst.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, takahiro.akashi@linaro.org, Jungseok Lee <jungseoklee85@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Li Bin <huawei.libin@huawei.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Christopher Li <sparse@chrisli.org>, Jiri Kosina <jikos@kernel.org>, andrew.wafaa@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org

On Mon, Jun 27, 2016 at 05:17:17PM +0200, Torsten Duwe wrote:
> Once gcc is enhanced to optionally generate NOPs at the beginning
> of each function, like the concept proven in
> https://gcc.gnu.org/ml/gcc-patches/2016-04/msg01671.html
> (sans the "fprintf (... pad_size);", which spoils the data structure
> for kernel use), the generated pads can nicely be used to reroute
> function calls for tracing/profiling, or live patching.
> 
> The pads look like
> fffffc00081335f0 <hrtimer_init>:
> fffffc00081335f0:       d503201f        nop
> fffffc00081335f4:       d503201f        nop
> fffffc00081335f8:       a9bd7bfd        stp     x29, x30, [sp,#-48]!
> fffffc00081335fc:       910003fd        mov     x29, sp
> [...]
> 
> This patch gets the pad locations from the compiler-generated
> __prolog_pads_loc into the _mcount_loc array, and provides the
> code patching functions to turn the pads at runtime into
> 
> fffffc00081335f0     mov     x9, x30
> fffffc00081335f4     bl      0xfffffc00080a08c0 <ftrace_caller>
> fffffc00081335f8     stp     x29, x30, [sp,#-48]!
> fffffc00081335fc     mov     x29, sp
> 
> as well as an ftrace_caller that can handle these call sites.
> Now ARCH_SUPPORTS_FTRACE_OPS as a benefit, and the graph caller
> still works, too.
> 
> Signed-off-by: Li Bin <huawei.libin@huawei.com>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> ---
>  arch/arm64/Kconfig                |  1 +
>  arch/arm64/Makefile               |  4 ++
>  arch/arm64/include/asm/ftrace.h   |  8 ++++
>  arch/arm64/kernel/Makefile        |  6 +--
>  arch/arm64/kernel/entry-ftrace.S  | 89 +++++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/ftrace.c        | 43 +++++++++++++++++--
>  include/asm-generic/vmlinux.lds.h |  2 +-
>  include/linux/compiler.h          |  4 ++
>  8 files changed, 150 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5a0a691..36a0e26 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -72,6 +72,7 @@ config ARM64
>  	select HAVE_DMA_API_DEBUG
>  	select HAVE_DMA_CONTIGUOUS
>  	select HAVE_DYNAMIC_FTRACE
> +	select HAVE_DYNAMIC_FTRACE_WITH_REGS
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_FUNCTION_TRACER
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 648a32c..e5e335c 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -35,6 +35,10 @@ KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
>  KBUILD_CFLAGS	+= $(call cc-option, -mpc-relative-literal-loads)
>  KBUILD_AFLAGS	+= $(lseinstr)
>  
> +ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS), y)
> +CC_FLAGS_FTRACE := -fprolog-pad=2 -DCC_USING_PROLOG_PAD
> +endif
> +

It would probably be good to print a warning for older gccs which don't
support this option, so that when the build fails, there's at least a
warning to indicate why.  Something like:

  ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
    CC_FLAGS_FTRACE := -fprolog-pad=2 -DCC_USING_PROLOG_PAD
    ifeq ($(call cc-option,-fprolog-pad=2),)
      $(warning Cannot use CONFIG_DYNAMIC_FTRACE_WITH_REGS: \
               -fprolog-pad not supported by compiler)
    endif
  endif

-- 
Josh
