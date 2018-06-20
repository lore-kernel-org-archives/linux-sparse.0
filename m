From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v3 17/17] kasan: add SPDX-License-Identifier mark to
 source files
Date: Wed, 20 Jun 2018 21:41:46 +0200
Message-ID: <CAAeHK+zJgSAxiHHfzhrm7N7iey7CbW42WfWvUN+FnZMPP3FXrA@mail.gmail.com>
References: <cover.1529515183.git.andreyknvl@google.com> <f76d3070776e0038eda3cd76d471d1bfeae18480.1529515183.git.andreyknvl@google.com>
 <CAOMZO5BgPaMsmx_3AJvMTKCFjhusfH=kH26U_PQCSD5TcUDA+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5BgPaMsmx_3AJvMTKCFjhusfH=kH26U_PQCSD5TcUDA+w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@lin>
List-Id: linux-sparse@vger.kernel.org

On Wed, Jun 20, 2018 at 9:15 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Jun 20, 2018 at 2:40 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
>
>> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
>> index 6f4f2ebf5f57..3feacd889e24 100644
>> --- a/mm/kasan/kasan.h
>> +++ b/mm/kasan/kasan.h
>> @@ -1,4 +1,4 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> +// SPDX-License-Identifier: GPL-2.0
>
> The original notation is correct: /* */ style is used for header files.

I used mm/slub.c as a reference, which uses //. Bu I can change it to
/* */ in the next version, no problem.
