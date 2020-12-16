Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD24C4361B
	for <linux-sparse@archiver.kernel.org>; Wed, 16 Dec 2020 23:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2941A23730
	for <linux-sparse@archiver.kernel.org>; Wed, 16 Dec 2020 23:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgLPXwh (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 16 Dec 2020 18:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgLPXwg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Dec 2020 18:52:36 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2F0C061794
        for <linux-sparse@vger.kernel.org>; Wed, 16 Dec 2020 15:51:56 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id 6so20642868ejz.5
        for <linux-sparse@vger.kernel.org>; Wed, 16 Dec 2020 15:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RpUv1LwJtr71EFgGhj+Ra240W3N75TVb5/vWlKmCrbw=;
        b=bMSDJeI/QEJ2EEvn1QiBGo+W0OeMLCmOUGezIr5Av+IKWS/l4QRtYfrecVAqtEkXWx
         Mmrz49nOgSe8F7/AYRkhsoI4IMOVHlGoT4B1CVATm9WN3TcEWzzhqD1U7gdCSb/+0Tut
         wu64F3jqmhDdhDuIyZP4OX8m7L+TE8xkfEjrF0zCZPPdLendAmSfb1nU/KIufCYpoprr
         pnXAhWGa2GcaeoNRI0WvlXncIk3u99YqOw8Hr1x2nqZgI8DQekjXPa8fIkLV6IAgWrIE
         VL8Ct+USi/NGV1Ib3mBgTg1jRS+hvgkeO/EBThwMm/ACgr+cUsOkfdGrbVkfTX9xAjpD
         l0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RpUv1LwJtr71EFgGhj+Ra240W3N75TVb5/vWlKmCrbw=;
        b=j2HFXIoMwQ8eQZegwTmiuDIJUs/HTYPfJzsHVu/oVcKJQTnwImen1Lk2YVbRwQp/oG
         aVn+hagpRfYPNMYjvoZsKiZHSUjfvczKjOjtrS4LOfab/I9JFjCaMz2gfz030gfuKzWO
         QYYwXQ0+zIyqDfdaBLeqBxo0M4SPT249EjP0wObYbN6vLJDN20W+LISuiLLZ570w7gyx
         RD8/qyWdqUcfB4z4Ftx+A72vFhXJNmaDWfFgkxJ/9olE19uW8PUbJYUyOIaiYJn0v3Qk
         GDowtV5Za3jUE/ZKgOdbkWSBlhnjomCIbIUg6QtftlqUaw49OsY/ZMISAdaXBM4aFPA1
         r5yA==
X-Gm-Message-State: AOAM533hhV/LyEYQDo35/HoOQvyOzbly2il7nEl8Da/wrvoO9auTwRwD
        vRIId1CZGuFKN02q/RD2zFLaUYmBbR8=
X-Google-Smtp-Source: ABdhPJzIc3cKd1vjG7T/VetO34VjtoLdKI1F6wmoZMUUgz3FwU1xzhFsBG2jnK8jE4yhWi3w1zgyeg==
X-Received: by 2002:a17:906:f894:: with SMTP id lg20mr32742071ejb.348.1608162715105;
        Wed, 16 Dec 2020 15:51:55 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:30ac:ec9a:2892:f5b7])
        by smtp.gmail.com with ESMTPSA id by30sm54773edb.15.2020.12.16.15.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 15:51:54 -0800 (PST)
Date:   Thu, 17 Dec 2020 00:51:52 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] warn when zero-extending a negation
Message-ID: <20201216235152.6oinwuti3uzvwai5@ltop.local>
References: <CAHk-=wjiC6UejP6xob9BMQy98O6OLGDhy-qDfaFcOJxo90iOFg@mail.gmail.com>
 <20201216222448.2054-1-luc.vanoostenryck@gmail.com>
 <CAHk-=wiWSQgvyKxaVDac+1Fto7_hYCY9Nir8eaPu7dNmV+b=tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiWSQgvyKxaVDac+1Fto7_hYCY9Nir8eaPu7dNmV+b=tA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Dec 16, 2020 at 02:37:04PM -0800, Linus Torvalds wrote:
> On Wed, Dec 16, 2020 at 2:25 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > I suppose that it is fine for you that I your SoB instead of the
> > 'Originally-by' I used here?
> 
> Either works for me.
> 
> Some of the cases I saw (from my very quick look) were because of
> annoying zero extensions that should have been optimized away.

...
 
> Zero-extend, and then truncate:
> 
>   zext.32     %r2 <- (8) %arg1
>   shl.32      %r5 <- $1, %arg2
>   trunc.8     %r6 <- (32) %r5
> 
> then do the 'not' in 8 bits, because we did that part ok:
> 
>    not.8       %r7 <- %r6
> 
> and then the zero-extend and truncate thing again:
> 
>     zext.32     %r9 <- (8) %r7
>     and.32      %r10 <- %r2, %r9
>     trunc.8     %r11 <- (32) %r10
> 
> and then the return in 8 bits:
> 
>     ret.8       %r11
> 
> because sparse doesn't do the simplification to just do the shl and
> and in 8 bits (but sparse *does* do the simplification to do the 'not'
> in 8 bits).

But replacing a trunc + zext by the corresponding masking, very
little, if anything is done for such 'mixed-width' expressions.
So, I'm even a bit surprised by the not.8 but well ... 

I also confess, that coming from an ARM background, seeing a
not.8 or a shl.8 seems quite unnatural to me. I would tend to
force everything to at least the same width as 'int'.

> So the warning comes from the fact that we kept that zero extend
> around, even though it really wasn't relevant..
> 
> I don't know how many of the false positives were due to things like
> this, but at least a couple were.

Yes, most probably.
I suppose my (old old) series about bitfield simplification will
help a little bit here. I'll try to look at this during the holidays.

-- Luc
