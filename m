Return-Path: <SRS0=i4AA=IE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD245C433DB
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 21:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87912650BC
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 21:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhCFVeS (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 16:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCFVdr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 16:33:47 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24338C06174A
        for <linux-sparse@vger.kernel.org>; Sat,  6 Mar 2021 13:33:47 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id q14so9630550ljp.4
        for <linux-sparse@vger.kernel.org>; Sat, 06 Mar 2021 13:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYVEwzZhLwplYvENbyLDo2KBa4YyGfoYjQU60hfjeAE=;
        b=GeeH1OYVzaLLpPl2mP61ssVSI2UKJSm1EAkx4xzkZr84Wr3Nw/f5sD6LgJlbRFyxab
         XJG71kajxiLs01yTxCoNiDag9LNe0hXYgp1l4gznLjO91ntuKW7+sxaYeot4ghuHupke
         1pIs+cbYOLKakGudxCvKT4rmy2Fh4//V7dXYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYVEwzZhLwplYvENbyLDo2KBa4YyGfoYjQU60hfjeAE=;
        b=Ny0YkWIPbVYA4eYDNUK6VqyJYM7BEOpbtkshIPkgZryPv9XzPrbLXRx3YjkGzGncR1
         RdV6I0EICx7bCQ07YqWCNwHaM/0F0AFKSN7E2We7G6/sFSlddCws0FTAc1u3zgvUMrj0
         caKxJwHD6QQq3lMwy+e8Pz+WXID4nZF0Ui3u5ZmYoupcj60oN0d6m5CFfN21HXX9Gb1G
         VRe+Suqb2p5qcKUlwOhkYvQKC5oiELRlkC13X/2Zz0t5OHj0w/dtGoVbGonOGUpAK05T
         +V2EzBVqI/roq5nqYRXqZyUTK8XGHPmbeg8mAqHAupyhBrXYqinl6n8jQgMYy/hpFVFu
         JW4Q==
X-Gm-Message-State: AOAM5314ctApG3BsZ2nBMyQjOQiIC6f5lzN9UHdhoFSuLLmXzW5NSD5A
        cxDV52XIz2lgYpVAReF2iPepNV6l3+dWew==
X-Google-Smtp-Source: ABdhPJzGc/edtiQe+5ZmMCa2zAepBXKCZSaxi9i8a966oyTiKCYIxIAUBOX0ojMJt7RdcrTiC7kp9w==
X-Received: by 2002:a2e:99ce:: with SMTP id l14mr9548489ljj.93.1615066425086;
        Sat, 06 Mar 2021 13:33:45 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id m4sm830605ljp.84.2021.03.06.13.33.43
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 13:33:44 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id m22so12664050lfg.5
        for <linux-sparse@vger.kernel.org>; Sat, 06 Mar 2021 13:33:43 -0800 (PST)
X-Received: by 2002:a19:ed03:: with SMTP id y3mr9567287lfy.377.1615066423154;
 Sat, 06 Mar 2021 13:33:43 -0800 (PST)
MIME-Version: 1.0
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain> <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
 <YDvwVlG/fqVxVYlQ@localhost.localdomain> <CAHk-=wi54DEScexxpMrO+Q2Nag_Tup+Y5YBHc_9_xGLeRfP8pA@mail.gmail.com>
 <877dmo10m3.fsf@tromey.com> <CAHk-=wi13+FLcRo4zmnRUmmY=AAns-Yd5NR_mVdcAd6ZrPq2fA@mail.gmail.com>
 <4835ec1d2ecc40b285596288a0df4f47@AcuMS.aculab.com> <CAHk-=wh8PptzH-=ak1D7C5Zp6EJ8eurYqVqGdQauupAFaNuG4g@mail.gmail.com>
 <44a0cc9cb5344add8ee4d91bffbf958f@AcuMS.aculab.com> <CAHk-=whh3fiL7FcLD_r1rfx-gP9W4HWS7vTPM9LKUH+0xzF2=A@mail.gmail.com>
 <CANiq72k-_ORGU+tCVhBGnr0QtH4hQ45ayzDtoHND8JZa2jYYPA@mail.gmail.com>
In-Reply-To: <CANiq72k-_ORGU+tCVhBGnr0QtH4hQ45ayzDtoHND8JZa2jYYPA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Mar 2021 13:33:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTWnAZitAYrSD508rxoLtB47p1ntyqYLzVeb=mTQ6tHw@mail.gmail.com>
Message-ID: <CAHk-=wgTWnAZitAYrSD508rxoLtB47p1ntyqYLzVeb=mTQ6tHw@mail.gmail.com>
Subject: Re: [PATCH 00/11] pragma once: treewide conversion
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Tom Tromey <tom@tromey.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Mar 6, 2021 at 5:07 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Concerning #pragma once: I actually would like to have a standard
> #once directive if what is a "seen file" could be defined a bit more
> precisely.

I think it would be ok if you had something like

   #pragma once IDTOKEN

which would basically act *exactly* as a "#ifndef IDTOKEN/#define
IDTOKEN" with that final #endif at the end of the file.

But even then it should have the rule that it must be the very first
thing in the file (ignoring whitespace and pure comments).

Then it would literally be just a cleaner and simpler version of the
guarding logic, with none of the semantic confusion that #pragma once
now has.

Because I cannot see any other way to define what "seen file" really means.

There's no sane "implied IDTOKEN" that I can see. It can't really be
the pathname, because pathnames are actually really hard to turn into
canonical form in user space thanks to things like symlinks. It can't
be st_ino/st_dev stat information, because the C preprocessor isn't a
"POSIX only" thing.

It could be a "Ok, #pragma once only works if you don't have multiple
ways to reach the same file, and you never have ambiguous include
paths". But that's actually not all that unusual in real projects: you
often have fairly complex include paths, you have C files that include
the header in the same directory with just "filename.h", but it
_could_ get included indirectly from _another_ header that gave a
pathname relative to the project root, etc etc.

This is not unrelated to another complete morass of horrible problems:
precompiled header files. That feature had exactly the same reason for
it as "#pragma once" - slow build speeds due to the cost of parsing
complex header file hierarchies.

And I guarantee that multiple compiler teams spent hundreds of
person-years of effort on trying to make it work. And several
compilers do support the notion. And they ALL have big warnings about
when you should enable it, and when you shouldn't, and what things
don't work if you use them, and about how it can cause really really
subtle problems.

Because it turns out that precompiled header files are a major pain
and a major mistake. Some projects still use them, because they can be
such a huge timesaver (again: particularly C++ projects that just have
a "include everything" approach to headers because trying to separate
things out is too hard). But they all come with huge warnings about
how they break the actual real semantics of a compiler, and if you do
_anything_ to change the build ("hey, I'd like to use a different
compiler option"), things may or may not work.

           Linus
