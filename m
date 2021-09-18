Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BE5C433FE
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Sep 2021 17:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D60F6104F
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Sep 2021 17:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbhIRRaN (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 18 Sep 2021 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbhIRRaM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Sep 2021 13:30:12 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74C0C061574
        for <linux-sparse@vger.kernel.org>; Sat, 18 Sep 2021 10:28:48 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g41so13853538lfv.1
        for <linux-sparse@vger.kernel.org>; Sat, 18 Sep 2021 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPMj8VLwTy75eprkO41oC3JgAE7NDa67ow6tA6A6/r0=;
        b=cy1UQNMOS0XYpgCCs7UW1bRKopN5C73/mDGBe3xOEvU9Qfc5peAlSaAnDkUL4a5c+l
         T+T9VcGwQGkOsVeyqqcFOdpSy7FTSjlq6zJMH39qCslLX05iJqtLvtCekhr85+YjZU3Q
         mY8lX8VUfk8l+z37c+OMtnVi/VdXUVL9PCefk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPMj8VLwTy75eprkO41oC3JgAE7NDa67ow6tA6A6/r0=;
        b=wNWzDdIZI8/V2Qv2NlGyTW0O6wo5EQFkmhR4bg8OFx2qER9zGwwHNuJ/lcsh3c4uw/
         tYWueabZ/cZI0yoXt7dQlwU2FTsKPCg/q1darUks6H4bTAGbFqI4rHbdJXxENJZYNTDn
         GDnlRz6L8WHPtSMBf6HSoaTA9bOUFr1lYGMg8g5wERFnLzCjLEjCGH2w3D8krNM9xaif
         y6NUbDVi7gca42uI6RdlH15UcIfzfAqu/ij7Ns9LYNec4EvAEgQbgIZTlyMsTQ5BwHBl
         lBoqYaCfiAXln6nzyFjZ9/lDo+qLO7Xk5DcV9I/S+MPat27UYPmH8MbQNKGauRxgLrK+
         kpRQ==
X-Gm-Message-State: AOAM530C5F+9IkNtkrl9Z8f+leY+LszVHzR16D7SSQsGKOkmfG/ghK4a
        G+0i0fptA+Q3Ni8VmZv4LQ9L5t000rZ16KGv6/A=
X-Google-Smtp-Source: ABdhPJx2SWpg3TAkd7SnyIL/koXFNcl8TWvezUn6gnJMrzq5GRueh5ArPkiY1IJWtR+fmAzhVTD0rQ==
X-Received: by 2002:ac2:5624:: with SMTP id b4mr12687596lff.286.1631986126498;
        Sat, 18 Sep 2021 10:28:46 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a6sm891976lfs.160.2021.09.18.10.28.44
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 10:28:44 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id x27so47099620lfu.5
        for <linux-sparse@vger.kernel.org>; Sat, 18 Sep 2021 10:28:44 -0700 (PDT)
X-Received: by 2002:a2e:5815:: with SMTP id m21mr7711431ljb.95.1631986124170;
 Sat, 18 Sep 2021 10:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210918095134.GA5001@tower> <202109181311.18IDBKQB005215@valdese.nms.ulrich-teichert.org>
 <CAHk-=whY5mLggPSr2U00mqgUbRJYnYSxtNZm4FnEtQrHftYr8Q@mail.gmail.com>
In-Reply-To: <CAHk-=whY5mLggPSr2U00mqgUbRJYnYSxtNZm4FnEtQrHftYr8Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Sep 2021 10:28:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixOnf0i1GwYqCT=ihx=QTfB248GOFu6SZQhd3w6mm3aA@mail.gmail.com>
Message-ID: <CAHk-=wixOnf0i1GwYqCT=ihx=QTfB248GOFu6SZQhd3w6mm3aA@mail.gmail.com>
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

On Sat, Sep 18, 2021 at 10:04 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I do not see why you should be using that horrible __EXERN_INLINE. It
> will cause gcc to sometimes not inline at all, and not generate the
> out-of-line body either.

Yeah, that patch doesn't work at all with my cross-compiler, and only results in

  alpha-linux-gnu-ld: arch/alpha/kernel/sys_jensen.o:(.ref.data+0x58):
undefined reference to `jensen_ioread8'

because some of those 'extern inline' cases are never instantiated.

I'll look into it, we can make Jensen build again in case somebody
then gets the energy to see what causes it to not boot.

              Linus
