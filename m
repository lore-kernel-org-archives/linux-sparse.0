From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] arm64: pass machine size to sparse
Date: Tue, 20 Jun 2017 21:07:40 +0200
Message-ID: <20170620190739.ijtpo3ekibxi47qj@ltop.local>
References: <20170620122443.35880-1-luc.vanoostenryck@gmail.com>
 <20170620154938.GH21131@arm.com>
 <20170620162431.zi6qd3jby7shyu46@ltop.local>
 <20170620170401.GA28035@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36800 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbdFTTHo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Jun 2017 15:07:44 -0400
Received: by mail-wr0-f180.google.com with SMTP id c11so48151810wrc.3
        for <linux-sparse@vger.kernel.org>; Tue, 20 Jun 2017 12:07:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170620170401.GA28035@arm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org

On Tue, Jun 20, 2017 at 06:04:01PM +0100, Will Deacon wrote:
> On Tue, Jun 20, 2017 at 06:24:32PM +0200, Luc Van Oostenryck wrote:
> > On Tue, Jun 20, 2017 at 04:49:39PM +0100, Will Deacon wrote:
> > > Looks fine to me, but just wondering whether or not we should also be
> > > passing something to indicate the endianness of the target. Does sparse care
> > > about that?
> > 
> > Yes, we should. sparse doesn't care per-se but some macros, structures
> > or whole portion of code may depends on '__{LITTLE,BIG}_ENDIAN__'
> > being defined or not, for example (but I don't think it will make
> > a big difference, at least nothing like the 629904 'constant is so big'
> > warnings we have now due to the missing -m64).
> > 
> > For this, you have two possibilities:
> > 1) just doing something like PPC:
> > 	+ifdef CONFIG_CPU_BIG_ENDIAN
> > 	+CHECKFLAGS     += -D__BIG_ENDIAN__
> > 	+else
> > 	+CHECKFLAGS     += -D__LITTLE_ENDIAN__
> > 	+endif
> >    This will work now. I can't send you a proper patch if you wish.
> > 
> > 2) a cleaner solution, IMO, would be to teach sparse about
> >    -mlittle-endian/-mbig-endian. In fact I already wrote the patch
> >    earlier today. But of course, you will need to wait for the patch
> >    to reach sparse's master and then compile sparse yourself or wait
> >    for a new release (which shouldn't take much long, though).
> 
> If you do that, you could also teach it that AArch64 is 64-bit ;)

Well, currently sparse is arch agnostic and I think it's a good thing.
For the few arch specifities you have to use some of the '-m' flags
(like -m32/-m64, -msize-long). So, for the moment the '-m64' flag
is needed, thus the patch.

-- Luc
