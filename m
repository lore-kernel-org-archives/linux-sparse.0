From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] linearize.h: sanitize header
Date: Thu, 6 Aug 2009 11:30:08 +0200
Message-ID: <200908061130.08387.kdudka@redhat.com>
References: <200908061102.14935.kdudka@redhat.com> <154e089b0908060223h6ae15b26q73360ee3658d6a82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:55859 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615AbZHFJ2n (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 6 Aug 2009 05:28:43 -0400
In-Reply-To: <154e089b0908060223h6ae15b26q73360ee3658d6a82@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
Cc: sparse <linux-sparse@vger.kernel.org>

On Thu August 6 2009 11:23:26 Hannes Eder wrote:
> On Thu, Aug 6, 2009 at 11:02, Kamil Dudka<kdudka@redhat.com> wrote:
> > It's unfortunate to use 'true' and 'false' as identifiers in a system
> > header. It clashes with corresponding macros from <stdbool.h> when
> > included before <sparse/linearize.h>.
> >
> > Signed-off-by: Kamil Dudka <kdudka@redhat.com>
> > ---
> >  linearize.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/linearize.h b/linearize.h
> > index 2205082..50b3601 100644
> > --- a/linearize.h
> > +++ b/linearize.h
> > @@ -328,7 +328,7 @@ struct entrypoint {
> >         struct instruction *entry;
> >  };
> >
> > -extern void insert_select(struct basic_block *bb, struct instruction
> > *br, struct instruction *phi, pseudo_t true, pseudo_t false); +extern
> > void insert_select(struct basic_block *bb, struct instruction *br, struct
> > instruction *phi, pseudo_t if_true, pseudo_t if_false);
>
> I guess it is wise to change this in linearize.c as well.  Mind sending a
> patch?

The question is if we need/want to :-) It's change of the working code for no 
real benefit. I am talking only about system-wide headers which can be 
included anywhere.

Kamil

