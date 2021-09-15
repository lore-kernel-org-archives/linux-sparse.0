Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B07C433EF
	for <linux-sparse@archiver.kernel.org>; Wed, 15 Sep 2021 21:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E8C61108
	for <linux-sparse@archiver.kernel.org>; Wed, 15 Sep 2021 21:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhIOVVT (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 15 Sep 2021 17:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhIOVVR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Sep 2021 17:21:17 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C01C061574
        for <linux-sparse@vger.kernel.org>; Wed, 15 Sep 2021 14:19:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b18so8580545lfb.1
        for <linux-sparse@vger.kernel.org>; Wed, 15 Sep 2021 14:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3BMwFy0chXS7YMqLdf36Rg6yUUlp6nBZba3YILPvA0=;
        b=WsNqD0Opa3lPgwayobITOeBYzY09REebVD84cTigbwiVy8RERoiSXisEu8y+Nk+bfI
         rwr6ffFTpZComKTqahfaOR7CdEVqoy7csTG2SKHpEYZNr9AVK2EZciaTVWrgEw6jv2ed
         w803wR6rUWc2E3pW5t7Ag7qcjFS9X02JepaeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3BMwFy0chXS7YMqLdf36Rg6yUUlp6nBZba3YILPvA0=;
        b=7PKNIsNi2Y7V/ZBgKGpIVpX0JWjtrXnho252QlnMAAGEX0rq7UeMPBzsR7MbfepRnt
         kgFT0fGlajXqh53VUbqvgu7aCn0hsjLbNVgdy7icH6TxjfgNoVo9SYqSoBPfOmLABReI
         Htqc3caW6XBD/+iJkR7/zQoDsQhc3/+KCm6QAS69zanX3UUw0QeoAvLuLMDJVhDiBY31
         w0D053mORWDnZNTZYLoClsiyoWWHAr54sFGjlUn1PWSQ9h1dqgGgQM9dEKW29BpIDeMJ
         pxisunWIyklFjm9l99DCbVlFKMz/ZA0l1ycAZ+sCQCcwkLPzKLuWpUQdo5hTBkcV5ASd
         PEDg==
X-Gm-Message-State: AOAM531xrqHbdnLNxACY3lggM4utoT8JJFBuQmHG8TUFiqvDz+tvidkK
        1tI4iJIhmEQ1FQRmZpZ1xbXN6Zq9KUiYtdz3
X-Google-Smtp-Source: ABdhPJznIc7xwG3NE/uaB2BrxXl+x3DkKTkC2IMY+COXNQyM/3M2BtW/RRZ+qimZ6DYI4HAndZeajQ==
X-Received: by 2002:a05:6512:e98:: with SMTP id bi24mr1382151lfb.497.1631740796497;
        Wed, 15 Sep 2021 14:19:56 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id p1sm115095ljn.130.2021.09.15.14.19.56
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 14:19:56 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id c8so9843691lfi.3
        for <linux-sparse@vger.kernel.org>; Wed, 15 Sep 2021 14:19:56 -0700 (PDT)
X-Received: by 2002:a2e:bc1e:: with SMTP id b30mr1593765ljf.191.1631740795868;
 Wed, 15 Sep 2021 14:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210915035227.630204-1-linux@roeck-us.net> <CAHk-=wjXr+NnNPTorhaW81eAbdF90foVo-5pQqRmXZi-ZGaX6Q@mail.gmail.com>
 <47fcc9cc-7d2e-bc79-122b-8eccfe00d8f3@roeck-us.net> <CAHk-=wgdEHPm6vGcJ_Zr-Q_p=Muv1Oby5H2+6QyPGxiZ7_Wv+w@mail.gmail.com>
 <CAHk-=whSkMh9mc7+OSBZZvpoEEJmS6qY7kX3qixEXTLKGc=wgw@mail.gmail.com>
In-Reply-To: <CAHk-=whSkMh9mc7+OSBZZvpoEEJmS6qY7kX3qixEXTLKGc=wgw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Sep 2021 14:19:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjynK7SSgTOvW7tfpFZZ0pzo67BsOsqtVHYtvju8F_bng@mail.gmail.com>
Message-ID: <CAHk-=wjynK7SSgTOvW7tfpFZZ0pzo67BsOsqtVHYtvju8F_bng@mail.gmail.com>
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

On Wed, Sep 15, 2021 at 12:50 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Sep 15, 2021 at 12:47 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > What other notable issues end up being still live? I sent out that one
> > patch for sparc, but didn't get any response to it. I'm inclined to
> > just apply it (the 'struct mdesc_hdr' pointer misuse one).
>
> Oh, I forgot about the qnx4 one. That happens on sparc, possibly
> others, but not on x86-64.
>
> I'll go look at that patch too.

Ok, I didn't love any of the patches I saw for the qnx4 problem, so I
silenced that warning with a new patch of my own. Like the sparc64
case, the fix is to describe more extensively to the compiler what the
code is actually doing.

I think it ended up making it clearer what is going on to humans too.
Although that may be the old "peeing in the snow" effect - it looks
more understandable to me only because I spent so much time trying to
understand what it does, and then wrote the fix based on that possibly
flawed understanding. So of course I find it more understandable.

Looking at the qnx4 code-base history, I don't think it has gotten any
actual development outside of cleanups in the git history timeframe,
which makes me suspect nobody uses this code.

But hey, maybe it just works so well for the very specialized user base ...

Anyway, I pushed it out. I have a clean "allmodconfig" build on all
the architectures I tested, but I didn't test _that_ many.  sparc64,
arm64, powerpc64.

Lots of dts warnings (which aren't fatal), though. Particularly for
the powerpc64 build.

             Linus
