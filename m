Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680DBC1B0D8
	for <linux-sparse@archiver.kernel.org>; Thu, 17 Dec 2020 00:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4127223719
	for <linux-sparse@archiver.kernel.org>; Thu, 17 Dec 2020 00:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgLQAhI (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 16 Dec 2020 19:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgLQAhH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Dec 2020 19:37:07 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7343C0611CA
        for <linux-sparse@vger.kernel.org>; Wed, 16 Dec 2020 16:36:00 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id x16so35401497ejj.7
        for <linux-sparse@vger.kernel.org>; Wed, 16 Dec 2020 16:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=td63KZpe89LyUHK8egmDUgPelCfU1BBbZwUa97WsMI4=;
        b=rr+ej9+ok866x918vDiUVpByX+3vDoS7EEsrPX1dMWdcIBB0uQivalWUB/uiTYMX4e
         lF1yQeDYQofcDPI00M0dXV+cPXtP0zfjsPPx+efLMcZHo1bfI0WhJA/1wyRhfyY2PdZk
         MD0+gLxkmv2n7Wzsm0c3kc7ftKM+iEuAmRQWzK/PtvAw1GZqEwEVSO4vfo9mdm21V5Ub
         cDCoUbqmKltQzgiqHlXshrxseA+v5589sIOZU9RPyGdhyzp1g0LgUwwNnKDXBJKHL8BT
         ImJGwinBsdypCSjWw4k9H2IgyXQ+fVWnaDDt1piSlDU/xZPPkeSSa/cCQShd5CuRNc9T
         aV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=td63KZpe89LyUHK8egmDUgPelCfU1BBbZwUa97WsMI4=;
        b=bFJzw7zZTcMdW0cpyZEalkq4N/ZzoUTa5ZhfptjgRimGkZwPwJZIYM7EvBbrqVWIwB
         e2Y3HFnkKXvjp/qa9zZ4sfyUoL2klDYjwA4AVcOBFqPvdL6DTO5rcOSPTncsov8Db5KS
         9A/7Ar7vTZC3ZiAyOSp1AtBjv7rJmg6ONxchE08X1ESxbqU4F3oC7FVDWy78ITnbiGr6
         h3M+zS6DK1IpqRrsEd9zZftcDqRxaTD184aprqTHKrHPU4TL0OEteTe3YkYGPiaUX2Ag
         eiUC0wwaKij1jo2ZO8zAdAK4gPmU1JBkLK+zwfV+dkgJuZzwfXNJXfnD6gs8cvxNNhxi
         SMeg==
X-Gm-Message-State: AOAM533IvUCNkx75U0g1zdIZ8WPhRNiFkhg9hNCAll9jKffyB4XuCaiD
        KFgLLXpCdLBerUjxhtpPYrPhEwDeWfw=
X-Google-Smtp-Source: ABdhPJxMVeBvbnx5gymti6yxJxegBDWIpDktZcu9IX6pLEve6ktFWrRZ8Olee1PshiiPkxQ3ljx9cQ==
X-Received: by 2002:a17:906:c414:: with SMTP id u20mr7982687ejz.511.1608165359671;
        Wed, 16 Dec 2020 16:35:59 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:30ac:ec9a:2892:f5b7])
        by smtp.gmail.com with ESMTPSA id t19sm2509001ejc.62.2020.12.16.16.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 16:35:58 -0800 (PST)
Date:   Thu, 17 Dec 2020 01:35:57 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] warn when zero-extending a negation
Message-ID: <20201217003557.qpcawxx46cwmvz27@ltop.local>
References: <CAHk-=wjiC6UejP6xob9BMQy98O6OLGDhy-qDfaFcOJxo90iOFg@mail.gmail.com>
 <20201216222448.2054-1-luc.vanoostenryck@gmail.com>
 <CAHk-=wiWSQgvyKxaVDac+1Fto7_hYCY9Nir8eaPu7dNmV+b=tA@mail.gmail.com>
 <20201216235152.6oinwuti3uzvwai5@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216235152.6oinwuti3uzvwai5@ltop.local>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Dec 17, 2020 at 12:51:52AM +0100, Luc Van Oostenryck wrote:
> 
> But replacing a trunc + zext by the corresponding masking, very
> little, if anything is done for such 'mixed-width' expressions.
> So, I'm even a bit surprised by the not.8 but well ... 

This bothered me a bit and kept me awake, so I had to check.

I think that the situation is caused by some premature optimization
for the ~ operator in expression.c:cast_to(). It saves the allocation
and initialization of one expression but makes things more complicated
at linearization and simplification. If this is disabled, then the IR
simplification returns what I was expecting:
	maskout:
		zext.32     %r2 <- (8) %arg1
		shl.32      %r5 <- $1, %arg2
		not.32      %r6 <- %r5
		and.32      %r9 <- %r6, $255
		and.32      %r10 <- %r2, %r9
		trunc.8     %r11 <- (32) %r10
		ret.8       %r11

and some reassociation patches (coming soon) will simplify away
the masking with $255 and the trunc.8

-- Luc
