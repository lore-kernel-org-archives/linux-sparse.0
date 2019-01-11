From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v3 1/3] kasan, arm64: use ARCH_SLAB_MINALIGN instead of
 manual aligning
Date: Fri, 11 Jan 2019 14:48:52 +0100
Message-ID: <CAAeHK+wYo95G3pSoxDWwUs2wf-tBoupwf+0XjO68WXjLzsNWaw@mail.gmail.com>
References: <cover.1546540962.git.andreyknvl@google.com> <52ddd881916bcc153a9924c154daacde78522227.1546540962.git.andreyknvl@google.com>
 <fc93e5a4-fa54-98a1-ea5f-4708568d7857@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fc93e5a4-fa54-98a1-ea5f-4708568d7857@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@lin>
List-Id: linux-sparse@vger.kernel.org

On Wed, Jan 9, 2019 at 11:10 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> On 03/01/2019 18:45, Andrey Konovalov wrote:
> > Instead of changing cache->align to be aligned to KASAN_SHADOW_SCALE_SIZE
> > in kasan_cache_create() we can reuse the ARCH_SLAB_MINALIGN macro.
> >
> > Suggested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  arch/arm64/include/asm/cache.h | 6 ++++++
> >  mm/kasan/common.c              | 2 --
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> > index 13dd42c3ad4e..eb43e09c1980 100644
> > --- a/arch/arm64/include/asm/cache.h
> > +++ b/arch/arm64/include/asm/cache.h
> > @@ -58,6 +58,12 @@
> >   */
> >  #define ARCH_DMA_MINALIGN    (128)
> >
> > +#ifdef CONFIG_KASAN_SW_TAGS
> > +#define ARCH_SLAB_MINALIGN   (1ULL << KASAN_SHADOW_SCALE_SHIFT)
> > +#else
> > +#define ARCH_SLAB_MINALIGN   __alignof__(unsigned long long)
> > +#endif
> > +
>
> Could you please remove the "#else" case here, because it is redundant (it is
> defined in linux/slab.h as ifndef) and could be misleading in future?

Sure, sent a patch. Thanks!

>
> >  #ifndef __ASSEMBLY__
> >
> >  #include <linux/bitops.h>
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 03d5d1374ca7..44390392d4c9 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -298,8 +298,6 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> >               return;
> >       }
> >
> > -     cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
> > -
> >       *flags |= SLAB_KASAN;
> >  }
> >
> >
>
> --
> Regards,
> Vincenzo
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/fc93e5a4-fa54-98a1-ea5f-4708568d7857%40arm.com.
> For more options, visit https://groups.google.com/d/optout.
