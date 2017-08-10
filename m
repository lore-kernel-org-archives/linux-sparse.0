From: Christopher Li <sparse@chrisli.org>
Subject: Re: Upcoming sparse release RC5
Date: Wed, 9 Aug 2017 20:18:31 -0400
Message-ID: <CANeU7Q=w3REgmDDQ-t6LyWrnOijqcxnokr3AjCC4Rqk3x7ZmvA@mail.gmail.com>
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
 <CANeU7Qn1wfucEqfsyGjqoLwJRwAxpreh_r+Fk7Q0yJYVbEQamw@mail.gmail.com>
 <CACXZuxfXE7cbdGPXvTTpyka77MD0iuyLrK39vjbA=W0prUjPaA@mail.gmail.com>
 <CANeU7Qnn=-M3MrUBwPdGqog5T+NiSLS_xgnww0jM53+KYimxtQ@mail.gmail.com> <CACXZuxd83EjbX5i9cgo0H3TTNKBV+pHec7HURVb2GF-GJOFszQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:36406 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752178AbdHJASc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 20:18:32 -0400
Received: by mail-yw0-f174.google.com with SMTP id u207so49665372ywc.3
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 17:18:32 -0700 (PDT)
In-Reply-To: <CACXZuxd83EjbX5i9cgo0H3TTNKBV+pHec7HURVb2GF-GJOFszQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 9, 2017 at 5:10 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> I think that compile error should not be possible? Because before you
> merge any patch presumably you build Sparse and run the tests?
>
> As for other changes that were later removed - in my view this is
> valuable history as it tells people what was tried and discarded and
> why. I still feel all history is good.
>

OK. I think my obsession of "clean up the history" is wrong and not  worthy
doing. Linus's criticism of sparse-next rebase is correct.  I will just got back
to the master doing the normal git pull and merges. That actually simplify
my own work flow as we.

Chris
