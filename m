Return-Path: <SRS0=pmk5=BI=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607ADC433E0
	for <linux-sparse@archiver.kernel.org>; Wed, 29 Jul 2020 14:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D75206D8
	for <linux-sparse@archiver.kernel.org>; Wed, 29 Jul 2020 14:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDJmrsg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgG2Oua (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2Ou3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 29 Jul 2020 10:50:29 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6199FC061794
        for <linux-sparse@vger.kernel.org>; Wed, 29 Jul 2020 07:50:29 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id c16so4265929ejx.12
        for <linux-sparse@vger.kernel.org>; Wed, 29 Jul 2020 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q1Z85cpoNJOEp8A3uYT1t/gbivG6xxIMrOhQue15sH8=;
        b=RDJmrsg8R7dUiIZqrIWc9BCkT9jTHCqX6Y7VY4qfqAmb0QDSusmJDVy3tJ/rcFhSoe
         vm45NuxPjy5vGuQxv1Ef+Yriywqz4p06/4s2PaF4xPJE1Eh0sm/UGDqDE1EbT1/qHqf2
         r/2WTCVJDnqqy1AN5Fz3/lnrgkDJnhYH+Y8tHKzNmhnS2qqiQU3HgDF6Cc+pn33FkNRV
         frbzm46aL9gMvHb+ffMT2J4z43SEz8HyAbJ1OPpJbw9d4SMeStVISn2glm0fZC3XxVOH
         nlpkjLyTlMpkycUROOj5rssUuBJAxeFgp8gwbrc8nUAMO7R0FfZeLmtPhdYc2qQ17oNx
         auew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q1Z85cpoNJOEp8A3uYT1t/gbivG6xxIMrOhQue15sH8=;
        b=CKAZ2lgA4bOOqkVGebeZhXJtA9P6dHHxnGO/YiIoxJHgXcyJlW2RgSwFIKum+fjKUq
         hUs873WBzXbrppipQUrl3tOxEP08XIBHkAAY1d5v5gEmxmgMEFJhraNmAwvUnq4VWR2U
         yzrr/FRK+gFI5enL5hlpb94HcsYoWfUx5kMt9JgWW30dmnRMeGO7Mqeez8FewIfpnYPX
         6qxzSdeaynNj1YqaJ+qmj3qCShcVJAkkXikI20JcANBnotT8F93hJ9kC4PMFKlw7PHFV
         D4sZB4V/waJbKN2EQjK4FeUCgsxq2wKtNqya2yzTh4GIsYbAhe49YXs8orxI1f/HwYtr
         sAOw==
X-Gm-Message-State: AOAM531EH6kwtEm3YqG+zmsf+FJUwtKNXu80rLB04KX7Dk/iSnlcLJrn
        8A5VlrFd/pYakQzM3l3vESUwRoyt
X-Google-Smtp-Source: ABdhPJxpCzgOXueUWi/Zcq1K0cBIWBHLeAKKECXETs50kDjzvMOtqkCg+3tJVVddnJOHpxdwlPyynA==
X-Received: by 2002:a17:906:82c1:: with SMTP id a1mr19522114ejy.172.1596034228056;
        Wed, 29 Jul 2020 07:50:28 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:98d9:cf3a:3f6c:265a])
        by smtp.gmail.com with ESMTPSA id dc23sm2047008edb.50.2020.07.29.07.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 07:50:26 -0700 (PDT)
Date:   Wed, 29 Jul 2020 16:50:25 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] dissect: add support for _Generic
Message-ID: <20200729145025.g26jqfpqcnhd5wed@ltop.local>
References: <20200728183507.422662-1-gladkov.alexey@gmail.com>
 <20200728194937.GA2467@redhat.com>
 <20200728231058.3yakpfw3dqslxq5t@ltop.local>
 <20200729112801.GA4360@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729112801.GA4360@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Jul 29, 2020 at 01:28:02PM +0200, Oleg Nesterov wrote:
> On 07/29, Luc Van Oostenryck wrote:
> >
> > OTOH, I wonder what can be done without first evaluating
> > (the type of) the controlling expression and the types of the map
> > (if I understand correctly, evaluation is avoided in dissect).
> 
> Yes. I'll try to think a bit more, but so far I think I'll simply
> send the patch below.

... 

> Of course, technically this is wrong, it looks as if all 3 variables are
> modified. But not that bad imo, dissect doesn't even try to be "precise",
> and this output still looks useful for the indexing/etc.
> 
> --- a/dissect.c
> +++ b/dissect.c
> @@ -342,7 +342,6 @@ again:
>  	case EXPR_TYPE:		// [struct T]; Why ???
>  	case EXPR_VALUE:
>  	case EXPR_FVALUE:
> -	case EXPR_GENERIC:
>  
>  	break; case EXPR_LABEL:
>  		ret = &label_ctype;
> @@ -472,6 +471,17 @@ again:
>  		} while ((expr = expr->down));
>  	}
>  
> +	break; case EXPR_GENERIC: {
> +		struct type_expression *map;
> +
> +		do_expression(U_VOID, expr->control);
> +
> +		for (map = expr->map; map; map = map->next)
> +			ret = do_expression(mode, map->expr);
> +		if (expr->def)
> +			ret = do_expression(mode, expr->def);
> +	}
> +
>  	break; case EXPR_SYMBOL:
>  		ret = report_symbol(mode, expr);
>  	}

Yes, that should do the 'walking'. The returned type will just be
quite arbitrary, but I don't know how much it matters.

-- Luc
