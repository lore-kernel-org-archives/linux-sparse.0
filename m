From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Upcoming sparse release RC5
Date: Tue, 8 Aug 2017 02:58:08 +0200
Message-ID: <CAExDi1R6Vg8cztVA32nOEHKRgpiUcZnHfOoK6rshJq46FSaj2g@mail.gmail.com>
References: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
 <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com>
 <CANeU7QnY20n-UHY07RotcAJzFtMREB-CcsE1WXLi=b=cwQCizQ@mail.gmail.com>
 <CAExDi1QVtkoFCXzSoP0mg+3gbE45Z-bOGLAtjsTi8tsQZMdcEg@mail.gmail.com>
 <CANeU7Q=9Ma3+gA21+=bLi38XFw5B1FDoVFUvtaxLR3V0oHeCig@mail.gmail.com>
 <20170808002331.f3g6l7yzhsq3vhxe@ltop.local> <CANeU7QmJmzumvNNFm5W=Ti8TJdw-BZ2DeR0t2UXO-R2vCjqh6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34015 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbdHHA6K (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 20:58:10 -0400
Received: by mail-qk0-f179.google.com with SMTP id u139so11970157qka.1
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 17:58:09 -0700 (PDT)
In-Reply-To: <CANeU7QmJmzumvNNFm5W=Ti8TJdw-BZ2DeR0t2UXO-R2vCjqh6Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 8, 2017 at 2:42 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Aug 7, 2017 at 8:23 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> If you don't mind, it would be nice if you could use the pull request
>> I sent here: http://marc.info/?l=linux-sparse&m=150188507213269&w=4
>> (you never saw it because I copy-pasted "[PATCH v3]" in the title of
>> the cover page instead of using "[PATCH v4]" and so used the v3 and
>> corrected the s/list/__list/ by hand).
>> But it's not very important.
>
> I did not find that git pull url due to the V3 title. I did look for it.
>
> When I look at the patch, there is some compile error on one of the
> patch (patch 4?). I just fix it by hand. I assume the git pull has the
> same error because the patch are generated from git.
>
> I just checked, that compile error still on the git url you send out
> in the email. I still can't use it

Are you sure?
in the link I pasted here above, the git branch is:

    git://github.com/lucvoo/sparse.git fix-nested-pseudo-users-deletion-v4

    aka: bddf7d1e4ed81c3def7c6de2796a5489ca678399


> I actually prefer to use git pull if it is available to use.

Good.

> Also, can you please give the pull request a dedicate branch,
> like "for-chris",  not a tag? I don't want to pull from random branch
> and end up merging between your topic branches.

It won't change anything, in both case it's just a name for something
(and using specific name for specific thing is a good thing I think)
but no problem, it's fine for me.

I'll sent a proper pull request.

> I often need to seek clarify if this patches series is mean for merge.
> If you make that in the dedicate pull branch, I will know for sure.

Make sense.

-- Luc
