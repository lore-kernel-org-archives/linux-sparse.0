From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Sun, 9 Jul 2017 07:44:46 -0700
Message-ID: <CANeU7Q=GHJgpr2sST3JP3=Dz1OEtae5j2Zeg0xmT1Toc-x1AzQ@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7Qktna3bNQ+kgVsULqwmze49wijZihA-Ea-weKcURmgL_Q@mail.gmail.com>
 <20170709102637.6pakvvwfduzulatl@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33859 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdGIOos (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Jul 2017 10:44:48 -0400
Received: by mail-pf0-f180.google.com with SMTP id q85so37772002pfq.1
        for <linux-sparse@vger.kernel.org>; Sun, 09 Jul 2017 07:44:48 -0700 (PDT)
In-Reply-To: <20170709102637.6pakvvwfduzulatl@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Jul 9, 2017 at 3:26 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> diff --git a/flow.c b/flow.c
>> index c7161d4..5d2f15a 100644
>> --- a/flow.c
>> +++ b/flow.c
>> @@ -841,7 +841,7 @@ void kill_unreachable_bbs(struct entrypoint *ep)
>>   } END_FOR_EACH_PTR(bb);
>>   PACK_PTR_LIST(&ep->bbs);
>>
>> - repeat_phase &= ~REPEAT_CFG_CLEANUP;
>> + repeat_phase |=  REPEAT_CSE ;
>
> It would be good to add a comment for why the '|= REPEAT_CSE' is needed here.
OK. I will update the patch. Basically removing unreachable dead code will
impact the us


> And not removing the REPEAT_CFG_CLEANUP is an error IMO.
> At the end of the function the CFG *is* clean. If you don't
> clear it here, then what is its meaning?
It is an error as concept or it is an error the program will do wrong
things?

I want to turn REPEAT_CFG_CLEANUP usage pattern similar
to REPEAT_SYMBOL_CLEANUP. Take the a look at

if (repeat_phase & REPEAT_SYMBOL_CLEANUP)
simplify_memops(ep);

The simplify_memops does not clear the REPEAT_SYMBOL_CLEANUP
either. It was clear at the very beginning of the cse repeat loop:

repeat:
repeat_phase = 0;

I just want to be consistent with other usage of the similar flags.

It is also a reflection of my review feedback when you submit the
patch back then. One of the comment I give was that I want to
avoid calling "kill unreachable bb" multiple time within one "ep->bbs"
pass. You said there is no simple way to do it. This patch is actually
what I want back then.

I think when you introduce REPEAT_CFG_CLEANUP you have
different usage in mind. I found the flag clean at beginning of the
CSE loop is conceptually clean as well, it is simpler. The flag
is just a request, it can set more than one times. The action is
perform only once at one CSE pass.

Chris
