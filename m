From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL v5] fix list corruption with recursive remove_usage()
Date: Mon, 7 Aug 2017 22:19:30 -0400
Message-ID: <CANeU7Qm1+eJYJmeUtY1Hjc9u5VUfpYHT-LLyfCRaXEOVTg_E-Q@mail.gmail.com>
References: <20170808020022.12729-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33340 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbdHHCTb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 22:19:31 -0400
Received: by mail-pf0-f173.google.com with SMTP id h68so8582194pfk.0
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 19:19:31 -0700 (PDT)
In-Reply-To: <20170808020022.12729-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 10:00 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> ----------------------------------------------------------------
> The following changes since commit 0c4c998690e5e31696404fa518022865fd9232d2:
>
>   fix crash with sym->bb_target == NULL (2017-07-31 22:21:59 +0200)
>
> are available in the git repository at:
>
>   git://github.com/lucvoo/sparse.git for-chris
>
> for you to fetch changes up to faad58bc8499e52ccf71da79a2ba46e2d928e33e:
>
>   mark pseudo users as deleted instead of removing them (2017-08-08 03:46:26 +0200)

There is slight issue with "for-chris".

- Your "for-chris" is not fast forwardable from master.
- Your "for-chris" does not contain
   "take comma expr in account for constant value"
   "fix: give a type to bad cond expr with known condition"

Which I already apply in sparse-next.

When I rebase spase-next, I will use your "for-chris" as base.
It will end up rebase the above two changes for you.
Which you will complain.

I am not falling for that trap :-)

Let me repeat. The "for-chris" branch should:
1. fast forwardable from master
2. contain *all* of the patches from you that want me to pull.

"for-chris" doesn't need to be always fast forward-able to the
last "for-chris" point.

If you need to fix the "for-chris" for some v4-> v5. Go ahead
and rebase the "for-chris" as you like. It is your call how to
make "for-chris" stable the way you like.

The implications is that. You practically define the stable part
of  the master branch. My sparse-next will always use your
"for-chris" as base.

I think that will be the best way for our current development
model. It give you to control the stable point on master, it give
me the flexibility to rebase spase-next.

Chris
