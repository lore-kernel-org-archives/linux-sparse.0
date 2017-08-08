From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Upcoming sparse release RC5
Date: Tue, 8 Aug 2017 04:13:32 +0200
Message-ID: <CAExDi1QDDDTKb9Ht6-pquT1w5PS_G+yCBPtoYLofuMPVuxgN+Q@mail.gmail.com>
References: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
 <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com>
 <CANeU7QnY20n-UHY07RotcAJzFtMREB-CcsE1WXLi=b=cwQCizQ@mail.gmail.com>
 <CAExDi1QVtkoFCXzSoP0mg+3gbE45Z-bOGLAtjsTi8tsQZMdcEg@mail.gmail.com>
 <CANeU7Q=9Ma3+gA21+=bLi38XFw5B1FDoVFUvtaxLR3V0oHeCig@mail.gmail.com>
 <20170808002331.f3g6l7yzhsq3vhxe@ltop.local> <CANeU7QmJmzumvNNFm5W=Ti8TJdw-BZ2DeR0t2UXO-R2vCjqh6Q@mail.gmail.com>
 <CAExDi1R6Vg8cztVA32nOEHKRgpiUcZnHfOoK6rshJq46FSaj2g@mail.gmail.com> <CANeU7QkU+GZA6J_B5SdZw0L=yvmYr_V=ue-h-TrZoWaGc-ATvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34566 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbdHHCNe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 22:13:34 -0400
Received: by mail-qk0-f178.google.com with SMTP id u139so12618466qka.1
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 19:13:33 -0700 (PDT)
In-Reply-To: <CANeU7QkU+GZA6J_B5SdZw0L=yvmYr_V=ue-h-TrZoWaGc-ATvg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 8, 2017 at 3:34 AM, Christopher Li <sparse@chrisli.org> wrote:

> If you maintain that "for-chris" to aggregate your own topic branch.
> I can just use "for-chris" as a base to rease the sparse-next,
> I only need to rebase patches not from you.

Yes, exactly.

> I do want to have the flexibility to rebase spase-next.
> It is just how to do it in a way impact you less.

Just don't rebase my series. I maintain a few aggregation
branches with all the topics branches I need and often
do new dev on top of them because I need to.
When I don't need it I base new dev on some stable point
like master.

If it is a small thing I did the day before, it won't probably be a big
problem but for older stuff it is.

>>> I often need to seek clarify if this patches series is mean for merge.
>>> If you make that in the dedicate pull branch, I will know for sure.

Let's do as we had agreed: real pull request will have "[GIT PULL]"
in the email and will always be from the 'for-chris'. I also guarantee
that the pull will not need a non-trivial merge when done from
the current sparse-next.

-- Luc
