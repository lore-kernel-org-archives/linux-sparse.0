Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B511C433F5
	for <linux-sparse@archiver.kernel.org>; Sun, 12 Sep 2021 19:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3133C60FDA
	for <linux-sparse@archiver.kernel.org>; Sun, 12 Sep 2021 19:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbhILTOp (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 12 Sep 2021 15:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbhILTOp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Sep 2021 15:14:45 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2761C061574
        for <linux-sparse@vger.kernel.org>; Sun, 12 Sep 2021 12:13:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c8so16281540lfi.3
        for <linux-sparse@vger.kernel.org>; Sun, 12 Sep 2021 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzZRty5syTefvslqvSNH1KyI4p4ePIHehKrpq3jNHak=;
        b=UhV7ZB03lfxtT+Ye8FzC9W6hmCQoAxoCGQimJcLY7prrx8mbKe9DIiT4SGaXesQFeB
         bwrVZJdZaPGgx4eSKLVt3nOkqcznQcyPpP9BRmCWBP8k038tMJltDQ1VrUpAU3aNMwNA
         gTOxiP2LUi8KOIoIT19q3qZx861ljKejcehZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzZRty5syTefvslqvSNH1KyI4p4ePIHehKrpq3jNHak=;
        b=TXnGbdt5LZ5fC9iAe2DnJNKPM3nvqFyGYT334hMu+7VMi/9L6Viq63UYHY1xiE6vXb
         PM+GuIJhUwXloYe/LULPH3Oq+HbKCpJCIjrS7XM3MhsoiC2F9N+e0AUu2+yX43rlUpsV
         Ad6OWUJcPTxSUjczQQ8bFl5bxxaFHOCANTN3veoUygGtD0Vba9Ibzc/FeLS9csWnbull
         Ok9/KwX+sMKKkLFHx75QnXyVVEb5Gs2o3lL0+3uEQPME9xvEc7Ln9/SX8eZtPrtjieQC
         67cAJ+gPtgFkUaAWgDEXq3dX1ctIXc0zCCc3qS0tWKC7cVzEAWYB+UzZes5/N2yqfyqu
         uMNQ==
X-Gm-Message-State: AOAM5312R/gOjCtI3NHAq/2CsgHLnBLcibNEa8PvWW7VU9Lj6TrNl7Fa
        SGtdEtU1vQW/SQlFU8hCK8lm/AYAjvEgybP/VHk=
X-Google-Smtp-Source: ABdhPJyhPHcj57nOp8deHeq7F00rItXNxvKtoxZSUpolyH+Qt1U1ZjWiy1dHC7zf8eKPyZ9wZG4wbw==
X-Received: by 2002:a05:6512:22d1:: with SMTP id g17mr6069335lfu.637.1631474008982;
        Sun, 12 Sep 2021 12:13:28 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id a10sm594887lfj.49.2021.09.12.12.13.27
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 12:13:27 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id k4so16247655lfj.7
        for <linux-sparse@vger.kernel.org>; Sun, 12 Sep 2021 12:13:27 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr6351605lfv.655.1631474006987;
 Sun, 12 Sep 2021 12:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210912160149.2227137-1-linux@roeck-us.net> <20210912160149.2227137-5-linux@roeck-us.net>
In-Reply-To: <20210912160149.2227137-5-linux@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Sep 2021 12:13:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1=8shingNuo1CtfJ7eDByDsmwsz750Nbxq=7q0Gs+zg@mail.gmail.com>
Message-ID: <CAHk-=wi1=8shingNuo1CtfJ7eDByDsmwsz750Nbxq=7q0Gs+zg@mail.gmail.com>
Subject: Re: [PATCH 4/4] alpha: Use absolute_pointer for strcmp on fixed
 memory location
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Sep 12, 2021 at 9:02 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> -       if (strcmp(COMMAND_LINE, "INSTALL") == 0) {
> +       if (strcmp(absolute_pointer(COMMAND_LINE), "INSTALL") == 0) {

Again, this feels very much like treating the symptoms, not actually
fixing the real issue.

It's COMMAND_LINE itself that should have been fixed up, not that one use of it.

Because the only reason you didn't get a warning from later uses is
that 'strcmp()' is doing compiler-specific magic. You're just delaying
the inevitable warnings about the other uses of that thing.

            Linus
