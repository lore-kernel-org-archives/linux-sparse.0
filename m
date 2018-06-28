From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address sanitizer
Date: Thu, 28 Jun 2018 20:56:41 +0200
Message-ID: <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
References: <cover.1530018818.git.andreyknvl@google.com> <20180628105057.GA26019@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628105057.GA26019@e103592.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <ks>
List-Id: linux-sparse@vger.kernel.org

On Thu, Jun 28, 2018 at 12:51 PM, Dave Martin <Dave.Martin@arm.com> wrote:
> On Tue, Jun 26, 2018 at 03:15:10PM +0200, Andrey Konovalov wrote:
>> 1. By using the Top Byte Ignore arm64 CPU feature, we can store pointer
>>    tags in the top byte of each kernel pointer.
>
> [...]
>
> This is a change from the current situation, so the kernel may be
> making implicit assumptions about the top byte of kernel addresses.
>
> Randomising the top bits may cause things like address conversions and
> pointer arithmetic to break.
>
> For example, (q - p) will not produce the expected result if q and p
> have different tags.

If q and p have different tags, that means they come from different
allocations. I don't think it would make sense to calculate pointer
difference in this case.

>
> Conversions, such as between pointer and pfn, may also go wrong if not
> appropriately masked.
>
> There are also potential pointer comparison and aliasing issues if
> the tag bits are ever stripped or modified.
>
>
> What was your approach to tracking down all the points in the code
> where we have a potential issue?

I've been fuzzing the kernel built with KWHASAN with syzkaller. This
gives a decent coverage and I was able to find some places where
fixups were required this way. Right now the fuzzer is running without
issues. It doesn't prove that all such places are fixed, but I don't
know a better way to test this.
