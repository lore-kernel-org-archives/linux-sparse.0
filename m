From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 14:24:16 -0400
Message-ID: <CANeU7QkTQuvTqehm6FTnFVkuTSLvodH170oK8ZzH5odqoNpZOg@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com> <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:33483 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdHNSYS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 14:24:18 -0400
Received: by mail-yw0-f182.google.com with SMTP id p68so59893486ywg.0
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 11:24:17 -0700 (PDT)
In-Reply-To: <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Sun, Aug 13, 2017 at 3:03 PM, Christopher Li <sparse@chrisli.org> wrote:
> ========rc5=======
> 1145.45user 514.38system 2:36.93elapsed 1057%CPU (0avgtext+0avgdata
> 235540maxresident)k
> 0inputs+12736outputs (0major+127283813minor)pagefaults 0swaps
> =================
> ========rc4=======
> 1125.58user 523.66system 2:38.09elapsed 1043%CPU (0avgtext+0avgdata
> 235604maxresident)k
> 0inputs+12744outputs (0major+126738411minor)pagefaults 0swaps
> =================
>
BTW,

I bought a new compile server for my testing for sparse. I finally get it set up
and start to crush some numbers. It is doing the sparse kernel checking with
24 threads:

1133.13user 431.11system 1:13.51elapsed 2127%CPU (0avgtext+0avgdata
235616maxresident)k
                                              ^^^^^^^^^^^^^^^^^^^^^^
0inputs+12744outputs (0major+125472993minor)pagefaults 0swaps
1134.75user 431.77system 1:13.55elapsed 2129%CPU (0avgtext+0avgdata
235620maxresident)k
                                            ^^^^^^^^^^^^^^^^^^^^^^^^
0inputs+12736outputs (0major+125473516minor)pagefaults 0swaps
1133.19user 432.63system 1:13.77elapsed 2122%CPU (0avgtext+0avgdata
235660maxresident)k
                                             ^^^^^^^^^^^^^^^^^
0inputs+12736outputs (0major+125473542minor)pagefaults 0swaps

So the overall compile speed is about doubled. And the run to run variance is
very small. Within a second. In the last round I am running some monitor
program to see the server work load so that account for some delay there.

The new server is *very* loud. Other than that, I am very happen about it.

Chris
