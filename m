From: Christopher Li <sparse@chrisli.org>
Subject: Re: Upcoming sparse release RC5
Date: Wed, 9 Aug 2017 21:01:45 -0400
Message-ID: <CANeU7Q=098-uU0eUND21an=kHC9Lan-F+n_tSWvrrZu9gbnJTA@mail.gmail.com>
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
 <CANeU7Qnn=-M3MrUBwPdGqog5T+NiSLS_xgnww0jM53+KYimxtQ@mail.gmail.com>
 <CACXZuxd83EjbX5i9cgo0H3TTNKBV+pHec7HURVb2GF-GJOFszQ@mail.gmail.com>
 <CANeU7Q=w3REgmDDQ-t6LyWrnOijqcxnokr3AjCC4Rqk3x7ZmvA@mail.gmail.com> <CACXZuxfcQ8t3VP1QtQpuB8Pz2Uv0o5RHUaLVSx5as312v8ryVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33132 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbdHJBBr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 21:01:47 -0400
Received: by mail-yw0-f169.google.com with SMTP id p68so50097024ywg.0
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 18:01:46 -0700 (PDT)
In-Reply-To: <CACXZuxfcQ8t3VP1QtQpuB8Pz2Uv0o5RHUaLVSx5as312v8ryVw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 9, 2017 at 8:42 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> It will also help me if I can assume that a patch will not be re-done.
> At the moment I cannot apply any patch - because I do not know if a
> new version of the patch will be published soon. Instead if changes
> always go forward - i.e. you apply fixes to existing patches - then I
> can safely apply a patch, and when a fix is published, apply the fix.

Well, I can promise any thing apply to master, which will be the new
integration happening on, will not be rebase or revert.

If there is improvement of already applied patches. It will be a
delta change apply to master.  Master will not roll back, ever.
It actually haven't. However, if the patch is not yet apply to master, the
developer can come up with new versions. That I will not able to stop,
there is no reason to.
>
> I learnt from database technology that it is better for changes to
> always go forward - trying to revert past changes by undoing them is
> troublesome as it means you may need to undo all changes that follow

Yes, master will be always forwarding. It will also solve another problem,
patches takes too long from sparse-next to reach master. So master will
be where integration happens. There is no safe period like sparse-next
any more. The topic branches will still control by their original developer,
I don't have direct control unless that is my topic branch.

> the one you want to undo. Progress can become very difficult in this
> approach. That is why in databases, often undo is just another forward
> change - there is no going back to remove a past change. A really good
> description of this approach is given in the ARIES approach to
> database recovery.

I hope that answer your questions.

Chris
