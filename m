From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] arm64: pass machine size to sparse
Date: Tue, 20 Jun 2017 18:24:32 +0200
Message-ID: <20170620162431.zi6qd3jby7shyu46@ltop.local>
References: <20170620122443.35880-1-luc.vanoostenryck@gmail.com>
 <20170620154938.GH21131@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34307 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdFTQYg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Jun 2017 12:24:36 -0400
Received: by mail-lf0-f67.google.com with SMTP id l200so4181694lfg.1
        for <linux-sparse@vger.kernel.org>; Tue, 20 Jun 2017 09:24:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170620154938.GH21131@arm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org

On Tue, Jun 20, 2017 at 04:49:39PM +0100, Will Deacon wrote:
> On Tue, Jun 20, 2017 at 02:24:43PM +0200, Luc Van Oostenryck wrote:
> > When using sparse on the arm64 tree we get many thousands of
> > warnings like 'constant ... is so big it is unsigned long long'
> > or 'shift too big (32) for type unsigned long'. This happens
> > because by default sparse considers the machine as 32bit and
> > defines the size of the types accordingly.
> > 
> > Fix this by passing the '-m64' flag to sparse so that
> > sparse can correctly define longs as being 64bit.
> > 
> > CC: Catalin Marinas <catalin.marinas@arm.com>
> > CC: Will Deacon <will.deacon@arm.com>
> > CC: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  arch/arm64/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index f839ecd91..15d6c1476 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -62,7 +62,7 @@ LD		+= -EL
> >  UTS_MACHINE	:= aarch64
> >  endif
> >  
> > -CHECKFLAGS	+= -D__aarch64__
> > +CHECKFLAGS	+= -D__aarch64__ -m64
> 
> Looks fine to me, but just wondering whether or not we should also be
> passing something to indicate the endianness of the target. Does sparse care
> about that?

Yes, we should. sparse doesn't care per-se but some macros, structures
or whole portion of code may depends on '__{LITTLE,BIG}_ENDIAN__'
being defined or not, for example (but I don't think it will make
a big difference, at least nothing like the 629904 'constant is so big'
warnings we have now due to the missing -m64).

For this, you have two possibilities:
1) just doing something like PPC:
	+ifdef CONFIG_CPU_BIG_ENDIAN
	+CHECKFLAGS     += -D__BIG_ENDIAN__
	+else
	+CHECKFLAGS     += -D__LITTLE_ENDIAN__
	+endif
   This will work now. I can't send you a proper patch if you wish.

2) a cleaner solution, IMO, would be to teach sparse about
   -mlittle-endian/-mbig-endian. In fact I already wrote the patch
   earlier today. But of course, you will need to wait for the patch
   to reach sparse's master and then compile sparse yourself or wait
   for a new release (which shouldn't take much long, though).

Regards,
-- Luc Van Oostenryck
