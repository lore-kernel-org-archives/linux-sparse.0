From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v10 08/22] kasan, arm64: untag address in __kimg_to_phys
 and _virt_addr_is_linear
Date: Thu, 15 Nov 2018 14:43:02 +0100
Message-ID: <CAAeHK+yaYc4gOxWdvJALwUffAFDVwQe7+4Rwx=Ux936c_LtBFw@mail.gmail.com>
References: <cover.1541525354.git.andreyknvl@google.com> <b2aa056b65b8f1a410379bf2f6ef439d5d99e8eb.1541525354.git.andreyknvl@google.com>
 <20181107165200.oaou6cx2lmjzmjyl@lakrids.cambridge.arm.com> <CAAeHK+yAve4fBg_UZQsNdVJ5W-7v8tQnRa=amQMyBeE_yHcq5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAeHK+yAve4fBg_UZQsNdVJ5W-7v8tQnRa=amQMyBeE_yHcq5g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kste>
List-Id: linux-sparse@vger.kernel.org

On Wed, Nov 14, 2018 at 8:23 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> On Wed, Nov 7, 2018 at 5:52 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>>  /*
>>> @@ -232,7 +241,7 @@ static inline unsigned long kaslr_offset(void)
>>>  #define __is_lm_address(addr)        (!!((addr) & BIT(VA_BITS - 1)))
>>>
>>>  #define __lm_to_phys(addr)   (((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
>>> -#define __kimg_to_phys(addr) ((addr) - kimage_voffset)
>>> +#define __kimg_to_phys(addr) (KASAN_RESET_TAG(addr) - kimage_voffset)
>>
>> IIUC You need to adjust __lm_to_phys() too, since that could be passed
>> an address from SLAB.
>>
>> Maybe that's done in a later patch, but if so it's confusing to split it
>> out that way. It would be nicer to fix all the *_to_*() helpers in one
>> go.
>
> __lm_to_phys() does & ~PAGE_OFFSET, so it resets the tag by itself. I
> can add an explicit __tag_reset() if you think it makes sense.

Hi Mark,

I think I've addressed all of your comments except for this one. Do
you think it makes sense to add explicit __tag_reset() calls to
__lm_to_phys() and a few other macros, that already set the tag to 0
by doing & ~PAGE_OFFSET?

Thanks!
