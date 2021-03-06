Return-Path: <SRS0=i4AA=IE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C89DC433E0
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 22:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3AC650C9
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 22:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhCFWFw (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 17:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCFWFe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 17:05:34 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7051FC06174A
        for <linux-sparse@vger.kernel.org>; Sat,  6 Mar 2021 14:05:32 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lr13so11904715ejb.8
        for <linux-sparse@vger.kernel.org>; Sat, 06 Mar 2021 14:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FXG33zAP1x5RmJWV5OXLKcTyK8FKNzFyd1YW0qvg2HA=;
        b=gdpApHkPXMPs5X0Ry2mYVRi0iJqHh5jakL9vb/Q2GTlX5/Wtn5hmVLRnQdK1ROmxJG
         xHR4X+mOYLBHAH+k+EsVr0azq10aAeyg4ovdSyXzWBaKWhqMc6/QcFsnv4a4YLg0KBzR
         IhA8T7AqxS8n+Y49crMPqDaF3M6f5DroiyfxUrYHdvPSBqmvswI0Y5i60A3sDkkfOokL
         L43/osTFF8aNcMZ/hDiuAySsf4uRQ3QxQW1/zScjvHp1i9ilgeQ9d6J4AoR8kC6gSOH/
         fXodxs8OoOUve/Hj5YZw8cd3qRw1RvzbwpZPv9GHGVVEebJjHktiK2i8RMPW896S7za+
         a/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FXG33zAP1x5RmJWV5OXLKcTyK8FKNzFyd1YW0qvg2HA=;
        b=tiMvesLyKJ9uvwwvZSQQCXK05tlQxodAZ4/M8LghuaCQOTHJ1Na7cVHm+cC457VrLS
         G/rl3zkjTFrkDxw+QPyjcfvctNGwWdSgg5+qfFBkaX29F6f+hcY+uf1sbBRuMtytB4MB
         ScFTS8nQ9C1Y0NrHpZWr3c4y9f5ZiFW+T2tHUURgugCHjImNYGWk2ltGY9Sa/jCa0Io8
         i0PuWELrmdSrwWw8yq5Z1I5Epk3A6VDa64wuDZdMeNCyW4o9VjnueHgZ10iRo1oRnjrx
         QCb8ykESUje5x6DijO4X4RlwCAHcwB3mxZTDF96A5z+t+WZjMhIQeOlvQlw2juEGHoV5
         /nvQ==
X-Gm-Message-State: AOAM533Pgw4Nj9lPraefyHD7YcitmEFxaEmWypcY4Yvdkapo5mUyeBY0
        A7XOkoD17R1jVgyIxkDwg1aBuQsAXKw=
X-Google-Smtp-Source: ABdhPJxL7ZCV+MgIUGs2unmaeJwVSYINyRd+1pepf2vI4vH2T3ehwOvyAsFba2PdehRbZettjXt/Lg==
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr8413929ejc.408.1615068331268;
        Sat, 06 Mar 2021 14:05:31 -0800 (PST)
Received: from mail ([2a02:a03f:b7fe:f700:bc27:6c84:bc74:6682])
        by smtp.gmail.com with ESMTPSA id u1sm3851286edv.90.2021.03.06.14.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 14:05:30 -0800 (PST)
Date:   Sat, 6 Mar 2021 23:05:29 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 5/6] ptrlist: make linearize_ptr_list() generic
Message-ID: <20210306220529.wkncnewr6mnm7qet@mail>
References: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
 <20210306100552.33784-6-luc.vanoostenryck@gmail.com>
 <b896e87f-8850-f0ae-875b-15251f93ffb3@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b896e87f-8850-f0ae-875b-15251f93ffb3@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Mar 06, 2021 at 04:35:52PM +0000, Ramsay Jones wrote:
> On 06/03/2021 10:05, Luc Van Oostenryck wrote:
> > The ptrlist API has a function to copy the elements of a ptrlist
> > into an array but it's not typed and thus needs a wrapper (or casts)
> > for each type it's used for. Also, 'linearize' is confusing since
> > this is unrelated to Sparse's linearization.
> > 
> > Simplify this by adding a generic (but type-safe) macro for this
> > (and changing the name): ptr_list_to_array()
> 
> Hmm, you have removed/renamed all current callers of linearize_ptr_list(),
> but you haven't 'changed the name'; you can't, otherwise the new wrapper
> macro wouldn't work! ;-)

I've changed the name of the interface. But yes, the message was confusing.

> Maybe, s/and changing the name/with a more descriptive name/

Yes, this is better. Thank you.
-- Luc
