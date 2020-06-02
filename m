From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [SPARSE PATCH] univ-init: conditionally accept { 0 } without
 warnings
Date: Tue, 2 Jun 2020 18:41:58 +0200
Message-ID: <20200602164158.lovn2dsuc2g74l55@ltop.local>
References: <20200518235446.84256-1-luc.vanoostenryck@gmail.com>
 <2fcda487-733b-8ed1-e1f4-6c6204a68569@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgFBQmC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 2 Jun 2020 12:42:02 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8697EC05BD1E
        for <linux-sparse@vger.kernel.org>; Tue,  2 Jun 2020 09:42:02 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id o26so7694313edq.0
        for <linux-sparse@vger.kernel.org>; Tue, 02 Jun 2020 09:42:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2fcda487-733b-8ed1-e1f4-6c6204a68569@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org

On Wed, May 20, 2020 at 01:22:22AM +0100, Ramsay Jones wrote:
> >  
> > diff --git a/parse.c b/parse.c
> > index a29c67c8cf41..48494afc6f2c 100644
> > --- a/parse.c
> > +++ b/parse.c
> > @@ -2750,6 +2750,13 @@ static struct token *initializer_list(struct expression_list **list, struct toke
> >  {
> >  	struct expression *expr;
> >  
> > +	// '{ 0 }' is equivalent to '{ }' unless wanting all possible
> > +	// warnings about using '0' to initialize a null-pointer.
> > +	if (!Wuniversal_initializer) {
> > +		if (match_token_zero(token) && match_op(token->next, '}'))
> > +			token = token->next;
> > +	}
> > +
> 
> Ha! This made me LOL! (see my patch below).
> 
> So simple. (I did think, at first, that deleting the '0' token was
> not a good idea - then I realized that it's more like skipping/ignoring
> the token than deleting it.)
> 
> I wish I had thought of it.

Well, it ended that it wasn't that smart after all because it
caused several regressions when used with scalars.
So, I finally had to do a sort of hybrid between your version
(for the parsing) and mine (dropping the '0' element from the list,
but now, later, at evaluation time).

-- Luc
