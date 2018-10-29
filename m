From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 3/4] ARM: mm: fix build error in fix_to_virt with CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
Date: Mon, 29 Oct 2018 22:05:44 +0900
Message-ID: <CAK7LNAQP6SgtbYcxZ7ApGg006omEZErNcDAVtPR=2RibxN8Ruw@mail.gmail.com>
References: <20181028130945.23581-1-changbin.du@gmail.com> <20181028130945.23581-4-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181028130945.23581-4-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Michal Marek <michal.lkml@markovi.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-sparse@vger.kernel.org

On Sun, Oct 28, 2018 at 10:13 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> With '-Og' optimization level, GCC would not optimize a count for a loop
> as a constant value. But BUILD_BUG_ON() only accept compile-time constant
> values. Let's use __fix_to_virt() to avoid the error.
>
> arch/arm/mm/mmu.o: In function `fix_to_virt':
> /home/changbin/work/linux/./include/asm-generic/fixmap.h:31: undefined reference to `__compiletime_assert_31'
> Makefile:1051: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---

Applied to linux-kbuild





-- 
Best Regards
Masahiro Yamada
