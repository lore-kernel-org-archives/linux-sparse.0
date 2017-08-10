From: Christopher Li <sparse@chrisli.org>
Subject: Re: Upcoming sparse release RC5
Date: Wed, 9 Aug 2017 20:24:14 -0400
Message-ID: <CANeU7Qkx5DmXaVN+Gzuzi_359DJKXryoYfqF1c9PmV_KHq38Gw@mail.gmail.com>
References: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
 <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com>
 <CANeU7QnY20n-UHY07RotcAJzFtMREB-CcsE1WXLi=b=cwQCizQ@mail.gmail.com>
 <CAExDi1QVtkoFCXzSoP0mg+3gbE45Z-bOGLAtjsTi8tsQZMdcEg@mail.gmail.com>
 <CANeU7Q=9Ma3+gA21+=bLi38XFw5B1FDoVFUvtaxLR3V0oHeCig@mail.gmail.com>
 <20170808002331.f3g6l7yzhsq3vhxe@ltop.local> <CANeU7QmJmzumvNNFm5W=Ti8TJdw-BZ2DeR0t2UXO-R2vCjqh6Q@mail.gmail.com>
 <CAExDi1R6Vg8cztVA32nOEHKRgpiUcZnHfOoK6rshJq46FSaj2g@mail.gmail.com>
 <CANeU7QkU+GZA6J_B5SdZw0L=yvmYr_V=ue-h-TrZoWaGc-ATvg@mail.gmail.com>
 <CAExDi1QDDDTKb9Ht6-pquT1w5PS_G+yCBPtoYLofuMPVuxgN+Q@mail.gmail.com>
 <CANeU7Q=bCw0wYWsNTgbu=mLmDq40_Db-=f2rTb+UC2b8szpxvA@mail.gmail.com> <CA+55aFyB0nODr5eHnEE4_gfiff0o8L=nVakA=1Ngt=69DPWXZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35093 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbdHJAYX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 20:24:23 -0400
Received: by mail-yw0-f169.google.com with SMTP id l82so49634127ywc.2
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 17:24:23 -0700 (PDT)
In-Reply-To: <CA+55aFyB0nODr5eHnEE4_gfiff0o8L=nVakA=1Ngt=69DPWXZg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 11:31 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Why do you want that stupid linear history in the first place? Why
> can't you just merge Luc's git tree? That's how git is supposed to
> work, and it makes it easier for everybody.
>
> This whole rebasing is a disease. It is basically *impossible* to work
> sanely with other people if you keep rebasing.

I carefully think over it. You are right. Try to clean up history actually
make the whole integration a lot worse. I will take your advice and just
do the simple git merge on master from now on.

>
> You mustn't rebase other peoples work (because that causes tons of
> extra work for them) when you pull, and if you apply any other patches
> (or commit any of your own work), then Luc's branch by definition will
> need merging.

I will remember no to rebase other peoples work..

Thanks.

Chris
