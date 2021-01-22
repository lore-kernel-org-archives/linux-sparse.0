Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7B3C433DB
	for <linux-sparse@archiver.kernel.org>; Fri, 22 Jan 2021 21:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB23A23AF8
	for <linux-sparse@archiver.kernel.org>; Fri, 22 Jan 2021 21:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbhAVVak (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 22 Jan 2021 16:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730917AbhAVUMk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 22 Jan 2021 15:12:40 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9814C061788
        for <linux-sparse@vger.kernel.org>; Fri, 22 Jan 2021 12:11:59 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id rv9so9394944ejb.13
        for <linux-sparse@vger.kernel.org>; Fri, 22 Jan 2021 12:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ybchXrQ9mVE6dKMVMYWYkzKX9keQFRjzCeNMpqp6d2Q=;
        b=pabwrYFSpxyK+fyFD3eWFVmT4HSRYb4BZ/Y5/Kf2U1vf/vTFo6/2RRiZOsTLFNnGWH
         UhoFKbV7GV1U/g/yxOzr6zu5J4lpq9sB9XLtaT1/2yb7TeT4PCw//jf9Ey4v/rENbtTd
         ojSZhKnyI80AbEZE9RRhHK3gqt3xXcc1zSYrc55jLZnifR7blbjvGezF8IDaakT7Ikdo
         OB0g4jmOLF2jKARwziUbtf5f3TG88q/+cGN/ljg6zR1xy4p5uftT5Z8GpK6jigHDnAfn
         LZvB/PO5ZFt6Yy4M1U4YLypKbrxnbT1I3iT45wZK87OgXiSrfWDX59Xv5AU9Kw9sE0aO
         yg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ybchXrQ9mVE6dKMVMYWYkzKX9keQFRjzCeNMpqp6d2Q=;
        b=YVoy1LDrtV3RzGceEx05GscOzXRPFNKoTxaI/e/v6UxaULy88xvGH3fRy6QKjpcqHG
         M3VvyyE0IfvypT7hhqZm7JvsdNQUydtYc0wv8yZfbOytDjesfAk8Ih2Zvuyfmce9PW6k
         oBUVMA8WE+3ODyAkF4Zmt/czPkdmG10Llc2HwlSHR9hlna4MzWm1Kev7ziu0xP1RZgnW
         39VcEwZGUYYV6zlskT40LSO4gxMLrVjHDzwKKzamxkr0EGm+nt3AajZN2fTOmVGEGsjM
         H1qgOphjafEKHljJUz/IaD2O9lySwpYNKKCrUfBW8EzcbeWHCacWr88dBA7FdKRAxSrd
         P67Q==
X-Gm-Message-State: AOAM532Ko8LeDCA4qlDjNFmoJk3DJz17vAVRij1H0S91oypXf4Qxk/m5
        qGC5Tg4plu1MXBwhDqyH1IXHIVCF3nI=
X-Google-Smtp-Source: ABdhPJy216/0QEtp2ZRsXinibdaWZVCNVFNl5HR+9CBENQPTUg422A+7AhyLt7mZazhIxmtdU2eEEA==
X-Received: by 2002:a17:906:d0c1:: with SMTP id bq1mr257598ejb.202.1611346318699;
        Fri, 22 Jan 2021 12:11:58 -0800 (PST)
Received: from mail ([2a02:a03f:b7fe:f700:e13f:8447:6e59:7f11])
        by smtp.gmail.com with ESMTPSA id i18sm6037811edt.68.2021.01.22.12.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:11:57 -0800 (PST)
Date:   Fri, 22 Jan 2021 21:11:56 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] handle qualified anonymous structures
Message-ID: <20210122201156.7knkorg7yqr3dwdp@mail>
References: <CAHk-=wj4Kviw8q2Sx9vrrvyn3uWK-zNi4uGRx=5bzde0Cio8uQ@mail.gmail.com>
 <20210122162625.73007-1-luc.vanoostenryck@gmail.com>
 <CAHk-=wj3v1hm3x0x_3ui1PQDLbn7V5PoxGyDf_UB6TCxMTgjQw@mail.gmail.com>
 <CAHk-=wiGgNEWybdqu1pmV_zCXJ+woyni2ie3+2pnFZfzwY8NEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGgNEWybdqu1pmV_zCXJ+woyni2ie3+2pnFZfzwY8NEA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Jan 22, 2021 at 10:01:40AM -0800, Linus Torvalds wrote:
> On Fri, Jan 22, 2021 at 9:35 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Anyway, looks good, and obviously passes my trivial test-case.
> 
> Oh, and then I tried a slightly more complex test-case, and didn't get
> the result I expected.
> 
> In this:
> 
>     struct dummy {
>         const struct {
>                 int a;
>                 volatile struct {
>                         int b;
>                 };
>         };
>         int c;
>     };
> 
>     int *test(struct dummy *a)
>     {
>         a->a = a->c;
>         return &a->b;
>     }
> 
> I expected to also get a warning about how we return the wrong type
> (ie "&a->b" is of type "const volatile *int", but "test()" returns an
> "int *").
> 
> That seems to have nothing to do with the anonymous struct type,
> though. It is just because we never warn about that pointer conversion
> at all.
>
> Interestingly, It does show up as a "ptrcast" instruction in the
> linearization, so I can tell that yes, sparse saw that it was a
> different pointer type. It just didn't care to warn.
>
> Not a huge deal, but I thought I'd mention it since it showed up in my test.

Thank you to mention this.
It's because once an error has been issued, warnings are not displayed
anymore. For example, the following will return the expected warning:
	int *test(struct dummy *a)
	{
		return &a->b;
	}
 
I think it's something that made a lot of sense before but which is
more and more annoying because it hides legitimate warnings, like here
(of course, it also hides silly/'second order' warnings).

-- Luc
