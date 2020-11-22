Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECA1C5519F
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 19:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A998E2075A
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 19:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQl1ESRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgKVT5u (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 Nov 2020 14:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbgKVT5u (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 Nov 2020 14:57:50 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD702C0613CF
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 11:57:49 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 10so16026777wml.2
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 11:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=66upAZJbNgmpQybBrVQl3mXrezWP/xs5FBnnqnMFYIc=;
        b=JQl1ESRUtNon7tVS7Lt8SmAxCp7cEFRTCqdh0kzD7cfcOyZ3Z0bYSlN2uwb2yHHDx1
         1A26gKRkQRLzJL1ZNJhPc+C5jZGAAQMA+Zd5Oru3jq+DVi7bJT8lGgjg6Ff2DibPS2bS
         zLA7lG9ErMuYa7boxcyZCS6lfndSnomp3WEG8mqK1FgLoNnC7TtKofxBWrqHya2l7AyX
         9rTfGtyEniXaLyx84wnq3rwvkG8LkDwIYQf1nrjvzua+ZGmmutaE5gogi9LGAXzf1Afl
         N1SHyxbf8L191x/R4GAc5tYgBA0wfVh5AYtoeAbw6o+IBOnYfLsv8cRuer/T6Rq+6RZ/
         GuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=66upAZJbNgmpQybBrVQl3mXrezWP/xs5FBnnqnMFYIc=;
        b=FuiKjG4NND4SLDzAoge9PJdEgaRafZsuwHuCvkTd3YQdsTvzoR3UYa/g2IpaAGk0cr
         aZoSbTrqWFACIsdn5RHFutM3vdOnpSDlmn6zzBO+MXs95MiqS97Brrjixnl3gClB9Z29
         rN2wGeDgvKYO7KKBJwm4+dW0nBuR+QOGKYXn8C43iB3jVx0Ge5o8ZpCyyNxuIyLAACig
         kByNfDOevyQv0q4YMq1Q7qnA4KHhKUovN8rYARZaOeW0pRqs+GW72yw91pqCmAYfC7Cc
         e9NB+u/KXpAhSfv7V8Mda04c8gK8oWsFUbcNiHI48LP0NzVxT+OOr3G1qc/hyg2DvB92
         xiKw==
X-Gm-Message-State: AOAM532p/IVbM4c66470bqpkHBVb4jFx3JO+qj58CQSnUZpxvV3SjFBF
        PvFy5CUI+7wmp6fy8s51JMoZqE6bf4c=
X-Google-Smtp-Source: ABdhPJxuys6FxDQRROt7ZpyWfH2F0PMP1mFGrgJu87JIEpk+fYWD+5qA1nQxE61/78y4pWMRsvj7ow==
X-Received: by 2002:a1c:7f48:: with SMTP id a69mr20895214wmd.21.1606075068410;
        Sun, 22 Nov 2020 11:57:48 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:b0d0:6cd2:d2ec:fc3c])
        by smtp.gmail.com with ESMTPSA id w186sm12088157wmb.26.2020.11.22.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 11:57:47 -0800 (PST)
Date:   Sun, 22 Nov 2020 20:57:46 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 1/7] not: add testcases for canonicalization &
 simplification of negations
Message-ID: <20201122195746.uq44lstsy2pissxi@ltop.local>
References: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
 <20201122152731.10994-2-luc.vanoostenryck@gmail.com>
 <CAHk-=wjqwFDEJkGoPtjeTn1cDDpadz_eL_m1w-wk9G9Zmucosg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjqwFDEJkGoPtjeTn1cDDpadz_eL_m1w-wk9G9Zmucosg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Nov 22, 2020 at 11:00:26AM -0800, Linus Torvalds wrote:
> I thought we already canonicalized the pseudo ordering, but clearly not..
> 
> Anyway., looks good to me.
> 
> Btw, if you want to do another simplification, one that I've actually
> seen multiple times in the kernel is this one:
> 
>     if (val1 & BITx)
>        val2 |= BITy;
> 
> and turning it into
> 
>     val2 |= (val1 & BITx) .. shift left or right by (BITx-BITy);

Mmmm, yes, interesting. I'll look at this but ...
 
> and while actually testing the above, I note that sparse seems to have
> problems with even simple if-conversion:
> 
>    #define BIT1 4
>    #define BIT2 8
> 
>    int fn(int x, int y)
>    {
>         if (x & BIT1)
>                 y |= BIT2;
>         return y;
>    }
> 
> linearizes to a nasty mess of actual phi nodes and conditional jumps
> rather than just a 'select' op. Never mind the actual unconditional
> version, of course.
> 
> I didn't check why the if-conversion doesn't happen.

Yes, I know. I'm currently working on it the last days but it's nasty.
Very often, a (good) change blocks another one and I'm often bitten by
the CFG changing and thus invalidating things like dominance relation-
ships.

In the case here with your example, the if-conversion doesn't happen
because the phi-sources is not defined in the top block because of
the OR:
	fn:
		and.32      %r2 <- %arg1, $4
		phisrc.32   %phi2(y) <- %arg2
		cbr         %r2, .L1, .L2
	.L1:
		or.32       %r5 <- %arg2, $8
		phisrc.32   %phi3(y) <- %r5
		br          .L2
	.L2:
		phi.32      %r8(y) <- %phi2(y), %phi3(y)
		ret.32      %r8(y)

It's quite frequent and the obvious solution is to move up such
instructions (and maybe, if the if-conversion succeed, the BBs
will be merged and there won't be a top and bottom block anymore).
I've a very crude patch moving all such instructions up if possible,
it gives some positive results for the context imbalance but nothing
miraculous (IIRC something like 35 warnings less on a total of ~1000).

Another interesting example is something like:
	int foo(int a)
	{
		int e;
		if (a) {
			__context__(1);
			e = 1;
		} else {
			e = 0;
		}
		if (!e)
			return 1;
		__context__(-1);
		return 0;
	}

which produces the following IR:
	foo:
	.L0:
		cbr         %arg1, .L1, .L3
	.L1:
		context     1
		br          .L3
	.L3:
		seteq.32    %r5 <- %arg1, $0
		cbr         %arg1, .L5, .L6
	.L5:
		context     -1
		br          .L6
	.L6:
		ret.32      %r5

Sparse issues a "context imbalance" warnings on it but in fact
everything is OK. Three different things could unblock things:
1) the seteq move up to L0, then L1 can directly jump to L5
2) the seteq move down to L6, then again L1 can jump to L5
3) the context in L1 is changed into a conditional (a new instruction,
   essentially a select but for contexts) it can then be moved up
   to L0, L1 disappears and L3 can be merged with L0.
None of these are really hard but the problem, I'm sure you can guess
it, is that none bring a definitive, clear solution because, very often,
moving things up or down just displaces the problem to somewhere else.
But well, it's life.

-- Luc
