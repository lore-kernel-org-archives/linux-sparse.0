Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AEDC433B4
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Apr 2021 18:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C300611C2
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Apr 2021 18:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbhDQSV2 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Apr 2021 14:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbhDQSV1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Apr 2021 14:21:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951DEC061574
        for <linux-sparse@vger.kernel.org>; Sat, 17 Apr 2021 11:20:59 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f8so36012684edd.11
        for <linux-sparse@vger.kernel.org>; Sat, 17 Apr 2021 11:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vp6PyUnKvpB5YrXbNIBJiayZf1mFesTXPxdgS9aIuuo=;
        b=GI66uiUHYz21SOB7/RYv8y7QSofRNBQDUJE/IrTjhGbmkzD0tPb62zjwuQUvyGbvsS
         iWrAduCi8OTv8Zf6QrO0Lqwo5aUE/Y256vSL/I7+yaC0OQZJeCZsE3atcObYGRlG1hVc
         p5bSh7JCIK5pEBjSiQ9450QjuWvBSkOjMU0ZYJb5L0AOpm3t4J0IW4P8fqoiGnP5lPTg
         92SnVDuZ2G/TIpPj55SJeRRq6AvztT6ZxN1BoGqNImO7dU8lFERNmFCptUxk/64mXNiT
         NFS6std+cKVctqnix/iwlocpgBRQJXD279HWb5sUmG+stGGsR7m82kg/5AAhV0OtT8my
         IRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vp6PyUnKvpB5YrXbNIBJiayZf1mFesTXPxdgS9aIuuo=;
        b=eWbVzi9jHinKkGR0Q9/i/75480yPDLDCRIDd8dKh3cyRK4NpNdWsFbO9pAnRNPw9jP
         xb3FG7hxtvvIHovYrlpE+XNOgaoIS3/VaBhIE8ifqvnyVBBRw7X10BkC+xgsnpxbZv8L
         QoJ0kzDZfeOkegJ7k8fOnH6COiKTF3eisi3Kj2nU3gfiGaFpdGMSPuMtqJ6X92pUFzzC
         +hodxrudUm52RvCT4VKpfGB0GsdU8kJjHvvp2JiGA2flN3jbPsUtTMYZm6uNTXyhcQu2
         kCrDIgofK/MRuxgVWz9XwPOt+Rrhc8jxiqWSobOjBrPUguzUhdjY7WrNQ2K1XeSgbg3o
         +CYQ==
X-Gm-Message-State: AOAM533/hK5P/Dqv95g0M8s6iZVHJCIwlJIHQtC8ySuMeGKPKyv8YGqt
        S0GRCqjaW457kKf2Rt+an22hvHThBes=
X-Google-Smtp-Source: ABdhPJwRZIzTGtXpFrM75UVR6hK+2jnkvuX1PgFmrVImakohFYIYcpS5C7NuQEfm6lj2BjLe/gjA8Q==
X-Received: by 2002:a05:6402:10c6:: with SMTP id p6mr16746345edu.241.1618683655729;
        Sat, 17 Apr 2021 11:20:55 -0700 (PDT)
Received: from mail ([2a02:a03f:b7fe:f700:8120:1c81:5e73:b5c1])
        by smtp.gmail.com with ESMTPSA id g10sm9577881edf.82.2021.04.17.11.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 11:20:55 -0700 (PDT)
Date:   Sat, 17 Apr 2021 20:20:54 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 00/10] simplify and canonicalize signed compares
Message-ID: <20210417182054.rz52qrkm5hjnlv4z@mail>
References: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
 <CAHk-=wgO=9N_Qz6MsXB2SVUGXHX53bFEvNDbmLHB6_W+dEBN-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgO=9N_Qz6MsXB2SVUGXHX53bFEvNDbmLHB6_W+dEBN-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Apr 17, 2021 at 10:16:31AM -0700, Linus Torvalds wrote:
> On Tue, Jan 26, 2021 at 7:45 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > This series fixes and improves the simplification and the
> > canonicalization of signed compares.
> 
> Hmm. Sorry for not replying earlier, but I just checked the most
> common simplification of signed compares, and it didn't work.
> 
> This:
> 
>     _Bool test(int a)
>     {
>         return a >=0 && a < 16;
>     }
> 
> should simplify to be the same as
> 
>     _Bool test(int a)
>     {
>         return (unsigned)a < 16;
>     }
> 
> but it doesn't. It generates the silly - but straightforward - "two
> comparisons and a 'and' of the result".

Yes, I've a draft for this but I still needs to add some tests and such.

> In fact, the recent canonicalizations means that the compare against
> zero is actually pessimised, and ">= 0" becomes "> 0xffffffff", which
> is often a much more expensive operation.

Yes, I'm aware of the problem, more or less.
When I did the canonicalization, I wondered what was better:
* canonicalize toward 0
* canonicalize toward the smallest

I choose the later because at the moment it was somehow advantageous
because it reduced by 2 some patterns (it allows to eliminate all >=
and all <; when doing it toward 0 you can eliminate one set for positive
and the other one for negatives values so you need both sets). The
compare with -1 instead of with 0 didn't looked much problematic and
relatively rare. But in the following days I realized it was in fact
quite annoying.

So, yes, it's something I'll change very soon.

-- Luc
