From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/7] put struct symbol & friends on diet
Date: Sat, 1 Jul 2017 23:02:21 +0200
Message-ID: <20170701210220.36hsoiec46yf3uvw@ltop.local>
References: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qn-+q8nDRLkLGMQUQxyLS73RC0awYN2LrCrbrE1z3+BQg@mail.gmail.com>
 <20170701083915.27ogssgsakjgjz4s@ltop.local>
 <CANeU7QmzA4e3ZV-8R8G+AvpNRkqxNun20-0vTFY6HH=J81y6nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32847 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751996AbdGAVC1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Jul 2017 17:02:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id j85so13714194wmj.0
        for <linux-sparse@vger.kernel.org>; Sat, 01 Jul 2017 14:02:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QmzA4e3ZV-8R8G+AvpNRkqxNun20-0vTFY6HH=J81y6nQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jul 01, 2017 at 12:51:53PM -0700, Christopher Li wrote:
> On Sat, Jul 1, 2017 at 1:39 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > For the moment, I have no access to the measurements I made. I'll see
> > what I can do. One of the problem I had with kernel 'build' was that
> > I wasn't able able to get number stable enough to my taste (typically,
> > I had a two groups of values, each with a small variance within the
> > group, but the difference between the groups was like 10%, like you
> > would heer have a few value around 2m30 and a few ones around 2m45.
> > Given this, I never bothered to calculate the variance).
> 
> That is exactly the reason I develop my own test makefile instead of using
> kbuild directly.

Oh, I have no reason to believe that this variance had anything
to do with the build system. Sure kbuild have some overhead (not
much though) but it should be as deterministic as the rest.
I think it was just caused by some background tasks and I was busy
do to stuff while measuring.

I've run a batch of time measurement on another machine really unused,
it should give much more stable results. I'll give them when I'll have
access to them tomorrow.

> >
> > Meanwhile, I just looked at your numbers. At first sight, they look
> > more or less as expected. I'm just surprised that the sys time is so
> > high: around 45% of the user time (IIRC, in my measurements it was
> > more like 10%, but I can be wrong).
> 
> That is most likely cause by a high job count "-j12". My test machine
> has 12 hyper-threaded core total. That is why I pick "-j12".
> 
> I can run with some lower job count and see how it goes.

No, it's OK, -j12 is as good as -j4 or -j8. 
I still found very strange that your sys time is so high.
 
> >
> > Looking closer, calculating the mean value of each pair of measures
> > with the standard deviation in parenthesis, then calculating the
> > absolute and relative difference, I get:
> >
> >           NR = 29                  NR = 13               delta
> > real     150.723 (1.492)         147.628 (0.653)         3.096 = 2.1%
> > user    1095.505 (3.555)        1084.916 (1.485)        10.589 = 1.0%
> > sys      496.098 (4.766)         470.548 (0.837)        25.550 = 5.1%
> 
> I assume your test done with normal kernel kbuild.
> How many run was that per setup?

That's just your numbers.

> >
> > This look largely non-surprising:
> > * there is a significative difference in the sys time (where the memory
> >   allocation cost is)
> > * a much smaller difference in user time (which I suppose we can credit
> >   to positive cache effect minus some extra work for lists which are
> >   bigger than 13).
> > * all in all, it gives a modest win of 2% in real time (but here the
> >   difference is only twice the stdvar, so caution with this).
> 
> Yes, that all make sense.
> 
> Keep in mind of the NR change for ptrlist. For any list that is longer than
> 29 items. The memory wasted by the ptr_node itself will increase.
> 
> With NR=29, for long list (list has more than 29 entries). the memory
> use by ptr node is 3/32, about 9.4%. Which NR=13, 3/16= 18.8%.
> So there is about 9% more memory usage for longer list.
> That is some thing we need to keep in mind of.

I know, but the funny things is that even with a very short NR you win
memory and he speed is not slower, because the avarage list length is
so small. I'll give some numbers tomorrow.

> > Of course, the speedup must largely be dependent on the amount of free
> > memory and how fragmented memory is, in others words: how hard it is
> > for the kernel to allocate more memory for your process.
> 
> More system call for mmap and more CPU cache missing.

Yes, and more work for kernel's page allocation too and ... more time
to clear the pages before handing to user space (this is where most
time is spend) as nicely reported by perf. 

-- Luc
