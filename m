From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address sanitizer
Date: Fri, 29 Jun 2018 14:45:08 +0200
Message-ID: <CAAeHK+xsBOKghUp9XhpfXGqU=gjSYuy3G2GH14zWNEmaLPy8_w@mail.gmail.com>
References: <cover.1530018818.git.andreyknvl@google.com> <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
 <CAAeHK+xz552VNpZxgWwU-hbTqF5_F6YVDw3fSv=4OT8mNrqPzg@mail.gmail.com> <20180628124039.8a42ab5e2994fb2876ff4f75@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628124039.8a42ab5e2994fb2876ff4f75@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@l>
List-Id: linux-sparse@vger.kernel.org

On Thu, Jun 28, 2018 at 9:40 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu, 28 Jun 2018 20:29:07 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:
>
>> >> Slab memory usage after boot [2]:
>> >> * ~40 kb for clean kernel
>> >> * ~105 kb + 1/8th shadow ~= 118 kb for KASAN
>> >> * ~47 kb + 1/16th shadow ~= 50 kb for KHWASAN
>> >>
>> >> Network performance [3]:
>> >> * 8.33 Gbits/sec for clean kernel
>> >> * 3.17 Gbits/sec for KASAN
>> >> * 2.85 Gbits/sec for KHWASAN
>> >>
>> >> Note, that KHWASAN (compared to KASAN) doesn't require quarantine.
>> >>
>> >> [1] Time before the ext4 driver is initialized.
>> >> [2] Measured as `cat /proc/meminfo | grep Slab`.
>> >> [3] Measured as `iperf -s & iperf -c 127.0.0.1 -t 30`.
>> >
>> > The above doesn't actually demonstrate the whole point of the
>> > patchset: to reduce KASAN's very high memory consumption?
>>
>> You mean that memory usage numbers collected after boot don't give a
>> representative picture of actual memory consumption on real workloads?
>>
>> What kind of memory consumption testing would you like to see?
>
> Well, 100kb or so is a teeny amount on virtually any machine.  I'm
> assuming the savings are (much) more significant once the machine gets
> loaded up and doing work?

So with clean kernel after boot we get 40 kb memory usage. With KASAN
it is ~120 kb, which is 200% overhead. With KHWASAN it's 50 kb, which
is 25% overhead. This should approximately scale to any amounts of
used slab memory. For example with 100 mb memory usage we would get
+200 mb for KASAN and +25 mb with KHWASAN. (And KASAN also requires
quarantine for better use-after-free detection). I can explicitly
mention the overhead in %s in the changelog.

If you think it makes sense, I can also make separate measurements
with some workload. What kind of workload should I use?
