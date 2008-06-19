From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] ignore __cold__ attribute
Date: Thu, 19 Jun 2008 01:04:55 -0400
Message-ID: <1213851895.2405.2.camel@dv>
References: <1208860883.31429.8.camel@johannes.berg>
	 <20080422090739.2izftuclwocs80o4-cebfxv@fcnzpbc.arg@webmail.spamcop.net>
	 <1208870706.31429.23.camel@johannes.berg> <1208900131.22856.4.camel@dv>
	 <4811413E.1080103@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:64567 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251AbYFSFE6 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Jun 2008 01:04:58 -0400
In-Reply-To: <4811413E.1080103@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse <linux-sparse@vger.kernel.org>

On Thu, 2008-04-24 at 19:26 -0700, Josh Triplett wrote:
> Pavel Roskin wrote:
> > On Tue, 2008-04-22 at 15:25 +0200, Johannes Berg wrote:
> >> *Shrug*. I just wanted the kernel to work again and failed (in about 20
> >> minutes of searching) to find a changelog for gcc mentioning this so
> >> gave up and just added the one that the kernel uses. Want to amend the
> >> patch?
> > 
> > I think this would be better.  Now sparse would ignore both "cold" and
> > "hot", both with and without underscores.  They are also added to
> > ident-list.h.
> > 
> > diff --git a/ident-list.h b/ident-list.h
> > index 8fcd7de..6104826 100644
> > --- a/ident-list.h
> > +++ b/ident-list.h
> > @@ -74,6 +74,8 @@ IDENT(__malloc__);
> >  IDENT(nonnull); IDENT(__nonnull); IDENT(__nonnull__);
> >  IDENT(constructor); IDENT(__constructor__);
> >  IDENT(destructor); IDENT(__destructor__);
> > +IDENT(cold); IDENT(__cold__);
> > +IDENT(hot); IDENT(__hot__);
> >  IDENT(cdecl); IDENT(__cdecl__);
> >  IDENT(stdcall); IDENT(__stdcall__);
> >  IDENT(fastcall); IDENT(__fastcall__);
> > diff --git a/parse.c b/parse.c
> > index 137ba77..877414c 100644
> > --- a/parse.c
> > +++ b/parse.c
> > @@ -353,6 +353,10 @@ static struct init_keyword {
> >  	{ "__constructor__",	NS_KEYWORD,	.op = &ignore_attr_op },
> >  	{ "destructor",	NS_KEYWORD,	.op = &ignore_attr_op },
> >  	{ "__destructor__",	NS_KEYWORD,	.op = &ignore_attr_op },
> > +	{ "cold",	NS_KEYWORD,	.op = &ignore_attr_op },
> > +	{ "__cold__",	NS_KEYWORD,	.op = &ignore_attr_op },
> > +	{ "hot",	NS_KEYWORD,	.op = &ignore_attr_op },
> > +	{ "__hot__",	NS_KEYWORD,	.op = &ignore_attr_op },
> >  };
> 
> Looks good to me.  Could I get a signoff and commit message please?

Signed-off-by: Pavel Roskin <proski@gnu.org>

Sorry for delay.  I thought I answered it already.

-- 
Regards,
Pavel Roskin
