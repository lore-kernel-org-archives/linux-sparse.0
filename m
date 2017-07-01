From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/7] put struct symbol & friends on diet
Date: Sat, 1 Jul 2017 10:39:16 +0200
Message-ID: <20170701083915.27ogssgsakjgjz4s@ltop.local>
References: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qn-+q8nDRLkLGMQUQxyLS73RC0awYN2LrCrbrE1z3+BQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35671 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbdGAIjZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Jul 2017 04:39:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id u23so11566500wma.2
        for <linux-sparse@vger.kernel.org>; Sat, 01 Jul 2017 01:39:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qn-+q8nDRLkLGMQUQxyLS73RC0awYN2LrCrbrE1z3+BQg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jun 30, 2017 at 01:13:37AM -0700, Christopher Li wrote:
> On Wed, Jun 28, 2017 at 10:16 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > What can be win with these small changes is quite appreciable:
> > about 30% with some gain in speed too (but this are harder to
> > put numbers on it, 5% or a bit more seems quite common for
> > big files).
> 
> I am curious about the performance difference against the full kernel
> source check with sparse.
> I have some benchmark script build for that with linux "allmodconfig".
> 
> My test environment will only do sparse portion of the checking and
> save the result
> into files. The makefile is non-recursive so it is much faster than
> running sparse
> from the kernel build. A kernel no change incremental build take about 2m10s.
> On my non-recursive makefile for sparse it is only 4 seconds. So  the overhead
> of make itself is very light.
> 
> Any way, the two run of normal build of RC3:
> $ time make -f $PWD/linux-checker.make -j12 -C ../linux name=master
> real 2m31.778s
> user 18m18.019s
> sys 8m19.468s
> 
> real 2m29.668s
> user 18m12.991s
> sys 8m12.728s
> 
> two run with LIST_NODE_NR = 13 version of sparse
> 
> real 2m27.166s
> user 18m3.866s
> sys 7m51.140s
> 
> real 2m28.089s
> user 18m5.966s
> sys 7m49.956s
> 
> So it is barely able to register a real world difference, consider the
> run to run variance is about 2 second as well.
> 
> The number for the pure sparse run is about 1.3% difference on
> the full kernel allmodconfig build.

For the moment, I have no access to the measurements I made. I'll see
what I can do. One of the problem I had with kernel 'build' was that
I wasn't able able to get number stable enough to my taste (typically,
I had a two groups of values, each with a small variance within the
group, but the difference between the groups was like 10%, like you
would heer have a few value around 2m30 and a few ones around 2m45.
Given this, I never bothered to calculate the variance).

Meanwhile, I just looked at your numbers. At first sight, they look
more or less as expected. I'm just surprised that the sys time is so
high: around 45% of the user time (IIRC, in my measurements it was
more like 10%, but I can be wrong).

Looking closer, calculating the mean value of each pair of measures
with the standard deviation in parenthesis, then calculating the
absolute and relative difference, I get:

	  NR = 29		   NR = 13		 delta
real	 150.723 (1.492)	 147.628 (0.653)	 3.096 = 2.1%
user	1095.505 (3.555)	1084.916 (1.485)	10.589 = 1.0%
sys	 496.098 (4.766)	 470.548 (0.837)	25.550 = 5.1%

This look largely non-surprising:
* there is a significative difference in the sys time (where the memory
  allocation cost is)
* a much smaller difference in user time (which I suppose we can credit
  to positive cache effect minus some extra work for lists which are
  bigger than 13).
* all in all, it gives a modest win of 2% in real time (but here the
  difference is only twice the stdvar, so caution with this).

So it would give here 2% for what I consider as 'normal sized files'
compared to the 5% or more I saw for 'big files'.

Of course, the speedup must largely be dependent on the amount of free
memory and how fragmented memory is, in others words: how hard it is
for the kernel to allocate more memory for your process.

-- Luc
