From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v10 12/22] kasan, arm64: fix up fault handling logic
Date: Thu, 8 Nov 2018 12:22:29 +0000
Message-ID: <20181108122228.xqwhpkjritrvqneq@lakrids.cambridge.arm.com>
References: <cover.1541525354.git.andreyknvl@google.com>
 <4891a504adf61c0daf1e83642b6f7519328dfd5f.1541525354.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4891a504adf61c0daf1e83642b6f7519328dfd5f.1541525354.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kste>
List-Id: linux-sparse@vger.kernel.org

On Tue, Nov 06, 2018 at 06:30:27PM +0100, Andrey Konovalov wrote:
> show_pte in arm64 fault handling relies on the fact that the top byte of
> a kernel pointer is 0xff, which isn't always the case with tag-based
> KASAN.

That's for the TTBR1 check, right?

i.e. for the following to work:

	if (addr >= VA_START)

... we need the tag bits to be an extension of bit 55...

> 
> This patch resets the top byte in show_pte.
> 
> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/mm/fault.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 7d9571f4ae3d..d9a84d6f3343 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -32,6 +32,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/preempt.h>
>  #include <linux/hugetlb.h>
> +#include <linux/kasan.h>
>  
>  #include <asm/bug.h>
>  #include <asm/cmpxchg.h>
> @@ -141,6 +142,8 @@ void show_pte(unsigned long addr)
>  	pgd_t *pgdp;
>  	pgd_t pgd;
>  
> +	addr = (unsigned long)kasan_reset_tag((void *)addr);

... but this ORs in (0xffUL << 56), which is not correct for addresses
which aren't TTBR1 addresses to begin with, where bit 55 is clear, and
throws away useful information.

We could use untagged_addr() here, but that wouldn't be right for
kernels which don't use TBI1, and we'd erroneously report addresses
under the TTBR1 range as being in the TTBR1 range.

I also see that the entry assembly for el{1,0}_{da,ia} clears the tag
for EL0 addresses.

So we could have:

static inline bool is_ttbr0_addr(unsigned long addr)
{
	/* entry assembly clears tags for TTBR0 addrs */
	return addr < TASK_SIZE_64;
}

static inline bool is_ttbr1_addr(unsigned long addr)
{
	/* TTBR1 addresses may have a tag if HWKASAN is in use */
	return arch_kasan_reset_tag(addr) >= VA_START;
}

... and use those in the conditionals, leaving the addr as-is for
reporting purposes.

Thanks,
Mark.
