From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 21/36] build: no need to clean *.so and SLIB_FILE
Date: Sun, 5 Nov 2017 12:30:54 -0800
Message-ID: <20171105203054.25623mvmathjndu2@s>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-21-luc.vanoostenryck@gmail.com>
 <20171105174807.b4p6hmthwammarbv@s>
 <20171105200629.hkffk2l5zsev24mm@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52109 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdKEUa6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 15:30:58 -0500
Content-Disposition: inline
In-Reply-To: <20171105200629.hkffk2l5zsev24mm@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>

On Sun, Nov 05, 2017 at 09:06:31PM +0100, Luc Van Oostenryck wrote:
> On Sun, Nov 05, 2017 at 09:48:07AM -0800, Josh Triplett wrote:
> > On Sun, Nov 05, 2017 at 05:25:29PM +0100, Luc Van Oostenryck wrote:
> > > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > > ---
> > >  Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/Makefile b/Makefile
> > > index a8578c305..23c334132 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -207,7 +207,7 @@ version.h: FORCE
> > >  
> > >  
> > >  clean: clean-check
> > > -	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) version.h
> > > +	rm -f *.[oa] .*.d $(PROGRAMS) $(SLIB_FILE) version.h
> > 
> > You didn't remove SLIB_FILE here. And also, this should get squashed
> > into the patch that stops building these.
> 
> I know, this patch only remove the '*.so' which was redundant with
> $(SLIB_FILE).
> This was before I decided to remove everything related to shared lib.

Ah, I see. The subject seemed likt it was saying "no need to clean
either of these", rather than "no need to clean both, one suffices".

> And yes, once shared are removed, it's simpler to remove everything
> at the same time. I'll do that in next version.

Thanks!
