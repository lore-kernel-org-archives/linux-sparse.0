Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA9FC433EF
	for <linux-sparse@archiver.kernel.org>; Wed, 15 Sep 2021 19:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15D06105A
	for <linux-sparse@archiver.kernel.org>; Wed, 15 Sep 2021 19:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhIOTwB (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 15 Sep 2021 15:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhIOTwB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Sep 2021 15:52:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B992AC061574
        for <linux-sparse@vger.kernel.org>; Wed, 15 Sep 2021 12:50:41 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p29so8802124lfa.11
        for <linux-sparse@vger.kernel.org>; Wed, 15 Sep 2021 12:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nI3oXjB5y7fgBDUAfkrt5Qjrdw7kij1HF6V7usZScd0=;
        b=dDkQ2iIzDzvrHagUv0HQt/yEqNuVlVfROtNamlO02CizTu2FICtXWd210Bes/CwlqB
         vjF/fdxzFxIz7v0M5Mc4QD77K9x8ec18TENbGfCqGbSG3HiLnbhqoA4lCtQEqvSsm3+w
         v6hYS+kH7FyOqPuDkRIGswKh56YqlIWBTmiYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nI3oXjB5y7fgBDUAfkrt5Qjrdw7kij1HF6V7usZScd0=;
        b=XxH8fVtlCTuJp83I5FratgMFbUQ87djbxHBYKq4DNFmsNABinrqit871H11G/J12TN
         lnMGXDPGiM0cMB+9MLCbHb4H+an9XhDgHfQcBcDuXYUFnNYaNNYtxbpBSksrQpFaNvja
         V/jBfwwE2Ys4JjZgm5R7+GoBfNtIKht/XiAXXdLBju+d61aQFVH8PkItZ75YH7sfdCGI
         WPZRMeHVCcE7K1KLwqTOgZCtZTAHvwqBhzZpbxdBAQDd6OHXFg0UuGt6XmiGDQKDecPd
         pmlJALNSjo5uJ/G0RNGm8Fc6V42SOJM2rYILvxvOacrAeNQ66nZaU5Jk96/JU7VgKuvU
         k5rg==
X-Gm-Message-State: AOAM530Oqna/1ZtD2k8qgwxqLEa2+8g5nzynEMM/2sy3S3qGyKHt9W86
        ZF0+EFDEt+Jv0OlF8KUH7dp/1+dANejVmP6UbDw=
X-Google-Smtp-Source: ABdhPJy5hWaWvcKphiIYjwGcIdR8FmEEHYDiTMe3uGtLTEpj8e8TlkIv8VZh/I7pplEhR5fqkrrXQw==
X-Received: by 2002:a05:6512:3f8c:: with SMTP id x12mr1258692lfa.320.1631735439764;
        Wed, 15 Sep 2021 12:50:39 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id a18sm95463ljd.4.2021.09.15.12.50.38
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 12:50:38 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id i25so8891847lfg.6
        for <linux-sparse@vger.kernel.org>; Wed, 15 Sep 2021 12:50:38 -0700 (PDT)
X-Received: by 2002:a05:6512:3991:: with SMTP id j17mr1268421lfu.280.1631735438424;
 Wed, 15 Sep 2021 12:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210915035227.630204-1-linux@roeck-us.net> <CAHk-=wjXr+NnNPTorhaW81eAbdF90foVo-5pQqRmXZi-ZGaX6Q@mail.gmail.com>
 <47fcc9cc-7d2e-bc79-122b-8eccfe00d8f3@roeck-us.net> <CAHk-=wgdEHPm6vGcJ_Zr-Q_p=Muv1Oby5H2+6QyPGxiZ7_Wv+w@mail.gmail.com>
In-Reply-To: <CAHk-=wgdEHPm6vGcJ_Zr-Q_p=Muv1Oby5H2+6QyPGxiZ7_Wv+w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Sep 2021 12:50:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSkMh9mc7+OSBZZvpoEEJmS6qY7kX3qixEXTLKGc=wgw@mail.gmail.com>
Message-ID: <CAHk-=whSkMh9mc7+OSBZZvpoEEJmS6qY7kX3qixEXTLKGc=wgw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
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

On Wed, Sep 15, 2021 at 12:47 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> What other notable issues end up being still live? I sent out that one
> patch for sparc, but didn't get any response to it. I'm inclined to
> just apply it (the 'struct mdesc_hdr' pointer misuse one).

Oh, I forgot about the qnx4 one. That happens on sparc, possibly
others, but not on x86-64.

I'll go look at that patch too.

          Linus
