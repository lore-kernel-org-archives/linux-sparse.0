From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 1/4] x86/mm: declare check_la57_support() as inline
Date: Fri, 2 Nov 2018 12:27:29 +0100
Message-ID: <20181102112728.GC14602@zn.tnic>
References: <20181028130945.23581-1-changbin.du@gmail.com>
 <20181028130945.23581-2-changbin.du@gmail.com>
 <20181028140911.21d49629@vmware.local.home>
 <CAK7LNATixykqHqdu5W3NpfXqBXMNsP0OLKjNdsFc_EzJ_diOxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNATixykqHqdu5W3NpfXqBXMNsP0OLKjNdsFc_EzJ_diOxA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Changbin Du <changbin.du@gmail.com>, Michal Marek <michal.lkml@markovi.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, X86 ML <x86@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 29, 2018 at 10:04:46PM +0900, Masahiro Yamada wrote:
> On Mon, Oct 29, 2018 at 3:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Sun, 28 Oct 2018 13:09:42 +0000
> > Changbin Du <changbin.du@gmail.com> wrote:
> >
> > > The level4_kernel_pgt is only defined when X86_5LEVEL is enabled.
> > > So declare check_la57_support() as inline to make sure the code
> > > referring to level4_kernel_pgt is optimized out. This is a preparation
> > > for CONFIG_CC_OPTIMIZE_FOR_DEBUGGING.
> > >
> > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> >
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >
> > -- Steve
> >
> 
> Applied to linux-kbuild.

Next time, before you route a patch through your tree, please get an x86
maintainer's ACK first.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
