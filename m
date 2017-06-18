From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] fix bogus "crazy progammer"
Date: Sun, 18 Jun 2017 10:11:05 +0200
Message-ID: <20170618081104.hxfykfovebsdt6lf@ltop.local>
References: <20170616191844.86256-1-luc.vanoostenryck@gmail.com>
 <8132b29c-0bfc-9294-8040-a2f7271affd6@ramsayjones.plus.com>
 <20170617034449.6clvouwqxpfiujrb@ltop.local>
 <3c71421d-eb26-5268-7701-568d59e5b4d0@ramsayjones.plus.com>
 <20170618064340.czth3trqkb4tu5al@ltop.local>
 <CANeU7Q=keoffx75SxwPeS3UxWUKTxJ=LNPheqTncpgvNTDUP3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36029 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdFRILJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Jun 2017 04:11:09 -0400
Received: by mail-wm0-f47.google.com with SMTP id m125so55772949wmm.1
        for <linux-sparse@vger.kernel.org>; Sun, 18 Jun 2017 01:11:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=keoffx75SxwPeS3UxWUKTxJ=LNPheqTncpgvNTDUP3Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Jun 18, 2017 at 12:24:17AM -0700, Christopher Li wrote:
> On Sat, Jun 17, 2017 at 11:43 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > For info, I also tested on some other platform, just for the fun
> > and only running the testsuite. The results are:
> 
> Great you have got this issue fix.
> 
> I assume you want this fix merge for the -rc2 as well, right?

Yes, sure.
I would like to let it 'soak' a little bit more but I don't see
well how it could be more tested.
I may try the kernel on some non-x86 archs but it won't be for
today or tomorrow.

I have also a patch series for the root cause of the 1st patch:
the misplacement of phi-nodes. This series solve all sort of
problems but it's not the kind of changes for this release:
it's radical changes to some pretty fundamental things and it's
diffstat is: "16 files changed, 679 insertions(+), 476 deletions(-)"
excluding all the changes in the testcases. This will need to
wait for after the release and it's not yet ready anyway, not
even close to.

For the release, I also want the other fix I posted this week,
the one titled "fix: add missing examine in evaluate_dereference()"
which is much more straight-forward.


I'll send another pull request in the next few days.

-- Luc
