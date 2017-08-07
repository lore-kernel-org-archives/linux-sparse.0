From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Upcoming sparse release RC5
Date: Tue, 8 Aug 2017 01:58:11 +0200
Message-ID: <20170807235810.gtmuumczq3li56zx@ltop.local>
References: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
 <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com>
 <CANeU7QnY20n-UHY07RotcAJzFtMREB-CcsE1WXLi=b=cwQCizQ@mail.gmail.com>
 <CAExDi1QVtkoFCXzSoP0mg+3gbE45Z-bOGLAtjsTi8tsQZMdcEg@mail.gmail.com>
 <CANeU7Q=9Ma3+gA21+=bLi38XFw5B1FDoVFUvtaxLR3V0oHeCig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35144 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbdHGX6O (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 19:58:14 -0400
Received: by mail-wm0-f53.google.com with SMTP id m85so18517092wma.0
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 16:58:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=9Ma3+gA21+=bLi38XFw5B1FDoVFUvtaxLR3V0oHeCig@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 07, 2017 at 07:32:37PM -0400, Christopher Li wrote:
> That being said, what is your recommended way to fix it instead
> of rebase?
> 
> We can still fix up sparse-next as I haven't push to master.

There was something like:
	.. rc4 - fix-crashes-v3 - some others patches - sparse-next
               \ noipa = master

Where master must be stable and fix-crashes-v3 is the external branch.
The external branch is fast-forwardable to master but not always
based on the top of it (because it was developed & tested earlier).

So late in the release and with sparse-next having received
quite a bit testing I would expect to be stable (in the git meaning)
and master to be fast-forwardable to it.

So, IMO the thing to do in this case would have been to merge 
the external branch with master and only rebase the others patches
on top of this merge point. So we would have something like this:
	.. rc4 - fix-crashes-v3  - some others patches - sparse-next
               \ noipa = master /

but instead, because of the rebasing, we have:
	.. rc4 - fix-crashes-v3
	       \ master - rebased-fix-crashes-v3  - some others patches - sparse-next

and this create problems for development done on top of the external branch
(basically you force them to also rebase their work or to have duplicated
commits in the tree).

The correct workflow is to never rebase anything you pulled.


That said, I think that part of the problem is that things stay for too long
in this sparse-next. As soon as something is tested well enough, it should
move to master. 

-- Luc
