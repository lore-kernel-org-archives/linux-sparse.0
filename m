From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v10 06/22] kasan, arm64: adjust shadow size for tag-based
 mode
Date: Wed, 7 Nov 2018 16:54:38 +0000
Message-ID: <20181107165438.34kb5ufoe5ve2f6i@lakrids.cambridge.arm.com>
References: <cover.1541525354.git.andreyknvl@google.com>
 <86d1b17c755d8bfd6e44e6869a16f4a409e7bd06.1541525354.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <86d1b17c755d8bfd6e44e6869a16f4a409e7bd06.1541525354.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kste>
List-Id: linux-sparse@vger.kernel.org

Hi Andrey,

On Tue, Nov 06, 2018 at 06:30:21PM +0100, Andrey Konovalov wrote:
> Tag-based KASAN uses 1 shadow byte for 16 bytes of kernel memory, so it
> requires 1/16th of the kernel virtual address space for the shadow memory.
> 
> This commit sets KASAN_SHADOW_SCALE_SHIFT to 4 when the tag-based KASAN
> mode is enabled.
> 
> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/Makefile             |  2 +-
>  arch/arm64/include/asm/memory.h | 13 +++++++++----
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6cb9fc7e9382..9887492381d9 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -94,7 +94,7 @@ endif
>  # KASAN_SHADOW_OFFSET = VA_START + (1 << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
>  #				 - (1 << (64 - KASAN_SHADOW_SCALE_SHIFT))
>  # in 32-bit arithmetic
> -KASAN_SHADOW_SCALE_SHIFT := 3
> +KASAN_SHADOW_SCALE_SHIFT := $(if $(CONFIG_KASAN_SW_TAGS), 4, 3)


We could make this something like:

ifeq ($(CONFIG_KASAN_SW_TAGS), y)
KASAN_SHADOW_SCALE_SHIFT := 4
else
KASAN_SHADOW_SCALE_SHIFT := 3
endif

KBUILD_CFLAGS += -DKASAN_SHADOW_SCALE_SHIFT=$(KASAN_SHADOW_SCALE_SHIFT)

>  KASAN_SHADOW_OFFSET := $(shell printf "0x%08x00000000\n" $$(( \
>  	(0xffffffff & (-1 << ($(CONFIG_ARM64_VA_BITS) - 32))) \
>  	+ (1 << ($(CONFIG_ARM64_VA_BITS) - 32 - $(KASAN_SHADOW_SCALE_SHIFT))) \
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b96442960aea..0f1e024a951f 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -74,12 +74,17 @@
>  #define KERNEL_END        _end
>  
>  /*
> - * KASAN requires 1/8th of the kernel virtual address space for the shadow
> - * region. KASAN can bloat the stack significantly, so double the (minimum)
> - * stack size when KASAN is in use.
> + * Generic and tag-based KASAN require 1/8th and 1/16th of the kernel virtual
> + * address space for the shadow region respectively. They can bloat the stack
> + * significantly, so double the (minimum) stack size when they are in use.
>   */
> -#ifdef CONFIG_KASAN
> +#ifdef CONFIG_KASAN_GENERIC
>  #define KASAN_SHADOW_SCALE_SHIFT 3
> +#endif
> +#ifdef CONFIG_KASAN_SW_TAGS
> +#define KASAN_SHADOW_SCALE_SHIFT 4
> +#endif
> +#ifdef CONFIG_KASAN

... and remove the constant entirely here, avoiding duplication.

Maybe factor that into a Makefile.kasan if things are going to get much
more complicated.

Thanks,
Mark.

>  #define KASAN_SHADOW_SIZE	(UL(1) << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
>  #define KASAN_THREAD_SHIFT	1
>  #else
> -- 
> 2.19.1.930.g4563a0d9d0-goog
> 
