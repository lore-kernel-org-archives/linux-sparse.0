Return-Path: <SRS0=Zl/b=D6=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA842C388F9
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94BCD2192A
	for <linux-sparse@archiver.kernel.org>; Fri, 23 Oct 2020 16:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603469624;
	bh=Sk5EZMxLoUFukiJMkpJjrPQm572SWNAzF8uf2EE+zMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aUYOh8Gb7dQlJ672AlEQdPPsWToKnwZ6X9oMnRedLz+MSVxU2RyfnSrJ/323YN5Jd
	 M20QQ/MZTZq9fidsfRdyQHAtc3DVnPPnJVl/3wIAC4fGWiXvSDdMUTQ7FfkiIMpDc/
	 30iDYVDl/0dQk7ayiICJD+smRxVXjD1A8n4dZDIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373858AbgJWQNo (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373717AbgJWQNo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 23 Oct 2020 12:13:44 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F3AC0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:13:42 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h6so2749628lfj.3
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWk1mSHer3Jh2cTMXsh5KEP4O7bKVhS2FNdPvjM5/8g=;
        b=JFwlrzbm0GG+ZuIXG9xrE7Hd2H5vUukHiYKTaq06X6o9o4GOPeNPH/LuGoT6sAdxVq
         zvX1QEGbtkFKjT+Wvn2AsZZlPBQ5VJF+3yglSV/Z1d6PeYiPOMzQboJYkLiJnKFl2KDb
         meP6Rhg09e3pERek8Xb51h9aCx+ZeE6AdTBMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWk1mSHer3Jh2cTMXsh5KEP4O7bKVhS2FNdPvjM5/8g=;
        b=kGuvjksnQWJ9QhJIsoIUe4dg4HEoYZPYAz9YgRD6/mFKOfLDrBbDL79v8lRMEC5rCY
         K+1PPL5KwBe3cvbn7iwnJysTX2qX8bZS43htbRQAtBTUraiJcHnHDUFeGqqmIURayB5d
         f4ahNJNSrJ2P+1tyXWBi8UjNdnkE/qiETkLkXuluwhV5MPEaZST03AY+9Mv5TEof9IFD
         XdHRK91RlHjYDDwo22wO25yRSWwvtRSb82XyEpCCQY0hsPlwzA0FSQuY3WSX7O002qKo
         oF8EQwqQGjxGarCCCsmW5WVAUunuW+R4KywmWfzttwigVwtqUKalyG4p3nAb3gaXlXgQ
         zvKw==
X-Gm-Message-State: AOAM532IiMVIZq7TSaAte9sn/QnuL0MrW8QUgtjSZfEQTXjqPBM5nLfq
        72Re1mPzDxIA/mksckTmgNddTKrtg2fFEw==
X-Google-Smtp-Source: ABdhPJytDuGgg6+6Rh2UrsVv4OzYYEhbiF9QJtjV2+eqS/jCwBgZwydovWFpk0BNwRTA9W7Pjsu0gQ==
X-Received: by 2002:ac2:550e:: with SMTP id j14mr997283lfk.88.1603469620530;
        Fri, 23 Oct 2020 09:13:40 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id p26sm177769lfc.75.2020.10.23.09.13.39
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 09:13:39 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 184so2746740lfd.6
        for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2020 09:13:39 -0700 (PDT)
X-Received: by 2002:a19:cbcb:: with SMTP id b194mr1099376lfg.133.1603469619226;
 Fri, 23 Oct 2020 09:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201023155832.57237-1-luc.vanoostenryck@gmail.com> <20201023155832.57237-2-luc.vanoostenryck@gmail.com>
In-Reply-To: <20201023155832.57237-2-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Oct 2020 09:13:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjc7dZCCKF4xOar1HKtNRtnnwqCJTZuJM-YPyyT=wZryw@mail.gmail.com>
Message-ID: <CAHk-=wjc7dZCCKF4xOar1HKtNRtnnwqCJTZuJM-YPyyT=wZryw@mail.gmail.com>
Subject: Re: [PATCH 1/2] simplify unsigned compares against 0
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Oct 23, 2020 at 8:58 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Some unsigned compares against 0 are always true or always false
> (x < 0 or x >= 0). Simplify them.

Fair enough, but if you're simplifying compares, one of the more
important simplifications is to make the compare unsigned in the first
place.

IOW, simplifying

    (signed >= 0 && signed < X)

into

    (unsigned < X)

if you can show that X is positive (most trivially a constant). Example:

    int cmp(int i) { return i >= 0 && i < 4; }

which currently generates

    setge.1     %r3 <- %arg1, $0
    setlt.1     %r6 <- %arg1, $4
    and.1       %r7 <- %r3, %r6
    zext.32     %r8 <- (1) %r7
    ret.32      %r8

which is obviously not great.

Another comparison simplification often worth doing is to do cast
simplification, ie

   ((cast) X cmpop Y)

where 'Y' already fits in the original type of 'X', and the cast is
unnecessary. Test-case:

    int cmp(int i) { return i < sizeof(i); }

and notice how sparse generates

    sext.64     %r2 <- (32) %arg1
    setb.32     %r3 <- %r2, $4
    ret.32      %r3

with that entirely unnecessary sign extension that doesn't really help..

The related simplification is then

    (signed >= 0 && unsigned < X)

and just removing the "signed > 0" case. These happen when you have
code that checks for sizes:

    int cmp(int i) { return i >= 0 && i < sizeof(i); }

where that "i < sizeof(i)" ended up being not just extended to 64-bit,
but an unsigned compare due to the 'sizeof()' being unsigned.

              Linus
