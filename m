From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Upcoming sparse release RC5
Date: Wed, 9 Aug 2017 02:40:38 +0200
Message-ID: <CAExDi1StMLzq=yvkhTAyViPr57PQKQ4ifMm22xB4PyzEnDmnnQ@mail.gmail.com>
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
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34797 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbdHIAkk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 8 Aug 2017 20:40:40 -0400
Received: by mail-qt0-f178.google.com with SMTP id s6so28668278qtc.1
        for <linux-sparse@vger.kernel.org>; Tue, 08 Aug 2017 17:40:39 -0700 (PDT)
In-Reply-To: <CANeU7Qn1wfucEqfsyGjqoLwJRwAxpreh_r+Fk7Q0yJYVbEQamw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 8, 2017 at 3:44 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, Aug 8, 2017 at 8:02 AM, Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:
>> On Tue, Aug 8, 2017 at 4:38 AM, Christopher Li <sparse@chrisli.org> wrote:
>>>
>>> You need to make "for-chris" fast forwardable from master.
>>>
>>
>> It's possible to work like this too if you wish so.
>> It means that this 'for-chris' becomes the integration tree and
>> all patches need to go through this tree first.
>
> That effective make Luc control what become the master branch. It does mean
> that patch in sparse-next will go through Luc's "for-chris" to become part of
> master.

I just find that in this case 'for-chris' doesn't convey the right intention.
So for now, I'll use 'tip', it's a branch, will never be rebased and will be
fast-forwardable from master (and its name won't change anymore).

> I hope that clear up the git pull situations on sparse-next. If it helps, I can
> also rename spase-next to "unstable".

I think that those sparse-next-XXXX branches have no place on the master
repository, they never had. Even as tags they shouldn't be there.

Review and testing can and should be done on topic branches in separate
repositories. We can have a sparse/sparse-dev for that if needed. Once
acked & tested, as agreed here above, I'll do the integration.
Since integration will be done through my tree there won't be a need
for such branches on the main repo.

I don't see the need for an unstable branch on the main repository,
on the contrary, it's a nuisance for everybody.

Regards,
-- Luc
