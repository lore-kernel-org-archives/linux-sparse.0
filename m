From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 29/36] build: use git-clean
Date: Sun, 5 Nov 2017 21:56:35 +0100
Message-ID: <20171105205634.nwp2lghnjcr72okw@ltop.local>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-29-luc.vanoostenryck@gmail.com>
 <20171105174100.r3y4o4m2i47d25o5@s>
 <20171105201629.qwitgngzeb7jzr6n@ltop.local>
 <20171105203845.inkp5mcrm634lmov@s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:52083 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdKEU4j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 15:56:39 -0500
Received: by mail-wm0-f53.google.com with SMTP id b9so10553176wmh.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 12:56:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171105203845.inkp5mcrm634lmov@s>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>

On Sun, Nov 05, 2017 at 12:38:45PM -0800, Josh Triplett wrote:
> On Sun, Nov 05, 2017 at 09:16:31PM +0100, Luc Van Oostenryck wrote:
> > 
> > Hehe, I thought this would be somehow controversial ;)
> > 
> > TBH, I'm far from conviced for the first point.
> > There hasn't been any tarbal release since 2014 and, unless I'm
> > mistaken, people can't anymore get a tarball from kernel.org's cgit.
> 
> As far as I can tell,
> https://git.kernel.org/pub/scm/devel/sparse/sparse.git/snapshot/sparse-0.5.1.tar.gz
> still works, for instance.

Ah good, it's no more accessible directly from the summary page but
still there in the release/tag page.

> > The real question would be: "is there anybody, doing some kind of
> > development on sparse and who won't use git?"
> 
> Sure: anyone doing packaging. If someone wants to package Sparse for a
> distribution, they'll likely do so in a way that does not include .git
> in the source package. And if that package wants to "make clean" for any
> reason, or if someone grabs the source from that distribution for
> development and happens to run "make clean", that would be *bad*.

I don't think it can be a problem for Debian or Fedora but I agree
there is a unneeded risk here.

> Worse yet: I keep my home directory in git, and would very much not like

Hehe, glad to hear that I'm not alone doing that :)

> "git clean" run in *that* if .git doesn't exist in Sparse. I'd be
> immediately filing a "critical" bug report about data loss against the
> package, and trying to restore what data I can from backups.
> 
> > For the second point, well ... I purposely added '-e *.[ch]' to
> > avoid some problems and if I call 'make clean' I expect that things
> > like patches and cover letter are removed, but I agree that my
> > expectations here most probably doesn't match other's.
> 
> I most assuredly would not expect "make clean" to do this. I regularly

Yes, it would be something for distclean or mrproper and such.

> "make clean" in repositories while having valuable files in the
> directory: patches, cover-letters, lists of email addresess to CC
> patches to, benchmark results, etc.

Of course, I never do that :)

> > I think I'll drop this patch and continue to directly use
> > 'git clean -x' when I needed it.
> 
> Thank you.

-- Luc
