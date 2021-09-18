Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5867C433F5
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Sep 2021 20:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC947610E9
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Sep 2021 20:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhIRUry (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 18 Sep 2021 16:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhIRUrx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Sep 2021 16:47:53 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739C4C061574
        for <linux-sparse@vger.kernel.org>; Sat, 18 Sep 2021 13:46:29 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y28so47524055lfb.0
        for <linux-sparse@vger.kernel.org>; Sat, 18 Sep 2021 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgyQSOoQGXbqZDY5vmTdmtdWclji1aa8k4Dg+pV0f0o=;
        b=SEpYwuptd5hG3QJm95kYyoOdykEPWmWM41H04iYKD9x+gej2hvZLmI9MuQSd8s9QNq
         BFtt8Khl1a0U7BIzOb2mMeUeYORXvw3f1yoKo69QHfJASnbgDxK63qWoaCvmswBFSfMk
         A/FZp+Rl5zIq56YhAZEa2tHT6K7SetPgVBSjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgyQSOoQGXbqZDY5vmTdmtdWclji1aa8k4Dg+pV0f0o=;
        b=tKE8kIoKT349QIKw5jacFsMuhoGph4uPCEg8d4duUot4aeHjBhXqRaEnhJosHcTgq7
         gguf4+m1oO20CKUyd29a5hqzLKVxbmKlRETsm1VJI6Ddry+eNMKA+G8xNYzm700L9hGn
         JxEkHJJx2F8SIAAaxxc2KLrbTF8IQtNc34lrtRMjzPjx0TL8dciQ3ITkr1TjqxQIaXwT
         cP83r32RG52pXmzeaHBaPiE/XI0n56mto2lYeSj+VnA6CZC58o7+w0hvPvhYoZ3b4ixD
         0DUCqvYJGHUq+1mwCE1/XAHbaU3wcbUCtyg/Nh2toh/p3O0pFq7rmbIlT14qWHHuYVyw
         BnAg==
X-Gm-Message-State: AOAM533owtKYFROkm/wQ1MPzyDpHOf3WtjOFoQMTEXgUBnB/qODZSfcf
        tsf1XdqrvEGPAiDImmT33ZwB8XLFdJjnpHQxIhM=
X-Google-Smtp-Source: ABdhPJyEEpi+3fYWE2NjGEEjhEy9NGNQFNWqkec5hDSuXJtOzaf+evfZiUT0y9ULxQrAu3ySfAVL3g==
X-Received: by 2002:a2e:984e:: with SMTP id e14mr15568561ljj.134.1631997987582;
        Sat, 18 Sep 2021 13:46:27 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id c8sm850395lfb.229.2021.09.18.13.46.26
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 13:46:26 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id g1so48933618lfj.12
        for <linux-sparse@vger.kernel.org>; Sat, 18 Sep 2021 13:46:26 -0700 (PDT)
X-Received: by 2002:a05:6512:2611:: with SMTP id bt17mr13595935lfb.141.1631997986070;
 Sat, 18 Sep 2021 13:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whY5mLggPSr2U00mqgUbRJYnYSxtNZm4FnEtQrHftYr8Q@mail.gmail.com>
 <202109182026.18IKQLng003683@valdese.nms.ulrich-teichert.org>
In-Reply-To: <202109182026.18IKQLng003683@valdese.nms.ulrich-teichert.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Sep 2021 13:46:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZukwHDpm6PUP=cFTi8wWQs6Z5Np7xv7SRphNqvm0FPw@mail.gmail.com>
Message-ID: <CAHk-=wjZukwHDpm6PUP=cFTi8wWQs6Z5Np7xv7SRphNqvm0FPw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
To:     Ulrich Teichert <krypton@ulrich-teichert.org>
Cc:     Michael Cree <mcree@orcon.net.nz>,
        Guenter Roeck <linux@roeck-us.net>,
        Richard Henderson <rth@twiddle.net>,
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

On Sat, Sep 18, 2021 at 1:26 PM Ulrich Teichert
<krypton@ulrich-teichert.org> wrote:
>
> >
> > (I forget which alpha I had. For some reason I want to think I had an
> > EISA machine and probably Jensen. Maybe upgraded to a 164 later?)
>
> Well, as this was way back in 1995, it was perhaps a Multia? Also
> named UDB, a small "booksize" model.

No, that came later. I had one of the very original ones.

I'm pretty sure it was that Jensen platform, but I'm too lazy to go
back and look.

> > Can you send me your Jensen config?
>
> Sure, attached here. I don't know if it helps - I can't tell you why I
> used 4.18-rc5 for it, that was in 2018... Oh man, I am spending too much
> time at work...

I ended up hacking something up which was enough to show the build
problems, and then some.

But your config shows _other_ errors with the IO functions, so I guess
I'll need to look at that one too.

There's clearly a reason that Jensen was marked BROKEN in the Kconfig,
the whole situation with the IO accessor functions on that platform is
a disaster.

              Linus
