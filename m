From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v12 05/25] kasan: add CONFIG_KASAN_GENERIC and CONFIG_KASAN_SW_TAGS
Date: Tue, 4 Dec 2018 14:23:47 -0800
Message-ID: <CAMo8BfK5aEGae--xvboLxMXTe1orA7kmLR_uFNCqC6M-a=Om5Q@mail.gmail.com>
References: <cover.1543337629.git.andreyknvl@google.com> <20728567aae93b5eb88a6636c94c1af73db7cdbc.1543337629.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20728567aae93b5eb88a6636c94c1af73db7cdbc.1543337629.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, glider@google.com, Dmitry Vyukov <dvyukov@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, ndesaulniers@google.com, marc.zyngier@arm.com, dave.martin@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, paullawrence@google.com, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, rppt@linux.vnet.ibm.com, kasan-dev@googl
List-Id: linux-sparse@vger.kernel.org

Hello,

On Tue, Nov 27, 2018 at 9:00 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> This commit splits the current CONFIG_KASAN config option into two:
> 1. CONFIG_KASAN_GENERIC, that enables the generic KASAN mode (the one
>    that exists now);
> 2. CONFIG_KASAN_SW_TAGS, that enables the software tag-based KASAN mode.

[...]

> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -1,35 +1,95 @@
> +# This config refers to the generic KASAN mode.
>  config HAVE_ARCH_KASAN
>         bool
>
> +config HAVE_ARCH_KASAN_SW_TAGS
> +       bool
> +
> +config CC_HAS_KASAN_GENERIC
> +       def_bool $(cc-option, -fsanitize=kernel-address)
> +
> +config CC_HAS_KASAN_SW_TAGS
> +       def_bool $(cc-option, -fsanitize=kernel-hwaddress)
> +
>  if HAVE_ARCH_KASAN
>
>  config KASAN
> -       bool "KASan: runtime memory debugger"
> +       bool "KASAN: runtime memory debugger"
> +       help
> +         Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
> +         designed to find out-of-bounds accesses and use-after-free bugs.
> +         See Documentation/dev-tools/kasan.rst for details.

Perhaps KASAN should depend on
CC_HAS_KASAN_GENERIC || CC_HAS_KASAN_SW_TAGS,
otherwise make all*config may enable KASAN
for a compiler that does not have any -fsanitize=kernel-*address
support, resulting in build failures like this:
  http://kisskb.ellerman.id.au/kisskb/buildresult/13606170/log/

-- 
Thanks.
-- Max
