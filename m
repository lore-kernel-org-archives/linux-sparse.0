From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 15:03:51 -0400
Message-ID: <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33567 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdHMTDw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 15:03:52 -0400
Received: by mail-yw0-f173.google.com with SMTP id p68so45216774ywg.0
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 12:03:52 -0700 (PDT)
In-Reply-To: <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Sun, Aug 13, 2017 at 8:56 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Chris & Luc,
>
>
> I am merging and testing this in my repository. I notice that after
> applying the changes related to killing of BBs - there is a
> significant slow down in Sparse.
>
> Before the merge:
>
> real: 4.3 minutes
> user: 4.1 minutes
>
> After the merge:
>
> real: 18.9 minutes
> user: 18.7 minutes
>
> I just noticed this and these are my initial tests. But I thought it

I have done some testing on the rc5 vs rc4 in the kernel compile test.

========rc5=======
1145.45user 514.38system 2:36.93elapsed 1057%CPU (0avgtext+0avgdata
235540maxresident)k
0inputs+12736outputs (0major+127283813minor)pagefaults 0swaps
=================
========rc4=======
1125.58user 523.66system 2:38.09elapsed 1043%CPU (0avgtext+0avgdata
235604maxresident)k
0inputs+12744outputs (0major+126738411minor)pagefaults 0swaps
=================

I don't see the big different there. The second one shows a bit slower
is likely due to I haven't warm up my machine to run the first round.

It is likely that your test C file has a much bigger function than the
average kernel function file.

In for your case, even revert does not help you much right?
Because you want the result IR has more correct SSA.

Chris
