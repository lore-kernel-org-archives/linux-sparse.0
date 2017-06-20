From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] fix bogus "crazy progammer"
Date: Tue, 20 Jun 2017 20:48:23 +0200
Message-ID: <20170620184822.3h3qqjkfput6lune@ltop.local>
References: <20170616191844.86256-1-luc.vanoostenryck@gmail.com>
 <8132b29c-0bfc-9294-8040-a2f7271affd6@ramsayjones.plus.com>
 <20170617034449.6clvouwqxpfiujrb@ltop.local>
 <3c71421d-eb26-5268-7701-568d59e5b4d0@ramsayjones.plus.com>
 <20170618064340.czth3trqkb4tu5al@ltop.local>
 <CANeU7Q=keoffx75SxwPeS3UxWUKTxJ=LNPheqTncpgvNTDUP3Q@mail.gmail.com>
 <20170618081104.hxfykfovebsdt6lf@ltop.local>
 <CANeU7Qmu40UR_iThsYY-Z-7tKmRQy3UZtx_5fCV8OP9PuXZdnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34480 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdFTSs1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Jun 2017 14:48:27 -0400
Received: by mail-wr0-f193.google.com with SMTP id y25so17439278wrd.1
        for <linux-sparse@vger.kernel.org>; Tue, 20 Jun 2017 11:48:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qmu40UR_iThsYY-Z-7tKmRQy3UZtx_5fCV8OP9PuXZdnA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jun 20, 2017 at 11:09:18AM -0700, Christopher Li wrote:
> On Sun, Jun 18, 2017 at 1:11 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Yes, sure.
> > I would like to let it 'soak' a little bit more but I don't see
> > well how it could be more tested.
> 
> Understand. Do you want it on sparse-next while have it soaking?

IIRC, one of the two patches need a small changes.

I'll send you a pull request with the others few fixes.
But I have first some cleanup to do and some retesting.

> > I may try the kernel on some non-x86 archs but it won't be for
> > today or tomorrow.

There was some issues on ARM64.
I also made two changes for freebsd & openbsd that were broken.

> > I have also a patch series for the root cause of the 1st patch:
> > the misplacement of phi-nodes. This series solve all sort of
> > problems but it's not the kind of changes for this release:
> > it's radical changes to some pretty fundamental things and it's
> > diffstat is: "16 files changed, 679 insertions(+), 476 deletions(-)"
> > excluding all the changes in the testcases. This will need to
> > wait for after the release and it's not yet ready anyway, not
> > even close to.
> 
> Thanks I was wondering how complicate is the proper fix like.
> That is good to know.

Yes it's definitively not release material but I've fixed a blocking
issue, so I'll post the series soon. But for the moment, I focus
on the release.

> >
> > For the release, I also want the other fix I posted this week,
> > the one titled "fix: add missing examine in evaluate_dereference()"
> > which is much more straight-forward.
> 
> I have pull your "for-chris" branch into sparse-next.

Yes, I saw. Thanks. 

-- Luc
