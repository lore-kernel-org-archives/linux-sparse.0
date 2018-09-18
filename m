From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v6 17/18] khwasan: update kasan documentation
Date: Tue, 18 Sep 2018 20:42:56 +0200
Message-ID: <CAAeHK+wDhpX_E7cL8D4-BnM4WCT_Bb2Gp6wfqk7+P-4XAoiMOg@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com> <1a3b3030b6ee01931b397583b69f3af94e2a2308.1535462971.git.andreyknvl@google.com>
 <CACT4Y+a0A1n+FjbiQSEh4UMUPkq4KnqEOEXkfo-X+EwsVFZxMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+a0A1n+FjbiQSEh4UMUPkq4KnqEOEXkfo-X+EwsVFZxMg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kst>
List-Id: linux-sparse@vger.kernel.org

On Wed, Sep 12, 2018 at 8:39 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
>> This patch updates KASAN documentation to reflect the addition of KHWASAN.

>> -Currently KASAN is supported only for the x86_64 and arm64 architectures.
>> +KASAN uses compile-time instrumentation to insert validity checks before every
>> +memory access, and therefore requires a compiler version that supports that.
>> +For classic KASAN you need GCC version 4.9.2 or later. GCC 5.0 or later is
>> +required for detection of out-of-bounds accesses on stack and global variables.
>> +KHWASAN in turns is only supported in clang and requires revision 330044 or
>
> in turn?
>

>> -and choose between CONFIG_KASAN_OUTLINE and CONFIG_KASAN_INLINE. Outline and
>> -inline are compiler instrumentation types. The former produces smaller binary
>> -the latter is 1.1 - 2 times faster. Inline instrumentation requires a GCC
>> +and choose between CONFIG_KASAN_GENERIC (to enable classic KASAN) and
>> +CONFIG_KASAN_HW (to enabled KHWASAN). You also need to choose choose between
>
> to enable
>

>> +     print_address_description+0x73/0x280 mm/kasan/report.c:254
>
>
> KASAN does not print line numbers per se.
> I think we need to show unmodified output to not confuse readers
> (probably remove the useless ? lines).

Will fix all in v7.
