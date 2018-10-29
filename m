From: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v2 4/4] kernel hacking: new config
 CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og optimization
Date: Mon, 29 Oct 2018 14:56:56 +0000
Message-ID: <20181029145655.vzlhz7dipzmpw52m@mail.google.com>
References: <20181019124921.13780-1-changbin.du@gmail.com>
 <20181019124921.13780-5-changbin.du@gmail.com>
 <CAK7LNARW0=0d7m5DAgZOir=h0Y4tssqZoQRGasnGPNnvNf_+pg@mail.gmail.com>
 <20181028125106.azcn2dxia3snplin@mail.google.com>
 <CAK7LNARr7bE=DVuzim5771heuN5os0=5-D+jXfUyBb2e1xYoRA@mail.gmail.com>
 <20181028131357.parhzj32feapxncb@mail.google.com>
 <CAK7LNAQ0iZDHP8zQZ_Ws4Wy4H6rwiV5p-A0bM1yVJLP51sqQeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ0iZDHP8zQZ_Ws4Wy4H6rwiV5p-A0bM1yVJLP51sqQeg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Changbin Du <changbin.du@gmail.com>, Michal Marek <michal.lkml@markovi.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 29, 2018 at 10:01:44PM +0900, Masahiro Yamada wrote:
> Hi.
> 
> 
> On Sun, Oct 28, 2018 at 10:14 PM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > On Sun, Oct 28, 2018 at 10:09:21PM +0900, Masahiro Yamada wrote:
> > > Hi Changbin,
> > >
> > > On Sun, Oct 28, 2018 at 9:52 PM Changbin Du <changbin.du@gmail.com> wrote:
> > >
> > > > >
> > > > Thanks for pointing this out and kind suggestions. I have tested with your
> > > > modification. Will update patch serias soon.
> > >
> > >
> > > I have one more request.
> > >
> > > The patch subject
> > > "kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og
> > > optimization"
> > > is too long (83 characters)
> > >
> > >
> > > I'd like the subject to be within 70 columns or so.
> > >
> > oh, I just sent new version. Could me update the title if there are more
> > suggestions then?
> 
> 
> 
> How about this?
> 
> 2/4: kernel hacking: add a config option to disable compiler auto-inlining
> 3/4: ARM: mm: fix build error in fix_to_virt with -Og optimization level
> 4/4: kernel hacking: support building kernel with -Og optimization level
> 
> (The CONFIG name is so long that the subject
> would easily exceeds 80-columns with it.)
> 
> 
> I applied this series to linux-kbuild,
> and will send another pull request in this MW.
> 
> 
> If you come up with better patch titles,
> please let me know.
> I will fix them up locally.
>
I am just fine with these new titles. Thanks.

> 
> 
> -- 
> Best Regards
> Masahiro Yamada

-- 
Thanks,
Changbin Du
