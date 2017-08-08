From: Christopher Li <sparse@chrisli.org>
Subject: Re: Upcoming sparse release RC5
Date: Tue, 8 Aug 2017 15:03:19 -0400
Message-ID: <CANeU7Qnn=-M3MrUBwPdGqog5T+NiSLS_xgnww0jM53+KYimxtQ@mail.gmail.com>
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
 <CAExDi1RWu1geE77zfQJxATcpVziEEpm4PiOKJ2kMGuZzawubwQ@mail.gmail.com>
 <CANeU7Qn1wfucEqfsyGjqoLwJRwAxpreh_r+Fk7Q0yJYVbEQamw@mail.gmail.com> <CACXZuxfXE7cbdGPXvTTpyka77MD0iuyLrK39vjbA=W0prUjPaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36989 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbdHHTDV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 8 Aug 2017 15:03:21 -0400
Received: by mail-pg0-f45.google.com with SMTP id y129so18342852pgy.4
        for <linux-sparse@vger.kernel.org>; Tue, 08 Aug 2017 12:03:21 -0700 (PDT)
In-Reply-To: <CACXZuxfXE7cbdGPXvTTpyka77MD0iuyLrK39vjbA=W0prUjPaA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 8, 2017 at 12:10 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> I am not sure why you consider some history "dirty". I think all
> history is good as it tells people how the change evolved, If you
> apply a patch and a bug is found, or you want to amend the patch

For example, there is some internal version of patches has some compile error.
That definitely don't want to be part of the history. It will hurt the
binary search.
Some patch in the early version might be totally wrong, that does not
need to go into history. e.g. the revert of the change and revert of the revert
later on.

I consider a patch will take some time and experiment to mature.
We don't have to submit every generation of the patch into history.

> somehow, in my view there should simply be another patch or change
> done following the original rather than trying to backout history and
> redo the patch. I am not a git expert so I cannot comment on the git
> processes but conceptually I am saying that all history is good.

If follow the process I suggested, that ultimately give Luc the flexibility to
use the linear incremental history or the clean up version of the history.
He has the most pending changes.

I prefer the clean up histories, but I can do the all detail dirty history
as well if that is we all agree to do.

Chris
