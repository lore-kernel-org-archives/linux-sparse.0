From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v2 2/2] arm64: implement live patching
Date: Fri, 15 Jul 2016 12:03:08 -0400
Message-ID: <CAP=VYLocwooC+4oODKU6ER5v+cTo3oH6ReKC3VwD-juwvfpErw@mail.gmail.com>
References: <20160627151500.2247A68D20@newverein.lst.de> <20160627151722.B81C968D29@newverein.lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20160627151722.B81C968D29@newverein.lst.de>
Sender: linux-arch-owner@vger.kernel.org
To: Torsten Duwe <duwe@lst.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, takahiro.akashi@linaro.org, Jungseok Lee <jungseoklee85@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Li Bin <huawei.libin@huawei.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Christopher Li <sparse@chrisli.org>, Jiri Kosina <jikos@kernel.org>, andrew.wafaa@arm.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, live-patching@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Mon, Jun 27, 2016 at 11:17 AM, Torsten Duwe <duwe@lst.de> wrote:
> On top of FTRACE_WITH_REGS and the klp changes that go into v4.7
> this is straightforward.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> ---
>  arch/arm64/Kconfig                 |  3 +++
>  arch/arm64/include/asm/livepatch.h | 37 +++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/entry-ftrace.S   | 13 +++++++++++++
>  3 files changed, 53 insertions(+)
>  create mode 100644 arch/arm64/include/asm/livepatch.h
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 36a0e26..cb5adf3 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -80,6 +80,7 @@ config ARM64
>         select HAVE_GENERIC_DMA_COHERENT
>         select HAVE_HW_BREAKPOINT if PERF_EVENTS
>         select HAVE_IRQ_TIME_ACCOUNTING
> +       select HAVE_LIVEPATCH
>         select HAVE_MEMBLOCK
>         select HAVE_MEMBLOCK_NODE_MAP if NUMA
>         select HAVE_PATA_PLATFORM
> @@ -1042,4 +1043,6 @@ if CRYPTO
>  source "arch/arm64/crypto/Kconfig"
>  endif
>
> +source "kernel/livepatch/Kconfig"
> +
>  source "lib/Kconfig"
> diff --git a/arch/arm64/include/asm/livepatch.h b/arch/arm64/include/asm/livepatch.h
> new file mode 100644
> index 0000000..6b9a3d1
> --- /dev/null
> +++ b/arch/arm64/include/asm/livepatch.h
> @@ -0,0 +1,37 @@
> +/*
> + * livepatch.h - arm64-specific Kernel Live Patching Core
> + *
> + * Copyright (C) 2016 SUSE
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef _ASM_ARM64_LIVEPATCH_H
> +#define _ASM_ARM64_LIVEPATCH_H
> +
> +#include <linux/module.h>
> +#include <linux/ftrace.h>

These includes don't look right.  It would seem all you need is the one
for struct pt_regs.

Paul.
--

> +
> +#ifdef CONFIG_LIVEPATCH
> +static inline int klp_check_compiler_support(void)
> +{
> +       return 0;
> +}
> +
> +static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
> +{
> +       regs->pc = ip;
> +}
> +#endif /* CONFIG_LIVEPATCH */
> +
> +#endif /* _ASM_ARM64_LIVEPATCH_H */
> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> index 3ebe791..b166cbf 100644
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -204,6 +204,9 @@ ENTRY(ftrace_caller)
>         str     x9, [sp, #S_LR]
>         /* The program counter just after the ftrace call site */
>         str     lr, [sp, #S_PC]
> +#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
> +       mov     x19,lr          /* remember old return address */
> +#endif
>         /* The stack pointer as it was on ftrace_caller entry... */
>         add     x29, sp, #S_FRAME_SIZE+16       /* ...is also our new FP */
>         str     x29, [sp, #S_SP]
> @@ -219,6 +222,16 @@ ftrace_call:
>
>         bl      ftrace_stub
>
> +#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
> +       /* Is the trace function a live patcher an has messed with
> +        * the return address?
> +       */
> +       ldr     x9, [sp, #S_PC]
> +       cmp     x9, x19         /* compare with the value we remembered */
> +       /* to not call graph tracer's "call" mechanism twice! */
> +       b.eq    ftrace_regs_return
> +#endif
> +
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>         .global ftrace_graph_call
>  ftrace_graph_call:                     // ftrace_graph_caller();
> --
> 2.6.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
