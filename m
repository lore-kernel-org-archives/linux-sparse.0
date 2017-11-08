From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 29/36] build: use git-clean
Date: Wed, 8 Nov 2017 20:55:37 +0100
Message-ID: <20171108195534.byfsuoyh5mc75eor@ltop.local>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-29-luc.vanoostenryck@gmail.com>
 <1510141356.8401.1.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56503 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbdKHTzn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 14:55:43 -0500
Received: by mail-wm0-f65.google.com with SMTP id z3so13240764wme.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 11:55:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1510141356.8401.1.camel@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@redhat.com>
Cc: linux-sparse@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>

On Wed, Nov 08, 2017 at 06:42:36AM -0500, Jeff Layton wrote:
> On Sun, 2017-11-05 at 17:25 +0100, Luc Van Oostenryck wrote:
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  Makefile | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index afc1efe98..f0f7a5b69 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -233,16 +233,8 @@ check: all
> >  	$(Q)cd validation && ./test-suite
> >  
> >  
> > -clean: clean-check
> > -	@rm -f *.[oa] .*.d $(PROGRAMS) version.h
> > -clean-check:
> > +clean: FORCE
> >  	@echo '     CLEAN'
> > -	@find validation/ \( -name "*.c.output.expected" \
> > -	                 -o -name "*.c.output.got" \
> > -	                 -o -name "*.c.output.diff" \
> > -	                 -o -name "*.c.error.expected" \
> > -	                 -o -name "*.c.error.got" \
> > -	                 -o -name "*.c.error.diff" \
> > -	                 \) -exec rm {} \;
> > +	@git clean -q -d -x -e .sparse.mk -e '*.[ch]'
> >  
> >  .PHONY: FORCE
> 
> This seems wrong. It's certainly possible to build sparse out of a
> tarball that was generated from (e.g.) git-archive. In fact that's
> generally how fedora (and I imagine Debian) build packages.
> 
> This would break the ability to do "make clean" in that setup.

Yes, it's very wrong.
As you have probably already seen in Uwe's reply, he and Josh have
also reported this and I have since dropped this patch.
I guess that I'm too used to use git ...

It's really good to know that people are looking closely at these patches.
I appreciate this very much.

-- Luc
