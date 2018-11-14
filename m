From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v10 08/22] kasan, arm64: untag address in __kimg_to_phys
 and _virt_addr_is_linear
Date: Wed, 14 Nov 2018 20:52:29 +0100
Message-ID: <CAAeHK+zSEUq-bBide_kqwY831vQpxYUpjUNhPKSD0aC4OyewKw@mail.gmail.com>
References: <cover.1541525354.git.andreyknvl@google.com> <b2aa056b65b8f1a410379bf2f6ef439d5d99e8eb.1541525354.git.andreyknvl@google.com>
 <20181107181054.GC255021@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107181054.GC255021@arrakis.emea.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@l>
List-Id: linux-sparse@vger.kernel.org

On Wed, Nov 7, 2018 at 7:10 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Nov 06, 2018 at 06:30:23PM +0100, Andrey Konovalov wrote:
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -92,6 +92,15 @@
>>  #define KASAN_THREAD_SHIFT   0
>>  #endif
>>
>> +#ifdef CONFIG_KASAN_SW_TAGS
>> +#define KASAN_TAG_SHIFTED(tag)               ((unsigned long)(tag) << 56)
>> +#define KASAN_SET_TAG(addr, tag)     (((addr) & ~KASAN_TAG_SHIFTED(0xff)) | \
>> +                                             KASAN_TAG_SHIFTED(tag))
>> +#define KASAN_RESET_TAG(addr)                KASAN_SET_TAG(addr, 0xff)
>> +#else
>> +#define KASAN_RESET_TAG(addr)                addr
>> +#endif
>
> I think we should reuse the untagged_addr() macro we have in uaccess.h
> (make it more general and move to another header file).

Will do in v11, thanks!
