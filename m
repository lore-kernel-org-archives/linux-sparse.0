Return-Path: <SRS0=gthx=EM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F2EC2D0A3
	for <linux-sparse@archiver.kernel.org>; Fri,  6 Nov 2020 22:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C6B2087E
	for <linux-sparse@archiver.kernel.org>; Fri,  6 Nov 2020 22:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ty/DKkgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgKFWTX (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 6 Nov 2020 17:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbgKFWTV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 6 Nov 2020 17:19:21 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B12C0613CF
        for <linux-sparse@vger.kernel.org>; Fri,  6 Nov 2020 14:19:21 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id a71so2781859edf.9
        for <linux-sparse@vger.kernel.org>; Fri, 06 Nov 2020 14:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ZS3W9H8cdNzD7aLGJKTMN6H3uCKYE+8H5rbEMte0HA=;
        b=ty/DKkgQRSxltIaPBaK3/ks/rsqlIcZaCgzJRNgyFG6wmWC2eQRspqSXtBIbucpq7h
         NYwfu9jE5CW5twdeCSG4reffiZQP3liALnZV/Ke6WGCMaziOaxII2d8GHzweAwZTYr7o
         8SSgIEQ4WTlxsymURSfhRnzIPz6qm8NOxNwnv1/nct5kPIcQdQ7a6BOcwhSKVI9dyMsS
         VeTBanMqrbw6zhFNcdZlYxGk1gkiwN1VQhxZldrov3BWE33I5KwIzrOkq+kZ2DVgeVS7
         685T8BVrh96hMPcnR4QdwBJ036tIgUKj173tHITHIKn+UMc44daTlE0kPL4w/mzDdr6Y
         xgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ZS3W9H8cdNzD7aLGJKTMN6H3uCKYE+8H5rbEMte0HA=;
        b=ANQ/Q84VzalfIYT6tnG4t7Je5kEqEEcvIPKgOuEze+ja9OyBFXiiSWxqpNZ55xLqG4
         cNDE6HCAEync5XB81rWIM73ckdozVkdxdl9tcViqcOl/wn6kRLvqfHghRVNkzz9D1fVI
         6bv8RkjnF0IpJl6u9R45Bz6FUtUPvsS7VmSKz2YFbRpqESO1LLhxzR8QSNpiK03/Xnau
         8pUDPMY3qqdjfbGS8CnEnkF2SRdFUp2WxSfDkibYcrTr8x/WWM9k/DgFbWOSo0wlUj8D
         7SmEHR5rNVYdayL2AitmKbBqpdWKCTf6Vt8NjEX7xsC5qWDKKIXxHy3q1Ix6aT3LKFgB
         9XuQ==
X-Gm-Message-State: AOAM533wl1t+BqFX5UNaPODGNqKnxiCL/3Ww/Y9PZbpoCgMZliJYwdQd
        aXqIZV2h1spYPGT3bBW41r8=
X-Google-Smtp-Source: ABdhPJxU1b39BmtyULR4nUzWOO7qXgwr6dyOeBIQkKwguRMN0UpGPhk7X2DZjHQ0xPbd8yKKqH9+Vw==
X-Received: by 2002:aa7:c9cb:: with SMTP id i11mr4453423edt.100.1604701159957;
        Fri, 06 Nov 2020 14:19:19 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:fd3d:a98f:58bf:862e])
        by smtp.gmail.com with ESMTPSA id o20sm1824943eja.34.2020.11.06.14.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 14:19:18 -0800 (PST)
Date:   Fri, 6 Nov 2020 23:19:17 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: "warning: context imbalance" in kernel/bpf/hashtab.c
Message-ID: <20201106221917.n3is2fnud7jqa3x5@ltop.local>
References: <4126C08B-532F-4B6A-A3C2-9F7928EA2806@fb.com>
 <20201105211342.6mglug2a74bi5hvd@ltop.local>
 <CAHk-=wjgKzHvGYbHpJ6DJj6W73b54QqNK0LSjY-jYdU3kxhWMQ@mail.gmail.com>
 <20201105215023.wvekadtkdwgz7yim@ltop.local>
 <B8E674A7-1B84-4E64-A688-EF226A947AB3@fb.com>
 <CAHk-=wiTAFVdMCF=oADAOFwVWff2Rs1qqD1Wqj8rF0zTgbLYag@mail.gmail.com>
 <246A7DB8-75D8-46B6-8AE4-BDACD5714EC2@fb.com>
 <CAHk-=wjbOjD_3HBas10sb9VKyNGvDrs9vXGj=rVc5TdPSPMDMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjbOjD_3HBas10sb9VKyNGvDrs9vXGj=rVc5TdPSPMDMA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Nov 06, 2020 at 11:44:00AM -0800, Linus Torvalds wrote:
> On Fri, Nov 6, 2020 at 11:05 AM Song Liu <songliubraving@fb.com> wrote:
>  (a) the conditional following for the return value:
> 
>         select.32   %r4 <- %arg1, $0xffffffff, $0
>         select.32   %r6 <- %r4, $0xffffffff, $0
> 
> Note how it doesn't trigger CSE, because it's not the same instruction
> (%arg1 vs %r4), but sparse *could* see that a select that depends on a
> previous select that has constant arguments can be simplified to be
> conditional on the original select value instead, so it *could* be
> CSE'd into one single thing.
> 
> So the second "select" could be optimized away by realizing that it
> really gets the same value as the first one. That *should* be trivial
> to do in sparse by just having a simple pattern for select
> simplification.
> 
> And once that optimization is in place, the second optimization would be

I think I may even have already this in an half-polished form.
 
>  (b) trivial branch following: "conditional branch to conditional
> branch with the same condition".
> 
> ie we'd have the pattern of
> 
>         cbr         %arg1, .L5, .L4
>         ...
>     .L5:
>         cbr         %arg1, .L6, .L2
> 
> and now a trivial branch following optimization would see "oh, the
> first target of the first cbr is to another cbr that has the same
> condition, so we can rewrite the first cbr as
> 
>         cbr         %arg1, .L6, .L4
> 
> instead.

This, should already be done (by yourself, many years ago).

> And once you've done that trivial branch following, the .L5 target has
> only that fallthrough source from .L4, and the code becomes
> 
>     cmp:
>     .L0:
>         <entry-point>
>         select.32   %r4 <- %arg1, $0xffffffff, $0
>         cbr         %arg1, .L6, .L4
> 
>     .L4:
>         call        spin_lock
>         cbr         %arg1, .L6, .L2
> 
>     .L2:
>         call        spin_unlock
>         br          .L6
> 
>     .L6:
>         ret.32      %r4
> 
> which still isn't good enough, because it still has that conditional
> branch that is now pointless.
> 
> Removing the second conditional branch entirely would require having a
> "look, it's now dominated by a previous conditional branch on the same
> condition, so it can't trigger".
> 
> That's the only remaining optimization that isn't purely local.

Yes.

> Dominance analysis is always painful. sparse does do it (for memory
> accesses), but it's a *lot* more complex than just some local
> single-instruction pattern that looks at the source or the target of
> that single instruction.

This shouldn't be a big problem since we already have the dominance
tree (but it's not yet updated when there is changes n the CFG).
OTOH, the memops simplification creates invalid phi-nodes which
indirectly creates all sort of problems. I've several fixes for this
but none I'm really happy with.

> Maybe this gives Luc some ideas, though.
> 
> Or maybe Luc will point out that even my "simple" optimizations are
> slightly more painful than I think they are for some reason that I
> haven't looked at.

No no, it's certainly more than a few hours of work but it's also not
an immense task. Of course, the devil is always in the details.

There is also the option of explicitly handling conditional contexts.
I did maybe 6 months ago, in 2 or 3 different ways. It worked well,
and would probably solve the problem here but:
* it needs new annotations
* it's OK when the condition is simple ( = 0 or != 0), it could be
  adapted for some others (like, for example, >= 0) but more general
  condition would become hard to handle (the annotations needs to know
  about the condition).
* the benefits were disappointing because, in most cases I saw, it
  displaced the problem to somewhere else where a 'real' optimization
  was needed. This is why I stopped to look at it.

But so, yes, what you propose here makes a lot of sense and would be
very valuable. I'll take a look at it soon (but my stack is already so
full that I'm quite reluctant to begin anything new (I currently have
208 topic branches with 120 of them being valid, interesting seriess
waiting some polishing, validation and patch description :( ).

-- Luc

