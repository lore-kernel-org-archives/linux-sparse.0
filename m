Return-Path: <SRS0=rhKz=BZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47673C433E1
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2083922BED
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktKF9oRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgHOV6j (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbgHOVv5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:57 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39797C08C5EC
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 02:59:53 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh1so5234769plb.12
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pv0VLHMPN+ikEwMH3XPkeVHjwDiux12GmnXGe2SsEvI=;
        b=ktKF9oRQbBzwyK3ExSpzoYNy8KOIMD2EY//Fg0GAs1D3cgZ/FfGxpN5Eq6xAO1Mi3W
         xeuUphcqIoCWeaLHIWQtb4MA2BYReV068F1ITY9HABjLrPMEIadhwd88GPp7xawzFLkD
         LQ5GnUpngsEXJzieO1vZBc4HvXssBgRxOTx7fm/553yrdWBPhacab+LLWBK01d8VaBlA
         FRBRGncS+fNT0bFrPclhEE1jVagYjqSNWOaG2EQG5omBHuzYI3zzM1OzUsQjgsIlc8zx
         YNEuSL4urxN/9jNnNrFdhPGN5HkeB5K9/JpM2fzAVJ0OPOpd3z4K9um/QTkqkMXxe4+d
         zLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pv0VLHMPN+ikEwMH3XPkeVHjwDiux12GmnXGe2SsEvI=;
        b=FOaEm4Bh7RQG3fo8mrWmt1+JIZtUmhwiZJeJCUVgVaxfHr6jRiI13cTJHoCgXxu8yo
         rV3DDu2l7zaVPFjKh8Pe4QYCioukAduBOt6qNLSQ/IhhzPmnROTndJb1QzsUAnZFkZmD
         7erHbKlmEhE1/iIuBfni7O3B3LN9RqXMoY9nDNPXKi/PlPEdW4gLdTsF/U9KphysD4eI
         aTedRSTUifBSgVCx9O2a1dhdQpREvqQXnsqDt2kiU3s5QdhtLxZh7b9mIh/d48EQnveD
         mo6dIBXhJNYqVBP+CfdqiDjd+Dbob2fSN08qSBKXZimXaOjHJu1cUhV66KC6k2OCo8Wr
         TAGg==
X-Gm-Message-State: AOAM532WNocd1TjzO2FvKdq8b1MNh88AHVFz9HDHByKPHdbIxWSmbCWP
        ZgMnJSljmcU4aRuNBybarm4=
X-Google-Smtp-Source: ABdhPJyZrpKkQhDSIxd1L4lMZzbQmyLa719lAcXj0fD6s2ta3KTZSaVBI2QgvZVkHmCy3HFToIcsmQ==
X-Received: by 2002:a17:90a:32a3:: with SMTP id l32mr5295295pjb.5.1597485592449;
        Sat, 15 Aug 2020 02:59:52 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id g129sm11483658pfb.33.2020.08.15.02.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 02:59:51 -0700 (PDT)
Date:   Sat, 15 Aug 2020 18:59:49 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix shifts-assigns and avoid warns on deadcode
Message-ID: <20200815095949.GV80756@lianli.shorne-pla.net>
References: <20200806193003.10144-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806193003.10144-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Aug 06, 2020 at 09:29:59PM +0200, Luc Van Oostenryck wrote:
> Sparse warns shifts by a negative or oversized amount but
> it does this even on code that will not be executed. It's
> annoying because such warnings are given for generic macros.
> 
> The strategy for these warnings is changed in patch 4:
> they are delayed until after the elimination of deadcode.
> This uncovered a bug in the type evaluation and the linearization
> of shift-assigns which is now solved in patch 2 & 3.
> 
> Thanks to Stafford Horne to bring this back to my attention.
> 
> This series is available for testing & review at:
>   git://git.kernel.org/pub/scm/devel/sparse/sparse.git bad-shift-equal

Thanks!

I see you merged this already, I tested it and see no regressions on my kernel
build, and confirm the xchg issues are fixed.

Sorry, I reviewed this early but didn't respond until now as I had time to test.

I just had one question on 4/4.

-Stafford

> Luc Van Oostenryck (4):
>   shift-assign: add more testcases for bogus linearization
>   shift-assign: fix linearization of shift-assign
>   shift-assign: restrict shift count to unsigned int
>   bad-shift: wait dead code elimination to warn about bad shifts
> 
>  evaluate.c                         |  11 +-
>  expand.c                           |  18 --
>  linearize.c                        |  44 ++++
>  simplify.c                         |  20 +-
>  validation/expand/bad-shift.c      |   8 +-
>  validation/linear/bug-assign-op0.c |   1 -
>  validation/linear/shift-assign1.c  | 319 +++++++++++++++++++++++++++++
>  validation/linear/shift-assign2.c  |  53 +++++
>  validation/optim/shift-big.c       |  12 +-
>  validation/shift-negative.c        |   4 +-
>  validation/shift-undef-long.c      |   7 +-
>  validation/shift-undef.c           |  52 ++---
>  12 files changed, 462 insertions(+), 87 deletions(-)
>  create mode 100644 validation/linear/shift-assign1.c
>  create mode 100644 validation/linear/shift-assign2.c
> 
> 
> base-commit: 4c6cbe557c48205f9b3d2aae4c166cd66446b240
> -- 
> 2.28.0
> 
