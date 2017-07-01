From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/7] put struct symbol & friends on diet
Date: Sat, 1 Jul 2017 12:51:53 -0700
Message-ID: <CANeU7QmzA4e3ZV-8R8G+AvpNRkqxNun20-0vTFY6HH=J81y6nQ@mail.gmail.com>
References: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qn-+q8nDRLkLGMQUQxyLS73RC0awYN2LrCrbrE1z3+BQg@mail.gmail.com> <20170701083915.27ogssgsakjgjz4s@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35378 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751922AbdGATv7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Jul 2017 15:51:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id s66so21031657pfs.2
        for <linux-sparse@vger.kernel.org>; Sat, 01 Jul 2017 12:51:59 -0700 (PDT)
In-Reply-To: <20170701083915.27ogssgsakjgjz4s@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jul 1, 2017 at 1:39 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> For the moment, I have no access to the measurements I made. I'll see
> what I can do. One of the problem I had with kernel 'build' was that
> I wasn't able able to get number stable enough to my taste (typically,
> I had a two groups of values, each with a small variance within the
> group, but the difference between the groups was like 10%, like you
> would heer have a few value around 2m30 and a few ones around 2m45.
> Given this, I never bothered to calculate the variance).

That is exactly the reason I develop my own test makefile instead of using
kbuild directly.

A python script generate that makefile from the kbuild .*.cmd files.
The kbuild has a lot of extra cost. If I invoke kbuild with two make without
any file change, all file has been cached. The second make still takes a long
time to complete, in terms of minutes.

My sparse test makefile will complete the second null incremental make.
Total 4 seconds with one job. With my scripts, the variance run to run is in
terms of seconds as long as I keep the in cache. Very predictable.

I can share my scripts after I clean it up some how.

>
> Meanwhile, I just looked at your numbers. At first sight, they look
> more or less as expected. I'm just surprised that the sys time is so
> high: around 45% of the user time (IIRC, in my measurements it was
> more like 10%, but I can be wrong).

That is most likely cause by a high job count "-j12". My test machine
has 12 hyper-threaded core total. That is why I pick "-j12".

I can run with some lower job count and see how it goes.

>
> Looking closer, calculating the mean value of each pair of measures
> with the standard deviation in parenthesis, then calculating the
> absolute and relative difference, I get:
>
>           NR = 29                  NR = 13               delta
> real     150.723 (1.492)         147.628 (0.653)         3.096 = 2.1%
> user    1095.505 (3.555)        1084.916 (1.485)        10.589 = 1.0%
> sys      496.098 (4.766)         470.548 (0.837)        25.550 = 5.1%

I assume your test done with normal kernel kbuild.
How many run was that per setup?

>
> This look largely non-surprising:
> * there is a significative difference in the sys time (where the memory
>   allocation cost is)
> * a much smaller difference in user time (which I suppose we can credit
>   to positive cache effect minus some extra work for lists which are
>   bigger than 13).
> * all in all, it gives a modest win of 2% in real time (but here the
>   difference is only twice the stdvar, so caution with this).

Yes, that all make sense.

Keep in mind of the NR change for ptrlist. For any list that is longer than
29 items. The memory wasted by the ptr_node itself will increase.

With NR=29, for long list (list has more than 29 entries). the memory
use by ptr node is 3/32, about 9.4%. Which NR=13, 3/16= 18.8%.
So there is about 9% more memory usage for longer list.
That is some thing we need to keep in mind of.

> Of course, the speedup must largely be dependent on the amount of free
> memory and how fragmented memory is, in others words: how hard it is
> for the kernel to allocate more memory for your process.

More system call for mmap and more CPU cache missing.

Chris
