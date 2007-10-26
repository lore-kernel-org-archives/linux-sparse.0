From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
Subject: RE: [PATCH] Handle ignored attribute malloc
Date: Fri, 26 Oct 2007 13:11:35 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E27016E5CDF@az33exm24.fsl.freescale.net>
References: <1193346769-18030-1-git-send-email-Emilian.Medve@Freescale.com> <70318cbf0710252016x5c41ac82o2456bfa5b392d0f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from de01egw01.freescale.net ([192.88.165.102]:48614 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbXJZULq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 26 Oct 2007 16:11:46 -0400
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l9QKBbwX010725
	for <linux-sparse@vger.kernel.org>; Fri, 26 Oct 2007 13:11:38 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9QKBaxx021400
	for <linux-sparse@vger.kernel.org>; Fri, 26 Oct 2007 15:11:36 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <70318cbf0710252016x5c41ac82o2456bfa5b392d0f4@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: josh@freedesktop.org, linux-sparse@vger.kernel.org

Hi Chris,


It's not the kernel, but some other code I'm writing. However, I expect
it could be used for kmalloc() and friends.

Nobody is using malloc_ident yet, but I noticed other xxx_ident that are
not used nad are present in ident-list.h so I assumed it would be ok.

I'll try to add a test case.


Cheers,
Emil.


This e-mail, and any associated attachments have been classified as:
--------------------------------------------------------------------
[ ] Public
[x] Freescale Semiconductor Internal Use Only
[ ] Freescale Semiconductor Confidential Proprietary


> -----Original Message-----
> From: christ.li@gmail.com [mailto:christ.li@gmail.com] On 
> Behalf Of Christopher Li
> Sent: Thursday, October 25, 2007 10:16 PM
> To: Medve Emilian-EMMEDVE1
> Cc: josh@freedesktop.org; linux-sparse@vger.kernel.org
> Subject: Re: [PATCH] Handle ignored attribute malloc
> 
> Which kernel source code triggers this?
> 
> If nobody is using malloc_ident directly. You don't need to add it
> to ident-list.h.
> 
> Having a test case in validations directory will be nice too.
> 
> Chris
> 
> On 10/25/07, Emil Medve <Emilian.Medve@freescale.com> wrote:
> > This avoids error messages like this:
> >
> > error: attribute 'malloc': unknown attribute
> >
> > Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> > ---
> >
> > Please copy me in replies as I'm not subscribed to the list
> >
> >  ident-list.h |    1 +
> >  parse.c      |    1 +
> >  2 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/ident-list.h b/ident-list.h
> > index b183eac..8fcd7de 100644
> > --- a/ident-list.h
> > +++ b/ident-list.h
> > @@ -69,6 +69,7 @@ IDENT(model); IDENT(__model__);
> >  IDENT(format_arg); IDENT(__format_arg__);
> >  IDENT(nothrow); IDENT(__nothrow); IDENT(__nothrow__);
> >  IDENT(__transparent_union__);
> > +IDENT(malloc);
> >  IDENT(__malloc__);
> >  IDENT(nonnull); IDENT(__nonnull); IDENT(__nonnull__);
> >  IDENT(constructor); IDENT(__constructor__);
> > diff --git a/parse.c b/parse.c
> > index 47b5204..a41939d 100644
> > --- a/parse.c
> > +++ b/parse.c
> > @@ -283,6 +283,7 @@ static struct init_keyword {
> >         { "nothrow",    NS_KEYWORD,     .op = &ignore_attr_op },
> >         { "__nothrow",  NS_KEYWORD,     .op = &ignore_attr_op },
> >         { "__nothrow__",        NS_KEYWORD,     .op = 
> &ignore_attr_op },
> > +       { "malloc",     NS_KEYWORD,     .op = &ignore_attr_op },
> >         { "__malloc__", NS_KEYWORD,     .op = &ignore_attr_op },
> >         { "nonnull",    NS_KEYWORD,     .op = &ignore_attr_op },
> >         { "__nonnull",  NS_KEYWORD,     .op = &ignore_attr_op },
> > --
> > 1.5.3.GIT
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-sparse" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
