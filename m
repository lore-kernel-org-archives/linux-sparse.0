From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Fri, 1 Sep 2017 15:55:06 -0700
Message-ID: <20170901225506.nmxgugitn25brpq6@x>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <CANeU7QkBF=uw_EVBe7-zLadUU=cgCvFS7uKxdRk_vq=6SO7W5Q@mail.gmail.com>
 <20170901070212.7xurrbentxybdhfx@x>
 <20170901075709.gkjnug4dmsyvji7i@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51181 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbdIAWzN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 1 Sep 2017 18:55:13 -0400
Content-Disposition: inline
In-Reply-To: <20170901075709.gkjnug4dmsyvji7i@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: Christopher Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>

On Fri, Sep 01, 2017 at 09:57:09AM +0200, Uwe Kleine-König wrote:
> On Fri, Sep 01, 2017 at 12:02:12AM -0700, Josh Triplett wrote:
> > On Thu, Aug 31, 2017 at 08:47:55PM -0400, Christopher Li wrote:
> > > On Thu, Aug 31, 2017 at 4:55 PM, Uwe Kleine-König <uwe@kleine-> Yes
> > > that works. So to address the Debian bug I can do:
> > > >
> > > >  - move sparse to /usr/lib
> > > >  - teach cgcc about the move of sparse
> > > >  - make /usr/bin/sparse call cgcc -no-compile "$@"
> > > 
> > > I don't like that. It means the user can't invoke sparse directly.
> > > 
> > > >
> > > > or is it easier to teach sparse about the architecture stuff?
> > > 
> > > First of all. It is not very trivial to teach sparse about the architecture
> > > stuff. To my mind, we need to move all the cgcc logic into sparse.
> > 
> > Related to that: while it would mean we couldn't necessarily just rely
> > entirely on GCC's definitions for a target platform, I think in an ideal
> > world we could have a sparse binary that understood *all* target
> > platforms at once, such that you could ask Sparse on x86_64 to "compile"
> > as though targeting any arbitrary architecture. That would also have the
> > major advantage of making it easy to run the Sparse testsuite for
> > *every* target architecture without needing compilers for every such
> > architecture.
> 
> You'd need the target arch's system headers though.

Only for building userspace code, not for building standalone/kernel
code, or the Sparse testsuite.

- Josh Triplett
