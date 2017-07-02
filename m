From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/7] put struct symbol & friends on diet
Date: Sun, 2 Jul 2017 23:17:36 +0200
Message-ID: <20170702211735.q4bmcs5xrofv5mr3@ltop.local>
References: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qn-+q8nDRLkLGMQUQxyLS73RC0awYN2LrCrbrE1z3+BQg@mail.gmail.com>
 <20170701083915.27ogssgsakjgjz4s@ltop.local>
 <CANeU7QmzA4e3ZV-8R8G+AvpNRkqxNun20-0vTFY6HH=J81y6nQ@mail.gmail.com>
 <20170701210220.36hsoiec46yf3uvw@ltop.local>
 <CANeU7Qnj+9d-XVbizU+sWFz==Ls6GE_zuun8z-PsaE7OLzrM6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36021 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbdGBVRk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 2 Jul 2017 17:17:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id y5so17182252wmh.3
        for <linux-sparse@vger.kernel.org>; Sun, 02 Jul 2017 14:17:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qnj+9d-XVbizU+sWFz==Ls6GE_zuun8z-PsaE7OLzrM6Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jul 01, 2017 at 02:28:44PM -0700, Christopher Li wrote:
> On Sat, Jul 1, 2017 at 2:02 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Oh, I have no reason to believe that this variance had anything
> > to do with the build system. Sure kbuild have some overhead (not
> > much though) but it should be as deterministic as the rest.
> 
> I should correct that I don't know how consistent is kbuild.
> For me kbuild has very noticeable overhead on incremental build
> compare to my script:
> 
> One job:
> $ time make
...
> real 2m22.493s
> user 1m44.339s
> sys 0m35.836s
> 
> Change that to 12 jobs:
> $ time make -j12
...
> real 0m44.660s
> user 2m10.570s
> sys 0m45.502s
> 
> 
> With my make script:
> $ time make -f $PWD/linux-checker.make  -C ../linux name=master
> real 0m4.168s
> user 0m4.008s
> sys 0m0.143s
> 
> $ time make -j12 -f $PWD/linux-checker.make  -C ../linux name=master
> real 0m4.206s
> user 0m4.106s
> sys 0m0.181s

Yes, I did some simple 'make vmlinux' on an allyesconfig kernel which
was already compiled and I was surprised by the time it took (all times
in seconds, followed between the parenthesis by standard deviation,
relative standard deviation and the standard error (of the mean):
	          nbr measures: 12
	real:	  71.90 (1.50 = 2.09% ~ 0.67)
	user:	  57.19 (1.19 = 2.08% ~ 0.53)
	sys:	  10.30 (0.36 = 3.52% ~ 0.16)
But the variance is not much, about the same as full compile or full
check by sparse (see here under).

> You don't have to do the test. I am fine with this change. I am just
> curious with
> the numbers myself.

I'm interested myself in some good numbers.
 
The result for an allyesconfig kernel without using kbuild:
	NR = 29, nbr measures: 12
	real:	1080.44 (2.62 = 0.24% ~ 0.76)
	user:	 818.06 (2.27 = 0.28% ~ 0.66)
	sys:	 227.18 (1.12 = 0.49% ~ 0.32)

	NR = 13, nbr measures: 20
	real:	1064.25 (1.65 = 0.15% ~ 0.37)
	user:	 816.35 (1.29 = 0.16% ~ 0.29)
	sys:	 213.33 (0.90 = 0.42% ~ 0.20)

	NR = 05, nbr measures: 11
	real:	1058.52 (2.57 = 0.24% ~ 0.78)
	user:	 817.17 (2.34 = 0.29% ~ 0.70)
	sys:	 207.12 (0.95 = 0.46% ~ 0.29)

For the speedup, this gives us:
1) using NR=13 instead of 29:
	real:  16.19 (1.50%)
	user:   1.71 (0.21%)
	sys:   13.85 (6.10%)

1) using NR=5 instead of 29:
	real:  21.92 (2.03%)
	user:   0.89 (0.11%)
	sys:   20.06 (8.83%)

So, the speedup on the whole kernel is real but modest:
* 1.5-2.0% on real time,
* the gain in user time is negligible and smaller than the std dev.
  -> cache effect is very small or inexisting or is compensated
  by some extra work due to the use of  more list blocks.
* the speedup in system time is appreciable though: 6-8%

I have done some others tests with NR = 7, 9, ... They are not much
interesting, giving times similar but a bit higher than for NR = 13
(but for NR = 9). The differences are anyway quite small.

-- Luc
