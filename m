Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC49C433F5
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Sep 2021 17:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4DEB6104F
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Sep 2021 17:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbhIRR3S (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 18 Sep 2021 13:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbhIRR3S (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Sep 2021 13:29:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B121C061574
        for <linux-sparse@vger.kernel.org>; Sat, 18 Sep 2021 10:27:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v22so38361555edd.11
        for <linux-sparse@vger.kernel.org>; Sat, 18 Sep 2021 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VJ9K4Ss0fO8sq3w3fi+s1XQy4Iv3mwXh4Uemm8nutng=;
        b=HtuwRZUCtjojC6VdTZELWNXgY00qcbptQey5+LTejhwWo5g8CMmknjSym9G74RH6Ma
         oPcVOCFM0bvoDz0JDWFOmLoHw2mzTecjQrEShzwr3fyltdeg/Yk3k9bXEJyFI8+DILmo
         Zn76QBbRztSInJyQGaDYETcYPmfh81XD1W72o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VJ9K4Ss0fO8sq3w3fi+s1XQy4Iv3mwXh4Uemm8nutng=;
        b=3MGiKiiezCk3ccDFvHKrFXQo1uQ4ht505cYu+EXcmuOxh1N9Bw81QaHEqfXxAwf7Fc
         U1eDlp6RI4Q3YbTwBc2FEncMhdBpuz3+TNbi53bHwJlXA/iFxih+uaZo3K1vq9KOwjXQ
         nEiuEQ4t8GNrOTtUGSYYd6WsFHZ9k/ZZgaItHUq+K1mi9jdl2Va0rioYfg/DKZFQgfWS
         fVBYZ7YzShj1xmysxaFWcrlaD241Z/ANhUpFpkx0Cb8bVPeT/tXFDKAwHS9INWFJLwh1
         GnsxwYDvQSsFEXVjDilt+5ub8s3HbmMNmK1eImS6hpFp5nDZXA6XsNh9DyRWCZ6E+NOQ
         czFA==
X-Gm-Message-State: AOAM531+8IqymgveJOUBf1uTQnA1NIau9Piui+QSVZzYQHUudnatrPg5
        C13kedeIju7nqKWPLz++DKXwMWrds9K8ntsvzX4=
X-Google-Smtp-Source: ABdhPJyCcCgILLwvNr0ToIHe0Lsi1b1LHuyOZlZJbnB5yIy8WR4RP2JfQtrwyj/QDrkoUiixBnYd2w==
X-Received: by 2002:aa7:cd41:: with SMTP id v1mr19610982edw.393.1631986072997;
        Sat, 18 Sep 2021 10:27:52 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id u2sm2542475eda.32.2021.09.18.10.27.52
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 10:27:52 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id t6so42673366edi.9
        for <linux-sparse@vger.kernel.org>; Sat, 18 Sep 2021 10:27:52 -0700 (PDT)
X-Received: by 2002:a05:6512:94e:: with SMTP id u14mr12398440lft.173.1631985720656;
 Sat, 18 Sep 2021 10:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210918095134.GA5001@tower> <202109181311.18IDBKQB005215@valdese.nms.ulrich-teichert.org>
 <CAHk-=whY5mLggPSr2U00mqgUbRJYnYSxtNZm4FnEtQrHftYr8Q@mail.gmail.com> <56956079-19c3-d67e-d3f-92e475c71f6b@tarent.de>
In-Reply-To: <56956079-19c3-d67e-d3f-92e475c71f6b@tarent.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Sep 2021 10:21:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgj=fFDt6mkiOmRs7pdcYJSibqpVvwcG9_0rbVJEjBCsw@mail.gmail.com>
Message-ID: <CAHk-=wgj=fFDt6mkiOmRs7pdcYJSibqpVvwcG9_0rbVJEjBCsw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
To:     Thorsten Glaser <t.glaser@tarent.de>
Cc:     Ulrich Teichert <krypton@ulrich-teichert.org>,
        Michael Cree <mcree@orcon.net.nz>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Sep 18, 2021 at 10:17 AM Thorsten Glaser <t.glaser@tarent.de> wrote=
:
>
> Considering you can actually put ISA cards, 8 and 16 bit both,
> into EISA slots, I=E2=80=99d have assumed so. I don=E2=80=99t understand =
the
> =E2=80=9CEISA only=E2=80=9D question above.

Oh, it's so long since I had one of those machines I didn't even
remember that EISA took ISA cards too.

But yeah, there are also apparently PCI-based alpha machines with
actual ISA card slots.

            Linus
