From: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v2 1/4] x86/mm: surround level4_kernel_pgt with #ifdef
 CONFIG_X86_5LEVEL...#endif
Date: Sun, 28 Oct 2018 12:46:18 +0000
Message-ID: <20181028124507.4n2sfkm7iteyoud5@mail.google.com>
References: <20181019124921.13780-1-changbin.du@gmail.com>
 <20181019124921.13780-2-changbin.du@gmail.com>
 <CAK7LNAQJxVDWU5GPY4O6x+z_Pkmh4KuHiTpkY_LDJwNYO-eCBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNAQJxVDWU5GPY4O6x+z_Pkmh4KuHiTpkY_LDJwNYO-eCBw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: changbin.du@gmail.com, Michal Marek <michal.lkml@markovi.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-sparse@vger.kernel.org

On Sun, Oct 28, 2018 at 10:44:46AM +0900, Masahiro Yamada wrote:
> On Fri, Oct 19, 2018 at 9:50 PM Du Changbin <changbin.du@gmail.com> wrote:
> >
> > The level4_kernel_pgt is only defined when X86_5LEVEL is enabled. So
> > surround level4_kernel_pgt with #ifdef CONFIG_X86_5LEVEL...#endif to
> > make code correct.
> 
> For clarification, is it better to mention
> that this is a preparation for CONFIG_CC_OPTIMIZE_FOR_DEBUGGING ?
>
yes, I will update the commit msg.

> 
> > Signed-off-by: Du Changbin <changbin.du@gmail.com>
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  arch/x86/include/asm/pgtable_64.h |  2 ++
> >  arch/x86/kernel/head64.c          | 13 ++++++-------
> >  2 files changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
> > index 9c85b54bf03c..9333f7fa5bdb 100644
> > --- a/arch/x86/include/asm/pgtable_64.h
> > +++ b/arch/x86/include/asm/pgtable_64.h
> > @@ -16,7 +16,9 @@
> >  #include <linux/threads.h>
> >  #include <asm/fixmap.h>
> >
> > +#ifdef CONFIG_X86_5LEVEL
> >  extern p4d_t level4_kernel_pgt[512];
> > +#endif
> 
> 
> Is this #ifdef  necessary?
> 
> It is harmless to declaring unused stuff.
> 
> 
> 
> >  extern p4d_t level4_ident_pgt[512];
> >  extern pud_t level3_kernel_pgt[512];
> >  extern pud_t level3_ident_pgt[512];
> > diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> > index ddee1f0870c4..4a59ef93c258 100644
> > --- a/arch/x86/kernel/head64.c
> > +++ b/arch/x86/kernel/head64.c
> > @@ -151,16 +151,15 @@ unsigned long __head __startup_64(unsigned long physaddr,
> >
> >         pgd = fixup_pointer(&early_top_pgt, physaddr);
> >         p = pgd + pgd_index(__START_KERNEL_map);
> > -       if (la57)
> > -               *p = (unsigned long)level4_kernel_pgt;
> > -       else
> > -               *p = (unsigned long)level3_kernel_pgt;
> > -       *p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
> > -
> > +#ifdef CONFIG_X86_5LEVEL
> >         if (la57) {
> > +               *p = (unsigned long)level4_kernel_pgt;
> >                 p4d = fixup_pointer(&level4_kernel_pgt, physaddr);
> >                 p4d[511] += load_delta;
> > -       }
> > +       } else
> > +#endif
> > +               *p = (unsigned long)level3_kernel_pgt;
> > +       *p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
> >
> >         pud = fixup_pointer(&level3_kernel_pgt, physaddr);
> >         pud[510] += load_delta;
> > --
> > 2.17.1
> >
> 
> 
> Hmm, this code looks a bit ugly...
> 
> Does the following one liner work with CONFIG_CC_OPTIMIZE_FOR_DEBUGGING ?
> 
> 
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 8047379..579847f 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -97,7 +97,7 @@ static bool __head check_la57_support(unsigned long physaddr)
>         return true;
>  }
>  #else
> -static bool __head check_la57_support(unsigned long physaddr)
> +static __always_inline bool __head check_la57_support(unsigned long physaddr)
>  {
>         return false;
>  }
> 
This is much better. I just declared it as 'inline'. Thanks for your suggestion.

> 
> 
> 
> --
> Best Regards
> Masahiro Yamada

-- 
Thanks,
Changbin Du
