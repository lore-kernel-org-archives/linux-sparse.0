From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] build: clean up $CFLAGS handling in the makefile
Date: Sun, 29 Oct 2017 15:11:56 -0700
Message-ID: <20171029221155.gqki2qshonjhyy66@s>
References: <20171025100222.5983-1-jlayton@kernel.org>
 <20171025142009.foxh2rblmfpxvm7d@ltop.local>
 <CANeU7Qnvvezdc62s-cAWNonw2cKOJPWH2xSdgTdAL4M4skSnJw@mail.gmail.com>
 <1509019885.29077.6.camel@kernel.org>
 <CANeU7QmOACXKv2T2ovg7mxEDdpjUrwRgyYUsp2benDWh9R-2iw@mail.gmail.com>
 <20171029172809.6nlaz5lvxdcs677w@ltop.local>
 <CANeU7QnQi3313pVMiv4pGTZE51XU2EUbrB3Dg=DHgM-T-7f0EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:52119 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbdJ2WPF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Oct 2017 18:15:05 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id D81004962E2
        for <linux-sparse@vger.kernel.org>; Sun, 29 Oct 2017 23:12:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANeU7QnQi3313pVMiv4pGTZE51XU2EUbrB3Dg=DHgM-T-7f0EA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Jeff Layton <jlayton@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Oct 30, 2017 at 05:53:49AM +0800, Christopher Li wrote:
> On Mon, Oct 30, 2017 at 1:28 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > The goal of the initial patch, as stated by Jeff, was:
> > "The fedora packaging tools want to *override* $CFLAGS when building sparse"
> >
> > This version doesn't allow to override CFLAGS.
> > See what happens with 'make CFLAGS=-O3' for example.
> 
> The original patch proposed by Jeff does not allow usage of
> "make CFLAGS=-O3" either.  I take a look at your patch, it behave
> the same way in this regard. Do you mean I should change the
> commit title to *append* CFLAGS instead of override?
> 
> May be Jeff can clarify the intention?
> 
> BTW, I am actually leaning toward just expose some thing like
> CLI_CFLAGS to be override by package builders. I am not that
> convince override CFLAGS is established stander practices from
> the project that I have look at.

`make CFLAGS='-arbitrary -flags'` is quite common, and people generally
expect it to work, though it isn't *shocking* when it breaks. Though the
exact boundary for what should get overridden by that and what should
remain seems a bit fuzzy. Roughly speaking, if the application normally
wants to build with "-O2 -ffooish-bar -Wall -Wanother -I/some/path" ,
then `make CFLAGS='-Os -arbitrary -flags'` should build with "-Os
-arbitrary -flags -Wall -Wanother -Isome-path`. I think.

> On the other hand, it is trivial to avoid using CFLAGS in sparse
> Makefile. If Jeff really want CFLAGS instead of CLI_CFLAGS,
> it is not a big a deal.

I think it's worth not putting anything into CFLAGS that would break the
build if missing.

For instance, git's Makefile specifically says "# CFLAGS and LDFLAGS are
for the users to override from the command line.", and then just has
"CFLAGS = -g -O2 -Wall". It then has additional variables like
ALL_CFLAGS that include both CFLAGS and other things.
