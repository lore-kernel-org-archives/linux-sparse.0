From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [kbuild ack?] Re: [PATCH v6 0/9] x86: macrofying inline asm for
 better compilation
Date: Wed, 18 Jul 2018 10:47:10 +0900
Message-ID: <CAK7LNAQT02gDD8-1FuWd8Cv7pMTP-wg-9DNYDo4+Y3MGOxsnmg@mail.gmail.com>
References: <20180622172212.199633-1-namit@vmware.com> <BA4C0931-A51D-41AE-B918-C37EFFF35840@vmware.com>
 <20180715215452.GA14040@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180715215452.GA14040@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <namit@vmware.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>, "virtualization@lists.linux-foundation.org" <virtualizat>
List-Id: linux-sparse@vger.kernel.org

2018-07-16 6:54 GMT+09:00 Ingo Molnar <mingo@kernel.org>:
>
> * Nadav Amit <namit@vmware.com> wrote:
>
>> > I ran some limited number of benchmarks, and in general the performance
>> > impact is not very notable. You can still see >10 cycles shaved off some
>> > syscalls that manipulate page-tables (e.g., mprotect()), in which
>> > paravirt caused many functions not to be inlined. In addition this
>> > patch-set can prevent issues such as [1], and improves code readability
>> > and maintainability.
>
> Ok, that's good enough as a benefit, I suppose.
>
>> > Nadav Amit (9):
>> >  Makefile: Prepare for using macros for inline asm
>
> This non-trivial kbuild patch needs an Acked-by from Masahiro.


Sorry for delay.

I've issued Acked-by to 1/9 now.

Thanks.



> Thanks,
>
>         Ingo



-- 
Best Regards
Masahiro Yamada
