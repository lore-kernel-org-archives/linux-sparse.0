From: Christopher Li <sparse@chrisli.org>
Subject: Re: Upcoming sparse release RC5
Date: Mon, 7 Aug 2017 19:32:37 -0400
Message-ID: <CANeU7Q=9Ma3+gA21+=bLi38XFw5B1FDoVFUvtaxLR3V0oHeCig@mail.gmail.com>
References: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
 <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com>
 <CANeU7QnY20n-UHY07RotcAJzFtMREB-CcsE1WXLi=b=cwQCizQ@mail.gmail.com> <CAExDi1QVtkoFCXzSoP0mg+3gbE45Z-bOGLAtjsTi8tsQZMdcEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:37164 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbdHGXcj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 19:32:39 -0400
Received: by mail-pg0-f51.google.com with SMTP id y129so7282319pgy.4
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 16:32:38 -0700 (PDT)
In-Reply-To: <CAExDi1QVtkoFCXzSoP0mg+3gbE45Z-bOGLAtjsTi8tsQZMdcEg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 12:41 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> I think I use one of your branch as base. I will fix it now.
>
> You have now rebased an existing branch,
> the one for "fix crash with sym->bb_target == NULL".
> There was no reasons for that.

I just do git rebase master from the sparse-next.

I think sparse-next was design to allow to rebase.

It is not about git pull any more, because I rebase the sparse-next
from your branch, I need rebase because I need to throw out the
patch replaced by yours in sparse-next.

Your branch is not fast forward to master.

If your branch is fast forward to master then I don't need to
rebase sparse-next to master again.

That being said, what is your recommended way to fix it instead
of rebase?

We can still fix up sparse-next as I haven't push to master.

Chris
