From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 29/36] build: use git-clean
Date: Sun, 5 Nov 2017 12:38:45 -0800
Message-ID: <20171105203845.inkp5mcrm634lmov@s>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-29-luc.vanoostenryck@gmail.com>
 <20171105174100.r3y4o4m2i47d25o5@s>
 <20171105201629.qwitgngzeb7jzr6n@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52269 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdKEUit (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 15:38:49 -0500
Content-Disposition: inline
In-Reply-To: <20171105201629.qwitgngzeb7jzr6n@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>

On Sun, Nov 05, 2017 at 09:16:31PM +0100, Luc Van Oostenryck wrote:
> On Sun, Nov 05, 2017 at 09:41:02AM -0800, Josh Triplett wrote:
> > On Sun, Nov 05, 2017 at 05:25:37PM +0100, Luc Van Oostenryck wrote:
> > > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > > ---
> > >  Makefile | 12 ++----------
> > >  1 file changed, 2 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/Makefile b/Makefile
> > > index afc1efe98..f0f7a5b69 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -233,16 +233,8 @@ check: all
> > >  	$(Q)cd validation && ./test-suite
> > >  
> > >  
> > > -clean: clean-check
> > > -	@rm -f *.[oa] .*.d $(PROGRAMS) version.h
> > > -clean-check:
> > > +clean: FORCE
> > >  	@echo '     CLEAN'
> > > -	@find validation/ \( -name "*.c.output.expected" \
> > > -	                 -o -name "*.c.output.got" \
> > > -	                 -o -name "*.c.output.diff" \
> > > -	                 -o -name "*.c.error.expected" \
> > > -	                 -o -name "*.c.error.got" \
> > > -	                 -o -name "*.c.error.diff" \
> > > -	                 \) -exec rm {} \;
> > > +	@git clean -q -d -x -e .sparse.mk -e '*.[ch]'
> > 
> > No, you can't use git-clean here, for two reasons.
> > 
> > First, it has to be possible to build, and clean, sparse from a
> > tarball release, not just a git repository.
> > 
> > And second, even if not for that, this should *not* use -x or -d, *only*
> > -X. Otherwise, you might remove, say, a pile of carefully written
> > patches and cover letters sitting in the user's Sparse source directory.
> 
> Hehe, I thought this would be somehow controversial ;)
> 
> TBH, I'm far from conviced for the first point.
> There hasn't been any tarbal release since 2014 and, unless I'm
> mistaken, people can't anymore get a tarball from kernel.org's cgit.

As far as I can tell,
https://git.kernel.org/pub/scm/devel/sparse/sparse.git/snapshot/sparse-0.5.1.tar.gz
still works, for instance.

> The real question would be: "is there anybody, doing some kind of
> development on sparse and who won't use git?"

Sure: anyone doing packaging. If someone wants to package Sparse for a
distribution, they'll likely do so in a way that does not include .git
in the source package. And if that package wants to "make clean" for any
reason, or if someone grabs the source from that distribution for
development and happens to run "make clean", that would be *bad*.

Worse yet: I keep my home directory in git, and would very much not like
"git clean" run in *that* if .git doesn't exist in Sparse. I'd be
immediately filing a "critical" bug report about data loss against the
package, and trying to restore what data I can from backups.

> For the second point, well ... I purposely added '-e *.[ch]' to
> avoid some problems and if I call 'make clean' I expect that things
> like patches and cover letter are removed, but I agree that my
> expectations here most probably doesn't match other's.

I most assuredly would not expect "make clean" to do this. I regularly
"make clean" in repositories while having valuable files in the
directory: patches, cover-letters, lists of email addresess to CC
patches to, benchmark results, etc.

> I think I'll drop this patch and continue to directly use
> 'git clean -x' when I needed it.

Thank you.
