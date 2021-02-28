Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DA3C433E0
	for <linux-sparse@archiver.kernel.org>; Sun, 28 Feb 2021 21:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 135C864E54
	for <linux-sparse@archiver.kernel.org>; Sun, 28 Feb 2021 21:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhB1Vkt (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 28 Feb 2021 16:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhB1Vkt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 Feb 2021 16:40:49 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6270C06174A
        for <linux-sparse@vger.kernel.org>; Sun, 28 Feb 2021 13:40:08 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id do6so24634856ejc.3
        for <linux-sparse@vger.kernel.org>; Sun, 28 Feb 2021 13:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=glJdM80sOirsalhJyERG5NSrwbanC9DPFxQNyKClmSI=;
        b=moBvOXE96NYnCktgoxHbCG+nSJ26s1xEADklISsXD7wgvFo1y3jFpLLRZYDLuPDHAd
         MW4sy06UvG33dWoSioYIVOiOEOYzAdYYv+GKiG8kt2WO4kXy0tS/UM/EupBShAxef/Ov
         Qe52Em6K/bGP47LKu4/4ae1WF5n7Le9Glt2x9e8EWI05fSZZ3JTFSblM3KFNNiSo1Kxa
         Q8MNq89POE9UJOdrZBlIvfpACTBMdYX13Xp9tworWIB4KnhBgKsps/4Z0LygmrVfKpuC
         D+l6PFIeeS8gwJrRPb6XCKdqT8ZAcyd4sVcF1Rn+lHYM3RoI7nkfAMyxAAca1xLmqeSB
         rGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=glJdM80sOirsalhJyERG5NSrwbanC9DPFxQNyKClmSI=;
        b=Ku7AjXPWs/Yq2nQqDBrRpN1Rq2KqpfoR5UT2qkFKQlJUfD+RXCn7piIfO89FtTH3fr
         USk5k8jfNBHCht4ojT+tO3zpz2LWU6RKZTO73XIBndrTAjGoUMykoon4DhMPuaVljBI9
         4MEq7bl+H4nck7Zsq6/2c+1Q1V03zpoPygnGJdntP6twyWVWAyQihsoLyD2xIFRVk7al
         DCSOE6liDHqlKd+/JbNHrrBaq/onvR+T5ybyu0qWbpoKXaEtPwHPCHPM2wZvN+3ktrAN
         +TF9s1hJk7NeGbP6UiunYkHC1Tu3No1nz0z32Xc/Q1uNplFzfWxsV0ZyHmcMxUcpTHz2
         URFA==
X-Gm-Message-State: AOAM530ZVM8d1nWJbLMK2xcE6gF+ZQIoMT0UjJ0GeNnus0GfxQDz+fVX
        wZ1X6EICE2kBIjPP75gSYCIF4dao15w=
X-Google-Smtp-Source: ABdhPJy4QxacUm+8q7Wgve6lGj5seloluOWSwNyeprKgg2HirbCM/w8gF4hfgQFkoFO1TnWreLi7+g==
X-Received: by 2002:a17:906:c08e:: with SMTP id f14mr13536547ejz.388.1614548407662;
        Sun, 28 Feb 2021 13:40:07 -0800 (PST)
Received: from mail ([2a02:a03f:b7fe:f700:f064:41f:ed1d:4c78])
        by smtp.gmail.com with ESMTPSA id g10sm11212066ejk.88.2021.02.28.13.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 13:40:07 -0800 (PST)
Date:   Sun, 28 Feb 2021 22:40:06 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 3/4] slice: OP_SLICE needs the source's type: make it a
 kind of unop
Message-ID: <20210228214006.exlge44yl4xiph2m@mail>
References: <20210225233908.97275-1-luc.vanoostenryck@gmail.com>
 <20210225233908.97275-4-luc.vanoostenryck@gmail.com>
 <bff5dc80-92cc-8bc0-2bd8-0e6f8f9f46a7@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bff5dc80-92cc-8bc0-2bd8-0e6f8f9f46a7@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Feb 26, 2021 at 11:56:58PM +0000, Ramsay Jones wrote:
> On 25/02/2021 23:39, Luc Van Oostenryck wrote:
> > diff --git a/liveness.c b/liveness.c
> > index 30a9a5b6b169..755509e59b52 100644
> > --- a/liveness.c
> > +++ b/liveness.c
> > @@ -76,6 +76,7 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
> >  	/* Uni */
> >  	case OP_UNOP ... OP_UNOP_END:
> >  	case OP_SYMADDR:
> > +	case OP_SLICE:
> >  		USES(src1); DEFINES(target);
> 
> wouldn't USES(src) be more appropriate? They are not binops.

Yes, even though they are synonymous (and documented as such) it makes
thinks slightly clearer. I'll change this in a separate patch.

Thank you (also for the 2 other patches),
-- Luc
