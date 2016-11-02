From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/3] Warn on unknown attributes instead of throwing errors
Date: Thu, 3 Nov 2016 00:09:39 +0100
Message-ID: <20161102230938.GA64433@macpro.local>
References: <20161102215939.36765-1-luc.vanoostenryck@gmail.com>
 <20161102215939.36765-2-luc.vanoostenryck@gmail.com>
 <f9d05ae2-8e1d-c743-f73a-9a02499fea77@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33725 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756406AbcKBXJn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 19:09:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id u144so5258608wmu.0
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 16:09:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f9d05ae2-8e1d-c743-f73a-9a02499fea77@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Wed, Nov 02, 2016 at 10:29:41PM +0000, Ramsay Jones wrote:
> 
> 
> On 02/11/16 21:59, Luc Van Oostenryck wrote:
> > GCC creates new attributes quite often, generaly for specific
> > usages irrelevant to what sparse is used for.
> > Throwing errors on these create needless noise and annoyance
> > which is better to avoid.
> > 
> > 
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  parse.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/parse.c b/parse.c
> > index 205e1264..212fae3a 100644
> > --- a/parse.c
> > +++ b/parse.c
> > @@ -1230,7 +1230,8 @@ static struct token *recover_unknown_attribute(struct token *token)
> >  {
> >  	struct expression *expr = NULL;
> >  
> > -	sparse_error(token->pos, "attribute '%s': unknown attribute", show_ident(token->ident));
> > +	if (Wunknown_attribute)
> 
> Since Wunknown_attribute is not declared yet, this won't even compile.
> Simply squash this into patch #2.
> 
> Apart from that, looks good.
> 
> Thanks!
> 
> ATB,
> Ramsay Jones
> --

Grrr yes.
A leftover of the patch splitting. Sorry for that.

Thanks for noticing that.

Luc
