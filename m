From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Upcoming sparse release RC5
Date: Mon, 7 Aug 2017 20:31:39 -0700
Message-ID: <CA+55aFyB0nODr5eHnEE4_gfiff0o8L=nVakA=1Ngt=69DPWXZg@mail.gmail.com>
References: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
 <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com>
 <CANeU7QnY20n-UHY07RotcAJzFtMREB-CcsE1WXLi=b=cwQCizQ@mail.gmail.com>
 <CAExDi1QVtkoFCXzSoP0mg+3gbE45Z-bOGLAtjsTi8tsQZMdcEg@mail.gmail.com>
 <CANeU7Q=9Ma3+gA21+=bLi38XFw5B1FDoVFUvtaxLR3V0oHeCig@mail.gmail.com>
 <20170808002331.f3g6l7yzhsq3vhxe@ltop.local> <CANeU7QmJmzumvNNFm5W=Ti8TJdw-BZ2DeR0t2UXO-R2vCjqh6Q@mail.gmail.com>
 <CAExDi1R6Vg8cztVA32nOEHKRgpiUcZnHfOoK6rshJq46FSaj2g@mail.gmail.com>
 <CANeU7QkU+GZA6J_B5SdZw0L=yvmYr_V=ue-h-TrZoWaGc-ATvg@mail.gmail.com>
 <CAExDi1QDDDTKb9Ht6-pquT1w5PS_G+yCBPtoYLofuMPVuxgN+Q@mail.gmail.com> <CANeU7Q=bCw0wYWsNTgbu=mLmDq40_Db-=f2rTb+UC2b8szpxvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33204 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbdHHDbk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 23:31:40 -0400
Received: by mail-oi0-f49.google.com with SMTP id f11so6737750oic.0
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 20:31:40 -0700 (PDT)
In-Reply-To: <CANeU7Q=bCw0wYWsNTgbu=mLmDq40_Db-=f2rTb+UC2b8szpxvA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 7:38 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> You need to make "for-chris" fast forwardable from master.

Chris, that makes no sense at all.

If you ever apply any other patches than the patches from Luc,
suddenly his "for-chris" is no longer fast-forwardeable.

Why do you want that stupid linear history in the first place? Why
can't you just merge Luc's git tree? That's how git is supposed to
work, and it makes it easier for everybody.

This whole rebasing is a disease. It is basically *impossible* to work
sanely with other people if you keep rebasing.

You mustn't rebase other peoples work (because that causes tons of
extra work for them) when you pull, and if you apply any other patches
(or commit any of your own work), then Luc's branch by definition will
need merging.

Nobody else works like you do. Yes, other people have unstable
branches (eg git's own "pu" branch), but those are for experimental
stuff, not for working with anybody else.

Rebasing really is wrong for any pubic tree. Its' fine for your own
_private_ pacthes, as you develop and clean up a branch that you're
still working on, but it shouldn't be an integration model.

                   Linus
