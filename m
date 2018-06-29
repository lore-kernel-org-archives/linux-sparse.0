From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address sanitizer
Date: Fri, 29 Jun 2018 15:18:31 +0200
Message-ID: <CAAeHK+zXzTEo_DJ5a7KaVDQa06Gx98Oj2O3jMFJo_tNgkq822g@mail.gmail.com>
References: <cover.1530018818.git.andreyknvl@google.com> <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110419.GC26019@e103592.cambridge.arm.com> <20180629112613.7i4xesjyxolc63gu@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180629112613.7i4xesjyxolc63gu@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dave Martin <Dave.Martin@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Paul Lawrence <paullawrence@google.com>, Linux Memory Management List <linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>, Chintan Pandya <cpandya@codeaurora.org>, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Jann Horn <jannh@google.com>, Mark Brand <markbrand@google.com>, kasan-dev <kasan-dev@googlegroups.com>, linux-sparse@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Andrey
List-Id: linux-sparse@vger.kernel.org

On Fri, Jun 29, 2018 at 1:26 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Fri, Jun 29, 2018 at 12:04:22PM +0100, Dave Martin wrote:
>>
>> Can sparse be hacked to identify pointer subtractions where the pointers
>> are cannot be statically proved to point into the same allocation?

Re all the comments about finding all the places where we do pointer
subtraction/comparison:

I might be wrong, but I doubt you can easily do that with static analysis.

What we could do is to try to detect all such subtractions/comparisons
dynamically. The idea is to instrument all pointer/ulong
subtraction/comparison instructions and try to detect tags mismatch.
And then run some workload (e.g. syzkaller) to trigger more kernel
code. The question is how much false positives we would get, since I
imagine there would be a number of cases when we compare some random
ulongs.
