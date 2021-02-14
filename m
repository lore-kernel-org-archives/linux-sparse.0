Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC5BC433E6
	for <linux-sparse@archiver.kernel.org>; Sun, 14 Feb 2021 19:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2916364E26
	for <linux-sparse@archiver.kernel.org>; Sun, 14 Feb 2021 19:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhBNTBu (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 14 Feb 2021 14:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhBNTBs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 14 Feb 2021 14:01:48 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860BAC061756
        for <linux-sparse@vger.kernel.org>; Sun, 14 Feb 2021 11:01:07 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id v6so5245841ljh.9
        for <linux-sparse@vger.kernel.org>; Sun, 14 Feb 2021 11:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+PrlagK3FXPEbDOZIY/ECRbDBZyE6NRnFmFq47XoKo=;
        b=e8vgrlaDAszZNUkNayc/bQhGtTDVv2JWQ2vcikOXiPfOvXZyT7o6vWAx5IiBM+Q5aK
         xdHDapKbzufyKmtn2WyIcyjmXvK9/AY/sW/TaHGzXucoZnioLMvlxwq5wCIBY1xjxt3H
         8t/fXMkN3hYAEKXFusstufxRxZGE6gAS/rk1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+PrlagK3FXPEbDOZIY/ECRbDBZyE6NRnFmFq47XoKo=;
        b=mYRMY6nDiQK8TUGm25xGzqfdcymaWbrb+ec4vbjF3ksJdZ3+304+T8e9pquoHz4Aan
         OuYcpoVHaOU2+o08jL5r+OsEaLZ5Hr2eg1xWQ96xhsLqSc49fZfVEEUy+NpKeDnnyx1y
         sQvDdGsFWRpW9D6UiYXJrdCb1HIJHA83W3LfasMyVZvEDlII2/q0ZJ96AXvfDjLufiC4
         aKRoorGfJ5KIc3cNbh+Ba7P67Z+HNykRCiNnYOgWR1lcDgWdYwhkXSoK4QJKH7L6n1g0
         Dlwbufc7qEDbTqVsBgx9wWfVQpXma4R4U0GxkdaCzOlIxyZclNdthVYhice3xEvDlh0o
         G4kQ==
X-Gm-Message-State: AOAM532boTQrsy9iOcKlHlgGW145dL/qodpMdhxatKDGf72sIM+INTkt
        EishL9x72gObhhaK8nqZpdjX9t5v9DAGUQ==
X-Google-Smtp-Source: ABdhPJwIF1zFGa/FL4Wzsg9JVUnZ6PfzqHa27ZEF2lBWQ4NDkK8a4Bh6u0yUnlnvkXC1uFjMfaoN3w==
X-Received: by 2002:a2e:7c0c:: with SMTP id x12mr7615267ljc.296.1613329265492;
        Sun, 14 Feb 2021 11:01:05 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id s4sm2492681lfp.281.2021.02.14.11.01.04
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 11:01:04 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id v30so7029303lfq.6
        for <linux-sparse@vger.kernel.org>; Sun, 14 Feb 2021 11:01:04 -0800 (PST)
X-Received: by 2002:a19:7f44:: with SMTP id a65mr6579147lfd.41.1613329264262;
 Sun, 14 Feb 2021 11:01:04 -0800 (PST)
MIME-Version: 1.0
References: <651ac50b9ff6ed3db8cab9f176514900f6a02a0c.1613131413.git.agx@sigxcpu.org>
 <20210213031237.GP219708@shao2-debian> <YClYh7pqDlbXy8qh@bogon.m.sigxcpu.org> <6a8eb07f-16d5-f461-cf0b-6c4aaf93b014@ramsayjones.plus.com>
In-Reply-To: <6a8eb07f-16d5-f461-cf0b-6c4aaf93b014@ramsayjones.plus.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Feb 2021 11:00:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjCAVj7J+KAC1pvtdeM-c76oXZq7k=v40-maKjTo6qfVw@mail.gmail.com>
Message-ID: <CAHk-=wjCAVj7J+KAC1pvtdeM-c76oXZq7k=v40-maKjTo6qfVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] usb: typec: tps6598x: Add trace event for status register
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Cc:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Feb 14, 2021 at 10:42 AM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> >
> > I looked around but didn't find any hints how to fix this. Any pointers
> > I missed (added the sparse list to cc:)?
>
> This is a limitation of sparse; when using the 'stringize' pre-processor
> operator #, the maximum size of the resulting string is about 8k (if I
> remember correctly).

Well, yes and no.

The C89 standard actually says that a string literal can be at most
509 characters to be portable. C99 increased it to 4095 characters.

Sparse makes the limit higher, and the limit could easily be expanded
way past 8kB - but the point is that large string literals are
actually not guaranteed to be valid C.

So honestly, it really sounds like that TRACE_EVENT() thing is doing
something it shouldn't be doing.

I don't think there's any fundamental limit why sparse does 8kB as a
limit (just a few random buffers). Making sparse accept larger ones
should be as simple as just increasing MAX_STRING, but I really don't
think the kernel should encourage that kind of excessive string sizes.

I wouldn't be surprised if tracing buffers etc make such strings useless anyway.

               Linus
