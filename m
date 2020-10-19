Return-Path: <SRS0=6y8R=D2=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717DDC433E7
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 04:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE312225F
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 04:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8f7SKvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgJSE7p (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Oct 2020 00:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgJSE7p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Oct 2020 00:59:45 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F994C061755
        for <linux-sparse@vger.kernel.org>; Sun, 18 Oct 2020 21:59:45 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p13so8828454edi.7
        for <linux-sparse@vger.kernel.org>; Sun, 18 Oct 2020 21:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AqMfgwc6rdAmp5ycZA+N8/OgjAHIkluSL3m4olTAh7U=;
        b=n8f7SKvCbTnZyQKcPzfs5RTEsJVYHcMaynFGQoE9cDRqT+O7k+2S0HUQLpr4lezBrp
         0leSe3Nm3KkVJw3w+5axdz4TaeI1IPl4QGjYfzasBvaA8BbDrWMMtWEhQAhCai8Mm8Ey
         dZJY4p9W+bU4ipFnN6FoRivgW7f0pvNR9MEDDnR+E0814LO8eW0/Qf3Gzqet/VFWqOoy
         mUzlz/CeeZ1RE/7IO+RHmqGA4pQHFoi6WuobEgJuBDXI1EskP2WHvggVJX4JFpMbGNFQ
         vYOQsu9LqAx2MezMwbpxC4kD7iqatCymo2746uqOOL/OfgfLiDVFi8L7jZpveQu2oA9b
         BuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AqMfgwc6rdAmp5ycZA+N8/OgjAHIkluSL3m4olTAh7U=;
        b=TWIl6nM6LgIUjWHFG9qf4MgOpe7TEfLlgs9UFtZHTHCMOCab+MypWd5SIQem9yciL/
         Cy6eejC2NrNRCHb9Q7pgBW+iWO5YV3tPSh+0Yd8knETFjPw8YLi0TkcF8RT7k6Ym4Pia
         a8DbtPsnmmzaS3XeSQF77/Gji3RU5182pZCCyDuqvwzJFA/JJGGL8WowGbJ2D+uvE6qC
         7i131TI21M1bW3WMS4TVxm6um9EH3nNCjd92VIYIsGX23ZO5VswK7NTwjXi+vN8TY397
         5AmxfzAaTzG1A27n77M28Wp8omXnP18nXEHlkd7EaN0q+lhmx6vCEPMPjKdgI3dKfyaM
         H6/A==
X-Gm-Message-State: AOAM533Sem/7/7uFjmRSo0qzBdP5TGwe5iVYLDWmbp5LbJtcJ+qh9wmE
        TkAqNW5Mz6CdFNLPFu0cKf+vJSkXEdk=
X-Google-Smtp-Source: ABdhPJwnGjhG/dvHoq1UQ2BAnObee2LCv+buzHycdFxWgOP/AjSnsz5Gu5tcm99n9AQgUOq9PPHObA==
X-Received: by 2002:a50:e8cc:: with SMTP id l12mr16307129edn.29.1603083583874;
        Sun, 18 Oct 2020 21:59:43 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:159c:4578:7f8d:4dab])
        by smtp.gmail.com with ESMTPSA id c5sm9166039edx.58.2020.10.18.21.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 21:59:43 -0700 (PDT)
Date:   Mon, 19 Oct 2020 06:59:42 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 03/12] builtin: make eval_sync_compare_and_swap() more
 generic
Message-ID: <20201019045942.jvjbfa25sn2hfnxb@ltop.local>
References: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
 <20201017225633.53274-4-luc.vanoostenryck@gmail.com>
 <728b9b1a-600a-ee81-a2cb-16c684124d0e@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <728b9b1a-600a-ee81-a2cb-16c684124d0e@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Oct 18, 2020 at 10:31:55PM +0100, Ramsay Jones wrote:
> On 17/10/2020 23:56, Luc Van Oostenryck wrote:
> > Most __sync_* or __atomic_* builtin functions have one or
> > more arguments having its real type determined by the first
> > argument: either the same type (a pointer to an integral type)
> > or the type of the object it points to.
> > 
> > Currently, only __sync_{bool,val}_compare_and_swap() are handled
> > but lots of very similar variants would be needed for the others.
> > So, make it a generic function, able to handle all these builtins.
> > 
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  builtin.c | 47 +++++++++++++++++++++++++++++++----------------
> >  1 file changed, 31 insertions(+), 16 deletions(-)
> > 
> > diff --git a/builtin.c b/builtin.c
> > index 0d4cb12cca22..880dd54f647e 100644
> > --- a/builtin.c
> > +++ b/builtin.c
> > @@ -31,6 +31,14 @@
> >  #include "compat/bswap.h"
> >  #include <stdarg.h>
> >  
> > +#define dyntype incomplete_ctype
> > +static bool is_dynamic_type(struct symbol *t)
> > +{
> > +	if (t->type == SYM_NODE)
> > +		t = t->ctype.base_type;
> > +	return t == &dyntype;
> > +}
> > +
> >  static int evaluate_to_int_const_expr(struct expression *expr)
> >  {
> >  	expr->ctype = &int_ctype;
> > @@ -362,29 +370,32 @@ static struct symbol_op overflow_p_op = {
> >  };
> >  
> >  
> > -static int eval_sync_compare_and_swap(struct expression *expr)
> > +static int eval_atomic_common(struct expression *expr)
> >  {
> > +	struct symbol *fntype = expr->fn->ctype->ctype.base_type;
> >  	struct symbol_list *types = NULL;
> >  	struct symbol *ctype = NULL;
> > +	struct symbol *t;
> >  	struct expression *arg;
> >  	int n = 0;
> >  
> > -	/* the first arg is a pointer type; we'd already verified that */
> > +	// The number of arguments have already be verified.
> > +	// The first arg must be a pointer type to an integral type.
> 
> s/pointer type to/pointer to/
> (it just sounds odd, otherwise)
> or maybe ... must be a 'pointer to an integral' type. ?

Well, yes, it's a bit hard to express clearly. The real infos are:
* it must be a 'struct symbol *', the are used for any type, pointer or not
* the type represented by this 'struct symbol *' must indeed be a pointer :
  (first_args->type == SYM_PTR) to an integral type:
  (first_args->ctype.base_type = &int_ctype).
So yes, "must be a 'pointer to an integral' type. " seems to do the job.

Thanks
-- Luc
