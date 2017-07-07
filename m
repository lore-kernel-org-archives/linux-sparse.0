From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 09:30:37 +0200
Message-ID: <20170707073036.x2kzu3tdu4kafky3@ltop.local>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
 <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <20170707054459.pkhqnmrz7yt3sppc@ltop.local>
 <CANeU7Q=6MZSn2Lm_+xhqrR1mU95Fq-j6oox8jEYqW+zW=UYTEA@mail.gmail.com>
 <20170707061016.gcbmwrp7zbhlhbpv@ltop.local>
 <CANeU7Q===1Qm0kEGX4DQLeY9jeu1DdmhzvKGw7FNG1j5zWz-gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34100 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdGGHam (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 03:30:42 -0400
Received: by mail-wr0-f169.google.com with SMTP id 77so34300812wrb.1
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 00:30:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q===1Qm0kEGX4DQLeY9jeu1DdmhzvKGw7FNG1j5zWz-gw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 06, 2017 at 11:27:58PM -0700, Christopher Li wrote:
> On Thu, Jul 6, 2017 at 11:10 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> >> Go try this patch with a "make check". It has over one hundreds fails.
> >
> > I'll do, later (just wakeup here).
> 
> No problem at all.
> 
> Just a head up. I need to crash soon. And tomorrow I will not have much
> Internet access at all. I have time to code but no internet. I will see if I
> can get a ptrlist safe against delete.

Sure, no problem.
 
> Sparse ptrlist currently has very subtle bug on this situation.

Yes, it's not the first time we have been bitten by them.

The real problem, in my opinion, is:
- The ptr_list macros & functions have rules about their usage but
  * they are not explained at all
  * they is no way to enforce them or detect a violation
  * detection a violation will probably have a cost higher than
    we'll be willing to pay.
  * it's hard to not violate these rules because list walking is
    ubiquitous.
- Problems can only occurs when deleting an element from the list.
  Pure walking of the list, adding an element or modifying one
  is safe. Even modifying the pointer itself, like, for example,
  setting it to NULL, is safe (hint, hint!).

-- Luc
