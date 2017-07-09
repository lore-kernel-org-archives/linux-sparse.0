From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Sun, 9 Jul 2017 18:11:55 +0200
Message-ID: <20170709161152.jfck3tj6egtpzrdz@ltop.local>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
 <CANeU7Qktna3bNQ+kgVsULqwmze49wijZihA-Ea-weKcURmgL_Q@mail.gmail.com>
 <20170709102637.6pakvvwfduzulatl@ltop.local>
 <CANeU7Q=GHJgpr2sST3JP3=Dz1OEtae5j2Zeg0xmT1Toc-x1AzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34507 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdGIQL7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Jul 2017 12:11:59 -0400
Received: by mail-wr0-f174.google.com with SMTP id 77so107948487wrb.1
        for <linux-sparse@vger.kernel.org>; Sun, 09 Jul 2017 09:11:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=GHJgpr2sST3JP3=Dz1OEtae5j2Zeg0xmT1Toc-x1AzQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Jul 09, 2017 at 07:44:46AM -0700, Christopher Li wrote:
> On Sun, Jul 9, 2017 at 3:26 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >> diff --git a/flow.c b/flow.c
> >> index c7161d4..5d2f15a 100644
> >> --- a/flow.c
> >> +++ b/flow.c
> >> @@ -841,7 +841,7 @@ void kill_unreachable_bbs(struct entrypoint *ep)
> >>   } END_FOR_EACH_PTR(bb);
> >>   PACK_PTR_LIST(&ep->bbs);
> >>
> >> - repeat_phase &= ~REPEAT_CFG_CLEANUP;
> >> + repeat_phase |=  REPEAT_CSE ;
> >
> > It would be good to add a comment for why the '|= REPEAT_CSE' is needed here.
> OK. I will update the patch. Basically removing unreachable dead code will
> impact the us
> 
> 
> > And not removing the REPEAT_CFG_CLEANUP is an error IMO.
> > At the end of the function the CFG *is* clean. If you don't
> > clear it here, then what is its meaning?
> It is an error as concept or it is an error the program will do wrong
> things?

Concept.
 
> I want to turn REPEAT_CFG_CLEANUP usage pattern similar
> to REPEAT_SYMBOL_CLEANUP.


> I just want to be consistent with other usage of the similar flags.

For the other usage, the clearing of the flag (REPEAT_CSE) was done
just after the CSE was done.

You focus on the placement. I would focus on the meaning.
But it's your choice.

> I think when you introduce REPEAT_CFG_CLEANUP you have
> different usage in mind. I found the flag clean at beginning of the
> CSE loop is conceptually clean as well, it is simpler. The flag
> is just a request, it can set more than one times. The action is
> perform only once at one CSE pass.

This doesn't sound technically convincing to me, not at all.
Does the facts that:
1) it's a request flag
2) it can be set more than once
imply in any sort of way that:
1) the action is to be performed at the CSE pass and only there
2) and thus the only sane place where the flag can be cleared
   is there like the other flags?

By clearing the flag there and not at the end of the function
doing the action, you're more or less forcing the action to be
done there and only there. This may be a good enough reason to
for whishing to enforce that but then tell it, put it in a nice
comment in the code.

This is certainly not "conceptually clean as well" to me.

-- Luc
