From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Upcoming sparse release RC5
Date: Tue, 8 Aug 2017 03:43:08 +0200
Message-ID: <CAExDi1R8GzvkAaGOUfkTLctuFfiA8JaF8vzp2mRr+-fKSaNzGA@mail.gmail.com>
References: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
 <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com>
 <CANeU7QnY20n-UHY07RotcAJzFtMREB-CcsE1WXLi=b=cwQCizQ@mail.gmail.com>
 <CAExDi1QVtkoFCXzSoP0mg+3gbE45Z-bOGLAtjsTi8tsQZMdcEg@mail.gmail.com>
 <CANeU7Q=9Ma3+gA21+=bLi38XFw5B1FDoVFUvtaxLR3V0oHeCig@mail.gmail.com>
 <20170808002331.f3g6l7yzhsq3vhxe@ltop.local> <CANeU7QmJmzumvNNFm5W=Ti8TJdw-BZ2DeR0t2UXO-R2vCjqh6Q@mail.gmail.com>
 <CAExDi1R6Vg8cztVA32nOEHKRgpiUcZnHfOoK6rshJq46FSaj2g@mail.gmail.com> <CANeU7QkU+GZA6J_B5SdZw0L=yvmYr_V=ue-h-TrZoWaGc-ATvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33663 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbdHHBnK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 21:43:10 -0400
Received: by mail-qk0-f177.google.com with SMTP id a77so12458441qkb.0
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 18:43:09 -0700 (PDT)
In-Reply-To: <CANeU7QkU+GZA6J_B5SdZw0L=yvmYr_V=ue-h-TrZoWaGc-ATvg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 8, 2017 at 3:34 AM, Christopher Li <sparse@chrisli.org> wrote:
>>> I just checked, that compile error still on the git url you send out
>>> in the email. I still can't use it
>>
>> Are you sure?
>> in the link I pasted here above, the git branch is:
>>
>>     git://github.com/lucvoo/sparse.git fix-nested-pseudo-users-deletion-v4
>>
>>     aka: bddf7d1e4ed81c3def7c6de2796a5489ca678399
>
> Yes, see the git log -p bddf7d1e4ed81c3def7c6de2796a5489ca678399

Yes, I see now.
It compiles but not the previous commit.

please ignore the pull request I just sent.

--Luc
