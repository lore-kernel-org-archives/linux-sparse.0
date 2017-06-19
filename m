From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] dissect: use built_in_ident() instead of MK_IDENT()
Date: Tue, 20 Jun 2017 00:42:34 +0200
Message-ID: <20170619224233.6ftwy5ul3dfcj4ol@ltop.local>
References: <20170619211454.45244-1-luc.vanoostenryck@gmail.com>
 <a37ee7f2-2653-ff93-01ed-492bb193dc5f@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33756 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdFSWmh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Jun 2017 18:42:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id f90so19466048wmh.0
        for <linux-sparse@vger.kernel.org>; Mon, 19 Jun 2017 15:42:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a37ee7f2-2653-ff93-01ed-492bb193dc5f@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org, Chris Li <sparse@chrisli.org>, Oleg Nesterov <oleg@redhat.com>

On Mon, Jun 19, 2017 at 11:35:30PM +0100, Ramsay Jones wrote:
> On 19/06/17 22:14, Luc Van Oostenryck wrote:
> > The motivation for this patch was to allow sparse to be
> > compiled with clang which doesn't like what is done
> > on VLAs in the MK_IDENT() macro.
> > 
> > But also, I can't see any justification for not using the
> > real thing to create identifiers: built_in_ident().
> > 
> > CC: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  dissect.h      | 13 -------------
> >  test-dissect.c |  6 +++---
> >  2 files changed, 3 insertions(+), 16 deletions(-)
> > 
> > diff --git a/dissect.h b/dissect.h
> > index 3b72b8988..5ac1f4d40 100644
> > --- a/dissect.h
> > +++ b/dissect.h
> > @@ -25,16 +25,3 @@ struct reporter
> >  };
> >  
> >  extern void dissect(struct symbol_list *, struct reporter *);
> > -
> > -#define	MK_IDENT(s)	({				\
> > -	static struct {					\
> > -		struct ident ident;			\
> > -		char __[sizeof(s)];			\
> > -	} ident = {{					\
> > -		.len  = sizeof(s)-1,			\
> > -		.name = s,				\
> > -	}};						\
> > -	&ident.ident;					\
> > -})
> > -
> > -#endif
> 
> Hmm, does this compile?; you seem to have removed an #endif,
> leaving an unbalanced '#ifndef DISSECT_H'.

Yes, something (or more probably someone (me)) eat it.
It's already corrected.

But thanks again!

-- Luc 
