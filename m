From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v13 05/25] kasan: add CONFIG_KASAN_GENERIC and CONFIG_KASAN_SW_TAGS
Date: Tue, 11 Dec 2018 17:02:42 +0100
Message-ID: <CAAeHK+y0AzO8r21L=9HftHuoTXMuTjkZYJOZ6hKZqCEQOjygHQ@mail.gmail.com>
References: <cover.1544099024.git.andreyknvl@google.com> <b2550106eb8a68b10fefbabce820910b115aa853.1544099024.git.andreyknvl@google.com>
 <20181211152840.ezjujzpyz5z6fd2d@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211152840.ezjujzpyz5z6fd2d@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linu>
List-Id: linux-sparse@vger.kernel.org

On Tue, Dec 11, 2018 at 4:28 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Thu, Dec 06, 2018 at 01:24:23PM +0100, Andrey Konovalov wrote:
> > diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> > index 3e7dafb3ea80..39f668d5066b 100644
> > --- a/include/linux/compiler-clang.h
> > +++ b/include/linux/compiler-clang.h
> > @@ -16,9 +16,13 @@
> >  /* all clang versions usable with the kernel support KASAN ABI version 5 */
> >  #define KASAN_ABI_VERSION 5
> >
> > +#if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
> >  /* emulate gcc's __SANITIZE_ADDRESS__ flag */
> > -#if __has_feature(address_sanitizer)
> >  #define __SANITIZE_ADDRESS__
> > +#define __no_sanitize_address \
> > +             __attribute__((no_sanitize("address", "hwaddress")))
> > +#else
> > +#define __no_sanitize_address
> >  #endif
> >
> >  /*
> > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> > index 2010493e1040..5776da43da97 100644
> > --- a/include/linux/compiler-gcc.h
> > +++ b/include/linux/compiler-gcc.h
> > @@ -143,6 +143,12 @@
> >  #define KASAN_ABI_VERSION 3
> >  #endif
> >
> > +#if __has_attribute(__no_sanitize_address__)
> > +#define __no_sanitize_address __attribute__((no_sanitize_address))
> > +#else
> > +#define __no_sanitize_address
> > +#endif
>
> Not really important but it's the name with leading and trailing
> underscores that is tested with __has_attribute() but then it's
> the naked 'no_sanitize_address' that is used in the attribute.

Hi Luc,

You're right. This shouldn't be important though, since "__" in
attribute names are optional AFAIK. It might make sense to fix it as a
separate patch when this series is merged.

Thanks!
