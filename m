From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: pass machine size to sparse
Date: Tue, 20 Jun 2017 18:04:01 +0100
Message-ID: <20170620170401.GA28035@arm.com>
References: <20170620122443.35880-1-luc.vanoostenryck@gmail.com>
 <20170620154938.GH21131@arm.com>
 <20170620162431.zi6qd3jby7shyu46@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbdFTRDt (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Jun 2017 13:03:49 -0400
Content-Disposition: inline
In-Reply-To: <20170620162431.zi6qd3jby7shyu46@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org

On Tue, Jun 20, 2017 at 06:24:32PM +0200, Luc Van Oostenryck wrote:
> On Tue, Jun 20, 2017 at 04:49:39PM +0100, Will Deacon wrote:
> > On Tue, Jun 20, 2017 at 02:24:43PM +0200, Luc Van Oostenryck wrote:
> > > When using sparse on the arm64 tree we get many thousands of
> > > warnings like 'constant ... is so big it is unsigned long long'
> > > or 'shift too big (32) for type unsigned long'. This happens
> > > because by default sparse considers the machine as 32bit and
> > > defines the size of the types accordingly.
> > > 
> > > Fix this by passing the '-m64' flag to sparse so that
> > > sparse can correctly define longs as being 64bit.
> > > 
> > > CC: Catalin Marinas <catalin.marinas@arm.com>
> > > CC: Will Deacon <will.deacon@arm.com>
> > > CC: linux-arm-kernel@lists.infradead.org
> > > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > > ---
> > >  arch/arm64/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > > index f839ecd91..15d6c1476 100644
> > > --- a/arch/arm64/Makefile
> > > +++ b/arch/arm64/Makefile
> > > @@ -62,7 +62,7 @@ LD		+= -EL
> > >  UTS_MACHINE	:= aarch64
> > >  endif
> > >  
> > > -CHECKFLAGS	+= -D__aarch64__
> > > +CHECKFLAGS	+= -D__aarch64__ -m64
> > 
> > Looks fine to me, but just wondering whether or not we should also be
> > passing something to indicate the endianness of the target. Does sparse care
> > about that?
> 
> Yes, we should. sparse doesn't care per-se but some macros, structures
> or whole portion of code may depends on '__{LITTLE,BIG}_ENDIAN__'
> being defined or not, for example (but I don't think it will make
> a big difference, at least nothing like the 629904 'constant is so big'
> warnings we have now due to the missing -m64).
> 
> For this, you have two possibilities:
> 1) just doing something like PPC:
> 	+ifdef CONFIG_CPU_BIG_ENDIAN
> 	+CHECKFLAGS     += -D__BIG_ENDIAN__
> 	+else
> 	+CHECKFLAGS     += -D__LITTLE_ENDIAN__
> 	+endif
>    This will work now. I can't send you a proper patch if you wish.
> 
> 2) a cleaner solution, IMO, would be to teach sparse about
>    -mlittle-endian/-mbig-endian. In fact I already wrote the patch
>    earlier today. But of course, you will need to wait for the patch
>    to reach sparse's master and then compile sparse yourself or wait
>    for a new release (which shouldn't take much long, though).

If you do that, you could also teach it that AArch64 is 64-bit ;)

Will
