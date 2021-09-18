Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600ABC433F5
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Sep 2021 21:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2CE60EB4
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Sep 2021 21:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhIRVOB (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 18 Sep 2021 17:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbhIRVOB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Sep 2021 17:14:01 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3A6C06175F
        for <linux-sparse@vger.kernel.org>; Sat, 18 Sep 2021 14:12:37 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i25so49074762lfg.6
        for <linux-sparse@vger.kernel.org>; Sat, 18 Sep 2021 14:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVZJu4t/IugUGV+W6kU+ykKkbEaLVPP4RIQU42du5mE=;
        b=NO0esR917j83JwTOpZQWYClId3457L6NJIf6fJ7Evei4pDJ6w9tdhLXDN3IinOEvW+
         VMthkeYirKlrzLR7LCf4USQHGLJ9wmo5a/QkxpfY9+CPatz4XjsnDZX+q2dIqcXYIANe
         4/RbL5IIz9wKXWQ+bU6E9Y8mF2Wc3GAB8iq/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVZJu4t/IugUGV+W6kU+ykKkbEaLVPP4RIQU42du5mE=;
        b=0F+mpVYzEs51e3JNZ0Hzx56D7pDfGdWYLqQZ4aZm0jJJsxfITrxfe68M7fLRhY90ot
         cdUT5uDT+5Gk7eFxALtU/G7e7CrFWauMbuS/xCUOqUsF4rvh3eIVrxt10qEJo2z9Xp+I
         tTFuWr52Tnto7t067l7aHTPFGfXSUW0GdZK/vhOFtQbMFlcwYn+kLwUEKOjOyEkw7fAR
         EY0J9XKO6bmvJmd2VvIBqN6JIkYwrECtCJ7cYWfH5J5QE2RoXFSA4Q3CFjap/N//E3DK
         lAQbAjYHDUar4leG+jHSX4h67bdpIynNpYQUvjA3HWtACO6XsG2gJ+JGkQ15EDTnaPH3
         ZSsQ==
X-Gm-Message-State: AOAM532fJ6vCa5+YSEfEwfm4u91AA78xZvmcWXQhCkvUVOYUw6ZnThZ9
        vxEkUk0hQBi27NA5qm9YiVOD5Yor3i96QEsHlq4=
X-Google-Smtp-Source: ABdhPJy1R78uCHkTPi1Uz7myCRsHwP/p+yIv0JVphN3ZDW6/+HS+3eQSaOcb4KF8OWSb6hIp62S5mg==
X-Received: by 2002:a2e:5758:: with SMTP id r24mr15698355ljd.432.1631999554954;
        Sat, 18 Sep 2021 14:12:34 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id s3sm858148lfg.248.2021.09.18.14.12.32
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 14:12:33 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id g41so15402836lfv.1
        for <linux-sparse@vger.kernel.org>; Sat, 18 Sep 2021 14:12:32 -0700 (PDT)
X-Received: by 2002:a2e:8107:: with SMTP id d7mr16412051ljg.68.1631999551766;
 Sat, 18 Sep 2021 14:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whY5mLggPSr2U00mqgUbRJYnYSxtNZm4FnEtQrHftYr8Q@mail.gmail.com>
 <202109182026.18IKQLng003683@valdese.nms.ulrich-teichert.org> <CAHk-=wjZukwHDpm6PUP=cFTi8wWQs6Z5Np7xv7SRphNqvm0FPw@mail.gmail.com>
In-Reply-To: <CAHk-=wjZukwHDpm6PUP=cFTi8wWQs6Z5Np7xv7SRphNqvm0FPw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Sep 2021 14:12:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whswL8vPtdVphebUwdDd2Y-9j2d8XAd35bB+mqrhc0YTA@mail.gmail.com>
Message-ID: <CAHk-=whswL8vPtdVphebUwdDd2Y-9j2d8XAd35bB+mqrhc0YTA@mail.gmail.com>
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

On Sat, Sep 18, 2021 at 1:46 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But your config shows _other_ errors with the IO functions, so I guess
> I'll need to look at that one too.

Oh, and all those games with

   #define __EXTERN_INLINE
   #include <asm/io.h>
   #include <asm/jensen.h>
   #undef  __EXTERN_INLINE

don't actually work, because there's the usual multiple-inclusion
protection on top of asm/jensen.h:

   #ifndef __ALPHA_JENSEN_H
   #define __ALPHA_JENSEN_H

and this include of <asm/jensen.h> is entirely unused, because we
ended up getting the one *without* that empty __EXTERN_INLINE #define
from an earlier include of

  #include <linux/interrupt.h>

that caused asm/io.h and asm/jensen.h to be included earlier.

The *other* machine files know to do their includes at the top of the file.

But then I end up getting

     ERROR: modpost: "__udiv_qrnnd" [lib/mpi/mpi.ko] undefined!

because CONFIG_MATHEMU wasn't set and the crypto stuff wants the MPI code.

So there seems to be other alpha Kconfig issues in there, and they
aren't all actually Jensen-specific.

Oh well. I guess can fix things up, since I did get tthe
cross-compiler environment..

          Linus
