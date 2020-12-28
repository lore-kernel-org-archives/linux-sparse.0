Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D7EC4361B
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E908223C8
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgL1Wzw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbgL1Uty (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 15:49:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1C2C061793
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 12:49:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c5so12481022wrp.6
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 12:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3YV2amOpBffge8wHke0l/dVwoCLRBRKXcCc+HrXhULo=;
        b=hWcV+ojRTgRPefWw8jOAGz/7eGmmNknAwj6a4Uy1G91yGFAUkN31Aanf5+ETgQnwFU
         Fmzb14kTKi668Th2qUGkG0bmhu5VxFIGjsFCct/hFhyghGnDazL73cfR/0jb7GM0vtf1
         lQ209808ckmmeaWbMHx41OEp1p5oe+eDABCD3N5FzO8/hcbapbvYN6KazNsCLVoqFFvZ
         TCs+1qeOKvdL5DiT0JS0peP/xQfbJ2+x/MMn0zSyyCFRu84fru0eJFH+2w9Jf9jtk4gV
         ywE9nl8045fI9/Xm69a2bgC4nPurAHsJhx2WJv1hUI730yAUIWEUx74u6ris+E8fu1Ig
         TxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3YV2amOpBffge8wHke0l/dVwoCLRBRKXcCc+HrXhULo=;
        b=LoT330ErPr28mHKuGnNM9RtlMINaK36nKf0M/8TqgXkscNGbJQuHReemCbTZRxHm+L
         Etgp30nm3s2UuDEfrS8wMucWzP29abBEPNNBsDhuC06rRSvtgCw84zg2AIt7Z5jj0uLR
         XhhFO4YRiqvtZR+f6Sxh197kZLTcr7s/8Q082wVCZIat28xhfP21F5AkSobCDfcOFmCV
         tP0P6rhYkD9nugcStLU1033QSmiti21y444HPueAydVX8XHdAOuyMyLi4NojTEhbr6zz
         b6X03T9AtimsgHoMLhMvAibHazG4ahnh2k61iaLnXVn4h2mKjU8AQCnpFDfbZf1SkOKq
         aLQw==
X-Gm-Message-State: AOAM531TPCyM70A8PVwZ0bEIQ3vVfeJ1DyU0VgeLJIRcSB+TQ1Z9Xbur
        h4cInD8ZUBPpI2BaRpiXF7c=
X-Google-Smtp-Source: ABdhPJzcvlC7b3feyVNRZKodOVvz1s491MOq5o9JzfV2bFxNEfzW9Xz5LOAYfknP5Olo/jbG0LtKJQ==
X-Received: by 2002:a5d:5112:: with SMTP id s18mr40298952wrt.267.1609188552539;
        Mon, 28 Dec 2020 12:49:12 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:1cf:be4f:91b8:4ca6])
        by smtp.gmail.com with ESMTPSA id b9sm567437wmd.32.2020.12.28.12.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 12:49:11 -0800 (PST)
Date:   Mon, 28 Dec 2020 21:49:10 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 10/16] struct-attr: prepare to handle attributes at
 the end of struct definitions (1)
Message-ID: <20201228204910.qeu4vw5d4od24j4u@ltop.local>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <20201226175129.9621-11-luc.vanoostenryck@gmail.com>
 <d15f0dbe-4645-6050-f995-7c815e86f8c0@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d15f0dbe-4645-6050-f995-7c815e86f8c0@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Dec 28, 2020 at 04:54:30PM +0000, Ramsay Jones wrote:
> On 26/12/2020 17:51, Luc Van Oostenryck wrote:
> > Type attributes for struct can be placed either just after the
> > keyword 'struct' or after the '}' ending its definition but this
> > later case is currently ignored.
> > 
> > Prepare the handling of this by factoring the code common to both
> > cases in a single place.
> > 
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  parse.c                        | 11 +++++------
> >  validation/parsing/enum-attr.c |  4 ++--
> >  2 files changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/parse.c b/parse.c
> > index d6343f0e48bf..99d810910dab 100644
> > --- a/parse.c
> > +++ b/parse.c
> > @@ -745,12 +745,7 @@ static struct token *struct_union_enum_specifier(enum type type,
> >  			if (sym->symbol_list)
> >  				error_die(token->pos, "redefinition of %s", show_typename (sym));
> >  			sym->pos = *repos;
> > -			token = parse(token->next, sym);
> > -			token = expect(token, '}', "at end of struct-union-enum-specifier");
> > -
> > -			// Mark the structure as needing re-examination
> > -			sym->examined = 0;
> > -			sym->endpos = token->pos;
> > +			goto end;
> >  		}
> >  		return token;
> >  	}
> > @@ -763,10 +758,14 @@ static struct token *struct_union_enum_specifier(enum type type,
> >  	}
> >  
> >  	sym = alloc_symbol(token->pos, type);
> > +end:
> >  	set_current_scope(sym);		// used by dissect
> >  	token = parse(token->next, sym);
> >  	ctx->ctype.base_type = sym;
> >  	token =  expect(token, '}', "at end of specifier");
> > +
> > +	// Mark the structure as needing re-examination
> > +	sym->examined = 0;
> >  	sym->endpos = token->pos;
> 
> Hmm, this is not a simple 1:1 code movement.
> Is the 'set_current_scope(sym);' or 'ctx->ctype.base_type = sym;'
> relevant to this change? It is not mentioned in the commit
> message (and I can't tell just looking at the patch text).

Good points, thanks.
For the 'set_current_scope(sym);', I'm not 100% sure it's OK and
it's to me to reason about it because it's done only for dissect.

Thinking a bit more about it, it should be moved just above the 'end:'.

Thanks,
-- Luc
