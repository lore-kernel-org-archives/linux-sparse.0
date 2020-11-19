Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124F2C63798
	for <linux-sparse@archiver.kernel.org>; Thu, 19 Nov 2020 08:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57AA246DC
	for <linux-sparse@archiver.kernel.org>; Thu, 19 Nov 2020 08:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n14LNnn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgKSILl (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 19 Nov 2020 03:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgKSILk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 19 Nov 2020 03:11:40 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A98C0613CF
        for <linux-sparse@vger.kernel.org>; Thu, 19 Nov 2020 00:11:40 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id gj5so6615620ejb.8
        for <linux-sparse@vger.kernel.org>; Thu, 19 Nov 2020 00:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R4FLayzx8rpN9LWWfrT9ADYLTbbXkmBLymeCNBHPp2E=;
        b=n14LNnn0AW3ro+bNMrOmK8OOf+y4q0/2EW+gmHbUgtob4ctqkfxrFpJcNsImghwMVZ
         unZDLy1x4YZcgf9vP4UoQ2WU3iPqSazRf4i17WLg5cnY4qoR/niDwOtX7p9CRjYBQYiZ
         YPVE3XP/CegIf1tUU2iSSR/LY6ivaVpkcqbC/ltPPFZmMvPlRXtUh6GdRpSN6BN65cmS
         KAgcHcoqJ1nBee0PKvfzT1nZ5iv4V9Zpn4y9q9x7t723sWhHVgn06+ivBQEczbRiNUcY
         Kd5JimJThOkxIuLUZBs3JIycARSDqiercg2WH7GwYnaH+kMDbfRjI4fSfr9a9qhonLBU
         3hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R4FLayzx8rpN9LWWfrT9ADYLTbbXkmBLymeCNBHPp2E=;
        b=AYp38KduG1gY6wbbBZyeHUJxGdDogHGiI1PA1dUbtIzeo6+BIkRyuMwRrZEdT9c7Rc
         bzBQnGLGsK8hIHasvlFqhyooZHUV7TvZDc6ImnQjYay9aKmXlgrZi/B8z1rPum6RPDnb
         /TWSKY00LXZPYg0TUHbVDnKes+gVJf/+i45T9DUNxuckoKn7rkTvdnTHtFrJbnnixHhs
         uBM2rQxfhYrEHkuDcvDH1bF2B+huEYq44HP46jdeGUIwlo5bDFaOiTTgTPnCxOSJzQGG
         8X7zMh2ORj5f3Log67xyZz3MjwZTI46l7diCyvy4y0qoo9uK2259+Ymw89k4O1O5ABuz
         E8qg==
X-Gm-Message-State: AOAM533RIVgDH23ixy9Bs55mVhXARqBxRvKGALbRZ5yza/wHRbaNwWfD
        aLjpl0oyv7+2DknvQe+SLYtI0PstBkI=
X-Google-Smtp-Source: ABdhPJxAzdnTWqUT/B2a8A5mXzezya9YME6fGPfhgCVhDT0mUOySc796ULtQIg2roSBOoRjblFyROQ==
X-Received: by 2002:a17:907:2657:: with SMTP id ar23mr9997646ejc.386.1605773499169;
        Thu, 19 Nov 2020 00:11:39 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:b5cc:847:de2e:9ae3])
        by smtp.gmail.com with ESMTPSA id f10sm4773391edw.93.2020.11.19.00.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 00:11:38 -0800 (PST)
Date:   Thu, 19 Nov 2020 09:11:37 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] casts should drop qualifiers
Message-ID: <20201119081137.lxmry66fbww3rhrz@ltop.local>
References: <CAHk-=wivBmCoux_bVz_tZ12byZS=oZ7+F2Og8OjJGM5aiM-KQQ@mail.gmail.com>
 <20201117212829.99552-1-luc.vanoostenryck@gmail.com>
 <CAHk-=wgtL1LPYev5cwhZqd=7RyaGrzx3mS-ydVZAQuYrf0XNuQ@mail.gmail.com>
 <CAHk-=wi-XUPMduO16mvNeou58O-LrxnSk33WBg+vbbqCpzHgOw@mail.gmail.com>
 <20201118191737.oq2e2t5h2wo3us3c@ltop.local>
 <CAHk-=wjB+c+1ykVzRz5yKX486hHNMMNVAhrwwvbRuuo9eO5gfg@mail.gmail.com>
 <20201118213027.3o74il23b5nesx3d@ltop.local>
 <CAHk-=wgYd+L_FVX7uny9_i2hNqB6=EryCKV4wtFwa+scaYnmHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgYd+L_FVX7uny9_i2hNqB6=EryCKV4wtFwa+scaYnmHw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Nov 18, 2020 at 04:58:26PM -0800, Linus Torvalds wrote:
> On Wed, Nov 18, 2020 at 1:30 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > If I read the standard correctly (big 'if'), in:
> >         volatile int x;
> >         typeof(++x) y;
> > 'y' should have the type 'volatile int' and GCC interpret it so.
> 
> That sounds extremely odd to me. I think it should have the same type
> as "x += 1" or "x = x+1",  no?

Yes, but both cases are explicitly excluded from C's 6.3.2.1 where
lvalue-conversion is defined. This whole section was very confusing
to me but the note 112) in n1570's 6.5.16.1 is somehow clearer.

So yes, I'll drop this patch (I should have tagged it as RFC anyway).
Thanks for the feedback.

-- Luc.
