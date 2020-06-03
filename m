From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] univ-init: scalar initializer needs some additional
 checks
Date: Wed, 3 Jun 2020 23:16:35 +0200
Message-ID: <20200603211635.ufhlujbchvlhbhib@ltop.local>
References: <20200602163336.32667-1-luc.vanoostenryck@gmail.com>
 <34e42c7f-6c9d-b8e5-6ee1-2988b1099176@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCVQl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 Jun 2020 17:16:41 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF66C08C5C0
        for <linux-sparse@vger.kernel.org>; Wed,  3 Jun 2020 14:16:40 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t21so266800edr.12
        for <linux-sparse@vger.kernel.org>; Wed, 03 Jun 2020 14:16:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <34e42c7f-6c9d-b8e5-6ee1-2988b1099176@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org

On Wed, Jun 03, 2020 at 02:01:07AM +0100, Ramsay Jones wrote:
> 
> I applied this patch just now and everything worked fine. In addition,
> the tests from my patch also passed, once I had remembered to add the
> -Wno-universal-initializer to the 'check-command' - because I do not
> have the patch which changes the default for that warning.

I should have added that this patch was meant to be applied before
the one for the default :(
 
> The only thing which gave me pause ...
> 
> > diff --git a/evaluate.c b/evaluate.c
> > index 8d2e68692a48..16553eb3481b 100644
> > --- a/evaluate.c
> > +++ b/evaluate.c
> > @@ -2608,6 +2608,9 @@ static void handle_list_initializer(struct expression *expr,
> >  	struct expression *e, *last = NULL, *top = NULL, *next;
> >  	int jumped = 0;
> >  
> > +	if (expr->zero_init)
> > +		expr->expr_list = NULL;
> 
> ... was the potential memory leak here. (OK it wouldn't be a
> huge leak, but still!).

Well yes [replying to your other mail too). It doesn't matter much here
but it's also easy to free the list, which is what I've done.

Thanks for giving a look at all of this.
Both patches are now applied.
-- Luc
