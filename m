From: Christopher Li <sparse@chrisli.org>
Subject: Re: Upcoming sparse release RC5
Date: Mon, 7 Aug 2017 22:38:46 -0400
Message-ID: <CANeU7Q=bCw0wYWsNTgbu=mLmDq40_Db-=f2rTb+UC2b8szpxvA@mail.gmail.com>
References: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
 <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com>
 <CANeU7QnY20n-UHY07RotcAJzFtMREB-CcsE1WXLi=b=cwQCizQ@mail.gmail.com>
 <CAExDi1QVtkoFCXzSoP0mg+3gbE45Z-bOGLAtjsTi8tsQZMdcEg@mail.gmail.com>
 <CANeU7Q=9Ma3+gA21+=bLi38XFw5B1FDoVFUvtaxLR3V0oHeCig@mail.gmail.com>
 <20170808002331.f3g6l7yzhsq3vhxe@ltop.local> <CANeU7QmJmzumvNNFm5W=Ti8TJdw-BZ2DeR0t2UXO-R2vCjqh6Q@mail.gmail.com>
 <CAExDi1R6Vg8cztVA32nOEHKRgpiUcZnHfOoK6rshJq46FSaj2g@mail.gmail.com>
 <CANeU7QkU+GZA6J_B5SdZw0L=yvmYr_V=ue-h-TrZoWaGc-ATvg@mail.gmail.com> <CAExDi1QDDDTKb9Ht6-pquT1w5PS_G+yCBPtoYLofuMPVuxgN+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33591 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdHHCir (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 22:38:47 -0400
Received: by mail-pf0-f172.google.com with SMTP id h68so8746169pfk.0
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 19:38:47 -0700 (PDT)
In-Reply-To: <CAExDi1QDDDTKb9Ht6-pquT1w5PS_G+yCBPtoYLofuMPVuxgN+Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 10:13 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:

>> I do want to have the flexibility to rebase spase-next.
>> It is just how to do it in a way impact you less.
>
> Just don't rebase my series. I maintain a few aggregation
> branches with all the topics branches I need and often
> do new dev on top of them because I need to.
> When I don't need it I base new dev on some stable point
> like master.

Do as I suggested, I always use "for-chris" as base.
You always put all the bits you want me to pull in "for-chris".
I will not rebase your series at all. Why? because your
"for-chris" are the base for me.

You need to make "for-chris" fast forwardable from master.

> If it is a small thing I did the day before, it won't probably be a big
> problem but for older stuff it is.

The beauty in my model is that. It does not matter how long does
sparse-next merge back to master. The you provide your own
stable point which I rebase on top of.

> Let's do as we had agreed: real pull request will have "[GIT PULL]"
> in the email and will always be from the 'for-chris'. I also guarantee
> that the pull will not need a non-trivial merge when done from
> the current sparse-next.

That will make your harder to make some V4 -> V5 change.

Your "for-chris" contain all your patches you want me to pull. Then
sparse-next only rebase on your "for-chris". Let me due with the
merges (not from your patch).

Chris
