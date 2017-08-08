From: Christopher Li <sparse@chrisli.org>
Subject: Re: Upcoming sparse release RC5
Date: Tue, 8 Aug 2017 09:44:10 -0400
Message-ID: <CANeU7Qn1wfucEqfsyGjqoLwJRwAxpreh_r+Fk7Q0yJYVbEQamw@mail.gmail.com>
References: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
 <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com>
 <CANeU7QnY20n-UHY07RotcAJzFtMREB-CcsE1WXLi=b=cwQCizQ@mail.gmail.com>
 <CAExDi1QVtkoFCXzSoP0mg+3gbE45Z-bOGLAtjsTi8tsQZMdcEg@mail.gmail.com>
 <CANeU7Q=9Ma3+gA21+=bLi38XFw5B1FDoVFUvtaxLR3V0oHeCig@mail.gmail.com>
 <20170808002331.f3g6l7yzhsq3vhxe@ltop.local> <CANeU7QmJmzumvNNFm5W=Ti8TJdw-BZ2DeR0t2UXO-R2vCjqh6Q@mail.gmail.com>
 <CAExDi1R6Vg8cztVA32nOEHKRgpiUcZnHfOoK6rshJq46FSaj2g@mail.gmail.com>
 <CANeU7QkU+GZA6J_B5SdZw0L=yvmYr_V=ue-h-TrZoWaGc-ATvg@mail.gmail.com>
 <CAExDi1QDDDTKb9Ht6-pquT1w5PS_G+yCBPtoYLofuMPVuxgN+Q@mail.gmail.com>
 <CANeU7Q=bCw0wYWsNTgbu=mLmDq40_Db-=f2rTb+UC2b8szpxvA@mail.gmail.com> <CAExDi1RWu1geE77zfQJxATcpVziEEpm4PiOKJ2kMGuZzawubwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34574 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752174AbdHHNoM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 8 Aug 2017 09:44:12 -0400
Received: by mail-pf0-f179.google.com with SMTP id o86so14810019pfj.1
        for <linux-sparse@vger.kernel.org>; Tue, 08 Aug 2017 06:44:11 -0700 (PDT)
In-Reply-To: <CAExDi1RWu1geE77zfQJxATcpVziEEpm4PiOKJ2kMGuZzawubwQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 8, 2017 at 8:02 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Tue, Aug 8, 2017 at 4:38 AM, Christopher Li <sparse@chrisli.org> wrote:
>>
>> You need to make "for-chris" fast forwardable from master.
>>
>
> It's possible to work like this too if you wish so.
> It means that this 'for-chris' becomes the integration tree and
> all patches need to go through this tree first.

More precisely, the "for-chris" will be come the proposal of the  integration
tree. If I am happy with "for-chris" and Luc don't intend to rebase "for-chris"
any more. The master can just sync up to the "for-chris". Everybody is happy.

If I have some feed back for "for-chris" V3 and Luc decide to incorporate the
feed back and come back with "for-chris" V4. Notice the "for-chris" V4 does
not need to be fast forwardable from V3. If Luc wants the V4 contain a "clean"
history, he is free to do so. Of course he want to have incremental change
from V3 -> V4, V3 will show up in master history. That is of fine too.
It is Luc's
call.

That effective make Luc control what become the master branch. It does mean
that patch in sparse-next will go through Luc's "for-chris" to become part of
master. The net effect is that, if Luc and I want to clean up the experimental
history, we can do so. Those V1...V3 internal version don't have to show up
on master.

From my point of view, I think that is the model Luc and I already agree on
about two month back, when we have the discussion how to do git pull properly
for sparse using pull request.  I kind of see Luc doing that for
sparse up to RC3,
He is already integrating the static assert patches etc. Luc's is not using a
"for-chris" branch though, I did not insist either.

I did not realized that there is an understand gap how this git pull request
will work on Luc's side. I did not see the proper git pull request I
assume those
patch on mailing list are for discussion/experimental only. I have send email
to clarify those are for git pull or not.

I hope that clear up the git pull situations on sparse-next. If it helps, I can
also rename spase-next to "unstable". I am also open to suggestion for how
this integration should be done. The original intend for having this complex
model is to get rid of the dirty history. If that turn out to be the
bigger evil.
We can do the other way around as well.

Chris
