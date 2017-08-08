From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Upcoming sparse release RC5
Date: Tue, 8 Aug 2017 17:10:04 +0100
Message-ID: <CACXZuxfXE7cbdGPXvTTpyka77MD0iuyLrK39vjbA=W0prUjPaA@mail.gmail.com>
References: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
 <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com>
 <CANeU7QnY20n-UHY07RotcAJzFtMREB-CcsE1WXLi=b=cwQCizQ@mail.gmail.com>
 <CAExDi1QVtkoFCXzSoP0mg+3gbE45Z-bOGLAtjsTi8tsQZMdcEg@mail.gmail.com>
 <CANeU7Q=9Ma3+gA21+=bLi38XFw5B1FDoVFUvtaxLR3V0oHeCig@mail.gmail.com>
 <20170808002331.f3g6l7yzhsq3vhxe@ltop.local> <CANeU7QmJmzumvNNFm5W=Ti8TJdw-BZ2DeR0t2UXO-R2vCjqh6Q@mail.gmail.com>
 <CAExDi1R6Vg8cztVA32nOEHKRgpiUcZnHfOoK6rshJq46FSaj2g@mail.gmail.com>
 <CANeU7QkU+GZA6J_B5SdZw0L=yvmYr_V=ue-h-TrZoWaGc-ATvg@mail.gmail.com>
 <CAExDi1QDDDTKb9Ht6-pquT1w5PS_G+yCBPtoYLofuMPVuxgN+Q@mail.gmail.com>
 <CANeU7Q=bCw0wYWsNTgbu=mLmDq40_Db-=f2rTb+UC2b8szpxvA@mail.gmail.com>
 <CAExDi1RWu1geE77zfQJxATcpVziEEpm4PiOKJ2kMGuZzawubwQ@mail.gmail.com> <CANeU7Qn1wfucEqfsyGjqoLwJRwAxpreh_r+Fk7Q0yJYVbEQamw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35413 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbdHHQKG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 8 Aug 2017 12:10:06 -0400
Received: by mail-wm0-f52.google.com with SMTP id m85so11283380wma.0
        for <linux-sparse@vger.kernel.org>; Tue, 08 Aug 2017 09:10:05 -0700 (PDT)
In-Reply-To: <CANeU7Qn1wfucEqfsyGjqoLwJRwAxpreh_r+Fk7Q0yJYVbEQamw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 8 August 2017 at 14:44, Christopher Li <sparse@chrisli.org> wrote:

> I hope that clear up the git pull situations on sparse-next. If it helps, I can
> also rename spase-next to "unstable". I am also open to suggestion for how
> this integration should be done. The original intend for having this complex
> model is to get rid of the dirty history. If that turn out to be the
> bigger evil.

I am not sure why you consider some history "dirty". I think all
history is good as it tells people how the change evolved, If you
apply a patch and a bug is found, or you want to amend the patch
somehow, in my view there should simply be another patch or change
done following the original rather than trying to backout history and
redo the patch. I am not a git expert so I cannot comment on the git
processes but conceptually I am saying that all history is good.

Regards
Dibyendu
