From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 08:10:17 +0200
Message-ID: <20170707061016.gcbmwrp7zbhlhbpv@ltop.local>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
 <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <20170707054459.pkhqnmrz7yt3sppc@ltop.local>
 <CANeU7Q=6MZSn2Lm_+xhqrR1mU95Fq-j6oox8jEYqW+zW=UYTEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:34912 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdGGGKT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 02:10:19 -0400
Received: by mail-wr0-f170.google.com with SMTP id k67so31606890wrc.2
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 23:10:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=6MZSn2Lm_+xhqrR1mU95Fq-j6oox8jEYqW+zW=UYTEA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 06, 2017 at 11:02:24PM -0700, Christopher Li wrote:
> On Thu, Jul 6, 2017 at 10:44 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Mmmm ...
> >
> > I really don't like this kind of solution.
> > The ptrlist is already fragile and now it would contains
> > yet another field that need to be taken care of *and* stay
> > coherent with other users. I doubt this will help to reduce bugs.
> 
> You totally miss the point. This patch is not a final solution.
> I am not suggesting submit this patch as it is.
> 
> It is mean to expose existing bugs.

Ah, OK.

> Go try this patch with a "make check". It has over one hundreds fails.

I'll do, later (just wakeup here).

> Those are real bugs. The current big offender is remove_usage() inside
> of the  kill_use_list(). It might relate to your code as well. Can you help me
> take a look at the offender?

Yes, of course I'll help with this.
And yes, I added a bunch of these remove_use() with the recursive call
to kill_instruction() which I never liked much but solved a bunch of
things.
 
-- Luc
