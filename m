From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Upcoming sparse release RC5
Date: Thu, 10 Aug 2017 01:42:09 +0100
Message-ID: <CACXZuxfcQ8t3VP1QtQpuB8Pz2Uv0o5RHUaLVSx5as312v8ryVw@mail.gmail.com>
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
 <CACXZuxd83EjbX5i9cgo0H3TTNKBV+pHec7HURVb2GF-GJOFszQ@mail.gmail.com> <CANeU7Q=w3REgmDDQ-t6LyWrnOijqcxnokr3AjCC4Rqk3x7ZmvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:36465 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbdHJAmL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 20:42:11 -0400
Received: by mail-ua0-f180.google.com with SMTP id k43so35153710uaf.3
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 17:42:10 -0700 (PDT)
In-Reply-To: <CANeU7Q=w3REgmDDQ-t6LyWrnOijqcxnokr3AjCC4Rqk3x7ZmvA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 10 August 2017 at 01:18, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Aug 9, 2017 at 5:10 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> I think that compile error should not be possible? Because before you
>> merge any patch presumably you build Sparse and run the tests?
>>
>> As for other changes that were later removed - in my view this is
>> valuable history as it tells people what was tried and discarded and
>> why. I still feel all history is good.
>>
>
> OK. I think my obsession of "clean up the history" is wrong and not  worthy
> doing. Linus's criticism of sparse-next rebase is correct.  I will just got back
> to the master doing the normal git pull and merges. That actually simplify
> my own work flow as we.
>

It will also help me if I can assume that a patch will not be re-done.
At the moment I cannot apply any patch - because I do not know if a
new version of the patch will be published soon. Instead if changes
always go forward - i.e. you apply fixes to existing patches - then I
can safely apply a patch, and when a fix is published, apply the fix.

I learnt from database technology that it is better for changes to
always go forward - trying to revert past changes by undoing them is
troublesome as it means you may need to undo all changes that follow
the one you want to undo. Progress can become very difficult in this
approach. That is why in databases, often undo is just another forward
change - there is no going back to remove a past change. A really good
description of this approach is given in the ARIES approach to
database recovery.

Regards
Dibyendu
