From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Sat, 5 Aug 2017 12:05:39 +0200
Message-ID: <CAExDi1QW+w0-dHptV5=8Gdw9gv2xya8hznpEgxqr3ija_MTzag@mail.gmail.com>
References: <CANeU7Qne+bdhtzrVCi-qihDt9kyJ8wN6i3XTixYJNX5yFmiBpA@mail.gmail.com>
 <20170730151254.xlnz7c4zphhnhump@ltop.local> <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
 <CAMHZB6Emib_U7AtDLZ5Wc6KGXtZzMwhbT-N+sk-B05PUVbtfNg@mail.gmail.com>
 <20170801203357.4ywboptvr6tlytab@ltop.local> <CANeU7QkShNBJ2nWh0wvTN3fTvwX710BT-g=aFf+GS1upnD_Gxw@mail.gmail.com>
 <CAExDi1R9QZJorwhMq4=nRLvMet+S0RCpeiMurko=rNYLpu8c2A@mail.gmail.com>
 <CANeU7QmzundH7qpdYhQqDJgBv+5pPemwft+1uH5oVQ1POnoQDw@mail.gmail.com>
 <CAMHZB6E0NYy_bNJftB5n4BFZ4-fNf___n0RN1OPb+jkV4Ry-Dw@mail.gmail.com>
 <20170803214906.dvvyibtf53j3ah6m@ltop.local> <20170804113329.54u5dzon5hrucohg@ltop.local>
 <CANeU7Qm8XKLavw=vWcKDyPkpnLVJ3kva17hkQhYqsi8QHZ2ArQ@mail.gmail.com>
 <CAExDi1SXUkfR1eNZWLy9cOdEsZSbEb_0rSsEbk6dO8CZkfRxQA@mail.gmail.com> <CANeU7QkBoEEec=Tj5HyeWPxSqKP9ioGuveODDv8eh+xmbOGHPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:35468 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdHEKFl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Aug 2017 06:05:41 -0400
Received: by mail-qt0-f177.google.com with SMTP id p3so20670993qtg.2
        for <linux-sparse@vger.kernel.org>; Sat, 05 Aug 2017 03:05:40 -0700 (PDT)
In-Reply-To: <CANeU7QkBoEEec=Tj5HyeWPxSqKP9ioGuveODDv8eh+xmbOGHPw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sat, Aug 5, 2017 at 2:23 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Aug 4, 2017 at 6:26 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> I have investigated a little more because even 2.1 or 1.93s seems
>> too much to me.
>
> Thanks for looking into this.
>
>> The real offending, taking about 75% of CPU time, is bb_dominates()
>> which while only directly called 82000 is a recursive function which
>> internally is called more than 71 million of time!
>> In other words, the mean recursion depth of bb_dominates() is 860,
>> which means that there are chains of bb->parent as long as 860.
>
> Yes, that is the impression I get as well for, some where the finding
> dominates is taking a lot of time. Also the result is not saved.
>
>>
>> By restricting the bb_dominates() in CSE to a reasonable depth of 32,
>> the compile time is reduced to .8s without changing a single bit in the
>> resulting code.
>
> We can revisit this after the release. I have side project work on finding
> the dominatior tree.

Don't forget that asking if this node dominates this other node is not
the same question as asking for the immediate dominator of a node.
In other words, even with the dominator tree you will still need to do
lookups in the tree.

-- Luc
