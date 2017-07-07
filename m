From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Thu, 6 Jul 2017 23:27:58 -0700
Message-ID: <CANeU7Q===1Qm0kEGX4DQLeY9jeu1DdmhzvKGw7FNG1j5zWz-gw@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <20170707054459.pkhqnmrz7yt3sppc@ltop.local> <CANeU7Q=6MZSn2Lm_+xhqrR1mU95Fq-j6oox8jEYqW+zW=UYTEA@mail.gmail.com>
 <20170707061016.gcbmwrp7zbhlhbpv@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33549 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdGGG2A (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 02:28:00 -0400
Received: by mail-pf0-f177.google.com with SMTP id e7so12397858pfk.0
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 23:28:00 -0700 (PDT)
In-Reply-To: <20170707061016.gcbmwrp7zbhlhbpv@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 6, 2017 at 11:10 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
>> Go try this patch with a "make check". It has over one hundreds fails.
>
> I'll do, later (just wakeup here).

No problem at all.

Just a head up. I need to crash soon. And tomorrow I will not have much
Internet access at all. I have time to code but no internet. I will see if I
can get a ptrlist safe against delete.

>
>> Those are real bugs. The current big offender is remove_usage() inside
>> of the  kill_use_list(). It might relate to your code as well. Can you help me
>> take a look at the offender?
>
> Yes, of course I'll help with this.
> And yes, I added a bunch of these remove_use() with the recursive call
> to kill_instruction() which I never liked much but solved a bunch of
> things.

Thanks for the help. Yes, that is exactly the bug I am talking about.
Deleting list entry while the parent is still looping on it.
Sparse ptrlist currently has very subtle bug on this situation.

Chris
