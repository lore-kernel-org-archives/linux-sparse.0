Return-Path: <SRS0=i4AA=IE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EF6C433E0
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 13:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8260465009
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 13:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhCFNHn (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 08:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhCFNHj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 08:07:39 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1813C06174A;
        Sat,  6 Mar 2021 05:07:38 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id u75so4981545ybi.10;
        Sat, 06 Mar 2021 05:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ATpFGSJY46yedmzJDru9SiqB2GPuBTTkX5e7hHNDmgQ=;
        b=OewBR4mFIG8qQm3SnYpRZvdV1lvJMb9wI45+5gWV4CaJ8QC+pQm3YBPnuimVmsWq61
         JU9LoZBvZSijQn/fb5FrWhmX3mcVAl+G8vB6LkgzQprzcO3kMxbhlEepzYr9Hxpnp2R+
         0ody94zv8NgPQyW5hYB9rjRkvyHHCkyOTxE5S0CUTf7xrIBtvWvlqeoIJqe6JqstYA1w
         6zvA43o+5OML4aoRcvcpPFAqiqrWRs+unbojR18EV/Ysg8+UkUc/AXDjbSVNn5eFxVx3
         +p0ArbvnOz7LO/rGTVoew8+k+t4LCFLlVEHAucohQPtQqNSXTLtehP//H/5GW46ZXbS2
         Jh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ATpFGSJY46yedmzJDru9SiqB2GPuBTTkX5e7hHNDmgQ=;
        b=irD1zS8dLpWfcaIVAdqXG3uN5CpqsYWhNgnhWtF5ARd9c4yJUhRNYenkqtZ7JfHcOO
         FKKUtxgCFrmDhkqp8gGY6CYFh3G/AmKIIqa7zUv2hb+VIGHh4dHe1YeSzUiA+X8Jofpq
         8yPzdPs6ybSnDKi1HOWr4LOvvCEivHZjLFSPjup6wpsR2INIrULHXVOyn4IO2R8LSToG
         P1jAn2oqMU3EO9tSc9HJyazaGFttWvffm1qjOxtmqI2M3OtoziE/EHTsHD3YXirIikDh
         szN18NStXM9xA5lRBf42Ku92/DY2NPwUzUGgbXP2XIvFa26lTNMQgLNY4wUo1+1pCiGW
         rkIg==
X-Gm-Message-State: AOAM533HqEMlqOYKWuWopFIlzA4nUbVgOAAc1g4jGMCXiLUGpfTedLko
        LfCtWcJQFATKWUN5ZKdT08v+ZsxDdO4iuLAPr8M=
X-Google-Smtp-Source: ABdhPJx1b37KN1V3/vvMORCUJFH9irDWY3DvTJJn0sJR1gZGT7+GIXqkXhdBHgwnRhXPiT6m/hVKyfdyQO7R0PI6J/Y=
X-Received: by 2002:a25:d296:: with SMTP id j144mr21120022ybg.33.1615036058165;
 Sat, 06 Mar 2021 05:07:38 -0800 (PST)
MIME-Version: 1.0
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain> <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
 <YDvwVlG/fqVxVYlQ@localhost.localdomain> <CAHk-=wi54DEScexxpMrO+Q2Nag_Tup+Y5YBHc_9_xGLeRfP8pA@mail.gmail.com>
 <877dmo10m3.fsf@tromey.com> <CAHk-=wi13+FLcRo4zmnRUmmY=AAns-Yd5NR_mVdcAd6ZrPq2fA@mail.gmail.com>
 <4835ec1d2ecc40b285596288a0df4f47@AcuMS.aculab.com> <CAHk-=wh8PptzH-=ak1D7C5Zp6EJ8eurYqVqGdQauupAFaNuG4g@mail.gmail.com>
 <44a0cc9cb5344add8ee4d91bffbf958f@AcuMS.aculab.com> <CAHk-=whh3fiL7FcLD_r1rfx-gP9W4HWS7vTPM9LKUH+0xzF2=A@mail.gmail.com>
In-Reply-To: <CAHk-=whh3fiL7FcLD_r1rfx-gP9W4HWS7vTPM9LKUH+0xzF2=A@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 6 Mar 2021 14:07:27 +0100
Message-ID: <CANiq72k-_ORGU+tCVhBGnr0QtH4hQ45ayzDtoHND8JZa2jYYPA@mail.gmail.com>
Subject: Re: [PATCH 00/11] pragma once: treewide conversion
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Tom Tromey <tom@tromey.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Mar 5, 2021 at 10:25 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And regardless of even _those_ issues, you still should do all the
> other syntactic tokenization stuff (ie all the quoting, the the
> character handling: 'a' is a valid C token, but if you see the string
> "it's" outside of a comment, that's a syntax error even if it's inside
> a disabled region. IOW, this is an incorrect file:
>
>    #if 0
>    it's a bug to do this, and the compiler should scream
>    #endif
>
> because it's simply not a valid token sequence. The fact that it's
> inside a "#if 0" region doesn't change that fact at all.  So you did
> need to do all the tokenization logic.

Compilers don't scream that much, only GCC seems to give a warning. I
assume it is because it is just undefined rather than a required
error/diagnostic, i.e. the "If a =E2=80=99 or a " character matches the las=
t
category, the behavior is undefined." in 6.4.

Concerning #pragma once: I actually would like to have a standard
#once directive if what is a "seen file" could be defined a bit more
precisely. Even if just says it creates a guard with something similar
to the result of `__FILE__` would be good enough for many projects out
there, and one can still use guards when flexibility is needed and/or
corner cases are expected (which, if detected, the compiler could also
warn about).

Cheers,
Miguel
