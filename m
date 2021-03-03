Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65477C4361B
	for <linux-sparse@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C6764E56
	for <linux-sparse@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhCDA1Q (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387999AbhCCUSG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 Mar 2021 15:18:06 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D50C061760
        for <linux-sparse@vger.kernel.org>; Wed,  3 Mar 2021 12:17:26 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a17so30406471ljq.2
        for <linux-sparse@vger.kernel.org>; Wed, 03 Mar 2021 12:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJU47HfLr24C5iHZ6QnN66/JheJ0eDT25q9fy/MswAI=;
        b=QLA9VfftBNrxhMy11KY7iYzpDwYXuC99/HWIBxltPnMI5ztG9/vW21kc1NVhBQ/G5m
         kKYXenXZCPFpBe/SQLVhcB/mrEA88dF0aV5ReqvCDpu3eopgJZPnBvojk7pBjyjLHpHb
         aIaG3jG6p0K8uMEl9uNHlxdJPHLRoguFi63uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJU47HfLr24C5iHZ6QnN66/JheJ0eDT25q9fy/MswAI=;
        b=k7Tiurjomb3kZnMQn7hNQIiMWv/rqi7oowcbvPNshNMFniTKMCsA4nHSkS0kBOYI+B
         NJnomFmkQO7tGF7zPT7+2RqrR2R4VtynumI9GwzXCK/wTTYXGLOlexwTlOi0TzzOuPix
         Quw2liSFM3E3uf3NyClJ9qoMo/0O5x65E+cx3o2IovXiclctQYE3uPhO1asoYIfNCHLa
         9/K/GZCZOaLQxBv8PEwUBe8c/XO//O7iOHB0VST7jQHZe4MtDl5S2CHzxCOuO0AuioPo
         Z2JLeigIl2JSP+OP64PiP7qUJNSuBlSi0Q7ke8QUfXnvHNAvCgshnYqAqilLb8KrES0d
         t85w==
X-Gm-Message-State: AOAM533jhoeNPCSc/6qFjYo+YwPgziRFe1g9OEdck8BUZKuKoVRQe3dz
        wpCq8BDxZL+fZmh6JZxQHjTlL/EEwlf2Zw==
X-Google-Smtp-Source: ABdhPJw5FPEYH8VQ2ETZ207G9t/x9lhAsWwEp8ZXr2w5kzJYjxrhSoCTCHz5XUyAcAFnTH+Du6ei+w==
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr327155ljp.495.1614802644101;
        Wed, 03 Mar 2021 12:17:24 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id o26sm1457971ljc.138.2021.03.03.12.17.23
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 12:17:23 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id f1so39229077lfu.3
        for <linux-sparse@vger.kernel.org>; Wed, 03 Mar 2021 12:17:23 -0800 (PST)
X-Received: by 2002:a19:ed03:: with SMTP id y3mr226039lfy.377.1614802642636;
 Wed, 03 Mar 2021 12:17:22 -0800 (PST)
MIME-Version: 1.0
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain> <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
 <YDvwVlG/fqVxVYlQ@localhost.localdomain> <CAHk-=wi54DEScexxpMrO+Q2Nag_Tup+Y5YBHc_9_xGLeRfP8pA@mail.gmail.com>
 <877dmo10m3.fsf@tromey.com>
In-Reply-To: <877dmo10m3.fsf@tromey.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Mar 2021 12:17:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi13+FLcRo4zmnRUmmY=AAns-Yd5NR_mVdcAd6ZrPq2fA@mail.gmail.com>
Message-ID: <CAHk-=wi13+FLcRo4zmnRUmmY=AAns-Yd5NR_mVdcAd6ZrPq2fA@mail.gmail.com>
Subject: Re: [PATCH 00/11] pragma once: treewide conversion
To:     Tom Tromey <tom@tromey.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Mar 3, 2021 at 11:46 AM Tom Tromey <tom@tromey.com> wrote:
>
> It's also worth noting that in GCC it is slower than include guards.
> See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58770
>
> It's just a bug, probably easy to fix.  On the other hand, nobody has
> ever bothered to do so.

That bugzilla is actually worth reading, if only to explain how the
include guard is more robust technology compared to #pragma once.

The traditional include guarding with #ifndef/#define/#endif around
the contents has the advantage that a compiler _can_ generate the
obvious trivial optimizations of just memoizing that "oh, I've seen
this filename already, and it had that include guard pattern, so I
don't need to include it again".

But, I hear you say "that's exactly what '#pragma once' does too!".

No, it's not. There's actually two huge and very fundamental
differences between '#pragma once' and the traditional include guard
optimization:

 (a) the traditional include guard optimization HAS NO HIDDEN SEMANTIC
MEANING. It's a pure optimization that doesn't actually change
anything else. If you don't do the optimization, absolutely nothing
changes.

 (b) the traditional include guard model allows for overriding and is
simply more flexible

And the GCC bugzilla talks about some of the issues with (a), and I
already mentioned one similar issue with (a) wrt sparse: exactly what
is it that "#pragma once" really protects?

Is it the filename? Is it the _canonical_ filename? What about
symbolic links or hardlinks? Is it the inode number? What about
filesystems that don't really have those concepts?

The above questions aren't some made-up example. They are literally
FUNDAMENTAL DESIGN MISTAKES in "#pragma once".

In contrast, include guards just work. You give the guard an explicit
name, and that solves all the problems above, and allows for extra
flexibility (ie the (b) issue: you can override things and include
things twice if you know you're playing games, but you can also use
the guard name to see "have I already included this file" for when you
have possible nasty circular include file issues etc).

So the traditional include guard model is simply technically the superior model.

This is why I'm NAK'ing "#pragma once". It was never a good idea, and
the alleged advantage ("faster builds by avoiding double includes")
was always pure garbage because preprocessors could do the same
optimization using the traditional include guards. In fact, because
the traditional include guards have well-defined meaning and doesn't
have any of the questions about what makes a file unique, and a missed
optimization doesn't cause any semantic differences, a compiler has a
much _easier_ time with that optimization than with the ostensibly
simpler "#pragma once".

Most #pragma things are not wonderful. But '#pragma once' is actively bad.

             Linus
