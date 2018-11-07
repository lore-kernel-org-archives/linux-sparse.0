From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v10 09/22] kasan: add tag related helper functions
Date: Wed, 7 Nov 2018 17:23:08 +0000
Message-ID: <20181107172306.3w2pjecaggsvl5z2@lakrids.cambridge.arm.com>
References: <cover.1541525354.git.andreyknvl@google.com>
 <b8c56d36b79eecf0c331a0a7a2df12632aefccc9.1541525354.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b8c56d36b79eecf0c331a0a7a2df12632aefccc9.1541525354.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kste>
List-Id: linux-sparse@vger.kernel.org

On Tue, Nov 06, 2018 at 06:30:24PM +0100, Andrey Konovalov wrote:
> This commit adds a few helper functions, that are meant to be used to
> work with tags embedded in the top byte of kernel pointers: to set, to
> get or to reset (set to 0xff) the top byte.
> 
> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/mm/kasan_init.c |  2 ++
>  include/linux/kasan.h      | 13 +++++++++
>  mm/kasan/kasan.h           | 55 ++++++++++++++++++++++++++++++++++++++
>  mm/kasan/tags.c            | 37 +++++++++++++++++++++++++
>  4 files changed, 107 insertions(+)
> 
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 18ebc8994a7b..370b19d0e2fb 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -249,6 +249,8 @@ void __init kasan_init(void)
>  	memset(kasan_zero_page, KASAN_SHADOW_INIT, PAGE_SIZE);
>  	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
>  
> +	kasan_init_tags();
> +
>  	/* At this point kasan is fully initialized. Enable error messages */
>  	init_task.kasan_depth = 0;
>  	pr_info("KernelAddressSanitizer initialized\n");
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 7f6574c35c62..4c9d6f9029f2 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -169,6 +169,19 @@ static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
>  
>  #define KASAN_SHADOW_INIT 0xFF
>  
> +void kasan_init_tags(void);
> +
> +void *kasan_reset_tag(const void *addr);
> +
> +#else /* CONFIG_KASAN_SW_TAGS */
> +
> +static inline void kasan_init_tags(void) { }
> +
> +static inline void *kasan_reset_tag(const void *addr)
> +{
> +	return (void *)addr;
> +}
> +

> +#ifdef CONFIG_KASAN_SW_TAGS
> +
> +#define KASAN_PTR_TAG_SHIFT 56
> +#define KASAN_PTR_TAG_MASK (0xFFUL << KASAN_PTR_TAG_SHIFT)
> +
> +u8 random_tag(void);
> +
> +static inline void *set_tag(const void *addr, u8 tag)
> +{
> +	u64 a = (u64)addr;
> +
> +	a &= ~KASAN_PTR_TAG_MASK;
> +	a |= ((u64)tag << KASAN_PTR_TAG_SHIFT);
> +
> +	return (void *)a;
> +}
> +
> +static inline u8 get_tag(const void *addr)
> +{
> +	return (u8)((u64)addr >> KASAN_PTR_TAG_SHIFT);
> +}
> +
> +static inline void *reset_tag(const void *addr)
> +{
> +	return set_tag(addr, KASAN_TAG_KERNEL);
> +}

We seem to be duplicating this functionality in several places.

Could we please make it so that the arch code defines macros:

arch_kasan_set_tag(addr, tag)
arch_kasan_get_tag(addr)
arch_kasan_reset_tag(addr)

... and use thoses consistently rather than open-coding them?

> +
> +#else /* CONFIG_KASAN_SW_TAGS */
> +
> +static inline u8 random_tag(void)
> +{
> +	return 0;
> +}
> +
> +static inline void *set_tag(const void *addr, u8 tag)
> +{
> +	return (void *)addr;
> +}
> +
> +static inline u8 get_tag(const void *addr)
> +{
> +	return 0;
> +}
> +
> +static inline void *reset_tag(const void *addr)
> +{
> +	return (void *)addr;
> +}

... these can be defined in linux/kasan.h as:

#define arch_kasan_set_tag(addr, tag)	(addr)
#define arch_kasan_get_tag(addr)	0
#define arch_kasan_reset_tag(addr)	(addr)

Thanks,
Mark.
