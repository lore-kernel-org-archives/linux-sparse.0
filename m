Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E01AC433E6
	for <linux-sparse@archiver.kernel.org>; Fri, 22 Jan 2021 23:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2EE523B51
	for <linux-sparse@archiver.kernel.org>; Fri, 22 Jan 2021 23:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbhAVXIr (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 22 Jan 2021 18:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730539AbhAVTj0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 22 Jan 2021 14:39:26 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0970FC0613D6
        for <linux-sparse@vger.kernel.org>; Fri, 22 Jan 2021 11:38:27 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id h16so7867391edt.7
        for <linux-sparse@vger.kernel.org>; Fri, 22 Jan 2021 11:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h4tWOESJBqVB+eHeKgXPCpnHaALR3nLu0OBahRCDtVE=;
        b=Bg74QKbwV+fINrxNSnxGl7R4wjPg3MGh08payeVeGQbee1wJxc8VGbaEDfzw/Px3BZ
         w3KzgzxgpuHKjkJuqIASjY9HMQm5eG3Oa5Qe3lI/2xM+57qXuwFmYs8jDgypRG3UmLO7
         Uu9y0TD5Ws0T3qCjFeP+Q6LKqgDpHcEkhLpM1lBOE8tS77VGTi9z2Br0SOvkEBgzhyBj
         yua/Mf39MW66t/XDHi1x8AB+voWWI3sQc2J02fAKTE70LFzFbCwkdA3+a/OKzoL9cXA2
         I8pUaqp7n09Z8wowOplExXZv1lRHma9rTLB/Xi6v2nf5GnwlskLAQRr8uynBduUGJ5WX
         HIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h4tWOESJBqVB+eHeKgXPCpnHaALR3nLu0OBahRCDtVE=;
        b=YLBQwDg0EjCLhXlICP7jLetxsf+Mt1DNZf29HOsqj5CM3V1HbUb8doLDOaUHuffZKb
         IsWwJBIPuA41xaPeaz1z8aWgTXh1lTHrB7llwz72awokR80rd11lcRDEggLmOm6/Bq1s
         DXqsxB3l+c+FxZ7TeSOWMFDVrPMsqK6HI2thcllwVuNmNa4CD7KS5w7FhKIyyK8PIMUu
         vXl9gI8V4NIoxfsgcO95UGPQvPE24a4hs9PVNNdQedxoz6faUiuBqaaVSELPuc8NotW2
         iua83mTmWjTNkoNaHyG1VTXH3tf0yup5ywWKdzhBupFsnpCRyzBZ/nos9lorDJRLalBw
         i0jw==
X-Gm-Message-State: AOAM532KYqp7hraS8VPSTzG/FpnWAHVqgOm4rWEeyU3lWKscFZXfuRuM
        +qqFefrcMU8PBPCBrrxzGDU=
X-Google-Smtp-Source: ABdhPJyV5SkzZRERMJI7PYAdEVcNDqYJuFFQI88Li2HmsIEDMJ0fJn3kfV4OKI8rWCMpwdLjGT0diQ==
X-Received: by 2002:a05:6402:4c1:: with SMTP id n1mr4474022edw.66.1611344300811;
        Fri, 22 Jan 2021 11:38:20 -0800 (PST)
Received: from mail ([2a02:a03f:b7fe:f700:e13f:8447:6e59:7f11])
        by smtp.gmail.com with ESMTPSA id s21sm5102780ejz.87.2021.01.22.11.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 11:38:20 -0800 (PST)
Date:   Fri, 22 Jan 2021 20:38:19 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] handle qualified anonymous structures
Message-ID: <20210122193819.x5f2teyaw3ve4m7x@mail>
References: <CAHk-=wj4Kviw8q2Sx9vrrvyn3uWK-zNi4uGRx=5bzde0Cio8uQ@mail.gmail.com>
 <20210122162625.73007-1-luc.vanoostenryck@gmail.com>
 <CAHk-=wj3v1hm3x0x_3ui1PQDLbn7V5PoxGyDf_UB6TCxMTgjQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj3v1hm3x0x_3ui1PQDLbn7V5PoxGyDf_UB6TCxMTgjQw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Jan 22, 2021 at 09:35:43AM -0800, Linus Torvalds wrote:
> On Fri, Jan 22, 2021 at 8:26 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > So, the solution chosen here is to handle this during type examination,
> > more precisely, inside examine_struct_union_type(), where things are
> > a bit more complicated
> 
> Well, doesn't look all that complicated to me.
> 
> The only thing I would do is to just at the head of that function do:
> 
>         unsigned long mod = sym->ctype.modifiers & MOD_QUALIFIER;
> 
>         if (!mod)
>                 return;
> 
> and that also means that you can avoid the "parent-vs-sym" thing,
> because the symbol is never used after that, so you don't need to
> create a new one.

Yes, certainly since the vast majority will have a null mod.
 
> The other thing that might be worth doing is to just make sure that
> the "sub" whose modifier you change is always a SYM_NODE. We never
> want to touch an actual type, only the node.
> 
> I don't think it _can_ be anything else (that's how the struct/union
> symbol_list should be set up), but since this is a very unusual case
> of going back and modifying a symbol after the fact, I think I'd be a
> bit more comfortable with that kind of sanity check.

Yes, I agree.
I fact I almost did this but hen I said "why bother? it's always a NODE
anyway". But sure, it's cheap and better be safe than sorry.

> Anyway, looks good, and obviously passes my trivial test-case.

Thank you.
-- Luc
