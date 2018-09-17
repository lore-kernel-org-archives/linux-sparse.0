From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v6 15/18] khwasan, arm64: add brk handler for inline instrumentation
Date: Mon, 17 Sep 2018 21:12:00 +0200
Message-ID: <CAAeHK+wVgmp2G63c5w4sMH1i97Ju-YW7RUQgOQjr5d8aMgh1EQ@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com> <f5e73b5ead3355932ad8b5fc96b141c3f5b8c16c.1535462971.git.andreyknvl@google.com>
 <CACT4Y+ZwLnk7V1cY-EAHbrfXPBxs6qyynZPhxoSKZZDWSK8Fuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+ZwLnk7V1cY-EAHbrfXPBxs6qyynZPhxoSKZZDWSK8Fuw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kst>
List-Id: linux-sparse@vger.kernel.org

On Wed, Sep 12, 2018 at 7:13 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

>> +static int khwasan_handler(struct pt_regs *regs, unsigned int esr)
>> +{
>> +       bool recover = esr & KHWASAN_ESR_RECOVER;
>> +       bool write = esr & KHWASAN_ESR_WRITE;
>> +       size_t size = KHWASAN_ESR_SIZE(esr);
>> +       u64 addr = regs->regs[0];
>> +       u64 pc = regs->pc;
>> +
>> +       if (user_mode(regs))
>> +               return DBG_HOOK_ERROR;
>> +
>> +       kasan_report(addr, size, write, pc);
>> +
>> +       /*
>> +        * The instrumentation allows to control whether we can proceed after
>> +        * a crash was detected. This is done by passing the -recover flag to
>> +        * the compiler. Disabling recovery allows to generate more compact
>> +        * code.
>> +        *
>> +        * Unfortunately disabling recovery doesn't work for the kernel right
>> +        * now. KHWASAN reporting is disabled in some contexts (for example when
>> +        * the allocator accesses slab object metadata; same is true for KASAN;
>> +        * this is controlled by current->kasan_depth). All these accesses are
>> +        * detected by the tool, even though the reports for them are not
>> +        * printed.
>
>
> I am not following this part.
> Slab accesses metadata. OK.
> This is detected as bad access. OK.
> Report is not printed. OK.
> We skip BRK and resume execution.
> What is the problem?

When the kernel is compiled with -fsanitize=kernel-hwaddress without
any additional flags (like it's done now with KASAN_HW) everything
works as you described and there's no problem. However if one were to
recompile the kernel with hwasan recovery disabled, KHWASAN wouldn't
work due to the reasons described in the comment. Should I make it
more clear?

>
>
>
>> +        *
>> +        * This is something that might be fixed at some point in the future.
>> +        */
>> +       if (!recover)
>> +               die("Oops - KHWASAN", regs, 0);
