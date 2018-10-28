From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/4] x86/mm: declare check_la57_support() as inline
Date: Sun, 28 Oct 2018 14:09:11 -0400
Message-ID: <20181028140911.21d49629@vmware.local.home>
References: <20181028130945.23581-1-changbin.du@gmail.com>
        <20181028130945.23581-2-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181028130945.23581-2-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk, akpm@linux-foundation.org, gregkh@linuxfoundation.org, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org, robin.murphy@arm.com
List-Id: linux-sparse@vger.kernel.org

On Sun, 28 Oct 2018 13:09:42 +0000
Changbin Du <changbin.du@gmail.com> wrote:

> The level4_kernel_pgt is only defined when X86_5LEVEL is enabled.
> So declare check_la57_support() as inline to make sure the code
> referring to level4_kernel_pgt is optimized out. This is a preparation
> for CONFIG_CC_OPTIMIZE_FOR_DEBUGGING.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>  arch/x86/kernel/head64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 5dc377dc9d7b..5ae682f2aa83 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -98,7 +98,7 @@ static bool __head check_la57_support(unsigned long physaddr)
>  	return true;
>  }
>  #else
> -static bool __head check_la57_support(unsigned long physaddr)
> +static inline bool __head check_la57_support(unsigned long physaddr)
>  {
>  	return false;
>  }
